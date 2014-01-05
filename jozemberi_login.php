<?php
	session_start();
    require_once ('_jozemberi_baza.php');
	require_once ('_openid.php');
	require_once('_jozemberi_smarty.php');
	require_once('_jozemberi_vrijeme.php');
	$smarty->assign('naslov', 'Prijava');
	$smarty->assign('div_id', 'content_v530px');		
	
	$cookie_korisnik='';
	if (isset($_COOKIE['cookie_korisnik'])) {
		$cookie_korisnik = $_COOKIE['cookie_korisnik'];
	}
	
	$smarty->assign('cookie_korisnik', $cookie_korisnik);
	
	if (isset ($_GET['logout'])) {
		unset($_SESSION['username']);
		unset($_SESSION['tip_korisnika']);
		unset($_SESSION['profilna_slika']);
		unset($_SESSION['ime']);
		unset($_SESSION['prezime']);
		unset($_SESSION['notLoggedIn']);
		session_destroy();
		header('Location:jozemberi_home.php');
	}
	
	if(isset($_SESSION['notLoggedIn'])){
		$smarty->assign('notLoggedIn', $_SESSION['notLoggedIn']);
		$_SESSION['notLoggedIn']='';
	}
	bazaConnect();
	
	//OpenID login
	try{
		if (isset($_POST['okOpenID'])) {
			$openid = new LightOpenID('arka.foi.hr');
			
			$openid->identity = $_POST['openID'];
			
			header('Location: ' . $openid->authUrl());
			
		}
		
		$openid = new LightOpenID('arka.foi.hr');
		
		if($openid->mode) {
			$ok = $openid->validate();
			if ($ok) {
				$_SESSION['username']= $openid->identity;//'OpenID User'; 
				$_SESSION['tip_korisnika']= '1';
				$_SESSION['profilna_slika']= 'openID.png';
				$openID = $openid->identity;
				$postoji_username = mysql_query("SELECT * FROM korisnik WHERE username = '$openID'");
				if (mysql_num_rows($postoji_username) == 1){
					$date = virtualnoVrijeme();
					$dat = date('Y-m-d H:i:s', $date);
					$statistika = mysql_query ("INSERT INTO statistika VALUES (default, '2', '$dat', '$openID')") or die(mysql_error());
					
				}
				else{
					$date = virtualnoVrijeme();
					$dat_reg = date('Y-m-d H:i:s', $date);
					$upis_podataka = mysql_query ("insert into korisnik (username, profilna_slika, dat_i_vrij_registracije, tip_korisnika, status_korisnika) values
							('$openID','openID.png', '$dat_reg', 1, 1)") or die(mysql_error());
					$statistika = mysql_query ("INSERT INTO statistika VALUES
							(default, '1', '$dat_reg', '$openID')") or die(mysql_error());		
					
				}
				header('Location:jozemberi_home.php');
			}
		
			else { 
				$errorOID = 'Autentikacija nije uspjela!';
				$smarty->assign('errorOID', $errorOID);
			}
		}
		}
	catch(ErrorException $e) {
		$errorOID = "Dogodila se greška pri prijavi! <br /> <span class='uputa'>Provjerite da li ste točno upisali Vaš OpenID URL</span>";
		$smarty->assign('errorOID', $errorOID);
		//echo $e->getMessage();
	}
	//openID
	
	if (isset($_GET['zaboravljena_lozinka']) or isset($_POST['posaljiZabLozinku'])) {
		if(isset($_GET['zaboravljena_lozinka'])){
			$zaboravljena_lozinka = $_GET['zaboravljena_lozinka'];
			$smarty->assign('zaboravljena_lozinka', $zaboravljena_lozinka);
		}
		
		if(isset($_POST['posaljiZabLozinku'])){
			$zabLozinka = mysql_real_escape_string($_POST['zabLozinka']);
			$greskaZabLozinka;
			if (empty ($zabLozinka)){
				$greskaZabLozinka = "Email nije unesen!";
				$smarty->assign('greskaZabLozinka', $greskaZabLozinka);
			}
			
			if (!isset($greskaZabLozinka)) {
				$sql = "SELECT username, password FROM korisnik WHERE email='$zabLozinka'";
				$rs = mysql_query($sql) or die(mysql_error());
				$korisnik = mysql_fetch_array($rs);
				if(!$korisnik){
					$greskaZabLozinka = "E-mail ne postoji u bazi!";
					$smarty->assign('greskaZabLozinka', $greskaZabLozinka);
				}
				
				else{
					$nadimak=$korisnik['username'];
					$pass = $korisnik['password'];
					$email = $zabLozinka;
					
					$subject = "Zaboravljena lozinka carconfig.hr!";
					$message = "Postovani $nadimak! Ukoliko niste zatrazili slanje Vase lozinke, molimo zanemarite ovaj email. Vasa lozinka za Sustav za konfiguraciju automobila je: $pass";
					$headers = 'From: noreplay@carconfig.hr'; 
					
					mail($email, $subject, $message, $headers);
					$poslano = 'Lozinka je poslana!';
					$smarty->assign('poslano', $poslano);
					
					$date = virtualnoVrijeme();
					$dat = date('Y-m-d H:i:s', $date);
					$statistika = mysql_query ("INSERT INTO statistika VALUES
							(default, '5', '$dat', '$nadimak')") or die(mysql_error());	
				}
			}
		}
	}

	 else if (isset($_POST['ok'])) {
		$korIme = mysql_real_escape_string($_POST['korIme']);
		$lozinka = mysql_real_escape_string($_POST['lozinka']);
		
		$greske=array();
	
		if (empty ($korIme)) $greske['korIme'] = "Korisničko ime nije uneseno!";
		if (empty ($lozinka)) $greske['lozinka'] = "Lozinka nije unesena!";
		
		$smarty->assign('greske', $greske);
		
		if (empty($greske)) {
			$sql = "SELECT username, password, profilna_slika, tip_korisnika, status_korisnika, br_neuspjesnih_prijava, blokiran_do FROM korisnik WHERE username='$korIme'";
			$rs = mysql_query($sql) or die(mysql_error());
			$korisnik = mysql_fetch_array($rs);
			
			if(!$korisnik) $greske['korIme'] = "Korisnik ne postoji u bazi!";
			else{
				if($korisnik['password'] != $lozinka and $korisnik['status_korisnika'] != '6'){
					$br_krivih_unosa;
					if ($korisnik['br_neuspjesnih_prijava'] < 3){ 
						$br_krivih_unosa= $korisnik['br_neuspjesnih_prijava'] + 1;
						$rez = mysql_query ("UPDATE korisnik SET br_neuspjesnih_prijava='$br_krivih_unosa' WHERE username='$korIme'") or die(mysql_error());
					}
					$greske['lozinka'] = 'Netočna lozinka! (' . $br_krivih_unosa . ')';
					
					if($br_krivih_unosa == 3){
						$greske['korRacun']='Zbog 3 neuspješne prijave za redom, <br /> Vaš korisnički račun je zaključan! <br \>';
						
						$promjena_podataka = mysql_query ("UPDATE korisnik SET status_korisnika = '6', br_neuspjesnih_prijava= '0' 
											WHERE username='$korIme'") or die(mysql_error());
											
						$date = virtualnoVrijeme();
						$dat = date('Y-m-d H:i:s', $date);
						$statistika = mysql_query ("INSERT INTO statistika VALUES
								(default, '3', '$dat', '$korIme')") or die(mysql_error());	
					}
				}
				
				elseif($korisnik['status_korisnika']=='4') $greske['korRacun'] = "Vaš korisnički račun je deaktiviran!";
				
				elseif($korisnik['status_korisnika']=='2') $greske['korRacun'] = "Vaš korisnički račun je blokiran <br />zbog kršenja pravila!";
				
				elseif($korisnik['status_korisnika']=='3'){
					$date = virtualnoVrijeme();
					$blokiran = strtotime ($korisnik['blokiran_do']);
					if($blokiran > $date){
						$dat_zam = date('d.m.Y H:i:s', $blokiran);
						$greske['korRacun'] = "Vaš korisnički račun je zamrznut do <br /> $dat_zam!";
					}
					else{
					$proBlokiran = mysql_query ("UPDATE korisnik SET blokiran_do = '0000-00-00 00:00:00', status_korisnika = '1' WHERE username = '$korIme'") or die(mysql_error());
					
					}
				}
				
				elseif($korisnik['status_korisnika']== '6'){
					$greske['korRacun'] = "Zbog 3 neuspješne prijave za redom, <br /> Vaš korisnički račun je zaključan!\n";
				}
				elseif($korisnik['status_korisnika']=='5') $greske['korRacun'] = "Vaš korisnički račun nije aktiviran!";
			}
			$smarty->assign('greske', $greske);
			
			if (empty($greske)) {
				$_SESSION['username']= $korisnik['username'];
				$_SESSION['tip_korisnika']=$korisnik['tip_korisnika'];
				$_SESSION['profilna_slika']=$korisnik['profilna_slika'];
				$_SESSION['ime']=$korisnik['ime'];
				$_SESSION['prezime']=$korisnik['prezime'];
				$_SESSION['notLoggedIn']='';
				
				$promjena_podataka = mysql_query ("UPDATE korisnik SET br_neuspjesnih_prijava= '0' WHERE username='$korIme'") or die(mysql_error());
				if (isset($_POST['cheBox'])) setcookie("cookie_korisnik", $korIme, time()+60*60*24*90); 
				
				else setcookie ("cookie_korisnik", "", time() - 3600);
				
				$date = virtualnoVrijeme();
				$dat = date('Y-m-d H:i:s', $date);
				$statistika = mysql_query ("INSERT INTO statistika VALUES
						(default, '2', '$dat', '$korIme')") or die(mysql_error());		
				
				header('Location:jozemberi_home.php');
			}	
		}
		bazaDisconnect();
			
	}
		
	$smarty->display('jozemberi_login.tpl');
	include 'templates/jozemberi_footer.tpl';
?>
