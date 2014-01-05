{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}

	<h1> {$naslov} </h1>
		<br />
		<form enctype="multipart/form-data" action='jozemberi_kreiranje_vijesti.php' method='post' name='kreiranjeVijesti'>
		<table class='registracija' align='center'>	
			{if isset($uspjeh)} {$uspjeh}{/if}
			<tr>
				<td width='30%'> <label for='tip'> Tip vijesti<span class='crveno'>*</span>: </label> </td>
				<td> 
					<select name='tip' {if isset($greske.tip)} style='border: solid 1px red;' {/if} >
					<option value='0'>Tip vijesti: </option>
					<option { if (isset($smarty.post.kreiraj_vijesti) and $smarty.post.tip=='1')} selected='selected' {/if}  value="1">Akcije i pogodnosti</option>
					<option { if (isset($smarty.post.kreiraj_vijesti) and $smarty.post.tip=='2')} selected='selected' {/if} value="2">Vijesti o novim tipovima automobila</option>
					</select>
					{ if isset($greske.tip)} <span class='greska'>{$greske.tip}</span> {/if}
				</td>
			</tr>
			
			<tr>
				<td> <label for='tekst'> Vijest<span class='crveno'>*</span>: </label> </td>
				<td> <textarea {if isset($greske.tekst)} style='border: solid 1px red;' {/if}  rows='8' cols='40' name= "tekst" id='komentar_statusa'>{ if isset($smarty.post.kreiraj_vijesti) }{$smarty.post.tekst}{/if}</textarea> 
				{ if isset($greske.tekst)} <span class='greska'><br />{$greske.tekst}</span>{/if} 
				</td>
			</tr>
			
			
			<tr>
				<td colspan='2' align='center'> <input type='submit' id='kreiraj_motor_submit' name='kreiraj_vijesti' value='Pošalji pretplaćenim korisnicima'/> </td>
			</tr>
		</table>
	</form>
			