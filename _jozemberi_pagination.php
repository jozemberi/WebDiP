<?php
	/* ---------------Calculating the starting and endign values for the loop----------------------------------- */
		if ($cur_page >= 7) {
			$start_loop = $cur_page - 3;
			if ($no_of_paginations > $cur_page + 3)
				$end_loop = $cur_page + 3;
			else if ($cur_page <= $no_of_paginations && $cur_page > $no_of_paginations - 6) {
				$start_loop = $no_of_paginations - 6;
				$end_loop = $no_of_paginations;
			} else {
				$end_loop = $no_of_paginations;
			}
		} else {
			$start_loop = 1;
			if ($no_of_paginations > 7)
				$end_loop = 7;
			else
				$end_loop = $no_of_paginations;
		}
		$msg = "";
		$msg .= "<div class='pagination'><ul>";

		// FOR ENABLING THE FIRST BUTTON
		$jedan=1;
		if ($first_btn && $cur_page > 1) {
			$msg .= "<li p='$jedan' id='gmbPrva' class='active'>Prva</li>";
		} else if ($first_btn) {
			$msg .= "<li p='$jedan' id='gmbPrva' class='inactive'>Prva</li>";
		}

		// FOR ENABLING THE PREVIOUS BUTTON
		if ($previous_btn && $cur_page > 1) {
			$pre = $cur_page - 1;
			$msg .= "<li p='$pre' id='gmbPrethodna' class='active'>Prethodna</li>";
		} else if ($previous_btn) {
			$msg .= "<li id='gmbPrethodna' class='inactive'>Prethodna</li>";
		}
		for ($i = $start_loop; $i <= $end_loop; $i++) {

			if ($cur_page == $i)
				$msg .= "<li p='$i' id='page$i' style='color:#fff;background-color:#006699;' class='active'>{$i}</li>";
			else
				$msg .= "<li p='$i' id='page$i' class='active'>{$i}</li>";
		}

		// TO ENABLE THE NEXT BUTTON
		if ($next_btn && $cur_page < $no_of_paginations) {
			$nex = $cur_page + 1;
			$msg .= "<li p='$nex' id='gmbSljedeca' class='active'>Sljedeća</li>";
		} else if ($next_btn) {
			$msg .= "<li id='gmbSljedeca' class='inactive'>Sljedeća</li>";
		}

		// TO ENABLE THE END BUTTON
		if ($last_btn && $cur_page < $no_of_paginations) {
			$msg .= "<li p='$no_of_paginations' id='gmbZadnja' class='active'>Zadnja</li>";
		} else if ($last_btn) {
			$msg .= "<li p='$no_of_paginations' id='gmbZadnja' class='inactive'>Zadnja</li>";
		}
	
		$msg = $msg . "</ul></div>"; 
	
	
?>