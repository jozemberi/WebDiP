<?php
	require_once('_jozemberi_baza.php');
	require_once('_jozemberi_smarty.php');
	bazaConnect();

	$id_komentara = $_POST['id_komentara'];
	
	$podkomentari = array();
	$rs = mysql_query("SELECT komentari.id_komentara, komentari.username_komentatora, komentari.komentar,
			komentari.dat_i_vrij_komentara, korisnik.profilna_slika AS avatar
			FROM komentari INNER JOIN korisnik ON komentari.username_komentatora=korisnik.username 
			WHERE komentari.nadkomentar='$id_komentara' ORDER BY id_komentara") or die(mysql_error());		
	while($row = mysql_fetch_array($rs)){
		$row['dat_i_vrij_komentara'] = date('d.m.Y. H:i:s', strtotime($row['dat_i_vrij_komentara']));
		$podkomentari[] = $row;
	}
			
	$smarty->assign('podkomentari',$podkomentari);
	header('Content-Type:text/xml');
	$smarty->display("jozemberi_podkomentari_xml.tpl");

	bazaDisconnect();
?>