<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	require_once('_recaptchalib.php');
	require_once('_simpleImage.php');
	require_once('_jozemberi_baza.php');
	bazaConnect();
	
	$smarty->assign('naslov', 'Kreiranje ponude - Gume');
	$smarty->assign('div_id', 'content');
	
	$sqlAkcija = "SELECT id_akcije, naziv_akcije FROM akcija";
			
			$rsAkcija = mysql_query($sqlAkcija) or die(mysql_error());						
			$akcija=array();
			while($row=mysql_fetch_array($rsAkcija)){
				$akcija[]=$row;
			}
	$smarty->assign('akcija', $akcija);
	
	if(isset($_GET['update'])){
		$id_gume_update = $_GET['update'];
		$sql = "SELECT * FROM gume WHERE id_gume=$id_gume_update";			
			
		$rs = mysql_query($sql) or die(mysql_error());						
		$gumeUpdate=mysql_fetch_array($rs);	 
		
		if(isset($_POST['azuriraj_gume'])){
			$greske=array();
	
			$naziv = mysql_real_escape_string($_POST['naziv']);
			$sirina = mysql_real_escape_string($_POST['sirina']);
			$visina = mysql_real_escape_string($_POST['visina']);
			$promjer = mysql_real_escape_string($_POST['promjer']);
			$vrsta_gume = mysql_real_escape_string($_POST['vrsta_gume']);
			$tip_gume = mysql_real_escape_string($_POST['tip_gume']);
			$cijena = mysql_real_escape_string($_POST['cijena']);
			$id_akcije = mysql_real_escape_string($_POST['akcija']);
			$naziv_slike = $gumeUpdate['slika'];
			$promjena_slike='ne';
			
			if(empty ($naziv)) $greske['naziv'] = "Naziv nije unesen";
			
			if (empty ($sirina)) $greske['sirina'] = "Širina gume nije unesena";
			
			if (empty ($visina)) $greske['visina'] = "Visina gume nije unesena";
			
			if (empty ($promjer)) $greske['promjer'] = "Promjer gume nije unesen";
			
			if($vrsta_gume=='0') $greske['vrsta_gume'] = "Niste odabrali vrstu gume";
			
			if($tip_gume=='0') $greske['tip_gume'] = "Niste odabrali tip gume";
			
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
			
				$upis_podataka = mysql_query ("UPDATE gume SET
							 naziv = '$naziv', sirina = '$sirina', visina = '$visina', promjer ='$promjer', vrsta ='$vrsta_gume', tip = '$tip_gume', 
							slika = '$naziv_slike', dostupno = $dostupno, cijena = '$cijena' , na_akciji = $na_akciji, id_akcije = $id_akcije WHERE id_gume = $id_gume_update") or die(mysql_error());
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
		$sql = "SELECT * FROM gume WHERE id_gume=$id_gume_update";			
			
		$rs = mysql_query($sql) or die(mysql_error());						
		$gumeUpdate=mysql_fetch_array($rs);	
		$smarty->assign('gumeUpdate', $gumeUpdate);
	}
	
	
	
	
    if (isset($_POST['kreiraj_gume'])) {
		$greske=array();
	
		$naziv = mysql_real_escape_string($_POST['naziv']);
		$sirina = mysql_real_escape_string($_POST['sirina']);
		$visina = mysql_real_escape_string($_POST['visina']);
		$promjer = mysql_real_escape_string($_POST['promjer']);
		$vrsta_gume = mysql_real_escape_string($_POST['vrsta_gume']);
		$tip_gume = mysql_real_escape_string($_POST['tip_gume']);
		$cijena = mysql_real_escape_string($_POST['cijena']);
		$id_akcije = mysql_real_escape_string($_POST['akcija']);
		
		
		if(empty ($naziv)) $greske['naziv'] = "Naziv nije unesen";
		
		if (empty ($sirina)) $greske['sirina'] = "Širina gume nije unesena";
		
		if (empty ($visina)) $greske['visina'] = "Visina gume nije unesena";
		
		
		if (empty ($promjer)) $greske['promjer'] = "Promjer gume nije unesen";
		
		if($vrsta_gume=='0') $greske['vrsta_gume'] = "Niste odabrali vrstu gume";
		
		if($tip_gume=='0') $greske['tip_gume'] = "Niste odabrali tip gume";
		
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
			
			$upis_podataka = mysql_query ("INSERT INTO gume VALUES
							(default, '$naziv', '$sirina', '$visina', '$promjer', '$vrsta_gume', '$tip_gume', 
							'$naziv_slike', $dostupno,'$cijena' ,$na_akciji, $id_akcije)") or die(mysql_error());
			
				copy ($_FILES['slika']['tmp_name'], "slike/".$naziv_slike) or die ('Could not upload'); 
				$image = new SimpleImage();
				$image->load($_FILES['slika']['tmp_name']);
				$visina = $image->getHeight();
				$sirina = $image->getWidth();
				if($visina > $sirina) $image->resizeToHeight(300);
				else $image->resizeToWidth(300);
				$image->save("thumbs/".$naziv_slike); 
			
			
			bazaDisconnect();
			
		}
		else {
			bazaDisconnect();
		}
	}
    $smarty->display('jozemberi_kreiranje_ponude_gume.tpl');
	
	include 'templates/jozemberi_footer.tpl';
?>
