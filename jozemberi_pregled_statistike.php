<?php
	session_start();
	
	if (!(isset($_SESSION['username']) && $_SESSION['username'] != '') or $_SESSION['tip_korisnika']!='3'){
		$_SESSION['notLoggedIn']='Stranica Vam nije dostupna!';
		header('Location:jozemberi_home.php');
	}

	else{
		include '_jozemberi_baza.php';
	
		bazaConnect();
		require_once('_jozemberi_smarty.php');
		require_once ("_recaptchalib.php");
		require_once('_jozemberi_vrijeme.php');
	/*
		$mailhide_pubkey = '01OI55-Z-BH5KxJDcJkbuUNQ==';
		$mailhide_privkey = 'e2e8f0730c60908ac5805d755a551384';
	
	*/
		if(isset($_POST['prikazi'])) $status = $_POST['statusPost'];	
		else $status = $_GET['status'];
		$nemaRez=0;
	
		if($status != '0'){	
			$rsc= mysql_query("SELECT count(*) AS total FROM statistika WHERE tip_podatka='$status'") or die(mysql_error());
			$rst = mysql_fetch_array($rsc);
		 
			$total_rows = $rst['total'];
			if($total_rows == '0'){
				$nemaRez = 1;
			}
			else{
				$targetpage = "jozemberi_pregled_statistike.php"; 	
				
				$rss= mysql_query ("SELECT sustav.limit, sustav.susjednost FROM sustav WHERE id='1'") or die(mysql_error());
				$rez=mysql_fetch_array($rss);
				$li= intval($rez['limit']);
				$su = intval($rez['susjednost']);
				
				$adjacents = $su;
				$limit = $li; 								
				
				if(isset($_GET['page'])) $page = $_GET['page'];
				else $page=0;
				
				if($page) $start = ($page - 1) * $limit;
				else $start = 0;	

				if ($page == 0) $page = 1;					
				$prev = $page - 1;							
				$next = $page + 1;							
				$lastpage = ceil($total_rows/$limit);		
				$lpm1 = $lastpage - 1;
				
				if($page > $lastpage){
					$errorMessage = date("d.m.Y.H:i:s", virtualnoVrijeme());
					$errorMessage.= "; STRANICA: jozemberi_ispis_korisnika.php; KORISNIK: " .
					$_SESSION['username'] . "(" . $_SESSION['ime'] . " " .
					$_SESSION['prezime'] . "); UNESENI ID:" . $_GET['page'];
					$errorMessage.="\n";
					error_log($errorMessage, 3, "_errorlog.txt");
					header("Location:jozemberi_home.php");
				}
	
				else{
					$sql = "SELECT korisnik.profilna_slika, statistika.tip_podatka, statistika.dat_i_vrij, statistika.korisnik, tip_podatka.tip FROM statistika INNER JOIN tip_podatka INNER JOIN korisnik ON statistika.tip_podatka = tip_podatka.id AND statistika.korisnik=korisnik.username WHERE statistika.tip_podatka='$status' LIMIT $start, $limit";			
					$rs = mysql_query($sql) or die(mysql_error());						
					
					$korisnici=array();
					while($row=mysql_fetch_array($rs)){
						$row['dat_i_vrij'] = date('d.m.Y. H:i:s', strtotime($row['dat_i_vrij']));
						//$row['email']=recaptcha_mailhide_html ($mailhide_pubkey, $mailhide_privkey, $row['email']);
						$korisnici[]=$row;
					}
				}
				
			
			}
		}
	/* svi korisnici, status=0 */
		else{	
			$rsc= mysql_query("SELECT count(*) AS total FROM statistika") or die(mysql_error());
			$rst = mysql_fetch_array($rsc);
		 
			$total_rows = $rst['total'];
			
			if($total_rows == '0'){
					$nemaRez = 1;
				}
				
			else{
				$targetpage = "jozemberi_pregled_statistike.php"; 	
				
				$rss= mysql_query ("SELECT sustav.limit, sustav.susjednost FROM sustav WHERE id='1'") or die(mysql_error());
				$rez=mysql_fetch_array($rss);
				$li= intval($rez['limit']);
				$su = intval($rez['susjednost']);
				
				$adjacents = $su;
				$limit = $li; 								
				
				if(isset($_GET['page'])) $page = $_GET['page'];
				else $page=0;
				
				if($page) $start = ($page - 1) * $limit;
				else $start = 0;	

				if ($page == 0) $page = 1;					
				$prev = $page - 1;							
				$next = $page + 1;							
				$lastpage = ceil($total_rows/$limit);		
				$lpm1 = $lastpage - 1;
				
				if($page > $lastpage){
					$errorMessage = date("d.m.Y.H:i:s", virtualnoVrijeme());
					$errorMessage.= "; STRANICA: jozemberi_ispis_korisnika.php; KORISNIK: " .
					$_SESSION['username'] . "(" . $_SESSION['ime'] . " " .
					$_SESSION['prezime'] . "); UNESENI ID:" . $_GET['page'];
					$errorMessage.="\n";
					error_log($errorMessage, 3, "_errorlog.txt");
					header("Location:jozemberi_home.php");
				}
				
				else{
					$sql = "SELECT korisnik.profilna_slika, statistika.tip_podatka, statistika.dat_i_vrij, statistika.korisnik, tip_podatka.tip FROM statistika INNER JOIN tip_podatka INNER JOIN korisnik ON statistika.tip_podatka = tip_podatka.id AND statistika.korisnik=korisnik.username LIMIT $start, $limit";	
					$rs = mysql_query($sql) or die(mysql_error());	
					
					$korisnici=array();
					while($row=mysql_fetch_array($rs)){
						$row['dat_i_vrij'] = date('d.m.Y. H:i:s', strtotime($row['dat_i_vrij']));
						//$row['email']=recaptcha_mailhide_html ($mailhide_pubkey, $mailhide_privkey, $row['email']);
						$korisnici[]=$row;
					}
				}
			}
		}//else
		
		$smarty->assign("naslov", "Pregled statistike");
		
		if($nemaRez==1){
			$smarty->assign("nemaKorisnika", "Nema takvih korisnika");
			$smarty->assign("div_id", "content_v530px");
		}
		else {
			$smarty->assign("div_id", "content");
			$smarty->assign("korisnici",$korisnici);
			include '_pagination.php';
			$smarty->assign("pagination",$pagination);
		}
	$smarty->assign("status",$status);
	$smarty->display("jozemberi_pregled_statistike.tpl");
	
	bazaDisconnect();
	include 'templates/jozemberi_footer.tpl';
}
?>