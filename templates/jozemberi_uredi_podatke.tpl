{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}

	<h1> {$naslov} </h1>
	{assign var="akcije_i_pogodnosti" value=""}
	{assign var="novi_tipovi" value=""}
		{if isset($pretplate)}
			{section name=pron loop=$pretplate}
				{if $pretplate[pron].id_tipa_pretplate == '1'} {assign var="akcije_i_pogodnosti" value="da"}
				{else if $pretplate[pron].id_tipa_pretplate == '2'} {assign var="novi_tipovi" value="da"}
				{/if}
			{/section}
		{/if}
	
		
		<form enctype="multipart/form-data" action='jozemberi_uredi_podatke.php' method='post' name='uredi_podatke'>
		<table class='registracija' align='center'>	
			<tr>
				<td colspan='2'> {if isset($poruka)} <span class='zeleno' align='center'>{$poruka}</span> {/if}</td>
			</tr>
			<tr>
				<td width='30%'> <label for='korImeUP'> Korisničko ime: </label> </td>
				<td> 
					<input type='text' name='korImeUP' id='korImeUP' size='40' value = "{$korisnik.username}" readonly='readonly'/> 
					<span class='uputa'> Nije moguće promijeniti </span>
				</td>
			</tr>
			
			<tr>
				<td> <label for='email'> E-mail: </label> </td>
				<td>
					<input { if isset($greske.email) } style='border: solid 1px red;' {/if} 
					type='text' name='email' id='email' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.email}{else}{$korisnik.email}{/if}" /> 
					{ if isset($greske.email)} <span class='greska'>{$greske.email}</span>  {/if}
				</td>
			</tr>
			{if $smarty.session.username == $korisnik.username}
			<tr>
				<td> <label for='staraLozinka'> Stara lozinka: </label> </td>
				<td> 
					<input { if isset($greske.lozinka) } style='border: solid 1px red;' {/if} 
					type='password' name='staraLozinka' id='staraLozinka' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.staraLozinka}{/if}" /> 
					{ if isset($greske.lozinka)} <span class='greska'>{$greske.lozinka}</span> 
					{else } <span class='uputa'> Za promjenu lozinke </span> {/if}	
				</td>
			</tr>
			
			<tr>
				<td> <label for='novaLozinka'> Nova lozinka: </label> </td>
				<td> 
					<input { if isset($greske.novaLozinka) } style='border: solid 1px red;' {/if} 
					type='password' name='novaLozinka' id='novaLozinka' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.novaLozinka}{/if}" /> 
					{if isset($greske.novaLozinka)} <span class='greska'>{$greske.novaLozinka}</span> 
					{else } <span class='uputa'> Kod promjene lozinke</span> {/if}	
				</td>
			</tr>
			
			<tr>
				<td> <label for='potLozinke'> Potvrda nove lozinke: </label> </td>
				<td> 
					<input { if isset($greske.potLozinke) } style='border: solid 1px red;' {/if} 
					type='password' name='potLozinke' id='potLozinke' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.potLozinke}{/if}" /> 
					{ if isset($greske.potLozinke) } <span class='greska'>{$greske.potLozinke}</span> 
					{else } <span class='uputa'> Kod promjene lozinke</span>{/if}	
				</td>
			</tr>
			{/if}
			
			
			<tr>
				<td> <label for='ime'> Ime: </label> </td>
				<td> 
					<input { if isset($greske.ime) } style='border: solid 1px red;' {/if} 
					type='text' name='ime' id='ime' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.ime}{else}{$korisnik.ime}{/if}" /> 
					{ if isset($greske.ime) } <span class='greska'>{$greske.ime}</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='prezime'> Prezime: </label> </td>
				<td> 
					<input { if isset($greske.prezime) } style='border: solid 1px red;' {/if} 
					type='text' name='prezime' id='prezime' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.prezime}{else}{$korisnik.prezime}{/if}" /> 
					{ if isset($greske.prezime) }<span class='greska'>{$greske.prezime}</span> {/if}
				</td>
			</tr>
			<tr>
				<td> Slika: </td>
				<td> {if (!isset($profilna_slika))}
					<a href='avatari/{$korisnik.profilna_slika}'><img class='profilna_slika'src='thumbs/{$korisnik.profilna_slika}' alt='Avatar' /></a> </td>
					{else}
					<a href='avatari/{$profilna_slika}'><img class='profilna_slika'src='thumbs/{$profilna_slika}' alt='Avatar' /></a> </td>
					{/if}
			<tr>
			<tr>
				<td> <label for='avatar'> Promijeni sliku: </label> </td>
				<td> 
						<input type="hidden" name="MAX_FILE_SIZE" value="2000000" />
						<input  type= "file" name="avatar" id="avatar" />
						{ if isset($greske.avatar) } <span class='greska'>{$greske.avatar}</span>
						{else} <span class='uputa'> .png .gif ili .jpeg</span> {/if}
				</td>
			</tr>
		
			<tr>
				<td> <label for='datRodenja'> Datum rođenja: </label> </td>
				<td> 
				
				<select name='datRodenja' id='datRodenja' >
					<option value='00'> Dan:  </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='01')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='01'} selected='selected' {/if} value='01'>1 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='02')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='02'} selected='selected' {/if} value='02'>2 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='03')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='03'} selected='selected' {/if} value='03'>3 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='04')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='04'} selected='selected' {/if} value='04'>4 </option>	
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='05')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='05'} selected='selected' {/if} value='05'>5 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='06')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='06'} selected='selected' {/if} value='06'>6 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='07')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='07'} selected='selected' {/if} value='07'>7 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='08')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='08'} selected='selected' {/if} value='08'>8 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='09')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='09'} selected='selected' {/if} value='09'>9 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='10')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='10'} selected='selected' {/if} value='10'>10 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='11')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='11'} selected='selected' {/if} value='11'>11 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='12')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='12'} selected='selected' {/if} value='12'>12 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='13')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='13'} selected='selected' {/if} value='13'>13 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='14')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='14'} selected='selected' {/if} value='14'>14 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='15')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='15'} selected='selected' {/if} value='15'>15 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='16')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='16'} selected='selected' {/if} value='16'>16 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='17')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='17'} selected='selected' {/if} value='17'>17 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='18')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='18'} selected='selected' {/if} value='18'>18 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='19')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='19'} selected='selected' {/if} value='19'>19 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='20')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='20'} selected='selected' {/if} value='20'>20 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='21')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='21'} selected='selected' {/if} value='21'>21 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='22')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='22'} selected='selected' {/if} value='22'>22 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='23')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='23'} selected='selected' {/if} value='23'>23 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='24')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='24'} selected='selected' {/if} value='24'>24 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='25')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='25'} selected='selected' {/if} value='25'>25 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='26')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='26'} selected='selected' {/if} value='26'>26 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='27')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='27'} selected='selected' {/if} value='27'>27 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='28')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='28'} selected='selected' {/if} value='28'>28 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='29')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='29'} selected='selected' {/if} value='29'>29 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='30')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='30'} selected='selected' {/if} value='30'>30 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.datRodenja=='31')} selected='selected' {/if} 
							{if (!isset($smarty.post.ok)) and $korisnik.datRodenja=='31'} selected='selected' {/if} value='31'>31 </option>
				</select>
				
				<select name='mjesec' id='mjesec' >
					<option value='00'> Mjesec: </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.mjesec=='01')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.mjesec=='01'} selected='selected' {/if} value='01'> siječanj </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.mjesec=='02')}selected='selected' {/if}
							{ if (!isset($smarty.post.ok)) and $korisnik.mjesec=='02'} selected='selected' {/if} value='02'> veljača </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.mjesec=='03')}selected='selected' {/if}
							{ if (!isset($smarty.post.ok)) and $korisnik.mjesec=='03'} selected='selected' {/if} value='03'> ožujak </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.mjesec=='04')}selected='selected' {/if}
							{ if (!isset($smarty.post.ok)) and $korisnik.mjesec=='04'} selected='selected' {/if} value='04'> travanj </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.mjesec=='05')}selected='selected' {/if}
							{ if (!isset($smarty.post.ok)) and $korisnik.mjesec=='05'} selected='selected' {/if} value='05'> svibanj </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.mjesec=='06')}selected='selected' {/if}
							{ if (!isset($smarty.post.ok)) and $korisnik.mjesec=='06'} selected='selected' {/if} value='06'> lipanj </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.mjesec=='07')}selected='selected' {/if}
							{ if (!isset($smarty.post.ok)) and $korisnik.mjesec=='07'} selected='selected' {/if} value='07'> srpanj </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.mjesec=='08')}selected='selected' {/if}
							{ if (!isset($smarty.post.ok)) and $korisnik.mjesec=='08'} selected='selected' {/if} value='08'> kolovoz </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.mjesec=='09')}selected='selected' {/if}
							{ if (!isset($smarty.post.ok)) and $korisnik.mjesec=='09'} selected='selected' {/if} value='09'> rujan </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.mjesec=='10')}selected='selected' {/if}
							{ if (!isset($smarty.post.ok)) and $korisnik.mjesec=='10'} selected='selected' {/if} value='10'> listopad </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.mjesec=='11')}selected='selected' {/if}
							{ if (!isset($smarty.post.ok)) and $korisnik.mjesec=='11'} selected='selected' {/if} value='11'> studeni </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.mjesec=='12')}selected='selected' {/if}
							{ if (!isset($smarty.post.ok)) and $korisnik.mjesec=='12'} selected='selected' {/if} value='12'> prosinac </option>
				</select>
				<input type='text' name='godina' id='godina' size='15' value = "{ if isset($smarty.post.ok) }{$smarty.post.godina}{else}{$korisnik.godina}{/if}" /> 
				{ if (isset($greske.datRodenja))} <span class='greska'>{$greske.datRodenja}</span> {/if}
				</td>
			</tr>
			
			{* Dodatne informacije *}
			
			<tr>
				<td> <label for='drzava'> Država: </label> </td>
				<td> 
					<select name='drzava' id='drzava' >
					<option value='none'> Država: </option>
					<option { if isset($smarty.post.ok) and $smarty.post.drzava=='Hrvatska'} selected='selected' {/if} 
							{ if (!isset($smarty.post.ok)) and $korisnik.drzava=='Hrvatska'} selected='selected' {/if} value='Hrvatska'> Hrvatska </option>
					<option { if isset($smarty.post.ok) and $smarty.post.drzava=='Slovenija'} selected='selected' {/if}
							{ if (!isset($smarty.post.ok)) and $korisnik.drzava=='Slovenija'} selected='selected' {/if} value='Slovenija'> Slovenija</option>
					<option { if isset($smarty.post.ok) and $smarty.post.drzava=='Bosna i Hercegovina'} selected='selected' {/if} 
					{ if (!isset($smarty.post.ok)) and $korisnik.drzava=='Bosna i Hercegovina'} selected='selected' {/if}value='Bosna i Hercegovina'> Bosna i Hercegovina </option>
					<option { if isset($smarty.post.ok) and $smarty.post.drzava=='Srbija'} selected='selected' {/if} 
					{ if (!isset($smarty.post.ok)) and $korisnik.drzava=='Srbija'} selected='selected' {/if} value='Srbija'> Srbija </option>
					<option { if isset($smarty.post.ok) and $smarty.post.drzava=='Crna Gora'} selected='selected' {/if}
					{ if (!isset($smarty.post.ok)) and $korisnik.drzava=='Crna Gora'} selected='selected' {/if} value='Crna Gora'> Crna Gora </option>
					</select>
				</td>
			</tr>
			
			<tr>
				<td> <label for='zupanija'> Županija: </label> </td>
				<td> 
					<input type='text' name='zupanija' id='zupanija' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.zupanija}{else}{$korisnik.zupanija}{/if}" /> 
				</td>
			</tr>
			
			<tr>
				<td> <label for='grad'> Grad: </label> </td>
				<td> 
					<input type='text' name='grad' id='grad' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.grad}{else}{$korisnik.grad}{/if}" /> 
				</td>
			</tr>
			
			<tr>
				<td> <label for='postanski_broj'> Poštanski broj: </label> </td>
				<td> 
					<input type='text' name='postanski_broj' id='postanski_broj' 
					size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.postanski_broj}{else}{$korisnik.postanski_broj}{/if}" /> 
				</td>
			</tr>
			
			<tr>
				<td> <label for='ulica'> Ulica: </label> </td>
				<td> 
					<input type='text' name='ulica' id='ulica' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.ulica}{else}{$korisnik.ulica}{/if}" /> 
				</td>
			</tr>
			
			<tr>
				<td> <label for='kucni_broj'> Kućni broj: </label> </td>
				<td> 
					<input type='text' name='kucni_broj' id='grad' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.kucni_broj}{else}{$korisnik.kucni_broj}{/if}" /> 
				</td>
			</tr>
			
			<tr>
				<td> <label for='telefon'> Broj telefona: </label> </td>
				<td> 
					<input type='text' name='telefon' id='telefon' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.telefon}{else}{$korisnik.telefon}{/if}" /> 
				</td>
			</tr>
			
			<tr> 
				<td colspan='2'>
					<input type='checkbox' name='vijTipAut' value='da' 
					{ if isset($smarty.post.ok, $smarty.post.vijTipAut)}checked {/if}
					{if (!isset($smarty.post.ok)) and ($novi_tipovi =='da') } checked {/if} id='vijTipAut' /> 
					Primanje vijesti o novim tipovima automobila
				</td>
			</tr>
			
			<tr> 
				
				<td colspan='2'>
					<input type='checkbox' name='vijAkcPog'
					value='da' { if isset($smarty.post.ok, $smarty.post.vijAkcPog)} checked {/if}
					{if (!isset($smarty.post.ok)) and ($akcije_i_pogodnosti=='da') } checked {/if} id='vijAkcPog' /> 
					Primanje vijesti o akcijama i pogodnostima						
				</td>
			</tr>
			
			{if $smarty.session.tip_korisnika=='3'}
			<tr>
				<td> <label for='tip_korisnika'> Tip korisnika: </label></td>
				<td> 
				<select name='tip_korisnika' id='tip_korisnika' >  
					<option { if (isset($smarty.post.ok) and $smarty.post.tip_korisnika=='1')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.tip_korisnika=='1'} selected='selected' {/if} value='1'>registrirani korisnik </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.tip_korisnika=='2')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.tip_korisnika=='2'} selected='selected' {/if} value='2'>voditelj trgovine </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.tip_korisnika=='3')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.tip_korisnika=='3'} selected='selected' {/if} value='3'>administrator sustava </option>
				</select>
				
				</td>
			</tr>
			{/if}
			
			{if $smarty.session.tip_korisnika=='3'}
			<tr>
				<td> <label for='status_korisnika'> Status korisnika: </label></td>
				<td> 
				<select name='status_korisnika' id='status_korisnika' >  
					<option { if (isset($smarty.post.ok) and $smarty.post.status_korisnika=='1')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.status_korisnika=='1'} selected='selected' {/if} value='1'>aktiviran </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.status_korisnika=='2')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.status_korisnika=='2'} selected='selected' {/if} value='2'>blokiran </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.status_korisnika=='3')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.status_korisnika=='3'} selected='selected' {/if} value='3'>zamrznut </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.status_korisnika=='4')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.status_korisnika=='4'} selected='selected' {/if} value='4'>deaktiviran </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.status_korisnika=='5')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.status_korisnika=='5'} selected='selected' {/if} value='5'>čeka na aktivaciju</option>
					<option { if (isset($smarty.post.ok) and $smarty.post.status_korisnika=='6')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.status_korisnika=='6'} selected='selected' {/if} value='6'>zaključan</option>	
				</select>
				
				</td>
			</tr>
			
			<tr>
				<td> <label for='komentar_statusa'> Komentar statusa: </label> </td>
				<td> <textarea rows='8' cols='40' name= "komentar_statusa" id='komentar_statusa'>{ if isset($smarty.post.ok) }{$smarty.post.komentar_statusa}{else}{$korisnik.komentar_statusa}{/if}</textarea> </td>
			</tr>
			
			
			<tr>
				<td> <label for='blokiran_do'> Račun je zamrznut do: </label> </td>
				<td>
					<input type='text' name='blokiran_do' id='blokiran_do' size='40' value = "{ if isset($smarty.post.ok) }{$smarty.post.blokiran_do}{elseif $korisnik.blokiran_do == '01.01.1970. 01:00:00'}-{else}{$korisnik.blokiran_do}{/if}" readonly='readonly'/> 
				</td>
			</tr>
			
			<tr>
				<td colspan='2'> <label for='blokiran_do_sati'> Zamrzni korisnički račun na: </label> 
				
					<input type='text' name='blokiran_do_sati' id='blokiran_do_sati' size='7' value = "{ if isset($smarty.post.ok) }{$smarty.post.blokiran_do_sati}{else}{$blokiran_do_sati}{/if}" /> 
					sata/sati <span class='uputa'> (Potrebno je promijeniti status u zamrznut) </span>
				</td>
			</tr>
			
			
			
			<tr>
				<td> <label for='br_neuspjesnih_prijava'> Broj neuspješnih prijava: </label></td>
				<td> 
				<select name='br_neuspjesnih_prijava' id='br_neuspjesnih_prijava' disabled='disabled'>  
					<option { if (isset($smarty.post.ok) and $smarty.post.br_neuspjesnih_prijava=='0')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.br_neuspjesnih_prijava=='0'} selected='selected' {/if} value='0'> 0 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.br_neuspjesnih_prijava=='1')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.br_neuspjesnih_prijava=='1'} selected='selected' {/if} value='1'> 1 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.br_neuspjesnih_prijava=='2')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.br_neuspjesnih_prijava=='2'} selected='selected' {/if} value='2'> 2 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.br_neuspjesnih_prijava=='3')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.br_neuspjesnih_prijava=='3'} selected='selected' {/if} value='3'> 3 </option>	
				</select>
				</td>
			</tr>
			<tr>
				<td> <label for='br_opomena'> Broj opomena: </label></td>
				<td> 
				<select name='br_opomena' id='br_opomena'>  
					<option { if (isset($smarty.post.ok) and $smarty.post.br_opomena=='0')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.br_opomena=='0'} selected='selected' {/if} value='0'> 0 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.br_opomena=='1')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.br_opomena=='1'} selected='selected' {/if} value='1'> 1 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.br_opomena=='2')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.br_opomena=='2'} selected='selected' {/if} value='2'> 2 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.br_opomena=='3')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.br_opomena=='3'} selected='selected' {/if} value='3'> 3 </option>	
				</select>
			
			{/if}
			{if $smarty.session.tip_korisnika=='1'}
			<tr>
				<td> <label for='br_opomena'> Broj opomena: </label></td>
				<td> 
				<select name='br_opomena' id='br_opomena' disabled="disabled">  
					<option { if (isset($smarty.post.ok) and $smarty.post.br_opomena=='0')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.br_opomena=='0'} selected='selected' {/if} value='0'> 0 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.br_opomena=='1')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.br_opomena=='1'} selected='selected' {/if} value='1'> 1 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.br_opomena=='2')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.br_opomena=='2'} selected='selected' {/if} value='2'> 2 </option>
					<option { if (isset($smarty.post.ok) and $smarty.post.br_opomena=='3')} selected='selected' {/if}
							{if (!isset($smarty.post.ok)) and $korisnik.br_opomena=='3'} selected='selected' {/if} value='3'> 3 </option>	
				</select>
			
			{/if}
			<tr>
				<td colspan='2' align='center'> <input type='submit' name='ok' value='Spremi promjene'/> </td>
			</tr>
		</table>
	</form>
			