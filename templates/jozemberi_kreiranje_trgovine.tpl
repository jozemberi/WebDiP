{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}

	<h1> {$naslov} </h1>
		<br />
		<form enctype="multipart/form-data" {if isset($trgovinaUpdate.naziv)} action='jozemberi_kreiranje_trgovine.php?update={$trgovinaUpdate.id_trgovine}'{else}action='jozemberi_kreiranje_trgovine.php' {/if} method='post' name='kreiranjeTrgovine'>
		<table class='registracija' align='center'>	
			<tr>
				<td width='30%'> <label for='naziv'> Naziv<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input {if isset($greske.naziv)} style='border: solid 1px red;' {/if} 
					type='text' name='naziv' id='naziv' size='40' value = "{$trgovinaUpdate.naziv}"/> 
					{ if isset($greske.naziv)} <span class='greska'>{$greske.naziv}</span> 
					{else if !isset($smarty.post.naziv)}  <span class='uputa'> Naziv trgovine</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='voditelj'> Voditelj trgovine: </label> </td>
				<td> 
					<select name='voditelj' { if isset($greske.voditelj) } style='border: solid 1px red;' {/if}>
					<option value='0'>Voditelj trgovine: </option>
					{section name=i loop=$voditelj}
					<option {if (!isset($smarty.post.kreiraj_trgovinu)) and $trgovinaUpdate.voditelj_trgovine==$voditelj[i].username} selected='selected' {/if} value="{$voditelj[i].username}">{$voditelj[i].ime} {$voditelj[i].prezime} ({$voditelj[i].username})</option>
					{/section}
					</select>
					{ if isset($greske.voditelj)} <span class='greska'>{$greske.voditelj}</span>  {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='drzava'> Država: </label> </td>
				<td> 
					<select name='drzava' id='drzava' { if isset($greske.drzava) } style='border: solid 1px red;' {/if} >
					<option value='0'> Država: </option>
					<option { if (!isset($smarty.post.kreiraj_trgovinu)) and $trgovinaUpdate.drzava=='Hrvatska'} selected='selected' {/if} value='Hrvatska'> Hrvatska </option>
					<option { if (!isset($smarty.post.kreiraj_trgovinu)) and $trgovinaUpdate.drzava=='Slovenija'} selected='selected' {/if} value='Slovenija'> Slovenija</option>
					<option { if (!isset($smarty.post.kreiraj_trgovinu)) and $trgovinaUpdate.drzava=='Bosna i Hercegovina'}
					selected='selected' {/if} value='Bosna i Hercegovina'> Bosna i Hercegovina </option>
					<option { if (!isset($smarty.post.kreiraj_trgovinu)) and $trgovinaUpdate.drzava=='Srbija'} selected='selected' {/if} value='Srbija'> Srbija </option>
					<option { if (!isset($smarty.post.kreiraj_trgovinu)) and $trgovinaUpdate.drzava=='Crna Gora'} selected='selected' {/if} value='Crna Gora'> Crna Gora </option>
					</select>
					{ if isset($greske.drzava)} <span class='greska'>{$greske.drzava}</span>  {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='zupanija'> Županija<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.zupanija) } style='border: solid 1px red;' {/if} 
					type='text' name='zupanija' id='zupanija' size='40' value = "{$trgovinaUpdate.zupanija}"/> 
					{ if isset($greske.zupanija)} <span class='greska'>{$greske.zupanija}</span>  {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='telefon'> Broj telefona<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.telefon) } style='border: solid 1px red;' {/if} 
					type='text' name='telefon' id='telefon' size='40' value = "{$trgovinaUpdate.telefon}"/> 
					{ if isset($greske.telefon)} <span class='greska'>{$greske.telefon}</span>  {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='grad'> Grad<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.grad) } style='border: solid 1px red;' {/if} 
					type='text' name='grad' id='grad' size='40' value = "{$trgovinaUpdate.grad}"/> 
					{ if isset($greske.grad)} <span class='greska'>{$greske.grad}</span>  {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='postanski_broj'> Poštanski broj<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.postanski_broj) } style='border: solid 1px red;' {/if} 
					type='text' name='postanski_broj' id='postanski_broj' size='40' value = "{$trgovinaUpdate.postanski_broj}"/> 
					{ if isset($greske.postanski_broj)} <span class='greska'>{$greske.postanski_broj}</span>  {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='ulica'> Ulica<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.ulica) } style='border: solid 1px red;' {/if} 
					type='text' name='ulica' id='ulica' size='40' value = "{$trgovinaUpdate.ulica}"/> 
					{ if isset($greske.ulica)} <span class='greska'>{$greske.ulica}</span>  {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='kucni_broj'> Kućni broj<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.kucni_broj) } style='border: solid 1px red;' {/if} 
					type='text' name='kucni_broj' id='kucni_broj' size='40' value = "{$trgovinaUpdate.kucni_broj}"/> 
					{ if isset($greske.kucni_broj)} <span class='greska'>{$greske.kucni_broj}</span>  {/if}
				</td>
			</tr>
			
			
			<tr>
				<td colspan='2' align='center'> <input type='submit' id='kreiraj_trgovinu_submit' {if isset($trgovinaUpdate.naziv)}name='azuriraj_trgovinu' value='Spremi promjene'{else} name='kreiraj_trgovinu' value='Kreiraj' {/if}/> </td>
			</tr>
		</table>
	</form>
			