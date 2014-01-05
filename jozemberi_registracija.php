<?php
	require_once('_jozemberi_smarty.php');
	require_once('_recaptchalib.php');
	require_once('_simpleImage.php');
	require_once('_jozemberi_vrijeme.php');
	require_once ('_jozemberi_baza.php');
	$privatekey='6LcTfdASAAAAAC5LqEekcHEChpTkcEFu5E204iS9';
	$publickey='6LcTfdASAAAAACWi2gFGSOPZxMjoGeAhbGVQREX6';
	$error=null;
	
	$smarty->assign('naslov', 'Registracija');
	$smarty->assign('div_id', 'content');
	$smarty->assign("recaptcha", recaptcha_get_html($publickey, $error));

	if (isset($_POST['ok'])) {
		$greske=array();

		/* Captcha Provjera */
		if ($_POST["recaptcha_response_field"]) {
				$resp = recaptcha_check_answer ($privatekey,
				$_SERVER["REMOTE_ADDR"],
				$_POST["recaptcha_challenge_field"],
				$_POST["recaptcha_response_field"]);
				if ($resp->is_valid) {	} 
				else {
					# set the error code so that we can display it
					$error = $resp->error;
					$greske['recaptcha'] = "Unos nije točan! Pokušajte ponovno...";	
				}
		} 
			
		else {
			$greske['recaptcha'] = "Upišite obje riječi odvojene razmakom";
			}
			
		$smarty->assign("recaptcha", recaptcha_get_html($publickey, $error));
		//kraj captcha provjera

		bazaConnect();
	
		$korIme = mysql_real_escape_string($_POST['korIme']);
		$email = mysql_real_escape_string($_POST['email']);
		$lozinka = mysql_real_escape_string($_POST['lozinka']);
		$potLozinke = mysql_real_escape_string($_POST['potLozinke']);
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
		
		
		if(empty ($korIme)) $greske['korIme'] = "Korisničko ime nije uneseno";
		else if(strlen($korIme) < 6) $greske['korIme'] = "Potrebno min 6 znakova";
		else{
			$postoji_username = mysql_query("SELECT * FROM korisnik WHERE username = '$korIme'");
			if (mysql_num_rows($postoji_username) == 1) $greske ['korIme'] = "Koriničko ime je zauzeto";		
		}
		
		if (empty ($email)) $greske['email'] = "E-mail nije unesen";
		
		else{
			$postoji_email = mysql_query("SELECT * FROM korisnik WHERE email = '$email'");
			if (mysql_num_rows($postoji_email) == 1) $greske ['email'] = "E-mail adresa je zauzeta";		
		}
		
		
		if (empty ($lozinka)) $greske['lozinka'] = "Lozinka nije unesena";
		else{ 
			if(strlen($lozinka) < 6) $greske['lozinka'] = "Lozinka ima manje od 6 znakova";
			else if ( (!preg_match("#[0-9]+#", $lozinka)) || ( !preg_match("#[a-z]+#", $lozinka)) || 
					( !preg_match("#[A-Z]+#", $lozinka)) || ( !preg_match("#\W+#", $lozinka))) 
					$greske['lozinka'] = "Lozinka  mora sadržavati velika i mala slova, brojeve te posebne znakove (#, !, . i sl.)";
		}
		if (empty ($potLozinke)) $greske['potLozinke'] = "Potvrda lozinke nije unesena";
		else{ 
			if($lozinka != $potLozinke) $greske['potLozinke'] = "Unesene lozinke nisu jednake";
		}
		
		if (empty ($ime)) $greske['ime'] = "Ime nije uneseno";
		
		if (empty ($prezime)) $greske['prezime'] = "Prezime nije uneseno";
			
		if(empty($_FILES["avatar"]["name"])) $greske['avatar'] = "Niste odobrali sliku";
		
		else{
			if (($_FILES["avatar"]["type"] == "image/gif") || ($_FILES["avatar"]["type"] == "image/jpeg") || ($_FILES["avatar"]["type"] == "image/png")){
				$naziv_slike= $korIme."_".$_FILES['avatar']['name'];
				}
			else $greske['avatar'] = "Slika mora biti .jpg, png., ili .gif";			
		}
			
		if (($datRodenja=='00') or($mjesec=='00') or (empty($godina))) $greske['datRodenja'] = "Datum rođenja nije unesen";
		
		if(!(isset($_POST['priUvKor']) && $_POST['priUvKor'] == 'da')) $greske['priUvKor'] = "Niste prihvatili uvjete korištenja";
		
		
		$datum_timestamp = $godina . "-" . $mjesec . "-" .$datRodenja; 
		$date = virtualnoVrijeme();
		$dat_reg = date('Y-m-d H:i:s', $date);
		
		$smarty->assign('greske', $greske);
		
		if (empty($greske)) {
			$aktivacijski_kod = mt_rand() . mt_rand() . mt_rand() . mt_rand();
			
			$upis_podataka = mysql_query ("insert into korisnik (username, password, email, ime, prezime, dat_rodenja, profilna_slika, 
						dat_i_vrij_registracije, aktivacijski_kod, tip_korisnika, status_korisnika) values
						('$korIme', '$lozinka', '$email', '$ime', '$prezime', '$datum_timestamp', 
						'$naziv_slike', '$dat_reg','$aktivacijski_kod' ,1, 5)") or die(mysql_error());
			$statistika = mysql_query ("INSERT INTO statistika VALUES
						(default, '1', '$dat_reg', '$korIme')") or die(mysql_error());		
						
			/* Upis dodanih informacija */
			if(isset($_POST['drzava'])and $_POST['drzava']!='none') $proDrzava = mysql_query ("UPDATE korisnik SET drzava = '$drzava' WHERE username = '$korIme'") or die(mysql_error());
			if(isset($_POST['zupanija'])and $zupanija!='') $proZupanija = mysql_query ("UPDATE korisnik SET zupanija = '$zupanija' WHERE username = '$korIme'") or die(mysql_error());
			if(isset($_POST['grad']) and $grad!='') $proGrad = mysql_query ("UPDATE korisnik SET grad = '$grad' WHERE username = '$korIme'") or die(mysql_error());
			if(isset($_POST['postanski_broj']) and $postanski_broj !='') 
			$proPosBroj = mysql_query ("UPDATE korisnik SET postanski_broj = '$postanski_broj' WHERE username = '$korIme'") or die(mysql_error());
			if(isset($_POST['ulica'])) $proUlica = mysql_query ("UPDATE korisnik SET ulica = '$ulica' WHERE username = '$korIme'") or die(mysql_error());
			if(isset($_POST['kucni_broj']) and $kucni_broj!='') $proKucBroj = mysql_query ("UPDATE korisnik SET kucni_broj = '$kucni_broj' WHERE username = '$korIme'") or die(mysql_error());
			if(isset($_POST['telefon']) and $telefon!='') $proTelefon = mysql_query ("UPDATE korisnik SET telefon = '$telefon' WHERE username = '$korIme'") or die(mysql_error());
			
			
			copy ($_FILES['avatar']['tmp_name'], "avatari/".$naziv_slike) or die ('Could not upload'); 
			$image = new SimpleImage();
			$image->load($_FILES['avatar']['tmp_name']);
			$visina = $image->getHeight();
			$sirina = $image->getWidth();
			if($visina > $sirina) $image->resizeToHeight(40);
			else $image->resizeToWidth(40);
			$image->save("thumbs/".$naziv_slike); 
			
			if(isset($_POST['vijTipAut'])) $upis_podataka_vij_Tip_Aut = mysql_query ("insert into pretplate values (2, '$korIme')") or die(mysql_error());
			if(isset($_POST['vijAkcPog'])) $upis_podataka_vij_Akc_Pog = mysql_query ("insert into pretplate values (1, '$korIme')") or die(mysql_error());
		
			$subject = "Aktivacijski kod za aktivaciju korisnickog racuna carconfig.hr!";
			$message = "Postovani $ime! Kako bi aktivirali svoj korisnicki racun molimo Vas da kliknete na sljedeci link: http://arka.foi.hr/WebDiP/2011_projekti/WebDiP2011_131/jozemberi/jozemberi_aktivacija.php?a=$aktivacijski_kod&b=$korIme Aktivacijski link vrijedi 24h.";
			$headers = 'From: noreplay@carconfig.hr'; 
			
			mail($email, $subject, $message, $headers);
			
			bazaDisconnect();
			
			if(isset($upis_podataka)){
				$smarty->assign('naslov', 'Registracija uspješna!');
				$smarty->assign('div_id', 'content_v530px');	
				$smarty->display('jozemberi_registracija_uspjesna.tpl');
			}
			
		}
		else {
			bazaDisconnect();
			$smarty->display('jozemberi_registracija.tpl');
		}
	}
	else $smarty->display('jozemberi_registracija.tpl');
	
	include 'templates/jozemberi_footer.tpl';
?>
