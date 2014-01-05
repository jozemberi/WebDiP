{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}

	<h1> {$naslov} </h1>
		<br />
		<form enctype="multipart/form-data" {if isset($gumeUpdate.naziv)} action='jozemberi_kreiranje_ponude_gume.php?update={$gumeUpdate.id_gume}'{else}action='jozemberi_kreiranje_ponude_gume.php' {/if} method='post' name='kreiranjePonudeGume'>
		<table class='registracija' align='center'>	
			<tr>
				<td width='30%'> <label for='naziv'> Naziv<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input {if isset($greske.naziv)} style='border: solid 1px red;' {/if} 
					type='text' name='naziv' id='naziv' size='40' value = "{$gumeUpdate.naziv}"/> 
					{ if isset($greske.naziv)} <span class='greska'>{$greske.naziv}</span> 
					{else if !isset($smarty.post.naziv)}  <span class='uputa'> Naziv gume</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='sirina'> Širina<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.sirina) } style='border: solid 1px red;' {/if} 
					type='text' name='sirina' id='sirina' size='40' value = "{$gumeUpdate.sirina}"/> 
					{ if isset($greske.sirina)} <span class='greska'>{$greske.sirina}</span>  {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='visina'> Visina<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.visina) } style='border: solid 1px red;' {/if} 
					type='text' name='visina' id='visina' size='40' value = "{$gumeUpdate.visina}"/> 
					{ if isset($greske.visina)} <span class='greska'>{$greske.visina}</span>  {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='promjer'> Promjer<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input { if isset($greske.promjer) } style='border: solid 1px red;' {/if} 
					type='text' name='promjer' id='promjer' size='40' value = "{$gumeUpdate.promjer}" /> 
					{ if isset($greske.promjer)} <span class='greska'>{$greske.promjer}</span> 
					{else } <span class='uputa'> Promjer gume </span> {/if}	
				</td>
			</tr>
			
			<tr>
				<td> <label for='vrsta_gume'> Vrsta<span class='crveno'>*</span>: </label> </td>
				<td> 
					<select name='vrsta_gume'>
					<option value="0"> Vrsta gume: </option>
					<option {if (!isset($smarty.post.kreiraj_gume)) and $gumeUpdate.vrsta=='1'} selected='selected' {/if} value="1"> Osobne, 4x4, SUV</option>
					<option {if (!isset($smarty.post.kreiraj_gume)) and $gumeUpdate.vrsta=='2'} selected='selected' {/if} value="2"> Poluteretne, Kombi</option>
					</select>
					{ if isset($greske.vrsta_gume)} <span class='greska'>{$greske.vrsta_gume}</span>  {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='tip_gume'> Tip gume<span class='crveno'>*</span>: </label> </td>
				<td> 
					<select name='tip_gume'>
					<option value="0"> Tip gume:</option>
					<option {if (!isset($smarty.post.kreiraj_gume)) and $gumeUpdate.tip=='1'} selected='selected' {/if} value="1"> Ljetne</option>
					<option {if (!isset($smarty.post.kreiraj_gume)) and $gumeUpdate.tip=='2'} selected='selected' {/if} value="2"> Zimske</option>
					<option {if (!isset($smarty.post.kreiraj_gume)) and $gumeUpdate.tip=='3'} selected='selected' {/if} value="3"> Za sve sezone</option>
					</select>
					{ if isset($greske.tip_gume)} <span class='greska'>{$greske.tip_gume}</span>  {/if}
				</td>
			</tr>
			{if isset($gumeUpdate.slika)}
			<tr>
				<td> Stara slika: </td>
				<td> <a href='slike/{$gumeUpdate.slika}'><img src='thumbs/{$gumeUpdate.slika}' alt='{$gumeUpdate.naziv}' /></a> </td>
					
			<tr>
			{/if}
			
			<tr>
				<td> <label for='slika'> Slika<span class='crveno'>*</span>: </label> </td>
				<td> 
						<input type="hidden" name="MAX_FILE_SIZE" value="2000000" />
						<input  type= "file" name="slika" {if isset($gumeUpdate.slika)} id="slikaUpdate"{else} id="slika"{/if} />
						{ if isset($greske.slika) } <span class='greska'>{$greske.slika}</span>
						{else} <span class='uputa'> .png .gif ili .jpeg</span> {/if}
				</td>
			</tr>
			
			
			<tr>
				<td> <label for='cijena'> Cijena<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input { if isset($greske.cijena) } style='border: solid 1px red;' {/if}  
					type='text' name='cijena' id='cijena' size='10' value = "{$gumeUpdate.cijena}"/> kn
					{ if isset($greske.cijena) } <span class='greska'>{$greske.cijena}</span> {/if}
				</td>
			</tr>
			
			<tr> 
				<td colspan='2'> <input type='checkbox' name='dostupno' value='da' {if $gumeUpdate.dostupno =='0'} {else}checked {/if} id='dostupno' /> 
					Dostupno
				</td>
			</tr>
			
			<tr> 
				<td colspan='2'>
					<input type='checkbox' name='na_akciji' value='da'  {if $gumeUpdate.na_akciji =='1'} checked {/if} id='na_akciji' /> 
					Na akciji
				</td>
			</tr>
			
			<tr>
				<td> <label for='akcija'> Akcija: </label> </td>
				<td> 
					<select name='akcija'>
					{section name=i loop=$akcija}
					<option {if (!isset($smarty.post.kreiraj_gume)) and $gumeUpdate.id_akcije==$akcija[i].id_akcije} selected='selected' {/if} value="{$akcija[i].id_akcije}">{$akcija[i].naziv_akcije}</option>
					{/section}
					</select>
				</td>
			</tr>
			
			<tr>
				<td colspan='2' align='center'> <input type='submit' id='kreiraj_gume_submit' {if isset($gumeUpdate.naziv)}name='azuriraj_gume' value='Spremi promjene'{else} name='kreiraj_gume' value='Kreiraj' {/if}/> </td>
			</tr>
		</table>
	</form>
			