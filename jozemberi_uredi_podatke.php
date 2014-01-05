<?php 
	session_start();
	ini_set('session.bug_compat_warn', 0);
	ini_set('session.bug_compat_42', 0);
	
	require_once '_jozemberi_baza.php';
	require_once('_jozemberi_vrijeme.php');
	require_once('_jozemberi_smarty.php');
	require_once('_simpleImage.php');
	
	$smarty->assign('naslov', 'Uredi podatke');
	$smarty->assign('div_id', 'content');
	
	$korIme='';
	
	bazaConnect();
	if($_SESSION['tip_korisnika']==3 and isset($_GET['id'])){
		$korIme = $_GET['id'];
	}
	
	else if($_SESSION['tip_korisnika']!=3 and isset($_GET['id'])) {
		$errorMessage = date("d.m.Y.H:i:s", virtualnoVrijeme());
		$errorMessage.= "; STRANICA: jozemberi_uredi_podatke.php; KORISNIK: " .
		$_SESSION['username'] . "(" . $_SESSION['_ime'] . " " .
		$_SESSION['prezime'] . "); UNESENI ID:" . $_GET['id'];
		$errorMessage.="\n";
		error_log($errorMessage, 3, "_errorlog.txt");
		header("Location:jozemberi_home.php");
	}

	
	else if (isset($_POST['ok'])) 
		$korIme = mysql_real_escape_string($_POST['korImeUP']);
		
	else if(!isset($_GET['id']) and !isset($_POST['ok'])) $korIme = $_SESSION['username'];
	
	$sql = "SELECT username, password, email, ime, prezime, DAY(dat_rodenja) AS datRodenja, MONTH(dat_rodenja) AS mjesec, YEAR(dat_rodenja) AS godina,
			profilna_slika, drzava, zupanija, grad, telefon, ulica, kucni_broj, postanski_broj, tip_korisnika, status_korisnika, komentar_statusa, br_opomena, br_neuspjesnih_prijava, blokiran_do FROM korisnik WHERE username='$korIme'";			
			
	$rs = mysql_query($sql) or die(mysql_error());						

	$korisnik=mysql_fetch_array($rs);
	$korisnik['blokiran_do'] = date('d.m.Y. H:i:s', strtotime($korisnik['blokiran_do']));
	
	if(!$korisnik){
		$errorMessage = date("d.m.Y.H:i:s", virtualnoVrijeme());
		$errorMessage.= "; STRANICA: jozemberi_uredi_podatke.php; KORISNIK: " .
		$_SESSION['username'] . "(" . $_SESSION['ime'] . " " .
		$_SESSION['prezime'] . "); UNESENI ID:" . $_GET['id'];
		$errorMessage.="\n";
		error_log($errorMessage, 3, "_errorlog.txt");
		bazaDisconnect();
		header("Location:jozemberi_home.php");
	}
	
	$smarty->assign('korisnik', $korisnik);
	
	$rspr = mysql_query("SELECT id_tipa_pretplate, pretplatnik FROM pretplate WHERE pretplatnik='$korIme'");
	
	$pretplate=array();
	$vap='ne';
	$vta='ne';
	
	while($row=mysql_fetch_array($rspr)){
			$pretplate[]=$row;
			if($row['id_tipa_pretplate']=='1') $vap='da';
			else if($row['id_tipa_pretplate']=='2') $vta='da';
		}
	
	$smarty->assign("pretplate",$pretplate);
	

	if (isset($_POST['ok'])) {	
		$staraLozinka='';
		$novaLozinka='';
		$potLozinke='';
	
	
	
		$korIme = mysql_real_escape_string($_POST['korImeUP']);
		$email = mysql_real_escape_string($_POST['email']);
		if(isset($_POST['staraLozinka']))$staraLozinka = mysql_real_escape_string($_POST['staraLozinka']);
		//else $staraLozinka ='nema_promjene';
		if(isset($_POST['novaLozinka']))$novaLozinka = mysql_real_escape_string($_POST['novaLozinka']);
		if(isset($_POST['potLozinke']))$potLozinke = mysql_real_escape_string($_POST['potLozinke']);
		$ime = mysql_real_escape_string($_POST['ime']);
		$prezime = mysql_real_escape_string($_POST['prezime']);
		$datRodenja = mysql_real_escape_string($_POST['datRodenja']);
		$mjesec = mysql_real_escape_string($_POST['mjesec']);
		$godina = mysql_real_escape_string($_POST['godina']);
		/* Dodatne informacije */
		if(isset($_POST['drzava']) and $_POST['drzava']!='none')$drzava = mysql_real_escape_string($_POST['drzava']);
		if(isset($_POST['zupanija']))$zupanija = mysql_real_escape_string($_POST['zupanija']);
		if(isset($_POST['grad']))$grad = mysql_real_escape_string($_POST['grad']);
		if(isset($_POST['postanski_broj']))$postanski_broj = mysql_real_escape_string($_POST['postanski_broj']);
		if(isset($_POST['ulica']))$ulica = mysql_real_escape_string($_POST['ulica']);
		if(isset($_POST['kucni_broj']))$kucni_broj = mysql_real_escape_string($_POST['kucni_broj']);
		if(isset($_POST['telefon']))$telefon = mysql_real_escape_string($_POST['telefon']);
		/* admin */
		if(isset($_POST['tip_korisnika']))$tip_korisnika = mysql_real_escape_string($_POST['tip_korisnika']);
		if(isset($_POST['status_korisnika']))$status_korisnika = mysql_real_escape_string($_POST['status_korisnika']);
		
		if(isset($_POST['komentar_statusa']))$komentar_statusa = mysql_real_escape_string($_POST['komentar_statusa']);
		if(isset($_POST['blokiran_do']))$blokiran_do = mysql_real_escape_string($_POST['blokiran_do']);
		if(isset($_POST['blokiran_do_sati'])){
			if(($_POST['blokiran_do_sati']) !=''){
				$blokiran_do_sati = mysql_real_escape_string($_POST['blokiran_do_sati']);
				$date = virtualnoVrijeme() + (intval($blokiran_do_sati) * 60 * 60);
				$blokiran_do = date('Y-m-d H:i:s', $date);
				$_POST['blokiran_do'] = date('d.m.Y. H:i:s', $date);
			}
		
		}
	
		if(isset($_POST['br_opomena']))$br_opomena = mysql_real_escape_string($_POST['br_opomena']);
		
		if($_SESSION['tip_korisnika']!='3'){
			$tip_korisnika=$korisnik['tip_korisnika'];
			$status_korisnika=$korisnik['status_korisnika'];
		}
		
		$promjena_slike='ne';
		$promjena_lozinke='ne';
		
		$greske=array();
		
	
		if (empty ($email)) $greske['email'] = "E-mail nije unesen";
		
		else{
			$postoji_email = mysql_query("SELECT * FROM korisnik WHERE email = '$email'") or die(mysql_error());
			if (mysql_num_rows($postoji_email) >= 2) $greske ['email'] = "E-mail koristi drugi korisnik";		
		}
		
		if (isset($_POST['staraLozinka']) and $staraLozinka !=''){
			$promjena_lozinke= 'da';
			if($staraLozinka == $korisnik['password']){
			
				if ($novaLozinka=='') $greske['novaLozinka'] = "Nova lozinka nije unesena";
			
				else{ 
					if(strlen($novaLozinka) < 6) $greske['novaLozinka'] = "Nova lozinka ima manje od 6 znakova";
				/* provjera++ 
					else if ( (!preg_match("#[0-9]+#", $novaLozinka)) || ( !preg_match("#[a-z]+#", $novaLozinka)) || 
							( !preg_match("#[A-Z]+#", $novaLozinka)) || ( !preg_match("#\W+#", $novaLozinka))) 
							$greske['novaLozinka'] = "Lozinka  mora sadržavati velika i mala slova, brojeve te posebne znakove (#, !, . i sl.)";
							*/
				}
			
				if ($potLozinke=='') $greske['potLozinke'] = "Potvrda nove lozinke nije unesena";
			
				else{ 
					if($novaLozinka != $potLozinke) $greske['potLozinke'] = "Potvrda lozinke nije točna";
				}
			}
			else{
				$greske['lozinka']="Lozinka nije točna";
			}
		}
		
		else{
			if ($potLozinke !='') $greske['potLozinke'] = "Morate unijeti staru lozinku";
			if ($novaLozinka!='') $greske['novaLozinka'] = "Morate unijeti staru lozinku";
		}
		
		if (empty ($ime)) $greske['ime'] = "Ime nije uneseno";
		
		if (empty ($prezime)) $greske['prezime'] = "Prezime nije uneseno";
			
		if(! empty($_FILES["avatar"]["name"])){ 
			if (($_FILES["avatar"]["type"] == "image/gif") || ($_FILES["avatar"]["type"] == "image/jpeg") || ($_FILES["avatar"]["type"] == "image/png")){
				$profilna_slika= $korIme."_".$_FILES['avatar']['name'];
				$smarty->assign('profilna_slika', $profilna_slika);
				$promjena_slike='da';
				}
			else $greske['avatar'] = "Slika mora biti .jpg, png., ili .gif";			
		}
			
		
		if (($datRodenja=='00') or($mjesec=='00') or (empty($godina))) $greske['datRodenja'] = "Datum rođenja nije unesen";
		
		$datum_timestamp = $godina . "-" . $mjesec . "-" .$datRodenja; 
		
		$smarty->assign('greske', $greske);
		
		if (empty($greske)) {
			if($promjena_lozinke=='da') $lozinka=$novaLozinka;
			else $lozinka=$korisnik['password'];
			if($promjena_slike !='da') $profilna_slika = $korisnik['profilna_slika']; 
			
			$upis_podataka = mysql_query ("UPDATE korisnik SET 
						password = '$lozinka',
						email = '$email', 
						ime= '$ime',
						prezime = '$prezime', 
						dat_rodenja = '$datum_timestamp', 
						profilna_slika = '$profilna_slika',
						tip_korisnika = '$tip_korisnika',
						status_korisnika = '$status_korisnika' WHERE username = '$korIme'") or die(mysql_error());
			/* update */			
			if(isset($_POST['drzava'])and $_POST['drzava']!='none') $proDrzava = mysql_query ("UPDATE korisnik SET drzava = '$drzava' WHERE username = '$korIme'") or die(mysql_error());
			if(isset($_POST['zupanija'])and $zupanija!='') $proZupanija = mysql_query ("UPDATE korisnik SET zupanija = '$zupanija' WHERE username = '$korIme'") or die(mysql_error());
			if(isset($_POST['grad']) and $grad!='') $proGrad = mysql_query ("UPDATE korisnik SET grad = '$grad' WHERE username = '$korIme'") or die(mysql_error());
			if(isset($_POST['postanski_broj']) and $postanski_broj !='') 
			$proPosBroj = mysql_query ("UPDATE korisnik SET postanski_broj = '$postanski_broj' WHERE username = '$korIme'") or die(mysql_error());
			if(isset($_POST['ulica'])) $proUlica = mysql_query ("UPDATE korisnik SET ulica = '$ulica' WHERE username = '$korIme'") or die(mysql_error());
			if(isset($_POST['kucni_broj']) and $kucni_broj!='') $proKucBroj = mysql_query ("UPDATE korisnik SET kucni_broj = '$kucni_broj' WHERE username = '$korIme'") or die(mysql_error());
			if(isset($_POST['telefon']) and $telefon!='') $proTelefon = mysql_query ("UPDATE korisnik SET telefon = '$telefon' WHERE username = '$korIme'") or die(mysql_error());
			/* admin*/
			if(isset($_POST['blokiran_do_sati']) and $blokiran_do_sati!='') $proBlokiran = mysql_query ("UPDATE korisnik SET blokiran_do = '$blokiran_do' WHERE username = '$korIme'") or die(mysql_error());
			
			if(isset($_POST['komentar_statusa']) and $komentar_statusa!='') $proKomentara = mysql_query ("UPDATE korisnik SET komentar_statusa = '$komentar_statusa' WHERE username = '$korIme'") or die(mysql_error());
			
			if($promjena_slike =='da'){
				copy ($_FILES['avatar']['tmp_name'], "avatari/".$profilna_slika) or die ('Could not upload'); 
				$image = new SimpleImage();
				$image->load($_FILES['avatar']['tmp_name']);
				$visina = $image->getHeight();
				$sirina = $image->getWidth();
				if($visina > $sirina) $image->resizeToHeight(40);
				else $image->resizeToWidth(40);
				$image->save("thumbs/".$profilna_slika); 
				
				
				if($_SESSION['username']==$korIme)$_SESSION["profilna_slika"]=$profilna_slika;
				}
			
			if((isset($_POST['vijTipAut'])) and ($vta=='ne')) $vTA_rez = mysql_query ("insert into pretplate values (2, '$korIme')") or die(mysql_error());
			if((isset($_POST['vijAkcPog'])) and ($vap=='ne')) $vAP_rez = mysql_query ("insert into pretplate values (1, '$korIme')") or die(mysql_error());
			
			if((!isset($_POST['vijTipAut'])) and ($vta=='da')) $bTA_rez = mysql_query ("delete from pretplate 
						WHERE pretplatnik='$korIme' and id_tipa_pretplate='2'") or die(mysql_error());
			if((!isset($_POST['vijAkcPog'])) and ($vap=='da')) $bAP_rez = mysql_query ("delete from pretplate 
						WHERE pretplatnik='$korIme' and id_tipa_pretplate='1'") or die(mysql_error());
			
			$date = virtualnoVrijeme();
			$dat = date('Y-m-d H:i:s', $date);
			$statistika = mysql_query ("INSERT INTO statistika VALUES
						(default, '4', '$dat', '$korIme')") or die(mysql_error());	
			
			$smarty->assign('poruka', 'Vaše promjene su uspješno spremljene!');
			$smarty->display('jozemberi_uredi_podatke.tpl');
			
		}
	
		else {
			$smarty->display('jozemberi_uredi_podatke.tpl');
		}
	}
	else $smarty->display('jozemberi_uredi_podatke.tpl');
	
	bazaDisconnect();
	include 'templates/jozemberi_footer.tpl';
	
?>
