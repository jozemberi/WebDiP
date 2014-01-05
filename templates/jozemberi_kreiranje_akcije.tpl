{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}

	<h1> {$naslov} </h1>
		<br />
		<form enctype="multipart/form-data" action='jozemberi_kreiranje_akcije.php' method='post' name='kreiranjeAkcije'>
		<table class='registracija' align='center'>	
			<tr>
				<td width='30%'> <label for='naziv'> Naziv akcije<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input {if isset($greske.naziv)} style='border: solid 1px red;' {/if} 
					type='text' name='naziv' id='naziv' size='40'/> 
					{ if isset($greske.naziv)} <span class='greska'>{$greske.naziv}</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='cijena'> Akcijska cijena<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input { if isset($greske.cijena) } style='border: solid 1px red;' {/if}  
					type='text' name='cijena' id='cijena' size='10' /> kn
					{ if isset($greske.cijena) } <span class='greska'>{$greske.cijena}</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='satPoc'> Početak akcije<span class='crveno'>*</span>: </label> </td>
				<td> 
				<select name='satPoc' id='satPoc' >
					<option  value='0'> Sat:  </option>
					<option  value='01'>1 </option>
					<option  value='02'>2 </option>
					<option  value='03'>3 </option>
					<option  value='04'>4 </option>
					<option  value='05'>5 </option>
					<option  value='06'>6 </option>
					<option  value='07'>7 </option>
					<option  value='08'>8 </option>
					<option  value='09'>9 </option>
					<option  value='10'>10 </option>
					<option  value='11'>11 </option>
					<option  value='12'>12 </option>
					<option  value='13'>13 </option>
					<option  value='14'>14 </option>
					<option  value='15'>15 </option>
					<option  value='16'>16 </option>
					<option  value='17'>17 </option>
					<option  value='18'>18 </option>
					<option  value='19'>19 </option>
					<option  value='20'>20 </option>
					<option  value='21'>21 </option>
					<option  value='22'>22 </option>
					<option  value='23'>23 </option>
					<option  value='00'>24 </option>
				</select>
				
				
				<select name='danPoc' id='danPoc' >
					<option  value='0'> Dan:  </option>
					<option  value='01'>1 </option>
					<option  value='02'>2 </option>
					<option  value='03'>3 </option>
					<option  value='04'>4 </option>
					<option  value='05'>5 </option>
					<option  value='06'>6 </option>
					<option  value='07'>7 </option>
					<option  value='08'>8 </option>
					<option  value='09'>9 </option>
					<option  value='10'>10 </option>
					<option  value='11'>11 </option>
					<option  value='12'>12 </option>
					<option  value='13'>13 </option>
					<option  value='14'>14 </option>
					<option  value='15'>15 </option>
					<option  value='16'>16 </option>
					<option  value='17'>17 </option>
					<option  value='18'>18 </option>
					<option  value='19'>19 </option>
					<option  value='20'>20 </option>
					<option  value='21'>21 </option>
					<option  value='22'>22 </option>
					<option  value='23'>23 </option>
					<option  value='24'>24 </option>
					<option  value='25'>25 </option>
					<option  value='26'>26 </option>
					<option  value='27'>27 </option>
					<option  value='28'>28 </option>
					<option  value='29'>29 </option>
					<option  value='30'>30 </option>
					<option  value='31'>31 </option>
				</select>
				
				<select name='mjesecPoc' id='mjesecPoc' >
					<option value='0'> Mjesec: </option>
					<option  value='01'> siječanj </option>
					<option  value='02'> veljača </option>
					<option  value='03'> ožujak </option>
					<option  value='04'> travanj </option>
					<option  value='05'> svibanj </option>
					<option  value='06'> lipanj </option>
					<option  value='07'> srpanj </option>
					<option  value='08'> kolovoz </option>
					<option  value='09'> rujan </option>
					<option  value='10'> listopad </option>
					<option  value='11'> studeni </option>
					<option  value='12'> prosinac </option>
				</select>
				<input type='text' name='godinaPoc' id='godinaPoc' size='15' value = "2012" /> 
				{ if (isset($greske.satPoc))} <span class='greska'>{$greske.satPoc}</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='satZav'> Završetak akcije<span class='crveno'>*</span>: </label> </td>
				<td> 
				<select name='satZav' id='satZav' >
					<option value='0'> Sat:  </option>
					<option value='01'>1 </option>
					<option value='02'>2 </option>
					<option value='03'>3 </option>
					<option value='04'>4 </option>
					<option value='05'>5 </option>
					<option value='06'>6 </option>
					<option value='07'>7 </option>
					<option value='08'>8 </option>
					<option value='09'>9 </option>
					<option  value='10'>10 </option>
					<option  value='11'>11 </option>
					<option  value='12'>12 </option>
					<option  value='13'>13 </option>
					<option  value='14'>14 </option>
					<option  value='15'>15 </option>
					<option  value='16'>16 </option>
					<option  value='17'>17 </option>
					<option  value='18'>18 </option>
					<option  value='19'>19 </option>
					<option  value='20'>20 </option>
					<option  value='21'>21 </option>
					<option  value='22'>22 </option>
					<option  value='23'>23 </option>
					<option  value='00'>24 </option>
				</select>
				
				
				<select name='danZav' id='danZav' >
					<option value='0'> Dan:  </option>
					<option  value='01'>1 </option>
					<option  value='02'>2 </option>
					<option  value='03'>3 </option>
					<option  value='04'>4 </option>
					<option  value='05'>5 </option>
					<option  value='06'>6 </option>
					<option  value='07'>7 </option>
					<option  value='08'>8 </option>
					<option  value='09'>9 </option>
					<option  value='10'>10 </option>
					<option  value='11'>11 </option>
					<option  value='12'>12 </option>
					<option  value='13'>13 </option>
					<option  value='14'>14 </option>
					<option  value='15'>15 </option>
					<option  value='16'>16 </option>
					<option  value='17'>17 </option>
					<option  value='18'>18 </option>
					<option  value='19'>19 </option>
					<option  value='20'>20 </option>
					<option  value='21'>21 </option>
					<option  value='22'>22 </option>
					<option  value='23'>23 </option>
					<option  value='24'>24 </option>
					<option  value='25'>25 </option>
					<option  value='26'>26 </option>
					<option  value='27'>27 </option>
					<option  value='28'>28 </option>
					<option  value='29'>29 </option>
					<option  value='30'>30 </option>
					<option  value='31'>31 </option>
				</select>
				
				<select name='mjesecZav' id='mjesecZav' >
					<option value='0'> Mjesec: </option>
					<option  value='01'> siječanj </option>
					<option  value='02'> veljača </option>
					<option  value='03'> ožujak </option>
					<option  value='04'> travanj </option>
					<option  value='05'> svibanj </option>
					<option  value='06'> lipanj </option>
					<option  value='07'> srpanj </option>
					<option  value='08'> kolovoz </option>
					<option  value='09'> rujan </option>
					<option  value='10'> listopad </option>
					<option  value='11'> studeni </option>
					<option  value='12'> prosinac </option>
				</select>
				<input type='text' name='godinaZav' id='godinaZav' size='15' value = "2012" /> 
				{ if (isset($greske.satZav))} <span class='greska'>{$greske.satZav}</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td colspan='2' align='center'> <input type='submit' id='kreiraj_akciju_submit' name='kreiraj_akciju' value='Kreiraj'/> </td>
			</tr>
		</table>
	</form>
			