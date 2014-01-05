<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	require_once('_simpleImage.php');
	require_once('_jozemberi_baza.php');
	bazaConnect();
	
	$smarty->assign('naslov', 'Kreiranje vijesti');
	$smarty->assign('div_id', 'content_v530px');
	
	if (isset($_POST['kreiraj_vijesti'])) {
		$greske=array();
	
		$tekst = mysql_real_escape_string($_POST['tekst']);
		$tip = mysql_real_escape_string($_POST['tip']);
		
		if(empty ($tekst)) $greske['tekst'] = "Tekst vijesti nije unesen";
		if($tip=='0') $greske['tip']='Niste odabrali tip vijesti';
	
		$smarty->assign('greske', $greske);
		
		if (empty($greske)) {
			$rsK= mysql_query("SELECT pretplate.id_tipa_pretplate, korisnik.email, korisnik.ime, tipovi_pretplate.naziv FROM pretplate INNER JOIN korisnik INNER JOIN tipovi_pretplate ON pretplate.pretplatnik=korisnik.username AND pretplate.id_tipa_pretplate = tipovi_pretplate.id_tipa WHERE pretplate.id_tipa_pretplate = '$tip'") or die(mysql_error());	
		while($row=mysql_fetch_array($rsK)){
			$email = $row['email'];
			$ime = $row['ime'];
			
		
			$subject = $row['naziv'];
			$message = "Postovani $ime! $tekst";
			$headers = 'From: vijesti@carconfig.hr'; 
			
			mail($email, $subject, $message, $headers);
			
		}
		$uspjeh='<span class="zeleno"> Vijest je poslana svim pretplaćenim korisnicima </span> <br />';
		$smarty->assign('uspjeh', $uspjeh);
			
		}
		
	}
	bazaDisconnect();
	
	$smarty->display('jozemberi_kreiranje_vijesti.tpl');
	
	include 'templates/jozemberi_footer.tpl';
?>
