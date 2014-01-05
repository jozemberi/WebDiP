<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	require_once('_recaptchalib.php');
	require_once('_simpleImage.php');
	require_once('_jozemberi_baza.php');
	bazaConnect();
	
	$smarty->assign('naslov', 'Kreiranje ponude - Dodatna oprema');
	$smarty->assign('div_id', 'content');
	
	$sqlAkcija = "SELECT id_akcije, naziv_akcije FROM akcija";
			
			$rsAkcija = mysql_query($sqlAkcija) or die(mysql_error());						
			$akcija=array();
			while($row=mysql_fetch_array($rsAkcija)){
				$akcija[]=$row;
			}
	$smarty->assign('akcija', $akcija);
	
	$sqlKategorijeOpreme = "SELECT id_kategorije, kategorija FROM kategorije_opreme";
			$rsKategorijeOpreme = mysql_query($sqlKategorijeOpreme) or die(mysql_error());						
			$kategorija=array();
			while($row=mysql_fetch_array($rsKategorijeOpreme)){
				$kategorija[]=$row;
			}
	$smarty->assign('kategorija', $kategorija);
	
	$sqlPredefiniraneLinije = "SELECT id_linije, naziv FROM predefinirane_linije";
			$rsPredefiniraneLinije = mysql_query($sqlPredefiniraneLinije) or die(mysql_error());						
			$linija=array();
			while($row=mysql_fetch_array($rsPredefiniraneLinije)){
				$linija[]=$row;
			}
	$smarty->assign('linija', $linija);
	
	if(isset($_GET['update'])){
		$id_opreme_update = $_GET['update'];
		$sql = "SELECT * FROM dodatna_oprema WHERE id_opreme=$id_opreme_update";			
			
		$rs = mysql_query($sql) or die(mysql_error());						
		$opremaUpdate=mysql_fetch_array($rs);	 
		
		if(isset($_POST['azuriraj_opremu'])){
			$greske=array();
	
			$naziv = mysql_real_escape_string($_POST['naziv']);
			$proizvodac = mysql_real_escape_string($_POST['proizvodac']);
			$opis = mysql_real_escape_string($_POST['opis']);
			$cijena = mysql_real_escape_string($_POST['cijena']);
			$id_kategorije = mysql_real_escape_string($_POST['kategorija']);
			$id_akcije = mysql_real_escape_string($_POST['akcija']);
			$linija = mysql_real_escape_string($_POST['linija']);
			$naziv_slike = $opremaUpdate['slika'];
			$promjena_slike='ne';
			
			if($id_kategorije == '0') $greske['kategorija'] = "Niste odabrali kategoriju";
			
			if(empty ($naziv)) $greske['naziv'] = "Naziv nije unesen";
			
			if (empty ($proizvodac)) $greske['proizvodac'] = "Proizvođač nije unesen";
			
			if (empty ($opis)) $greske['opis'] = "Opis nije unesen";
			
			if (empty ($cijena)) $greske['cijena'] = "Cijena nije unesena";
			
			else if((preg_match("#[a-z]+#", $cijena)) || 
						(preg_match("#[A-Z]+#", $cijena)))$greske['cijena'] = "Cijena nije odgovarajućeg formata";
			
			if(isset($_FILES["slika"]["name"])){
				if(empty($_FILES["slika"]["name"])) $greske['slika'] = "Niste odobrali sliku";
			
				else{
					if (($_FILES["slika"]["type"] == "image/gif") || ($_FILES["slika"]["type"] == "image/jpeg") || ($_FILES["slika"]["type"] == "image/png")){
						$naziv_slike= $naziv."_".$_FILES['slika']['name'];
						$promjena_slike = 'da';
						}
					else $greske['slika'] = "Slika mora biti .jpg, png., ili .gif";			
				}
			}
			
		 
		   
		  if(isset($_POST['dostupno']) )$dostupno = 'default';
			else $dostupno = '0';
			
			if(isset($_POST['na_akciji'])) $na_akciji = '1';
			else $na_akciji = 'default';
			if($id_akcije == '0') $id_akcije = 'default';
			
				$upis_podataka = mysql_query ("UPDATE dodatna_oprema SET kategorija ='$id_kategorije',
							 naziv = '$naziv', proizvodac = '$proizvodac',slika = '$naziv_slike', opis='$opis', dostupno = $dostupno, cijena = '$cijena', predefinirana_linija='$linija', na_akciji = $na_akciji, id_akcije = $id_akcije WHERE id_opreme = $id_opreme_update") or die(mysql_error());
				if($promjena_slike=='da'){
					copy ($_FILES['slika']['tmp_name'], "slike/".$naziv_slike) or die ('Could not upload'); 
					$image = new SimpleImage();
					$image->load($_FILES['slika']['tmp_name']);
					$visina = $image->getHeight();
					$sirina = $image->getWidth();
					if($visina > $sirina) $image->resizeToHeight(300);
					else $image->resizeToWidth(300);
					$image->save("thumbs/".$naziv_slike); 
				}
			
	
		}
		$sql = "SELECT * FROM dodatna_oprema WHERE id_opreme=$id_opreme_update";			
			
		$rs = mysql_query($sql) or die(mysql_error());						
		$opremaUpdate=mysql_fetch_array($rs);	
		$smarty->assign('opremaUpdate', $opremaUpdate);
	}//update
	
	if (isset($_POST['kreiraj_opremu'])) {
		$greske=array();
	
		$naziv = mysql_real_escape_string($_POST['naziv']);
		$proizvodac = mysql_real_escape_string($_POST['proizvodac']);
		$opis = mysql_real_escape_string($_POST['opis']);
		$cijena = mysql_real_escape_string($_POST['cijena']);
		$id_kategorije = mysql_real_escape_string($_POST['kategorija']);
		$id_akcije = mysql_real_escape_string($_POST['akcija']);
		$linija = mysql_real_escape_string($_POST['linija']);
		
		if($id_kategorije == '0') $greske['kategorija'] = "Niste odabrali kategoriju";
		
		if(empty ($naziv)) $greske['naziv'] = "Naziv nije unesen";
		
		if (empty ($proizvodac)) $greske['proizvodac'] = "Proizvođač nije unesen";
		
		if (empty ($opis)) $greske['opis'] = "Opis nije unesen";
		
		if (empty ($cijena)) $greske['cijena'] = "Cijena nije unesena";
		
		else if((preg_match("#[a-z]+#", $cijena)) || 
					(preg_match("#[A-Z]+#", $cijena)))$greske['cijena'] = "Cijena nije odgovarajućeg formata";
		
		if(empty($_FILES["slika"]["name"])) $greske['slika'] = "Niste odobrali sliku";
		
		else{
			if (($_FILES["slika"]["type"] == "image/gif") || ($_FILES["slika"]["type"] == "image/jpeg") || ($_FILES["slika"]["type"] == "image/png")){
				$naziv_slike= $naziv."_".$_FILES['slika']['name'];
				}
				
			else $greske['slika'] = "Slika mora biti .jpg, png., ili .gif";			
		}
		
		$smarty->assign('greske', $greske);
		
		if (empty($greske)) {
			
			if(isset($_POST['dostupno']) )$dostupno = 'default';
			else $dostupno = '0';
			
			if(isset($_POST['na_akciji'])) $na_akciji = '1';
			else $na_akciji = 'default';
			if($id_akcije == '0') $id_akcije = 'default';
			
			$upis_podataka = mysql_query ("INSERT INTO dodatna_oprema VALUES
						(default, '$id_kategorije', '$naziv', '$proizvodac', '$naziv_slike', '$opis', $dostupno,'$cijena', $linija, $na_akciji, $id_akcije)") or die(mysql_error());
			
			copy ($_FILES['slika']['tmp_name'], "slike/".$naziv_slike) or die ('Could not upload'); 
			$image = new SimpleImage();
			$image->load($_FILES['slika']['tmp_name']);
			$visina = $image->getHeight();
			$sirina = $image->getWidth();
			if($visina > $sirina) $image->resizeToHeight(300);
			else $image->resizeToWidth(300);
			$image->save("thumbs/".$naziv_slike); 
			
			bazaDisconnect();
			$smarty->display('jozemberi_kreiranje_ponude_dodatna_oprema.tpl');
			
		}
		else {
			bazaDisconnect();
			$smarty->display('jozemberi_kreiranje_ponude_dodatna_oprema.tpl');
		}
	}
	else $smarty->display('jozemberi_kreiranje_ponude_dodatna_oprema.tpl');
	
	include 'templates/jozemberi_footer.tpl';
?>
