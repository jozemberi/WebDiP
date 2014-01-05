<?php
	session_start();
	require_once '_jozemberi_baza.php';
	bazaConnect();
	require_once('_jozemberi_smarty.php');
	
	$notLoggedIn = false;
	
	if (!(isset($_SESSION['username']) && $_SESSION['username'] != '')){
		$upozorenje = 'Ocjenjivanje i komentiranje konfiguracija je dostupno prijavljenim korisnicima <br />
						Galerija slika je dostupna klikom na sliku';
		$notLoggedIn = true;
		$smarty->assign("upozorenje", $upozorenje);
	}
	
	$id_konfiguracije=$_GET['id_konf'];
	
	if($notLoggedIn==true){
		$sql = "SELECT konfiguracija.id_konfiguracije, korisnik.username AS kreator, konfiguracija.per_naziv AS naziv, osnovne_konfiguracije.model AS model, 
				osnovne_konfiguracije.tip AS tip_automobila, osnovne_konfiguracije.slika, osnovne_konfiguracije.god_proizvodnje, osnovne_konfiguracije.cijena,
				osnovne_konfiguracije.god_modela, marka_automobila.marka AS marka, tip_motora.tip AS tip_motora, motor.snaga, motor.radni_obujam, mjenjac.mjenjac, osnovne_konfiguracije.br_stupnjeva  
				FROM korisnik INNER JOIN konfiguracija INNER JOIN osnovne_konfiguracije INNER JOIN mjenjac
				INNER JOIN marka_automobila INNER JOIN motor INNER JOIN tip_motora ON korisnik.username=konfiguracija.kreator_konfiguracije AND osnovne_konfiguracije.mjenjac=mjenjac.id_mjenjac AND
				konfiguracija.osnovna_konfiguracija=osnovne_konfiguracije.id_osnovne_konfiguracije AND osnovne_konfiguracije.marka=marka_automobila.id_marke
				AND osnovne_konfiguracije.motor=motor.id_motora AND motor.tip=tip_motora.id_tipa 
				WHERE konfiguracija.javna_konfiguracija='1' AND konfiguracija.id_konfiguracije='$id_konfiguracije'";			
	}
	
	else{
		$sql = "SELECT konfiguracija.id_konfiguracije, korisnik.username AS kreator, konfiguracija.per_naziv AS naziv, osnovne_konfiguracije.model AS model, 
				osnovne_konfiguracije.tip AS tip_automobila, osnovne_konfiguracije.slika, osnovne_konfiguracije.god_proizvodnje, osnovne_konfiguracije.cijena,
				osnovne_konfiguracije.god_modela, marka_automobila.marka AS marka, tip_motora.tip AS tip_motora, motor.snaga, motor.radni_obujam, mjenjac.mjenjac, osnovne_konfiguracije.br_stupnjeva 
				FROM korisnik INNER JOIN konfiguracija INNER JOIN osnovne_konfiguracije INNER JOIN mjenjac
				INNER JOIN marka_automobila INNER JOIN motor INNER JOIN tip_motora ON korisnik.username=konfiguracija.kreator_konfiguracije AND osnovne_konfiguracije.mjenjac=mjenjac.id_mjenjac AND
				konfiguracija.osnovna_konfiguracija=osnovne_konfiguracije.id_osnovne_konfiguracije AND osnovne_konfiguracije.marka=marka_automobila.id_marke
				AND osnovne_konfiguracije.motor=motor.id_motora AND motor.tip=tip_motora.id_tipa WHERE konfiguracija.id_konfiguracije='$id_konfiguracije'";	
	}
		
	$rs = mysql_query($sql) or die(mysql_error());						
		
		
	$konfiguracije=array();
		
	$konfiguracija=mysql_fetch_array($rs);
	if(!$konfiguracija){
		$upozorenje = 'Konfiguracija ne postoji ili Vam nije dostupna';
		$smarty->assign("upozorenje", $upozorenje);
		
	}
	else{
		$sqlGume = "SELECT popis_guma.kolicina, gume.naziv, gume.sirina, gume.visina, gume.promjer, gume.slika, gume.cijena, vrsta_gume.vrsta, tip_gume.tip
		FROM popis_guma INNER JOIN gume INNER JOIN vrsta_gume INNER JOIN tip_gume 
		ON popis_guma.id_gume=gume.id_gume AND gume.vrsta=vrsta_gume.id_vrste AND
		gume.tip=tip_gume.id_tipa WHERE popis_guma.id_konfiguracije='$id_konfiguracije'";
		
		$rsGume = mysql_query($sqlGume) or die(mysql_error());						
		$gume=array();
		while($row=mysql_fetch_array($rsGume)){
			$gume[]=$row;
		}
		
		$sqlFelge = "SELECT popis_felgi.kolicina, felge.naziv, felge.promjer, felge.boja, felge.slika, felge.cijena
		FROM popis_felgi INNER JOIN felge 
		ON popis_felgi.id_felge=felge.id_felge WHERE popis_felgi.id_konfiguracije='$id_konfiguracije'";
		
		$rsFelge = mysql_query($sqlFelge) or die(mysql_error());						
		$felge=array();
		while($row=mysql_fetch_array($rsFelge)){
			$felge[]=$row;
		}
		
		$sqlOprema = "SELECT popis_dodatne_opreme.kolicina, dodatna_oprema.naziv, dodatna_oprema.proizvodac, 
		dodatna_oprema.opis, dodatna_oprema.slika, dodatna_oprema.cijena
		FROM popis_dodatne_opreme INNER JOIN dodatna_oprema 
		ON popis_dodatne_opreme.id_opreme=dodatna_oprema.id_opreme WHERE popis_dodatne_opreme.id_kofiguracije='$id_konfiguracije'";
		
		$rsOprema = mysql_query($sqlOprema) or die(mysql_error());						
		$oprema=array();
		while($row=mysql_fetch_array($rsOprema)){
			$oprema[]=$row;
		}
		if($notLoggedIn==false){
			$korIme = $_SESSION['username'];
			$rsOcjena= mysql_query("SELECT ocjena FROM ocjene_konfiguracija WHERE komentator='$korIme' AND id_konfiguracije='$id_konfiguracije'") or die(mysql_error());
			$rstOcjena = mysql_fetch_array($rsOcjena);
			$ocjena = $rstOcjena['ocjena'];
			$ocjenaPostotak = $ocjena * 20;
		}
		
		$rsProsjek= mysql_query("SELECT AVG(ocjena) AS prosjek FROM ocjene_konfiguracija WHERE id_konfiguracije='$id_konfiguracije'") or die(mysql_error());
		$rstProsjek = mysql_fetch_array($rsProsjek);
		$prosjek = round($rstProsjek['prosjek'],2);
		
		
		$smarty->assign("naslov", "Pregled konfiguracije");
		$smarty->assign("div_id", "content");
			
		$smarty->assign("konfiguracija",$konfiguracija);
		$smarty->assign("gume", $gume);
		$smarty->assign("felge", $felge);
		$smarty->assign("oprema", $oprema);
		
		$smarty->assign("prosjek",$prosjek);
		if($notLoggedIn==false){
			$smarty->assign("ocjenaPostotak",$ocjenaPostotak);
		}
		
		$smarty->display("jozemberi_pregled_konfiguracije.tpl");
		include 'templates/jozemberi_footer.tpl';
	}
	
	bazaDisconnect();
?>