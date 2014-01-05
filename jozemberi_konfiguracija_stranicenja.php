<?php
	session_start();
	require_once('_jozemberi_smarty.php');
	require_once('_jozemberi_baza.php');
	bazaConnect();
	
	$smarty->assign('naslov', 'Konfiguracija straničenja');
	$smarty->assign('div_id', 'content_v530px');
	
	$rss= mysql_query ("SELECT sustav.limit, sustav.susjednost FROM sustav WHERE id='1'") or die(mysql_error());
	$rez=mysql_fetch_array($rss);
	
	$smarty->assign('rez', $rez);
	
	if(isset($_POST['azuriraj_stranicenje'])){
		$greske=array();
		$limit = mysql_real_escape_string($_POST['limit']);
		$susjednost = mysql_real_escape_string($_POST['susjednost']);
			
		if(empty ($limit)) $greske['limit'] = "Limit nije unesen";
			
		if (empty ($susjednost)) $greske['susjednost'] = "Susjednost nije unesena";
		if(empty($greske)){	
			$upis_podataka = mysql_query ("UPDATE sustav SET
							 sustav.limit = '$limit', susjednost ='$susjednost' WHERE id = '1'") or die(mysql_error());
			
			
			}
		$rss= mysql_query ("SELECT sustav.limit, sustav.susjednost FROM sustav WHERE id='1'") or die(mysql_error());
		$rez=mysql_fetch_array($rss);
	
		$smarty->assign('rez', $rez);	
		}
	
    $smarty->display('jozemberi_konfiguracija_stranicenja.tpl');
	
	include 'templates/jozemberi_footer.tpl';
?>
