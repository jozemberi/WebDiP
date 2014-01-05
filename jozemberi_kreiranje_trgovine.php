<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	require_once('_jozemberi_baza.php');
	bazaConnect();
	
	$smarty->assign('naslov', 'Kreiranje trgovine');
	$smarty->assign('div_id', 'content');
	
	$sqlVoditelj = "SELECT username, ime, prezime FROM korisnik WHERE tip_korisnika='2'";
			
			$rsVoditelj = mysql_query($sqlVoditelj) or die(mysql_error());						
			$voditelj=array();
			while($row=mysql_fetch_array($rsVoditelj)){
				$voditelj[]=$row;
			}
	$smarty->assign('voditelj', $voditelj);
	
	
	if(isset($_GET['update'])){
		$id_trgovina_update = $_GET['update'];
		$sql = "SELECT * FROM trgovina WHERE id_trgovine=$id_trgovina_update";			
			
		$rs = mysql_query($sql) or die(mysql_error());						
		$trgovinaUpdate=mysql_fetch_array($rs);	 
		
		if(isset($_POST['azuriraj_trgovinu'])){
			$greske=array();
			$naziv = mysql_real_escape_string($_POST['naziv']);
			$voditelj = mysql_real_escape_string($_POST['voditelj']);
			$drzava = mysql_real_escape_string($_POST['drzava']);
			$zupanija = mysql_real_escape_string($_POST['zupanija']);
			$telefon = mysql_real_escape_string($_POST['telefon']);
			$grad = mysql_real_escape_string($_POST['grad']);
			$postanski_broj = mysql_real_escape_string($_POST['postanski_broj']);
			$ulica = mysql_real_escape_string($_POST['ulica']);
			$kucni_broj = mysql_real_escape_string($_POST['kucni_broj']);
			
			if(empty ($naziv)) $greske['naziv'] = "Naziv nije unesen";
			
			if (empty ($zupanija)) $greske['zupanija'] = "Županija nije unesena";
			
			if (empty ($telefon)) $greske['telefon'] = "Broj telefona nije unesen";
			
			if (empty ($grad)) $greske['grad'] = "Grad nije unesen";
			
			if (empty ($postanski_broj)) $greske['postanski_broj'] = "Poštanski broj nije unesen";
			
			if (empty ($ulica)) $greske['ulica'] = "Ulica nije unesena";
			
			if (empty ($kucni_broj)) $greske['kucni_broj'] = "Kućni broj nije unesen";
			
			if($voditelj=='0') $greske['voditelj'] = "Niste odabrali voditelja trgovine";
			
			if($drzava=='0') $greske['drzava'] = "Niste odabrali državu";
			
			$smarty->assign('greske', $greske);
			
			$upis_podataka = mysql_query ("UPDATE trgovina SET
							 naziv = '$naziv', voditelj_trgovine = '$voditelj', drzava = '$drzava', zupanija ='$zupanija', telefon ='$telefon', grad = '$grad', postanski_broj = '$postanski_broj', ulica = '$ulica', kucni_broj = '$kucni_broj' WHERE id_trgovine = $id_trgovina_update") or die(mysql_error());
	
		}
		$sql = "SELECT * FROM trgovina WHERE id_trgovine=$id_trgovina_update";			
			
		$rs = mysql_query($sql) or die(mysql_error());						
		$trgovinaUpdate=mysql_fetch_array($rs);	
		
		$smarty->assign('trgovinaUpdate', $trgovinaUpdate);
	}
	
	
	
	
    if (isset($_POST['kreiraj_trgovinu'])) {
		$greske=array();
	
		$naziv = mysql_real_escape_string($_POST['naziv']);
		$voditelj = mysql_real_escape_string($_POST['voditelj']);
		$drzava = mysql_real_escape_string($_POST['drzava']);
		$zupanija = mysql_real_escape_string($_POST['zupanija']);
		$telefon = mysql_real_escape_string($_POST['telefon']);
		$grad = mysql_real_escape_string($_POST['grad']);
		$postanski_broj = mysql_real_escape_string($_POST['postanski_broj']);
		$ulica = mysql_real_escape_string($_POST['ulica']);
		$kucni_broj = mysql_real_escape_string($_POST['kucni_broj']);
		
		if(empty ($naziv)) $greske['naziv'] = "Naziv nije unesen";
		
		if (empty ($zupanija)) $greske['zupanija'] = "Županija nije unesena";
		
		if (empty ($telefon)) $greske['telefon'] = "Broj telefona nije unesen";
		
		if (empty ($grad)) $greske['grad'] = "Grad nije unesen";
		
		if (empty ($postanski_broj)) $greske['postanski_broj'] = "Poštanski broj nije unesen";
		
		if (empty ($ulica)) $greske['ulica'] = "Ulica nije unesena";
		
		if (empty ($kucni_broj)) $greske['kucni_broj'] = "Kućni broj nije unesen";
		
		if($voditelj=='0') $greske['voditelj'] = "Niste odabrali voditelja trgovine";
		
		if($drzava=='0') $greske['drzava'] = "Niste odabrali državu";
		
		$smarty->assign('greske', $greske);
		
		if (empty($greske)) {	
			$upis_podataka = mysql_query ("INSERT INTO trgovina VALUES
							(default, '$naziv', '$voditelj', '$drzava', '$zupanija', '$telefon', '$grad', 
							'$postanski_broj', '$ulica','$kucni_broj')") or die(mysql_error());
			
			bazaDisconnect();
		}
		else {
			bazaDisconnect();
		}
	}
    $smarty->display('jozemberi_kreiranje_trgovine.tpl');
	
	include 'templates/jozemberi_footer.tpl';
?>
