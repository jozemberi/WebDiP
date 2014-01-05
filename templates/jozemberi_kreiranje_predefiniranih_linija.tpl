{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}

	<h1> {$naslov} </h1>
		<br />
		<form enctype="multipart/form-data" action='jozemberi_kreiranje_predefiniranih_linija.php' method='post' name='kreiranjePredefiniranihLinija'>
		<table class='registracija' align='center'>	
			
			<tr>
				<td> <label for='naziv'> Naziv<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input {if isset($greske.naziv)} style='border: solid 1px red;' {/if} 
					type='text' name='naziv' id='naziv' size='40'/> 
					{ if isset($greske.naziv)} <span class='greska'>{$greske.naziv}</span> 
					{else if !isset($smarty.post.naziv)}  <span class='uputa'> Naziv nove linije</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td colspan='2' align='center'> <input type='submit' id='kreiraj_liniju_submit' name='kreiraj_liniju' value='Kreiraj'/> </td>
			</tr>
		</table>
	</form>
			