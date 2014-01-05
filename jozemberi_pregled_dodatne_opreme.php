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
		$rsc= mysql_query("SELECT count(*) AS total FROM dodatna_oprema") or die(mysql_error());
		
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
		
	$sqlOprema = "SELECT dodatna_oprema.id_opreme, dodatna_oprema.naziv, dodatna_oprema.proizvodac, 
		dodatna_oprema.opis, dodatna_oprema.slika, dodatna_oprema.cijena, dodatna_oprema.dostupno, dodatna_oprema.na_akciji, dodatna_oprema.id_akcije, akcija.akcijska_cijena, akcija.pocetak_akcije, akcija.zavrsetak_akcije, kategorije_opreme.kategorija, predefinirane_linije.naziv AS naziv_linije
		FROM dodatna_oprema INNER JOIN akcija INNER JOIN kategorije_opreme INNER JOIN predefinirane_linije ON dodatna_oprema.kategorija=kategorije_opreme.id_kategorije AND dodatna_oprema.predefinirana_linija=predefinirane_linije.id_linije AND dodatna_oprema.id_akcije=akcija.id_akcije LIMIT $start, $per_page";
		
		$rsOprema = mysql_query($sqlOprema) or die(mysql_error());						
		$oprema=array();
		while($row=mysql_fetch_array($rsOprema)){
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
						$id_opreme = $row['id_opreme'];
						$upis_podataka = mysql_query ("UPDATE dodatna_oprema SET na_akciji = '0', id_akcije = '1' WHERE id_opreme = $id_opreme") or die(mysql_error());
					}
				}
		
			$oprema[]=$row;
		}	
		
	if(isset ($_POST['page'])){
		$smarty->assign('oprema', $oprema);
		header('Content-Type:text/xml');
		$smarty->display('jozemberi_oprema_xml.tpl');
	}	
		
	else{			
		
		include '_jozemberi_pagination.php';
		
		$smarty->assign("naslov", "Pregled dodatne opreme");
		$smarty->assign("div_id", "content");
		
		$smarty->assign("oprema",$oprema);
		
		$smarty->assign("pagination",$msg);
		$smarty->display("jozemberi_pregled_dodatne_opreme.tpl");
		include 'templates/jozemberi_footer.tpl';
	}//else
	
	bazaDisconnect();
?>