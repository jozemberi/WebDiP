{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}

	<h1> {$naslov} </h1>
		<br />
		<form enctype="multipart/form-data" {if isset($felgeUpdate.naziv)} action='jozemberi_kreiranje_ponude_felge.php?update={$felgeUpdate.id_felge}'{else}action='jozemberi_kreiranje_ponude_felge.php' {/if} method='post' name='kreiranjePonudeFelge'>
		<table class='registracija' align='center'>	
			<tr>
				<td width='30%'> <label for='naziv'> Naziv<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input {if isset($greske.naziv)} style='border: solid 1px red;' {/if} 
					type='text' name='naziv' id='naziv' size='40' value = "{$felgeUpdate.naziv}"/> 
					{ if isset($greske.naziv)} <span class='greska'>{$greske.naziv}</span> 
					{else if !isset($smarty.post.naziv)}  <span class='uputa'> Naziv felge</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='boja'> Boja<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.boja) } style='border: solid 1px red;' {/if} 
					type='text' name='boja' id='boja' size='40' value = "{$felgeUpdate.boja}"/> 
					{ if isset($greske.boja)} <span class='greska'>{$greske.boja}</span>  {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='promjer'> Promjer<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input { if isset($greske.promjer) } style='border: solid 1px red;' {/if} 
					type='text' name='promjer' id='promjer' size='40' value = "{$felgeUpdate.promjer}"/> 
					{ if isset($greske.promjer)} <span class='greska'>{$greske.promjer}</span> 
					{else } <span class='uputa'> Promjer felge </span> {/if}	
				</td>
			</tr>
			
			{if isset($felgeUpdate.slika)}
			<tr>
				<td> Stara slika: </td>
				<td> <a href='slike/{$felgeUpdate.slika}'><img src='thumbs/{$felgeUpdate.slika}' alt='{$felgeUpdate.naziv}' /></a> </td>
					
			<tr>
			{/if}
			
			<tr>
				<td> <label for='slika'> Slika<span class='crveno'>*</span>: </label> </td>
				<td> 
						<input type="hidden" name="MAX_FILE_SIZE" value="2000000" />
						<input  type= "file" name="slika" {if isset($felgeUpdate.slika)} id="slikaUpdate"{else} id="slika"{/if} />
						{ if isset($greske.slika) } <span class='greska'>{$greske.slika}</span>
						{else} <span class='uputa'> .png .gif ili .jpeg</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='cijena'> Cijena<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input { if isset($greske.cijena) } style='border: solid 1px red;' {/if}  
					type='text' name='cijena' id='cijena' size='10' value = "{$felgeUpdate.cijena}"/> kn
					{ if isset($greske.cijena) } <span class='greska'>{$greske.cijena}</span> {/if}
				</td>
			</tr>
			
			<tr> 
				<td colspan='2'> <input type='checkbox' name='dostupno' value='da' {if $felgeUpdate.dostupno =='0'} {else}checked {/if} id='dostupno' /> 
					Dostupno
				</td>
			</tr>
			
			<tr> 
				<td colspan='2'>
					<input type='checkbox' name='na_akciji' value='da'  {if $felgeUpdate.na_akciji =='1'} checked {/if} id='na_akciji' /> 
					Na akciji
				</td>
			</tr>
			
			<tr>
				<td> <label for='akcija'> Akcija: </label> </td>
				<td> 
					<select name='akcija'>
					{section name=i loop=$akcija}
					<option {if (!isset($smarty.post.kreiraj_felge)) and $felgeUpdate.id_akcije==$akcija[i].id_akcije} selected='selected' {/if} value="{$akcija[i].id_akcije}">{$akcija[i].naziv_akcije}</option>
					{/section}
					</select>
				</td>
			</tr>
			
			<tr>
				<td colspan='2' align='center'> <input type='submit' id='kreiraj_felge_submit' {if isset($felgeUpdate.naziv)}name='azuriraj_felge' value='Spremi promjene'{else} name='kreiraj_felge' value='Kreiraj' {/if} value='Kreiraj'/> </td>
			</tr>
		</table>
	</form>
			