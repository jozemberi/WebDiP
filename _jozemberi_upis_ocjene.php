<?php
	session_start();
	require_once('_jozemberi_baza.php');
	require_once('_jozemberi_smarty.php');
	bazaConnect();
	
	$id_konf = $_POST['id_konf'];
	
	if(!isset($_POST['glasaci'])){
		$ocjena = $_POST['ocjena'];
		$korIme = $_SESSION['username'];
		
		$rsc= mysql_query("SELECT count(*) AS total FROM ocjene_konfiguracija WHERE komentator='$korIme' AND id_konfiguracije='$id_konf'") or die(mysql_error());
		$rst = mysql_fetch_array($rsc);
		$count = $rst['total'];
		
		if($count >= 1){
			$upis_podataka = mysql_query ("UPDATE ocjene_konfiguracija SET 
							ocjena = '$ocjena' WHERE komentator = '$korIme' AND id_konfiguracije= $id_konf") or die(mysql_error());
			}
		else{
			$upis_podataka = mysql_query ("INSERT INTO ocjene_konfiguracija VALUES ('$korIme','$id_konf', '$ocjena')") or die(mysql_error());
		
		}
		$rsProsjek= mysql_query("SELECT AVG(ocjena) AS prosjek FROM ocjene_konfiguracija WHERE id_konfiguracije='$id_konf'") or die(mysql_error());
		$rstProsjek = mysql_fetch_array($rsProsjek);
		$prosjek = round($rstProsjek['prosjek'],2);
	
		$smarty->assign('prosjek', $prosjek);
		header('Content-Type:text/xml');
		$smarty->display("jozemberi_prosjecna_ocjena_xml.tpl");
	}
	
	else{
		$rsOcjenjivaci= mysql_query("SELECT komentator, ocjena FROM ocjene_konfiguracija WHERE id_konfiguracije='$id_konf'") or die(mysql_error());
		$ocjenjivaci=array();
		while($row=mysql_fetch_array($rsOcjenjivaci)){
			$ocjenjivaci[]=$row;
		}
		$smarty->assign("ocjenjivaci",$ocjenjivaci);
		header('Content-Type:text/xml');
		$smarty->display("jozemberi_korisnici_i_ocjene_xml.tpl");
	}
	
	bazaDisconnect();
?>