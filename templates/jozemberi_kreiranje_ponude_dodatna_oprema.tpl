{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}

	<h1> {$naslov} </h1>
		
		<form enctype="multipart/form-data" {if isset($opremaUpdate.naziv)} action='jozemberi_kreiranje_ponude_dodatna_oprema.php?update={$opremaUpdate.id_opreme}'{else}action='jozemberi_kreiranje_ponude_dodatna_oprema.php' {/if} method='post' name='kreiranjePonudeDodatnaOprema'>
		<table class='registracija' align='center'>	
			<tr>
				<td> <label for='kategorija'> Kategorija<span class='crveno'>*</span>: </label> </td>
				<td> 
					<select name='kategorija'>
					<option value='0'> Kategorija: </option>
					{section name=i loop=$kategorija}
					<option {if (!isset($smarty.post.kreiraj_opremu)) and $opremaUpdate.kategorija==$kategorija[i].id_kategorije} selected='selected' {/if} value="{$kategorija[i].id_kategorije}">{$kategorija[i].kategorija}</option>
					{/section}
					</select>
					{ if isset($greske.kategorija)} <span class='greska'>{$greske.kategorija}</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td width='30%'> <label for='naziv'> Naziv<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input {if isset($greske.naziv)} style='border: solid 1px red;' {/if} 
					type='text' name='naziv' id='naziv' size='40' value = "{$opremaUpdate.naziv}"/> 
					{ if isset($greske.naziv)} <span class='greska'>{$greske.naziv}</span> 
					{else if !isset($smarty.post.naziv)}  <span class='uputa'> Naziv dodatne opreme</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='proizvodac'> Proizvođač<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.proizvodac) } style='border: solid 1px red;' {/if} 
					type='text' name='proizvodac' id='proizvodac' size='40' value = "{$opremaUpdate.proizvodac}" /> 
					{ if isset($greske.proizvodac)} <span class='greska'>{$greske.proizvodac}</span>  {/if}
				</td>
			</tr>
			
			{if isset($opremaUpdate.slika)}
			<tr>
				<td> Stara slika: </td>
				<td> <a href='slike/{$opremaUpdate.slika}'><img src='thumbs/{$opremaUpdate.slika}' alt='{$opremaUpdate.naziv}' /></a> </td>
					
			<tr>
			{/if}
			
			<tr>
				<td> <label for='slika'> Slika<span class='crveno'>*</span>: </label> </td>
				<td> 
						<input type="hidden" name="MAX_FILE_SIZE" value="2000000" />
						<input  type= "file" name="slika" {if isset($opremaUpdate.slika)} id="slikaUpdate"{else} id="slika"{/if}/>
						{ if isset($greske.slika) } <span class='greska'>{$greske.slika}</span>
						{else} <span class='uputa'> .png .gif ili .jpeg</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='opis'> Opis<span class='crveno'>*</span>: </label> </td>
				<td> <textarea rows='8' cols='40' name='opis' id='opis'>{$opremaUpdate.opis}</textarea>
					{ if isset($greske.opis) } <span class='greska'>{$greske.opis}</span>{/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='cijena'> Cijena<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input { if isset($greske.cijena) } style='border: solid 1px red;' {/if}  
					type='text' name='cijena' id='cijena' size='10' value = "{$opremaUpdate.cijena}" /> kn
					{ if isset($greske.cijena) } <span class='greska'>{$greske.cijena}</span> {/if}
				</td>
			</tr>
			
			<tr> 
				<td colspan='2'> <input type='checkbox' name='dostupno' value='da' {if $opremaUpdate.dostupno =='0'} {else}checked {/if} id='dostupno' /> 
					Dostupno
				</td>
			</tr>
			
			<tr>
				<td> <label for='linija'> Predefinirana linija: </label> </td>
				<td> 
					<select name='linija'>
					{section name=i loop=$linija}
					<option {if (!isset($smarty.post.kreiraj_opremu)) and $opremaUpdate.predefinirana_linija==$linija[i].id_linije} selected='selected' {/if} value="{$linija[i].id_linije}">{$linija[i].naziv}</option>
					{/section}
					</select>
				</td>
			</tr>
			
			<tr> 
				<td colspan='2'>
					<input type='checkbox' name='na_akciji' value='da'  {if $opremaUpdate.na_akciji =='1'} checked {/if} id='na_akciji' /> 
					Na akciji
				</td>
			</tr>
			
			<tr>
				<td> <label for='akcija'> Akcija: </label> </td>
				<td> 
					<select name='akcija'>
					{section name=i loop=$akcija}
					<option {if (!isset($smarty.post.kreiraj_opremu)) and $opremaUpdate.id_akcije==$akcija[i].id_akcije} selected='selected' {/if} value="{$akcija[i].id_akcije}">{$akcija[i].naziv_akcije}</option>
					{/section}
					</select>
				</td>
			</tr>
			
			<tr>
				<td colspan='2' align='center'> <input type='submit' id='kreiraj_opremu_submit' {if isset($opremaUpdate.naziv)}name='azuriraj_opremu' value='Spremi promjene'{else} name='kreiraj_opremu' value='Kreiraj' {/if} /> </td>
			</tr>
		</table>
	</form>
			