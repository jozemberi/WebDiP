{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}

	<h1> {$naslov} </h1>
	
		{* Registracijska forma*}
		
		<form enctype="multipart/form-data" action='jozemberi_registracija.php' method='post' name='registriranje'>
		<table class='registracija' align='center'>	
			<tr>
				<td width='30%'> <label for='korIme'> Korisničko ime<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input {if isset($greske.korIme)} style='border: solid 1px red;' {/if} 
					type='text' name='korIme' id='korIme' size='40' value = "{ if isset($smarty.post.ok)}{$smarty.post.korIme}{/if}" /> 
					{ if isset($greske.korIme)} <span class='greska'>{$greske.korIme}</span>  {/if}
					<input type='submit' name='provjeri_korisnicko_ime' id='provjeri_korisnicko_ime' value='Provjeri zauzetost'/>
				</td>
			</tr>
			
			<tr>
				<td> <label for='email'> E-mail<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.email) } style='border: solid 1px red;' {/if} 
					type='text' name='email' id='email' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.email}{/if}" /> 
					{ if isset($greske.email)} <span class='greska'>{$greske.email}</span>  {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='lozinka'> Lozinka<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input { if isset($greske.lozinka) } style='border: solid 1px red;' {/if} 
					type='password' name='lozinka' id='lozinka' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.lozinka}{/if}" /> 
					{ if isset($greske.lozinka)} <span class='greska'>{$greske.lozinka}</span> 
					{else } <span class='uputa'> Minimalno 6 znakova</span> {/if}	
				</td>
			</tr>
			
			<tr>
				<td> <label for='potLozinke'> Potvrda lozinke<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input { if isset($greske.potLozinke) } style='border: solid 1px red;' {/if} 
					type='password' name='potLozinke' id='potLozinke' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.potLozinke}{/if}" /> 
					{ if isset($greske.potLozinke) } <span class='greska'>{$greske.potLozinke}</span> {/if}	
				</td>
			</tr>
			
			<tr>
				<td> <label for='ime'> Ime<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input { if isset($greske.ime) } style='border: solid 1px red;' {/if} 
					type='text' name='ime' id='ime' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.ime}{/if}" /> 
					{ if isset($greske.ime) } <span class='greska'>{$greske.ime}</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='prezime'> Prezime<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input { if isset($greske.prezime) } style='border: solid 1px red;' {/if} 
					type='text' name='prezime' id='prezime' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.prezime}{/if}" /> 
					{ if isset($greske.prezime) }<span class='greska'>{$greske.prezime}</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='avatar'> Slika<span class='crveno'>*</span>: </label> </td>
				<td> 
						<input type="hidden" name="MAX_FILE_SIZE" value="2000000" />
						<input  type= "file" name="avatar" id="avatar" />
						{ if isset($greske.avatar) } <span class='greska'>{$greske.avatar}</span>
						{else} <span class='uputa'> .png .gif ili .jpeg</span> {/if}
				</td>
			</tr>
		
			<tr>
				<td> <label for='datRodenja'> Datum rođenja<span class='crveno'>*</span>: </label> </td>
				<td> 
				
				<select name='datRodenja' id='datRodenja' >
					<option value='00'> Dan:  </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='01' } selected='selected' {/if} value='01'>1 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='02' } selected='selected' {/if} value='02'>2 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='03' } selected='selected' {/if} value='03'>3 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='04' } selected='selected' {/if} value='04'>4 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='05' } selected='selected' {/if} value='05'>5 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='06' } selected='selected' {/if} value='06'>6 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='07' } selected='selected' {/if} value='07'>7 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='08' } selected='selected' {/if} value='08'>8 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='09' } selected='selected' {/if} value='09'>9 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='10' } selected='selected' {/if} value='10'>10 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='11' } selected='selected' {/if} value='11'>11 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='12' } selected='selected' {/if} value='12'>12 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='13' } selected='selected' {/if} value='13'>13 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='14' } selected='selected' {/if} value='14'>14 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='15' } selected='selected' {/if} value='15'>15 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='16' } selected='selected' {/if} value='16'>16 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='17' } selected='selected' {/if} value='17'>17 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='18' } selected='selected' {/if} value='18'>18 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='19' } selected='selected' {/if} value='19'>19 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='20' } selected='selected' {/if} value='20'>20 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='21' } selected='selected' {/if} value='21'>21 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='22' } selected='selected' {/if} value='22'>22 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='23' } selected='selected' {/if} value='23'>23 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='24' } selected='selected' {/if} value='24'>24 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='25' } selected='selected' {/if} value='25'>25 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='26' } selected='selected' {/if} value='26'>26 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='27' } selected='selected' {/if} value='27'>27 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='28' } selected='selected' {/if} value='28'>28 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='29' } selected='selected' {/if} value='29'>29 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='30' } selected='selected' {/if} value='30'>30 </option>
					<option { if isset($smarty.post.ok) and $smarty.post.datRodenja=='31' } selected='selected' {/if} value='31'>31 </option>
				</select>
				
				<select name='mjesec' id='mjesec' >
					<option value='00'> Mjesec: </option>
					<option { if isset($smarty.post.ok) and $smarty.post.mjesec=='01' } selected='selected' {/if} value='01'> siječanj </option>
					<option { if isset($smarty.post.ok) and $smarty.post.mjesec=='02' } selected='selected' {/if} value='02'> veljača </option>
					<option { if isset($smarty.post.ok) and $smarty.post.mjesec=='03' } selected='selected' {/if} value='03'> ožujak </option>
					<option { if isset($smarty.post.ok) and $smarty.post.mjesec=='04' } selected='selected' {/if} value='04'> travanj </option>
					<option { if isset($smarty.post.ok) and $smarty.post.mjesec=='05' } selected='selected' {/if} value='05'> svibanj </option>
					<option { if isset($smarty.post.ok) and $smarty.post.mjesec=='06' } selected='selected' {/if} value='06'> lipanj </option>
					<option { if isset($smarty.post.ok) and $smarty.post.mjesec=='07' } selected='selected' {/if} value='07'> srpanj </option>
					<option { if isset($smarty.post.ok) and $smarty.post.mjesec=='08' } selected='selected' {/if} value='08'> kolovoz </option>
					<option { if isset($smarty.post.ok) and $smarty.post.mjesec=='09' } selected='selected' {/if} value='09'> rujan </option>
					<option { if isset($smarty.post.ok) and $smarty.post.mjesec=='10' } selected='selected' {/if} value='10'> listopad </option>
					<option { if isset($smarty.post.ok) and $smarty.post.mjesec=='11' } selected='selected' {/if} value='11'> studeni </option>
					<option { if isset($smarty.post.ok) and $smarty.post.mjesec=='12' } selected='selected' {/if} value='12'> prosinac </option>
				</select>
				<input type='text' name='godina' id='godina' size='15' value = "{ if isset($smarty.post.ok) }{$smarty.post.godina}{/if}" /> 
				{ if (isset($greske.datRodenja))} <span class='greska'>{$greske.datRodenja}</span> {/if}
				</td>
			</tr>
			{* Dodatne informacije *}
			
			<tr>
				<td> <label for='drzava'> Država: </label> </td>
				<td> 
					<select name='drzava' id='drzava' >
					<option value='none'> Država: </option>
					<option { if isset($smarty.post.ok) and $smarty.post.drzava=='Hrvatska'} selected='selected' {/if} value='Hrvatska'> Hrvatska </option>
					<option { if isset($smarty.post.ok) and $smarty.post.drzava=='Slovenija'} selected='selected' {/if} value='Slovenija'> Slovenija</option>
					<option { if isset($smarty.post.ok) and $smarty.post.drzava=='Bosna i Hercegovina'}
					selected='selected' {/if} value='Bosna i Hercegovina'> Bosna i Hercegovina </option>
					<option { if isset($smarty.post.ok) and $smarty.post.drzava=='Srbija'} selected='selected' {/if} value='Srbija'> Srbija </option>
					<option { if isset($smarty.post.ok) and $smarty.post.drzava=='Crna Gora'} selected='selected' {/if} value='Crna Gora'> Crna Gora </option>
					</select>
				</td>
			</tr>
			
			<tr>
				<td> <label for='zupanija'> Županija: </label> </td>
				<td> 
					<input type='text' name='zupanija' id='zupanija' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.zupanija}{/if}" /> 
				</td>
			</tr>
			
			<tr>
				<td> <label for='grad'> Grad: </label> </td>
				<td> 
					<input type='text' name='grad' id='grad' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.grad}{/if}" /> 
				</td>
			</tr>
			
			<tr>
				<td> <label for='postanski_broj'> Poštanski broj: </label> </td>
				<td> 
					<input type='text' name='postanski_broj' id='postanski_broj' 
					size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.postanski_broj}{/if}" /> 
				</td>
			</tr>
			
			<tr>
				<td> <label for='ulica'> Ulica: </label> </td>
				<td> 
					<input type='text' name='ulica' id='ulica' size='40' value = "" /> 
				</td>
			</tr>
			
			<tr>
				<td> <label for='kucni_broj'> Kućni broj: </label> </td>
				<td> 
					<input type='text' name='kucni_broj' id='grad' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.kucni_broj}{/if}" /> 
				</td>
			</tr>
			
			<tr>
				<td> <label for='telefon'> Broj telefona: </label> </td>
				<td> 
					<input type='text' name='telefon' id='telefon' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.telefon}{/if}" /> 
				</td>
			</tr>
			
			<tr> 
				<td colspan='2'>
					<input type='checkbox' name='vijTipAut' value='da' 
					{ if isset($smarty.post.ok, $smarty.post.vijTipAut) } checked {/if} id='vijTipAut' /> 
					Želim primati vijesti o novim tipovima automobila
				</td>
			</tr>
			
			<tr> 
				
				<td colspan='2'>
					<input type='checkbox' name='vijAkcPog'
					value='da' { if isset($smarty.post.ok, $smarty.post.vijAkcPog) } checked {/if} id='vijAkcPog' /> 
					Želim primati vijesti o akcijama i pogodnostima						
				</td>
			</tr>
			
			<tr> 
				<td colspan='2'> <input type='checkbox' name='priUvKor' value='da' 
				{ if isset($smarty.post.ok, $smarty.post.priUvKor) } checked {/if} id='priUvKor' /> 
					Slažem se s uvjetima korištenja<span class='crveno'>*</span>
					{ if isset($greske.priUvKor)} <span class='greska'>{$greske.priUvKor}</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td colspan='2' align='center'>
					{$recaptcha}
					{if isset($greske.recaptcha)}
							<span class='greska'>{$greske.recaptcha}</span>
					{else} <span class='uputa'> Upišite obje riječi odvojene razmakom</span>
					{/if}
				</td>
			</tr>
			
			<tr>
				<td colspan='2' align='center'> <input type='submit' name='ok' id='registracija_submit' value='Registriraj se'/> </td>
			</tr>
		</table>
	</form>
			