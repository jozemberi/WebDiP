<?php
	session_start();
	require_once '_jozemberi_baza.php';
	bazaConnect();
	require_once('_jozemberi_smarty.php');
	require_once('_jozemberi_vrijeme.php');
	
	$notLoggedIn = false;
	
	if (!(isset($_SESSION['username']) && $_SESSION['username'] != '')){
		$upozorenje = 'Za kreiranje, spremanje i naručivanje konfiguracija morate biti prijavljeni u sustav';
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
		$rsc= mysql_query("SELECT count(*) AS total FROM felge") or die(mysql_error());
		
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
		
	$sqlFelge = "SELECT felge.id_felge, felge.naziv, felge.promjer, felge.boja, felge.slika, felge.cijena, felge.dostupno, felge.na_akciji, felge.id_akcije, akcija.akcijska_cijena, akcija.pocetak_akcije, akcija.zavrsetak_akcije 
		FROM felge INNER JOIN akcija ON felge.id_akcije=akcija.id_akcije LIMIT $start, $per_page";
		
		$rsFelge = mysql_query($sqlFelge) or die(mysql_error());						
		$felge=array();
		while($row=mysql_fetch_array($rsFelge)){
			if(isset($_SESSION['username'])){
				if($_SESSION['tip_korisnika']=='2' || $_SESSION['tip_korisnika']=='3'){
					$row['opcijaUredi'] ='da';
				
				}
			}
			
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
						$id_felge = $row['id_felge'];
						$upis_podataka = mysql_query ("UPDATE felge SET na_akciji = '0', id_akcije = '1' WHERE id_felge = '$id_felge'") or die(mysql_error());
					}
				}
		
			$felge[]=$row;
		}	
	
	if(isset ($_POST['page'])){
		$smarty->assign('felge', $felge);
		header('Content-Type:text/xml');
		$smarty->display('jozemberi_felge_xml.tpl');
	}	
		
	else{			
		include '_jozemberi_pagination.php';
		
		$smarty->assign("naslov", "Pregled felgi");
		$smarty->assign("div_id", "content");
		
		$smarty->assign("felge",$felge);
		
		$smarty->assign("pagination",$msg);
		$smarty->display("jozemberi_pregled_felgi.tpl");
		include 'templates/jozemberi_footer.tpl';
	}//else
	
	bazaDisconnect();
?>