<?php
	$pagination = "";
	
	if($lastpage > 1){	
		$pagination .= "<div class=\"pagination\" align=\"center\">";
		//link prethodno
		if ($page > 1) 
			$pagination.= "<a href=\"$targetpage?page=$prev&status=$status\">« prethodno</a>";
		else
			$pagination.= "<span class=\"disabled\">« prethodno</span>";	
		
		//stranice
		if ($lastpage < 7 + ($adjacents * 2)){	//ako nema dovoljno stranica da se napravi prekid
			for ($counter = 1; $counter <= $lastpage; $counter++){
				if ($counter == $page)
					$pagination.= "<span class=\"current\">$counter</span>";
				else
					$pagination.= "<a href=\"$targetpage?page=$counter&status=$status\">$counter</a>";					
			}
		}
		
		elseif($lastpage > 5 + ($adjacents * 2)){	//ako ima dovoljno stranica da se neke sakriju
			//ako je blizu početka, sakrij stranice pred kraj
			if($page < 1 + ($adjacents * 2)){
				for ($counter = 1; $counter < 4 + ($adjacents * 2); $counter++){
					if ($counter == $page)
						$pagination.= "<span class=\"current\">$counter</span>";
					else
						$pagination.= "<a href=\"$targetpage?page=$counter&status=$status\">$counter</a>";					
				}
				$pagination.= "...";
				$pagination.= "<a href=\"$targetpage?page=$lpm1&status=$status\">$lpm1</a>";
				$pagination.= "<a href=\"$targetpage?page=$lastpage&status=$status\">$lastpage</a>";		
			}
			//u sredini, sakrij sa početka i sa kraja
			elseif($lastpage - ($adjacents * 2) > $page && $page > ($adjacents * 2)){
				$pagination.= "<a href=\"$targetpage?page=1&status=$status\">1</a>";
				$pagination.= "<a href=\"$targetpage?page=2&status=$status\">2</a>";
				$pagination.= "...";
				for ($counter = $page - $adjacents; $counter <= $page + $adjacents; $counter++){
					if ($counter == $page)
						$pagination.= "<span class=\"current\">$counter</span>";
					else
						$pagination.= "<a href=\"$targetpage?page=$counter&status=$status\">$counter</a>";					
				}
				$pagination.= "...";
				$pagination.= "<a href=\"$targetpage?page=$lpm1&status=$status\">$lpm1</a>";
				$pagination.= "<a href=\"$targetpage?page=$lastpage&status=$status\">$lastpage</a>";		
			}
			//blizu kraja, sakrij s početka stranice
			else{
				$pagination.= "<a href=\"$targetpage?page=1&status=$status\">1</a>";
				$pagination.= "<a href=\"$targetpage?page=2&status=$status\">2</a>";
				$pagination.= "...";
				for ($counter = $lastpage - (2 + ($adjacents * 2)); $counter <= $lastpage; $counter++){
					if ($counter == $page)
						$pagination.= "<span class=\"current\">$counter</span>";
					else
						$pagination.= "<a href=\"$targetpage?page=$counter&status=$status\">$counter</a>";					
				}
			}
		}
		
		//link sljedeće
		if ($page < $counter - 1) 
			$pagination.= "<a href=\"$targetpage?page=$next&status=$status\">sljedeće »</a>";
		else
			$pagination.= "<span class=\"disabled\">sljedeće »</span>";
		$pagination.= "</div>\n";		
	}
	
	
?>