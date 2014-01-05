<?php
	session_start();
	require_once('_jozemberi_baza.php');
	require_once('_jozemberi_smarty.php');
	bazaConnect();
	
	if(isset($_POST['page']) and (!isset($_POST['komentar']))){
		$page = $_POST['page'];
		$id_konf = $_POST['id_konf'];
		$per_page=10;
		$start=($page - 1) * $per_page;
	
		$komentari = array();
		$rs = mysql_query("SELECT komentari.id_komentara, komentari.username_komentatora, komentari.komentar, komentari.ima_podkomentare,
			komentari.dat_i_vrij_komentara, korisnik.profilna_slika AS avatar
			FROM komentari INNER JOIN korisnik ON komentari.username_komentatora=korisnik.username 
			WHERE komentari.id_konfiguracije='$id_konf' AND komentari.nadkomentar IS NULL ORDER BY id_komentara ASC LIMIT $start, $per_page") or die(mysql_error());		
			
	$prijavljen = 'ne';
	if(isset($_SESSION['username'])) $prijavljen = 'da';
		
	
		while($row = mysql_fetch_array($rs)){
				$row['dat_i_vrij_komentara'] = date('d.m.Y. H:i:s', strtotime($row['dat_i_vrij_komentara']));
				$komentari[] = $row;				
			}
			
		$rsc= mysql_query("SELECT count(*) AS total FROM komentari WHERE id_konfiguracije='$id_konf' AND komentari.nadkomentar IS NULL") or die(mysql_error());
		
		$rst = mysql_fetch_array($rsc);
	 
		$count = $rst['total'];
		$br_paginacija= ceil($count / $per_page);
		$smarty->assign('prijavljen', $prijavljen);
		$smarty->assign('br_paginacija', $br_paginacija);
		$smarty->assign('komentari',$komentari);
		header('Content-Type:text/xml');
		$smarty->display("jozemberi_komentari_xml.tpl");
	}
	
	bazaDisconnect();
?>