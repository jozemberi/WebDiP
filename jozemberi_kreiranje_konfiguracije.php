<?php
	session_start();

	require_once '_jozemberi_baza.php';
	bazaConnect();
	require_once('_jozemberi_smarty.php');
	require_once('_jozemberi_kosarica.php');
	require_once('_jozemberi_vrijeme.php');
	
	$notLoggedIn = false;
	
	if (!(isset($_SESSION['username']) && $_SESSION['username'] != '')){
		header("Location:jozemberi_login.php");
	}
	
	$per_page = 4;
	if(isset($_GET['id_konf']))$id_osnovne_konfiguracije=$_GET['id_konf'];
	
	if(isset($_POST['id_konf']) and isset($_POST['ukupnaCijenaKonfiguracije'])){
		$kreator=$_SESSION['username'];
		$naziv_konf = $_POST['naziv_konf'];
		$id_konf = $_POST['id_konf'];
		$cijena = $_POST['ukupnaCijenaKonfiguracije'];
		$boja = $_POST['boja'];
		$javna = $_POST['javna'];
		
		$sqlInsert = mysql_query ("INSERT INTO konfiguracija VALUES (default, '$kreator', '$naziv_konf', $id_konf, $boja, current_timestamp, $javna, 'test', '$cijena')") or die(mysql_error());	
		
		$rsc= mysql_query("SELECT id_konfiguracije AS total FROM konfiguracija WHERE kreator_konfiguracije='$kreator' and per_naziv='$naziv_konf'") or die(mysql_error());
		$rst = mysql_fetch_array($rsc);
		$id_kreirane_konfiguracije = $rst['total'];
		
		/* Upis guma */
		$max=count($_SESSION['gume']);
		for($i=0;$i<$max;$i++){
			$pid=$_SESSION['gume'][$i]['pid'];
			$kolicina = $_SESSION['gume'][$i]['kol'];
			$sqlInsert = mysql_query ("INSERT INTO popis_guma VALUES ('$id_kreirane_konfiguracije', '$pid', '$kolicina')") or die(mysql_error());
		}
		
		/* Upis felgi */
		$max=count($_SESSION['felge']);
		for($i=0;$i<$max;$i++){
			$pid=$_SESSION['felge'][$i]['pid'];
			$kolicina = $_SESSION['felge'][$i]['kol'];
			$sqlInsert = mysql_query ("INSERT INTO popis_felgi VALUES ('$id_kreirane_konfiguracije', '$pid', '$kolicina')") or die(mysql_error());
		}
		
		/* Upis dodatne opreme */
		$max=count($_SESSION['oprema']);
		for($i=0;$i<$max;$i++){
			$pid=$_SESSION['oprema'][$i]['pid'];
			$kolicina = $_SESSION['oprema'][$i]['kol'];
			$sqlInsert = mysql_query ("INSERT INTO popis_dodatne_opreme VALUES ('$id_kreirane_konfiguracije', '$pid', '$kolicina')") or die(mysql_error());
		}
		
		isprazniKosaricu();
	}//if
	
	if(isset($_POST['pid']) and isset($_POST['imeKat']) and isset($_POST['akc'])){
		$pid=$_POST['pid'];
		$imeKat=$_POST['imeKat'];
		if(isset($_POST['kol'])) $kol= $_POST['kol'];
		$akc=$_POST['akc'];
		
		if($akc=='dodaj' and $imeKat=='gume'){
			dodajProizvod($pid,$imeKat, $kol);
			
			$sqlGume = "SELECT gume.id_gume, gume.naziv, gume.sirina, gume.visina, gume.promjer, gume.slika, gume.cijena, vrsta_gume.vrsta, tip_gume.tip, gume.na_akciji, gume.id_akcije, akcija.akcijska_cijena, akcija.pocetak_akcije, akcija.zavrsetak_akcije
			FROM gume INNER JOIN vrsta_gume INNER JOIN tip_gume INNER JOIN akcija
			ON gume.vrsta=vrsta_gume.id_vrste AND gume.tip=tip_gume.id_tipa AND gume.id_akcije=akcija.id_akcije WHERE gume.id_gume=$pid";
			
			$rsGume = mysql_query($sqlGume) or die(mysql_error());						
			$gume=array();
			while($row=mysql_fetch_array($rsGume)){
				if(isset($row['na_akciji'])){
					$pocetakAkcije = strtotime ($row['pocetak_akcije']);
					$zavrsetakAkcije = strtotime ($row['zavrsetak_akcije']);
					$trenutnoVrijeme = virtualnoVrijeme();
					
					if($pocetakAkcije < $trenutnoVrijeme and $zavrsetakAkcije > $trenutnoVrijeme){
						$row['cijena'] =$row['akcijska_cijena'];
					}	
				}
				$gume[]=$row;
			}
			
			$smarty->assign('kolicina', $kol);
			$smarty->assign('gume', $gume);
			header('Content-Type:text/xml');
			$smarty->display('jozemberi_gume_xml.tpl');
		}
		else if($akc=='dodaj' and $imeKat=='felge'){
			dodajProizvod($pid,$imeKat, $kol);
			
			$sqlFelge = "SELECT felge.id_felge, felge.naziv, felge.promjer, felge.boja, felge.slika, felge.cijena, felge.na_akciji, felge.id_akcije, akcija.akcijska_cijena, akcija.pocetak_akcije, akcija.zavrsetak_akcije
			FROM felge INNER JOIN akcija ON felge.id_akcije=akcija.id_akcije WHERE felge.id_felge='$pid'";
			
			$rsFelge = mysql_query($sqlFelge) or die(mysql_error());						
			$felge=array();
			while($row=mysql_fetch_array($rsFelge)){
				if(isset($row['na_akciji'])){
					$pocetakAkcije = strtotime ($row['pocetak_akcije']);
					$zavrsetakAkcije = strtotime ($row['zavrsetak_akcije']);
					$trenutnoVrijeme = virtualnoVrijeme();
					
					if($pocetakAkcije < $trenutnoVrijeme and $zavrsetakAkcije > $trenutnoVrijeme){
						$row['cijena'] =$row['akcijska_cijena'];
					}	
				}
				$felge[]=$row;
			}
		
			$smarty->assign('kolicina', $kol);
			$smarty->assign('felge', $felge);
			header('Content-Type:text/xml');
			$smarty->display('jozemberi_felge_xml.tpl');
		}
		
		else if($akc=='dodaj' and $imeKat=='oprema'){
			dodajProizvod($pid,$imeKat, $kol);
			
			$sqlOprema = "SELECT dodatna_oprema.id_opreme, dodatna_oprema.naziv, dodatna_oprema.proizvodac, 
			dodatna_oprema.opis, dodatna_oprema.slika, dodatna_oprema.cijena, dodatna_oprema.opis, dodatna_oprema.slika, dodatna_oprema.cijena, dodatna_oprema.na_akciji, dodatna_oprema.id_akcije, akcija.akcijska_cijena, akcija.pocetak_akcije, akcija.zavrsetak_akcije
			FROM dodatna_oprema INNER JOIN akcija ON dodatna_oprema.id_akcije=akcija.id_akcije WHERE dodatna_oprema.id_opreme='$pid'";
		
			$rsOprema = mysql_query($sqlOprema) or die(mysql_error());						
			$oprema=array();
			while($row=mysql_fetch_array($rsOprema)){
				if(isset($row['na_akciji'])){
					$pocetakAkcije = strtotime ($row['pocetak_akcije']);
						$zavrsetakAkcije = strtotime ($row['zavrsetak_akcije']);
						$trenutnoVrijeme = virtualnoVrijeme();
						
						if($pocetakAkcije < $trenutnoVrijeme and $zavrsetakAkcije > $trenutnoVrijeme){
							$row['cijena'] =$row['akcijska_cijena'];
						}
					
				}
				$oprema[]=$row;
			}
				$smarty->assign('kolicina', $kol);
				$smarty->assign('oprema', $oprema);
				header('Content-Type:text/xml');
				$smarty->display('jozemberi_oprema_xml.tpl');
		}
			
		else if($akc=='ukloni'){
			ukloniProizvod($pid, $imeKat);
		}
	}
	
	else if(isset($_POST['page']) and isset($_POST['kategorija']) and isset($_POST['id_konf'])){
		$page = $_POST['page'];
		$page -= 1;
		$start = $page * $per_page;
	
		$id_osnovne_konfiguracije=$_POST['id_konf'];
		$kategorija = $_POST['kategorija'];
		if($kategorija == 'gume'){
			$sqlGume = "SELECT gume.id_gume, gume.naziv, gume.sirina, gume.visina, gume.promjer, gume.slika, gume.cijena, vrsta_gume.vrsta, tip_gume.tip,
				gume.na_akciji, gume.id_akcije, akcija.akcijska_cijena, akcija.pocetak_akcije, akcija.zavrsetak_akcije
				FROM gume INNER JOIN vrsta_gume INNER JOIN tip_gume INNER JOIN akcija
				ON gume.vrsta=vrsta_gume.id_vrste AND gume.tip=tip_gume.id_tipa AND gume.id_akcije=akcija.id_akcije WHERE gume.dostupno='1' LIMIT $start, $per_page";
				
				$rsGume = mysql_query($sqlGume) or die(mysql_error());						
				$gume=array();
				while($row=mysql_fetch_array($rsGume)){
					if(isset($row['na_akciji'])){
					$pocetakAkcije = strtotime ($row['pocetak_akcije']);
						$zavrsetakAkcije = strtotime ($row['zavrsetak_akcije']);
						$trenutnoVrijeme = virtualnoVrijeme();
						
						if($pocetakAkcije < $trenutnoVrijeme and $zavrsetakAkcije > $trenutnoVrijeme){
							$row['cijena'] =$row['akcijska_cijena'];
						}		
					}
					$gume[]=$row;
				}
				
				$rsc= mysql_query("SELECT count(*) AS total FROM gume WHERE dostupno='1'") or die(mysql_error());
				
				$rst = mysql_fetch_array($rsc);
			 
				$count = $rst['total'];
				$br_paginacija= ceil($count / $per_page);	
				
				$smarty->assign('br_paginacija', $br_paginacija);
				$smarty->assign('gume', $gume);
				header('Content-Type:text/xml');
				$smarty->display('jozemberi_gume_xml.tpl');
		}//if
		
		else if($kategorija == 'felge'){
				$sqlFelge = "SELECT felge.id_felge, felge.naziv, felge.promjer, felge.boja, felge.slika, felge.cijena, felge.na_akciji, felge.id_akcije, akcija.akcijska_cijena, akcija.pocetak_akcije, akcija.zavrsetak_akcije FROM felge INNER JOIN akcija ON felge.id_akcije=akcija.id_akcije WHERE felge.dostupno='1' LIMIT $start, $per_page";
				
				$rsFelge = mysql_query($sqlFelge) or die(mysql_error());						
				$felge=array();
				while($row=mysql_fetch_array($rsFelge)){
					if(isset($row['na_akciji'])){
					$pocetakAkcije = strtotime ($row['pocetak_akcije']);
						$zavrsetakAkcije = strtotime ($row['zavrsetak_akcije']);
						$trenutnoVrijeme = virtualnoVrijeme();
						
						if($pocetakAkcije < $trenutnoVrijeme and $zavrsetakAkcije > $trenutnoVrijeme){
							$row['cijena'] =$row['akcijska_cijena'];
						}	
					}
				
					$felge[]=$row;
				}
				$rsc= mysql_query("SELECT count(*) AS total FROM felge WHERE dostupno='1'") or die(mysql_error());
				
				$rst = mysql_fetch_array($rsc);
			 
				$count = $rst['total'];
				$br_paginacija= ceil($count / $per_page);	
				
				$smarty->assign('br_paginacija', $br_paginacija);
				$smarty->assign('felge', $felge);
				header('Content-Type:text/xml');
				$smarty->display('jozemberi_felge_xml.tpl');
				
		}//if
		
		else if($kategorija == 'oprema'){
				$sqlOprema = "SELECT dodatna_oprema.id_opreme, dodatna_oprema.naziv, dodatna_oprema.proizvodac, 
			dodatna_oprema.opis, dodatna_oprema.slika, dodatna_oprema.cijena, dodatna_oprema.na_akciji, dodatna_oprema.id_akcije, akcija.akcijska_cijena, akcija.pocetak_akcije, akcija.zavrsetak_akcije
			FROM dodatna_oprema INNER JOIN akcija ON dodatna_oprema.id_akcije=akcija.id_akcije WHERE dodatna_oprema.dostupno='1' LIMIT $start, $per_page";
				
				$rsOprema = mysql_query($sqlOprema) or die(mysql_error());						
				$oprema=array();
				while($row=mysql_fetch_array($rsOprema)){
					if(isset($row['na_akciji'])){
					$pocetakAkcije = strtotime ($row['pocetak_akcije']);
						$zavrsetakAkcije = strtotime ($row['zavrsetak_akcije']);
						$trenutnoVrijeme = virtualnoVrijeme();
						
						if($pocetakAkcije < $trenutnoVrijeme and $zavrsetakAkcije > $trenutnoVrijeme){
							$row['cijena'] =$row['akcijska_cijena'];
						}
						
						
					}
					$oprema[]=$row;
				}
				$rsc= mysql_query("SELECT count(*) AS total FROM dodatna_oprema WHERE dostupno='1'") or die(mysql_error());
				
				$rst = mysql_fetch_array($rsc);
			 
				$count = $rst['total'];
				$br_paginacija= ceil($count / $per_page);	
				
				$smarty->assign('br_paginacija', $br_paginacija);
				$smarty->assign('oprema', $oprema);
				header('Content-Type:text/xml');
				$smarty->display('jozemberi_oprema_xml.tpl');
				
		}//if
		
	}//else if
	
	else if (!isset($_POST['kol']) and (!isset ($_POST['page'])) and isset($_GET['id_konf'])){
		
		$sql = "SELECT osnovne_konfiguracije.id_osnovne_konfiguracije, osnovne_konfiguracije.model AS model, 
				osnovne_konfiguracije.tip AS tip_automobila, osnovne_konfiguracije.slika, osnovne_konfiguracije.god_proizvodnje, osnovne_konfiguracije.cijena,
				osnovne_konfiguracije.god_modela, marka_automobila.marka AS marka, tip_motora.tip AS tip_motora, motor.snaga, motor.radni_obujam, mjenjac.mjenjac, osnovne_konfiguracije.br_stupnjeva, osnovne_konfiguracije.dostupnost AS dostupno, akcija.akcijska_cijena, akcija.pocetak_akcije, akcija.zavrsetak_akcije, osnovne_konfiguracije.na_akciji, osnovne_konfiguracije.id_akcije   
				FROM osnovne_konfiguracije INNER JOIN mjenjac
				INNER JOIN marka_automobila INNER JOIN motor INNER JOIN tip_motora INNER JOIN akcija ON osnovne_konfiguracije.mjenjac=mjenjac.id_mjenjac AND
				osnovne_konfiguracije.marka=marka_automobila.id_marke AND osnovne_konfiguracije.id_akcije=akcija.id_akcije
				AND osnovne_konfiguracije.motor=motor.id_motora AND motor.tip=tip_motora.id_tipa 
				WHERE osnovne_konfiguracije.id_osnovne_konfiguracije='$id_osnovne_konfiguracije'";	

		$_SESSION['id_osnovne_konfiguracije'] = $id_osnovne_konfiguracije;
		
		$rs = mysql_query($sql) or die(mysql_error());						
			
		$konf=mysql_fetch_array($rs); 
		if(!$konf){
			$upozorenje = 'Konfiguracija ne postoji ili Vam nije dostupna';
			$smarty->assign("upozorenje", $upozorenje);
			
		}
		
		if(isset($konf['na_akciji'])){
					$pocetakAkcije = strtotime ($konf['pocetak_akcije']);
						$zavrsetakAkcije = strtotime ($konf['zavrsetak_akcije']);
						$trenutnoVrijeme = virtualnoVrijeme();
						
						if($pocetakAkcije < $trenutnoVrijeme and $zavrsetakAkcije > $trenutnoVrijeme){
							$konf['akcijaValjana'] ='da';
						}
						else if ($pocetakAkcije > $trenutnoVrijeme and $zavrsetakAkcije > $trenutnoVrijeme){
							$konf['na_akciji'] = '0';
						}
						
		}
		
		$sqlBoja = "SELECT id_boje, naziv FROM boje";
		
		$rsBoja = mysql_query($sqlBoja) or die(mysql_error());						
		$boja=array();
		while($row=mysql_fetch_array($rsBoja)){
			$boja[]=$row;
		}
		
		
		$smarty->assign("naslov", "Kreiranje nove konfiguracije");
		$smarty->assign("div_id", "content");
			
		$smarty->assign("konfiguracija",$konf);
		
		$smarty->assign("boja", $boja);
		
		$smarty->display("jozemberi_kreiranje_konfiguracije.tpl");
		include 'templates/jozemberi_footer.tpl';
	}
	bazaDisconnect();
?>