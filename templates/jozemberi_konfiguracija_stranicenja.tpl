{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}

	<h1> {$naslov} </h1>
		<br />
		<form enctype="multipart/form-data" action='jozemberi_konfiguracija_stranicenja.php' method='post' name='konfiguracija_stranicenja'>
		<table class='registracija' align='center'>	
			<tr>
				<td width='30%'> <label for='limit'> Limit<span class='crveno'>*</span>: </label> </td>
				<td> 
					<input {if isset($greske.limit)} style='border: solid 1px red;' {/if} 
					type='text' name='limit' id='naziv' size='5' value = "{$rez.limit}"/> 
					{ if isset($greske.limit)} <span class='greska'>{$greske.limit}</span> 
					{else if !isset($smarty.post.limit)}  <span class='uputa'> Broj elemenata po stranici (ispis korisnika)</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='susjednost'> Susjednost<span class='crveno'>*</span>: </label> </td>
				<td>
					<input { if isset($greske.susjednost) } style='border: solid 1px red;' {/if} 
					type='text' name='susjednost' id='boja' size='5' value = "{$rez.susjednost}"/> 
					{ if isset($greske.susjednost)} <span class='greska'>{$greske.susjednost}</span> 
					{else if !isset($smarty.post.limit)}  <span class='uputa'> Utječe na količinu stranica oko trenutne</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td colspan='2' align='center'> <input type='submit' id='kreiraj_felge_submit' name='azuriraj_stranicenje' value='Promijeni'/> </td>
			</tr>
		</table>
	</form>
			