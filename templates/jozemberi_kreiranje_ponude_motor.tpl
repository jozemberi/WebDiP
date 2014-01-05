{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}

	<h1> {$naslov} </h1>
		<br />
		<form enctype="multipart/form-data" action='jozemberi_kreiranje_ponude_motor.php' method='post' name='kreiranjePonudeMotor'>
		<table class='registracija' align='center'>	
		
			<tr>
				<td width='30%'> <label for='tip'> Tip<span class='crveno'>*</span>: </label> </td>
				<td> 
					<select name='tip'>
					<option value='0'> Tip Motora: </option>
					{section name=i loop=$tip}
					<option value="{$tip[i].id_tipa}">{$tip[i].tip}</option>
					{/section}
					</select>
				</td>
			</tr>
			
			<tr>
				<td> <label for='snaga'> Snaga<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input {if isset($greske.snaga)} style='border: solid 1px red;' {/if} 
					type='text' name='snaga' id='naziv' size='40'/> 
					{ if isset($greske.snaga)} <span class='greska'>{$greske.snaga}</span> 
					{else if !isset($smarty.post.naziv)}  <span class='uputa'> Sanaga motora</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='radni_obujam'> Radni obujam<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.radni_obujam) } style='border: solid 1px red;' {/if} 
					type='text' name='radni_obujam' id='radni_obujam' size='40' /> 
					{ if isset($greske.radni_obujam)} <span class='greska'>{$greske.radni_obujam}</span>  
					{else if !isset($smarty.post.radni_obujam)}  <span class='uputa'> Radni obujam motora</span>{/if}
				</td>
			</tr>
			
			
			<tr>
				<td colspan='2' align='center'> <input type='submit' id='kreiraj_motor_submit' name='kreiraj_motor' value='Kreiraj'/> </td>
			</tr>
		</table>
	</form>
			