<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	require_once('_recaptchalib.php');
	require_once('_simpleImage.php');
	require_once('_jozemberi_baza.php');
	bazaConnect();
	
	$smarty->assign('naslov', 'Kreiranje ponude - Felge');
	$smarty->assign('div_id', 'content');
	
	$sqlAkcija = "SELECT id_akcije, naziv_akcije FROM akcija";
			
			$rsAkcija = mysql_query($sqlAkcija) or die(mysql_error());						
			$akcija=array();
			while($row=mysql_fetch_array($rsAkcija)){
				$akcija[]=$row;
			}
	$smarty->assign('akcija', $akcija);
	
	
	if(isset($_GET['update'])){
		$id_felge_update = $_GET['update'];
		$sql = "SELECT * FROM felge WHERE id_felge=$id_felge_update";			
			
		$rs = mysql_query($sql) or die(mysql_error());						
		$felgeUpdate=mysql_fetch_array($rs);	 
		
		if(isset($_POST['azuriraj_felge'])){
			$greske=array();
			$naziv = mysql_real_escape_string($_POST['naziv']);
			$boja = mysql_real_escape_string($_POST['boja']);
			$promjer = mysql_real_escape_string($_POST['promjer']);
			$cijena = mysql_real_escape_string($_POST['cijena']);
			$id_akcije = mysql_real_escape_string($_POST['akcija']);
			$naziv_slike = $felgeUpdate['slika'];
			$promjena_slike='ne';
			
			if(empty ($naziv)) $greske['naziv'] = "Naziv nije unesen";
			
			if (empty ($boja)) $greske['boja'] = "Boja felge nije unesena";
			
			if (empty ($promjer)) $greske['promjer'] = "Promjer felge nije unesen";
			
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
			
				$upis_podataka = mysql_query ("UPDATE felge SET
							 naziv = '$naziv', promjer ='$promjer', boja ='$boja',
							slika = '$naziv_slike', dostupno = $dostupno, cijena = '$cijena' , na_akciji = $na_akciji, id_akcije = $id_akcije WHERE id_felge = $id_felge_update") or die(mysql_error());
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
		$sql = "SELECT * FROM felge WHERE id_felge=$id_felge_update";			
			
		$rs = mysql_query($sql) or die(mysql_error());						
		$gumeUpdate=mysql_fetch_array($rs);	
		$smarty->assign('felgeUpdate', $gumeUpdate);
	}
	
	if (isset($_POST['kreiraj_felge'])) {
		$greske=array();
	
		$naziv = mysql_real_escape_string($_POST['naziv']);
		$boja = mysql_real_escape_string($_POST['boja']);
		$promjer = mysql_real_escape_string($_POST['promjer']);
		$cijena = mysql_real_escape_string($_POST['cijena']);
		$id_akcije = mysql_real_escape_string($_POST['akcija']);
		
		
		if(empty ($naziv)) $greske['naziv'] = "Naziv nije unesen";
		
		if (empty ($boja)) $greske['boja'] = "Boja felge nije unesena";
		
		if (empty ($promjer)) $greske['promjer'] = "Promjer felge nije unesen";
		
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
			
			$upis_podataka = mysql_query ("INSERT INTO felge VALUES
						(default, '$naziv', '$promjer', '$boja', '$naziv_slike', $dostupno,'$cijena' ,$na_akciji, $id_akcije)") or die(mysql_error());
			
			copy ($_FILES['slika']['tmp_name'], "slike/".$naziv_slike) or die ('Could not upload'); 
			$image = new SimpleImage();
			$image->load($_FILES['slika']['tmp_name']);
			$visina = $image->getHeight();
			$sirina = $image->getWidth();
			if($visina > $sirina) $image->resizeToHeight(300);
			else $image->resizeToWidth(300);
			$image->save("thumbs/".$naziv_slike); 
			
			bazaDisconnect();
			$smarty->display('jozemberi_kreiranje_ponude_felge.tpl');
			
		}
		else {
			bazaDisconnect();
			$smarty->display('jozemberi_kreiranje_ponude_felge.tpl');
		}
	}
	else $smarty->display('jozemberi_kreiranje_ponude_felge.tpl');
	
	include 'templates/jozemberi_footer.tpl';
?>
