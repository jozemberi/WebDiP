<?php
	session_start();
	require_once '_jozemberi_baza.php';
	bazaConnect();
	require_once('_jozemberi_smarty.php');
	
	$notLoggedIn = false;
	
	if ((isset($_SESSION['username']) && $_SESSION['tip_korisnika'] != '3')){
	 header("Location:jozemberi_home.php");
	}
	
	$sqlTrgovina = "SELECT trgovina.id_trgovine, trgovina.naziv, trgovina.voditelj_trgovine, trgovina.drzava, trgovina.zupanija,trgovina.grad FROM trgovina INNER JOIN korisnik 
		ON trgovina.voditelj_trgovine=korisnik.username";
		
		$rsTrgovina = mysql_query($sqlTrgovina) or die(mysql_error());						
		$trgovina=array();
		
		while($row=mysql_fetch_array($rsTrgovina)){
			$trgovina[]=$row;
		}
			
		
		$smarty->assign("naslov", "Pregled trgovina");
		$smarty->assign("div_id", "content");
		
		$smarty->assign("trgovina",$trgovina);
		
		$smarty->display("jozemberi_pregled_trgovina.tpl");
		include 'templates/jozemberi_footer.tpl';
	
	bazaDisconnect();
?>