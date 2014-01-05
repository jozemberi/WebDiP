<?php
	session_start();
	require_once('_jozemberi_vrijeme.php');
	
	if($_POST){
		require_once('_jozemberi_baza.php');
		bazaConnect();
		
		$komentar = $_POST['komentar'];
		$nadkomentar = $_POST['nadkomentar'];
		$id_konf = $_POST['id_konf'];
		$username = $_SESSION['username'];
		$per_page=10;
		
		$date = virtualnoVrijeme();
		$dat_kom = date('Y-m-d H:i:s', $date);
		
		if($nadkomentar == 'nula'){;
			$sqlInsert = "INSERT INTO komentari VALUES (default, '$id_konf', '$username', '$komentar', '$dat_kom', null, null)"; 
			$rsInsert = mysql_query($sqlInsert) or die(mysql_error());	
		}
		else{
			$sqlInsert = "INSERT INTO komentari VALUES (default, '$id_konf', '$username', '$komentar', '$dat_kom', '$nadkomentar', null)"; 
			$rsInsert = mysql_query($sqlInsert) or die(mysql_error());	
			$update_nadkomentara = mysql_query ("UPDATE komentari SET 
							ima_podkomentare = true WHERE id_komentara = '$nadkomentar'") or die(mysql_error());
		}
		
	$rsc= mysql_query("SELECT count(*) AS total FROM komentari WHERE id_konfiguracije='$id_konf'  AND komentari.nadkomentar IS NULL") or die(mysql_error());
		
		$rst = mysql_fetch_array($rsc);
	 
		$count = $rst['total'];
		$br_paginacija = ceil($count / $per_page);
	
		echo "$br_paginacija";
		
		bazaDisconnect();
	}
?>
