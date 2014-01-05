<?php
	session_start();

	require_once '_jozemberi_baza.php';
	bazaConnect();
	require_once('_jozemberi_smarty.php');
	require_once('_jozemberi_vrijeme.php');
	
	$notLoggedIn = false;
	
	if (!(isset($_SESSION['username']) && $_SESSION['username'] != '')){
		$upozorenje = 'Neregistriranim korisnicima su dostupni samo modeli automobila i dodatna oprema <br />Za pregled, kreiranje, spremanje i naručivanje
		konfiguracija morate biti prijavljeni u sustav';
		$notLoggedIn = true;
		$smarty->assign("upozorenje", $upozorenje);
	}
	
	$per_page = 4;
	
	if(isset($_POST['page'])){
		$page = $_POST['page'];
		$page -= 1;
		$start = $page * $per_page;
	}
	
	else{
		$rsc= mysql_query("SELECT count(*) AS total FROM osnovne_konfiguracije") or die(mysql_error());
		
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
	
	$sql = "SELECT osnovne_konfiguracije.id_osnovne_konfiguracije, osnovne_konfiguracije.model AS model, 
				osnovne_konfiguracije.tip AS tip_automobila, osnovne_konfiguracije.slika, osnovne_konfiguracije.god_proizvodnje, osnovne_konfiguracije.cijena,
				osnovne_konfiguracije.god_modela, marka_automobila.marka AS marka, tip_motora.tip AS tip_motora, motor.snaga, motor.radni_obujam, mjenjac.mjenjac, osnovne_konfiguracije.br_stupnjeva, osnovne_konfiguracije.dostupnost AS dostupno, akcija.akcijska_cijena, akcija.pocetak_akcije, akcija.zavrsetak_akcije, osnovne_konfiguracije.na_akciji, osnovne_konfiguracije.id_akcije 
				FROM osnovne_konfiguracije INNER JOIN mjenjac INNER JOIN akcija
				INNER JOIN marka_automobila INNER JOIN motor INNER JOIN tip_motora ON osnovne_konfiguracije.mjenjac=mjenjac.id_mjenjac
				AND osnovne_konfiguracije.marka=marka_automobila.id_marke AND osnovne_konfiguracije.id_akcije=akcija.id_akcije
				AND osnovne_konfiguracije.motor=motor.id_motora AND motor.tip=tip_motora.id_tipa LIMIT $start, $per_page";	
		
	$rs = mysql_query($sql) or die(mysql_error());						
		
		
	$modeli_automobila=array();
		
	while($row=mysql_fetch_array($rs)){
		if(isset($row['na_akciji'])){
				$pocetakAkcije = strtotime ($row['pocetak_akcije']);
					$zavrsetakAkcije = strtotime ($row['zavrsetak_akcije']);
					$trenutnoVrijeme = virtualnoVrijeme();
					
					if($pocetakAkcije < $trenutnoVrijeme and $zavrsetakAkcije > $trenutnoVrijeme){
						$row['akcijaValjana'] ='da';
					}
					else if ($pocetakAkcije > $trenutnoVrijeme and $zavrsetakAkcije > $trenutnoVrijeme){
						$row['na_akciji'] = '0';
					}
					else if ($row['pocetak_akcije'] == null or $row['zavrsetak_akcije'] == null){
						$row['na_akciji'] = '0'; 
						$id_osnovne_konfiguracije = $row['id_osnovne_konfiguracije'];
						$upis_podataka = mysql_query ("UPDATE osnovne_konfiguracije SET na_akciji = '0', id_akcije = '1' WHERE id_osnovne_konfiguracije = $id_osnovne_konfiguracije") or die(mysql_error());
					}
				}
				
		$modeli_automobila[]=$row;
	}
		
	if(isset ($_POST['page'])){
		$smarty->assign('modeli_automobila', $modeli_automobila);
		header('Content-Type:text/xml');
		$smarty->display('jozemberi_modeli_automobila_xml.tpl');
	}	
		
	else{			
		include '_jozemberi_pagination.php';
		
		$smarty->assign("naslov", "Odabir osnovne konfiguracije");
		$smarty->assign("div_id", "content");
		
		$smarty->assign("modeli_automobila",$modeli_automobila);
		
		$smarty->assign("pagination",$msg);
		$smarty->display("jozemberi_odabir_osnovne_konfiguracije.tpl");
		include 'templates/jozemberi_footer.tpl';
	}//else
	
	bazaDisconnect();
?>