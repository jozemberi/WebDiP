<?php
	session_start();
	require_once '_jozemberi_baza.php';
	bazaConnect();
	require_once('_jozemberi_smarty.php');
	
	$notLoggedIn = false;
	
	if (!(isset($_SESSION['username']) && $_SESSION['username'] != '')){
		$notLoggedIn = true;
	}
	
	$per_page = 3;
	
	if(isset($_POST['status']) and isset($_POST['id_konfiguracije']) and isset($_POST['narucitelj']) and isset($_POST['id_narudzbe'])){
		$id_status = $_POST['status'];
		$id_konf = $_POST['id_konfiguracije'];
		$narucitelj = $_POST['narucitelj'];
		$id_narudzbe = $_POST['id_narudzbe'];
		
		$update_podataka = mysql_query ("UPDATE narudzba SET status = $id_status WHERE id_narudzbe = $id_narudzbe") or die(mysql_error());
		
		$rsK= mysql_query("SELECT korisnik.email, korisnik.ime, konfiguracija.per_naziv, status_narudzbe.status FROM korisnik INNER JOIN konfiguracija INNER JOIN status_narudzbe INNER JOIN narudzba ON korisnik.username=konfiguracija.kreator_konfiguracije AND narudzba.status = status_narudzbe.id_statusa AND
				narudzba.narucitelj = korisnik.username AND narudzba.id_konfiguracije = konfiguracija.id_konfiguracije WHERE narudzba.id_narudzbe = $id_narudzbe") or die(mysql_error());	
				
		$rst = mysql_fetch_array($rsK);
		$email = $rst['email'];
		$ime = $rst['ime'];
		
		$naziv_konf = $rst['per_naziv'];
		
		$status = $rst['status'];
		
		$subject = "Promjena statusa Vase narudzbe";
		$message = "Postovani $ime! Status Vase narudzbe za konfiguraciju \"$naziv_konf\" je promijenjen. Novi status Vase narudzbe je: $status ";
		$headers = 'From: noreplay@carconfig.hr'; 
			
		mail($email, $subject, $message, $headers);
		
	
	
	}
	
	else if(isset($_POST['page'])){
		$page = $_POST['page'];
		$page -= 1;
		$start = $page * $per_page;
	
		$rsc= mysql_query("SELECT count(*) AS total FROM korisnik INNER JOIN konfiguracija INNER JOIN narudzba
				ON korisnik.username=konfiguracija.kreator_konfiguracije AND narudzba.narucitelj = korisnik.username AND narudzba.id_konfiguracije = konfiguracija.id_konfiguracije") or die(mysql_error());	
			
		
		
		$rst = mysql_fetch_array($rsc);
		$count = $rst['total'];
		
	$br_paginacija= ceil($count / $per_page);
	
	$sql = "SELECT konfiguracija.id_konfiguracije, korisnik.username AS kreator, korisnik.email, konfiguracija.per_naziv AS naziv, osnovne_konfiguracije.model AS model, konfiguracija.cijena,
				osnovne_konfiguracije.tip AS tip_automobila, osnovne_konfiguracije.slika, osnovne_konfiguracije.god_proizvodnje,
				osnovne_konfiguracije.god_modela, marka_automobila.marka AS marka, tip_motora.tip AS tip_motora, narudzba.narucitelj, narudzba.id_konfiguracije, narudzba.status, narudzba.kolicina, narudzba.dat_i_vrij_narudzbe, narudzba.id_narudzbe 
				FROM korisnik INNER JOIN konfiguracija INNER JOIN osnovne_konfiguracije INNER JOIN narudzba
				INNER JOIN marka_automobila INNER JOIN motor INNER JOIN tip_motora ON korisnik.username=konfiguracija.kreator_konfiguracije AND
				konfiguracija.osnovna_konfiguracija=osnovne_konfiguracije.id_osnovne_konfiguracije AND osnovne_konfiguracije.marka=marka_automobila.id_marke
				AND osnovne_konfiguracije.motor=motor.id_motora AND motor.tip=tip_motora.id_tipa AND narudzba.narucitelj = korisnik.username AND narudzba.id_konfiguracije = konfiguracija.id_konfiguracije
				LIMIT $start, $per_page";	
		
	$rs = mysql_query($sql) or die(mysql_error());						
		
	$konfiguracije=array();
		
	while($row=mysql_fetch_array($rs)){
		$konfiguracije[]=$row;
	}
		
	if(isset ($_POST['page'])){
		$smarty->assign('konfiguracije', $konfiguracije);
		$smarty->assign('br_paginacija', $br_paginacija);
		header('Content-Type:text/xml');
		$smarty->display('jozemberi_konfiguracije_xml.tpl');
	}
}	
	
	else{
		$smarty->assign("naslov", "Pregled naručenih konfiguracija");
		
		$smarty->assign("div_id", "content");
		
		$smarty->display("jozemberi_pregled_narucenih_konfiguracija.tpl");
		include 'templates/jozemberi_footer.tpl';
	}
	
	bazaDisconnect();
?>