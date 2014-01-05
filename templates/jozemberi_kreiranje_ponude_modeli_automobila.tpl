{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}

	<h1> {$naslov} </h1>
		
		<form enctype="multipart/form-data" {if isset($modelUpdate.model)} action='jozemberi_kreiranje_ponude_modeli_automobila.php?update={$modelUpdate.id_osnovne_konfiguracije}'{else}action='jozemberi_kreiranje_ponude_modeli_automobila.php' {/if} method='post' name='kreiranjePonudeModeliAutomobila'>
		<table class='registracija' align='center'>	
			<tr>
				<td width='30%'> <label for='marka'> Marka<span class='crveno'>*</span>: </label> </td>
				<td> 
					<select name='marka'>
					<option value='0'> Marka automobila: </option>
					{section name=i loop=$marka}
					<option {if (!isset($smarty.post.kreiraj_model)) and $modelUpdate.marka==$marka[i].id_marke} selected='selected' {/if} value="{$marka[i].id_marke}">{$marka[i].marka}</option>
					{/section}
					</select>
					{ if isset($greske.marka)} <span class='greska'>{$greske.marka}</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='model'> Model<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input {if isset($greske.model)} style='border: solid 1px red;' {/if} 
					type='text' name='model' id='naziv' size='40' value="{$modelUpdate.model}"/> 
					{ if isset($greske.model)} <span class='greska'>{$greske.model}</span> 
					{else if !isset($smarty.post.model)}  <span class='uputa'> Model automobila</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='tip'> Tip<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.tip) } style='border: solid 1px red;' {/if} 
					type='text' name='tip' id='tip' size='40' value="{$modelUpdate.tip}"/> 
					{ if isset($greske.tip)} <span class='greska'>{$greske.tip}</span>  {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='god_proizvodnje'> Godina proizvodnje<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.god_proizvodnje) } style='border: solid 1px red;' {/if} 
					type='text' name='god_proizvodnje' id='god_proizvodnje' size='40' value="{$modelUpdate.god_proizvodnje}"/> 
					{ if isset($greske.god_proizvodnje)} <span class='greska'>{$greske.god_proizvodnje}</span>  {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='god_modela'> Godina modela<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.god_modela) } style='border: solid 1px red;' {/if} 
					type='text' name='god_modela' id='god_modela' size='40' value="{$modelUpdate.god_modela}" /> 
					{ if isset($greske.god_modela)} <span class='greska'>{$greske.god_modela}</span>  {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='motor'> Motor: </label> </td>
				<td> 
					<select name='motor'>
					<option value='0'> Motor: </option>
					{section name=i loop=$motor}
					<option {if (!isset($smarty.post.kreiraj_model)) and $modelUpdate.motor==$motor[i].id_motora} selected='selected' {/if} value="{$motor[i].id_motora}">{$motor[i].snaga}/{$motor[i].radni_obujam}/{$motor[i].tip}</option>
					{/section}
					</select>
				</td>
			</tr>
			
			<tr>
				<td> <label for='mjenjac'> Mjenjač: </label> </td>
				<td> 
					<select name='mjenjac'>
					<option value='0'> Mjenjač: </option>
					{section name=i loop=$mjenjac}
					<option {if (!isset($smarty.post.kreiraj_model)) and $modelUpdate.mjenjac==$mjenjac[i].id_mjenjac} selected='selected' {/if} value="{$mjenjac[i].id_mjenjac}">{$mjenjac[i].mjenjac}</option>
					{/section}
					</select>
				</td>
			</tr>
			
			
			<tr>
				<td> <label for='br_stupnjeva'> Broj stupnjeva<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.br_stupnjeva) } style='border: solid 1px red;' {/if} 
					type='text' name='br_stupnjeva' id='br_stupnjeva' size='10' value="{$modelUpdate.br_stupnjeva}"/> 
					{ if isset($greske.br_stupnjeva)} <span class='greska'>{$greske.br_stupnjeva}</span>  {/if}
				</td>
			</tr>
			
			{if isset($modelUpdate.slika)}
			<tr>
				<td> Stara slika: </td>
				<td> <a href='slike/{$modelUpdate.slika}'><img src='thumbs/{$modelUpdate.slika}' alt='{$modelUpdate.marka} {$modelUpdate.model}' /></a> </td>
					
			<tr>
			{/if}
			
			<tr>
				<td> <label for='slika'> Slika<span class='crveno'>*</span>: </label> </td>
				<td> 
						<input type="hidden" name="MAX_FILE_SIZE" value="2000000" />
						<input  type= "file" name="slika" {if isset($modelUpdate.slika)} id="slikaUpdate"{else} id="slika"{/if} />
						{ if isset($greske.slika) } <span class='greska'>{$greske.slika}</span>
						{else} <span class='uputa'> .png .gif ili .jpeg</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='cijena'> Cijena<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input { if isset($greske.cijena) } style='border: solid 1px red;' {/if}  
					type='text' name='cijena' id='cijena' size='10' value="{$modelUpdate.cijena}"/> kn
					{ if isset($greske.cijena) } <span class='greska'>{$greske.cijena}</span> {/if}
				</td>
			</tr>
			
			<tr> 
				<td colspan='2'> <input type='checkbox' name='dostupno' value='da' {if $modelUpdate.dostupno =='0'} {else} checked {/if} id='dostupno' /> 
					Dostupno
				</td>
			</tr>
			
			<tr> 
				<td colspan='2'>
					<input type='checkbox' name='na_akciji' value='da'  {if $modelUpdate.na_akciji =='1'} checked {/if} id='na_akciji' /> 
					Na akciji
				</td>
			</tr>
			
			<tr>
				<td> <label for='akcija'> Akcija: </label> </td>
				<td> 
					<select name='akcija'>
					{section name=i loop=$akcija}
					<option {if (!isset($smarty.post.kreiraj_model)) and $modelUpdate.id_akcije==$akcija[i].id_akcije} selected='selected' {/if} value="{$akcija[i].id_akcije}">{$akcija[i].naziv_akcije}</option>
					{/section}
					</select>
				</td>
			</tr>
			
			<tr>
				<td colspan='2' align='center'> <input type='submit' id='kreiraj_model_submit' {if isset($modelUpdate.model)}name='azuriraj_model' value='Spremi promjene'{else} name='kreiraj_model' value='Kreiraj' {/if}'/> </td>
			</tr>
		</table>
	</form>
			