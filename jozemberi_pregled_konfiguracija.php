<?php
	session_start();
	require_once '_jozemberi_baza.php';
	bazaConnect();
	require_once('_jozemberi_smarty.php');
	
	$notLoggedIn = false;
	$vlastita; // za pregled vlastitih konfiguracija
	
	if (!(isset($_SESSION['username']) && $_SESSION['username'] != '')){
		$notLoggedIn = true;
	}
	
	$per_page = 5;
	
	if(isset($_POST['page'])){
		$page = $_POST['page'];
		$page -= 1;
		$start = $page * $per_page;
	}
	
	else{
		if(!isset($_GET['korisnik']))
			$rsc= mysql_query("SELECT count(*) AS total FROM konfiguracija WHERE javna_konfiguracija='1'") or die(mysql_error());
		else {
			$korisnik=$_GET['korisnik'];
			$rsc= mysql_query("SELECT count(*) AS total FROM konfiguracija WHERE kreator_konfiguracije = '$korisnik'") or die(mysql_error());
		}
		
		$rst = mysql_fetch_array($rsc);
		$count = $rst['total'];
		
		$page=1;
		$cur_page = $page;
		$page -= 1;
		$previous_btn = true;
		$next_btn = true;
		$first_btn = true;
		$last_btn = true;
		$start = $page * $per_page;
		$no_of_paginations = ceil($count / $per_page);
	}

	if(!isset($_GET['korisnik'])){
		$sql = "SELECT konfiguracija.id_konfiguracije, korisnik.username AS kreator, konfiguracija.per_naziv AS naziv, osnovne_konfiguracije.model AS model, 
				osnovne_konfiguracije.tip AS tip_automobila, osnovne_konfiguracije.slika, osnovne_konfiguracije.god_proizvodnje,
				osnovne_konfiguracije.god_modela, marka_automobila.marka AS marka, tip_motora.tip AS tip_motora 
				FROM korisnik INNER JOIN konfiguracija INNER JOIN osnovne_konfiguracije
				INNER JOIN marka_automobila INNER JOIN motor INNER JOIN tip_motora ON korisnik.username=konfiguracija.kreator_konfiguracije AND
				konfiguracija.osnovna_konfiguracija=osnovne_konfiguracije.id_osnovne_konfiguracije AND osnovne_konfiguracije.marka=marka_automobila.id_marke
				AND osnovne_konfiguracije.motor=motor.id_motora AND motor.tip=tip_motora.id_tipa 
				WHERE konfiguracija.javna_konfiguracija='1' LIMIT $start, $per_page";	
		$vlastita='ne';
	}
	
	else{
		$korisnik=$_GET['korisnik'];
		$sql = "SELECT konfiguracija.id_konfiguracije, korisnik.username AS kreator, konfiguracija.per_naziv AS naziv, osnovne_konfiguracije.model AS model, 
				osnovne_konfiguracije.tip AS tip_automobila, osnovne_konfiguracije.slika, osnovne_konfiguracije.god_proizvodnje,
				osnovne_konfiguracije.god_modela, marka_automobila.marka AS marka, tip_motora.tip AS tip_motora 
				FROM korisnik INNER JOIN konfiguracija INNER JOIN osnovne_konfiguracije
				INNER JOIN marka_automobila INNER JOIN motor INNER JOIN tip_motora ON korisnik.username=konfiguracija.kreator_konfiguracije AND
				konfiguracija.osnovna_konfiguracija=osnovne_konfiguracije.id_osnovne_konfiguracije AND osnovne_konfiguracije.marka=marka_automobila.id_marke
				AND osnovne_konfiguracije.motor=motor.id_motora AND motor.tip=tip_motora.id_tipa WHERE konfiguracija.kreator_konfiguracije = '$korisnik'";	
		$vlastita='da';
	}
		
	$rs = mysql_query($sql) or die(mysql_error());						
		
	$konfiguracije=array();
		
	while($row=mysql_fetch_array($rs)){
		$konfiguracije[]=$row;
	}
		
	if(isset ($_POST['page'])){
		$smarty->assign('konfiguracije', $konfiguracije);
		$smarty->assign("vlastita",$vlastita);
		header('Content-Type:text/xml');
		$smarty->display('jozemberi_konfiguracije_xml.tpl');
	}	
		
	
	else{			
		include '_jozemberi_pagination.php';
		
		if(isset($_GET['korisnik'])) $smarty->assign("naslov", "Pregled vlastitih konfiguracija");
		else $smarty->assign("naslov", "Pregled javnih konfiguracija");
		
		$smarty->assign("div_id", "content");
		$smarty->assign("konfiguracija",$konfiguracije);
		$smarty->assign("vlastita",$vlastita);
		
		if(!isset($_GET['korisnik']))$smarty->assign("pagination",$msg);
		$smarty->display("jozemberi_pregled_konfiguracija.tpl");
		include 'templates/jozemberi_footer.tpl';
	}
	
	bazaDisconnect();
?>