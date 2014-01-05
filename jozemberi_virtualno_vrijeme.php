<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	require_once('_jozemberi_baza.php');
	require_once('_jozemberi_vrijeme.php');
	
	$smarty->assign("naslov", "Podešavanje virtualnog vremena");
	$smarty->assign("div_id", "content_v530px");
	
	if(isset($_POST['preuzmiPomak'])){
		$url = "http://arka.foi.hr/PzaWeb/PzaWeb2004/config/pomak.xml";      
		if(! ($fp = fopen($url,'r'))) {
		  echo "Problem: nije moguće otvoriti xml" ;
		  exit;
		}
		  
		$xml_string = fread($fp, 10000);
		fclose($fp);
		  
		$domdoc = new DOMDocument;
		$domdoc->loadXML($xml_string);
		  
		$params = $domdoc->getElementsByTagName('pomak');
		$sati = 0;
		
		foreach ($params as $param) {
			$attributes = $param->attributes;
			foreach ($attributes as $attr => $val) {
				if($attr == "brojSati") {
				$sati = $val->value;
				}
			}
		}
		bazaConnect();
	
		$update_pomak= mysql_query ("UPDATE sustav SET pomak = '$sati' WHERE id='1'");
	
		bazaDisconnect();
	}
	
	$vrijeme_sustava = virtualnoVrijeme();
	
	
	$smarty->assign("virtualno_vrijeme", $vrijeme_sustava);
	
	$smarty->display("jozemberi_virtualno_vrijeme.tpl");
	
	include 'templates/jozemberi_footer.tpl';
?>