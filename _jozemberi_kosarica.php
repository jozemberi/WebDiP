<?php
error_reporting(E_ALL ^ E_NOTICE); // Report all errors except E_NOTICE

	/* Dodaje proizvod u košaricu*/
	function dodajProizvod($pid,$imeKat, $kol){
		if($pid<1 or $kol<1) return;
	
		if(is_array($_SESSION[$imeKat])){
			$postoji = proizvodPostoji($pid,$imeKat);
			if($postoji){
				$_SESSION[$imeKat][$postoji-1]['kol']+=$kol;
			}
			  else{  
				$max=count($_SESSION[$imeKat]);
				$_SESSION[$imeKat][$max]['pid']=$pid;
				$_SESSION[$imeKat][$max]['kol']=$kol;
			}
		}
		else{
			unset($_SESSION[$imeKat]);
			$_SESSION[$imeKat]=array();
			$_SESSION[$imeKat][0]['pid']=$pid;
			$_SESSION[$imeKat][0]['kol']=$kol;
		} 
	}

	function ukloniProizvod($pid, $imeKat){
		$pid=intval($pid);
		$max=count($_SESSION[$imeKat]);
		for($i=0;$i<$max;$i++){
			if($pid==$_SESSION[$imeKat][$i]['pid']){
				unset($_SESSION[$imeKat][$i]);
				break;
			}
		}
		$_SESSION[$imeKat]=array_values($_SESSION[$imeKat]);
	}
	
	function proizvodPostoji($pid, $imeKat){
		$pid=intval($pid);
		$max=count($_SESSION[$imeKat]);
		$index=0;
		for($i=0;$i<$max;$i++){
			if($pid==$_SESSION[$imeKat][$i]['pid']){
				$index=$i+1;
				break;
			}
		}
		return $index;
	}
	
	function ispraznikosaricu(){
		unset($_SESSION['gume']);
		unset($_SESSION['felge']);
		unset($_SESSION['oprema']);
	}
		
?>