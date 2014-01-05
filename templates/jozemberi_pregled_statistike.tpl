{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}
{config_load file='jozemberi_ispis.conf'}
	<h1> {$naslov} </h1>
	{if isset($podnaslov)} <h2>{$podnaslov} <h2>{/if}
	<br />
	<form action='jozemberi_pregled_statistike.php?page=1&status={$status}' method='post' name='filter'>
		<tr>
				<td> <label for='statusPost'> Tip aktivnosti: </label> </td>
				<td> 
					<select name='statusPost'>
					<option value='0'> Sve </option>
					<option {if $status=='1'} selected='selected' {/if} value="1">Registracija</option>
					<option {if $status=='2'} selected='selected' {/if} value="2">Prijava</option>
					<option {if $status=='3'} selected='selected' {/if} value="3">Zaključavanje računa</option>
					<option {if $status=='4'} selected='selected' {/if} value="4">Promjena podataka</option>
					<option {if $status=='5'} selected='selected' {/if} value="5">Zaboravljena lozinka</option>
					</select>
					<input type='submit' id='prikazi' name='prikazi' value='Prikaži'/>
				</td>
				
		</tr>
	</form>
	<br />
		<table align='center' class='{#table_class#}'>
			<tr><th> Avatar </th><th> Korisnik </th> <th> Datum i vrijeme </th> <th> Aktivnost </th> 
			{*<th>{if $smarty.session.tip_korisnika == '3'} Uredi {/if}</th> *}</tr>
	
			{section name=ispis loop=$korisnici}
				<tr id='red'>
					 <td><img src='thumbs/{$korisnici[ispis].profilna_slika}' alt='Avatar' />
					 </td><td>{if $smarty.session.tip_korisnika == '3'} <a href='jozemberi_uredi_podatke.php?id={$korisnici[ispis].korisnik}'>
					 {$korisnici[ispis].korisnik} </a> {else}{$korisnici[ispis].korisnik} {/if} </td> 
					<td>{$korisnici[ispis].dat_i_vrij}</td> <td>{$korisnici[ispis].tip}</td> 
				</tr>
			{/section}
		</table>
	{$pagination}
	<br />