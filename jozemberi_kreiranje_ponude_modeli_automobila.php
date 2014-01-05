<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	require_once('_recaptchalib.php');
	require_once('_simpleImage.php');
	require_once('_jozemberi_baza.php');
	bazaConnect();
	
	$smarty->assign('naslov', 'Kreiranje ponude - Modeli automobila');
	$smarty->assign('div_id', 'content');
	
	$sqlAkcija = "SELECT id_akcije, naziv_akcije FROM akcija";
			
			$rsAkcija = mysql_query($sqlAkcija) or die(mysql_error());						
			$akcija=array();
			while($row=mysql_fetch_array($rsAkcija)){
				$akcija[]=$row;
			}
	$smarty->assign('akcija', $akcija);
	
	$sqlMarkaAutomobila = "SELECT id_marke, marka FROM marka_automobila";
			$rsMarkaAutomobila = mysql_query($sqlMarkaAutomobila) or die(mysql_error());						
			$marka=array();
			while($row=mysql_fetch_array($rsMarkaAutomobila)){
				$marka[]=$row;
			}
	$smarty->assign('marka', $marka);
	
	$sqlMjenjac = "SELECT id_mjenjac, mjenjac FROM mjenjac";
			$rsMjenjac = mysql_query($sqlMjenjac) or die(mysql_error());						
			$mjenjac=array();
			while($row=mysql_fetch_array($rsMjenjac)){
				$mjenjac[]=$row;
			}
	$smarty->assign('mjenjac', $mjenjac);
	
	$sqlMotor = "SELECT motor.id_motora, motor.snaga, motor.radni_obujam, tip_motora.tip AS tip FROM motor INNER JOIN tip_motora ON motor.tip=tip_motora.id_tipa";
			$rsMotor = mysql_query($sqlMotor) or die(mysql_error());						
			$motor=array();
			while($row=mysql_fetch_array($rsMotor)){
				$motor[]=$row;
			}
	$smarty->assign('motor', $motor);
	
	if(isset($_GET['update'])){
		$id_model_update = $_GET['update'];
		$sql = "SELECT * FROM osnovne_konfiguracije WHERE id_osnovne_konfiguracije=$id_model_update";			
			
		$rs = mysql_query($sql) or die(mysql_error());						
		$modelUpdate=mysql_fetch_array($rs);	 
		
		if(isset($_POST['azuriraj_model'])){
			$greske=array();
			
			$model = mysql_real_escape_string($_POST['model']);
			$tip = mysql_real_escape_string($_POST['tip']);
			$god_proizvodnje = mysql_real_escape_string($_POST['god_proizvodnje']);
			$god_modela = mysql_real_escape_string($_POST['god_modela']);
			$cijena = mysql_real_escape_string($_POST['cijena']);
			$marka = mysql_real_escape_string($_POST['marka']);
			$id_akcije = mysql_real_escape_string($_POST['akcija']);
			$motor = mysql_real_escape_string($_POST['motor']);
			$mjenjac = mysql_real_escape_string($_POST['mjenjac']);
			$br_stupnjeva = mysql_real_escape_string($_POST['br_stupnjeva']);
			$naziv_slike = $modelUpdate['slika'];
			$promjena_slike='ne';
			
			if($motor == '0') $greske['motor'] = "Niste odabrali motor";
			
			if($marka == '0') $greske['marka'] = "Niste odabrali marku";
			
			if($mjenjac == '0') $greske['mjenjac'] = "Niste odabrali tip mjenjača";
			
			if(empty ($model)) $greske['model'] = "Model automobila nije unesen";
			
			if (empty ($tip)) $greske['tip'] = "Tip automobila nije unesen";
			
			if (empty ($god_proizvodnje)) $greske['god_proizvodnje'] = "Godina proizvodnje nije unesena";
			
			if (empty ($god_modela)) $greske['god_modela'] = "Godina modela nije unesena";
			
			if (empty ($cijena)) $greske['cijena'] = "Cijena nije unesena";
			
			else if((preg_match("#[a-z]+#", $cijena)) || 
						(preg_match("#[A-Z]+#", $cijena)))$greske['cijena'] = "Cijena nije odgovarajućeg formata";
						
			if(isset($_FILES["slika"]["name"])){
				if(empty($_FILES["slika"]["name"])) $greske['slika'] = "Niste odobrali sliku";
				
				else{
					if (($_FILES["slika"]["type"] == "image/gif") || ($_FILES["slika"]["type"] == "image/jpeg") || ($_FILES["slika"]["type"] == "image/png")){
						$naziv_slike= $marka.$model.$tip."_".$_FILES['slika']['name'];
						$promjena_slike='da';
						}
						
					else $greske['slika'] = "Slika mora biti .jpg, png., ili .gif";			
				}
			}
			if(isset($_POST['dostupno']) )$dostupno = 'default';
			else $dostupno = '0';
			
			if(isset($_POST['na_akciji'])) $na_akciji = '1';
			else $na_akciji = 'default';
			if($id_akcije == '0') $id_akcije = 'default';
			
				$upis_podataka = mysql_query ("UPDATE osnovne_konfiguracije SET
							 marka = '$marka', model = '$model', tip = '$tip', god_proizvodnje ='$god_proizvodnje', god_modela ='$god_modela', motor = '$motor', mjenjac='$mjenjac', br_stupnjeva ='$br_stupnjeva',
							slika = '$naziv_slike', dostupnost = $dostupno, cijena = '$cijena' , na_akciji = $na_akciji, id_akcije = $id_akcije WHERE id_osnovne_konfiguracije = $id_model_update") or die(mysql_error());
							
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
		$sql = "SELECT * FROM osnovne_konfiguracije WHERE id_osnovne_konfiguracije=$id_model_update";			
			
		$rs = mysql_query($sql) or die(mysql_error());						
		$modelUpdate=mysql_fetch_array($rs);	
		$smarty->assign('modelUpdate', $modelUpdate);
	}
	
	if (isset($_POST['kreiraj_model'])) {
		$greske=array();
	
		$model = mysql_real_escape_string($_POST['model']);
		$tip = mysql_real_escape_string($_POST['tip']);
		$god_proizvodnje = mysql_real_escape_string($_POST['god_proizvodnje']);
		$god_modela = mysql_real_escape_string($_POST['god_modela']);
		$cijena = mysql_real_escape_string($_POST['cijena']);
		$marka = mysql_real_escape_string($_POST['marka']);
		$id_akcije = mysql_real_escape_string($_POST['akcija']);
		$motor = mysql_real_escape_string($_POST['motor']);
		$mjenjac = mysql_real_escape_string($_POST['mjenjac']);
		$br_stupnjeva = mysql_real_escape_string($_POST['br_stupnjeva']);
		
		if($motor == '0') $greske['motor'] = "Niste odabrali motor";
		
		if($marka == '0') $greske['marka'] = "Niste odabrali marku";
		
		if($mjenjac == '0') $greske['mjenjac'] = "Niste odabrali tip mjenjača";
		
		if(empty ($model)) $greske['model'] = "Model automobila nije unesen";
		
		if (empty ($tip)) $greske['tip'] = "Tip automobila nije unesen";
		
		if (empty ($god_proizvodnje)) $greske['god_proizvodnje'] = "Godina proizvodnje nije unesena";
		
		if (empty ($god_modela)) $greske['god_modela'] = "Godina modela nije unesena";
		
		if (empty ($cijena)) $greske['cijena'] = "Cijena nije unesena";
		
		else if((preg_match("#[a-z]+#", $cijena)) || 
					(preg_match("#[A-Z]+#", $cijena)))$greske['cijena'] = "Cijena nije odgovarajućeg formata";
		
		if(empty($_FILES["slika"]["name"])) $greske['slika'] = "Niste odobrali sliku";
		
		else{
			if (($_FILES["slika"]["type"] == "image/gif") || ($_FILES["slika"]["type"] == "image/jpeg") || ($_FILES["slika"]["type"] == "image/png")){
				$naziv_slike= $marka.$model.$tip."_".$_FILES['slika']['name'];
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
			
			$upis_podataka = mysql_query ("INSERT INTO osnovne_konfiguracije VALUES
						(default, $marka, '$model', '$tip', '$god_proizvodnje', '$god_modela', $motor, $mjenjac, '$br_stupnjeva','$naziv_slike', $dostupno,'$cijena', $na_akciji, $id_akcije)") or die(mysql_error());
			
			copy ($_FILES['slika']['tmp_name'], "slike/".$naziv_slike) or die ('Could not upload'); 
			$image = new SimpleImage();
			$image->load($_FILES['slika']['tmp_name']);
			$visina = $image->getHeight();
			$sirina = $image->getWidth();
			if($visina > $sirina) $image->resizeToHeight(300);
			else $image->resizeToWidth(300);
			$image->save("thumbs/".$naziv_slike); 
			
			bazaDisconnect();
			$smarty->display('jozemberi_kreiranje_ponude_modeli_automobila.tpl');
			
		}
		else {
			bazaDisconnect();
			$smarty->display('jozemberi_kreiranje_ponude_modeli_automobila.tpl');
		}
	}
	else $smarty->display('jozemberi_kreiranje_ponude_modeli_automobila.tpl');
	
	include 'templates/jozemberi_footer.tpl';
?>
