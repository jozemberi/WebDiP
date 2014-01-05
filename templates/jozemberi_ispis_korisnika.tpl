{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}
{config_load file='jozemberi_ispis.conf'}
	<h1> {$naslov} </h1>
	{if isset($podnaslov)} <h2>{$podnaslov} <h2>{/if}
	<br />
	<form action='jozemberi_ispis_korisnika.php?page=1&status={$status}' method='post' name='filter'>
		<tr>
				<td> <label for='statusPost'> Status korisnika: </label> </td>
				<td> 
					<select name='statusPost'>
					<option value='0'> Svi korisnici </option>
					<option {if $status=='1'} selected='selected' {/if} value="1">Aktiviran</option>
					<option {if $status=='2'} selected='selected' {/if} value="2">Blokiran</option>
					<option {if $status=='3'} selected='selected' {/if} value="3">Zamrznut</option>
					<option {if $status=='4'} selected='selected' {/if} value="4">Deaktiviran</option>
					<option {if $status=='5'} selected='selected' {/if} value="5">Čeka na aktivaciju</option>
					<option {if $status=='6'} selected='selected' {/if} value="6">Zaključan</option>
					</select>
					<input type='submit' id='prikazi' name='prikazi' value='Prikaži'/>
				</td>
				
		</tr>
	</form>
	<br />
		<table align='center' class='{#table_class#}'>
			<tr><th> Avatar </th><th> Nadimak </th> <th> Ime </th> <th> Prezime </th> <th> E-mail </th> 
			{*<th>{if $smarty.session.tip_korisnika == '3'} Uredi {/if}</th> *}</tr>
	
			{section name=ispis loop=$korisnici}
				<tr id='red'>
					 <td><img src='thumbs/{$korisnici[ispis].profilna_slika}' alt='Avatar' />
					 </td><td>{if $smarty.session.tip_korisnika == '3'} <a href='jozemberi_uredi_podatke.php?id={$korisnici[ispis].username}'>
					 {$korisnici[ispis].username} </a> {else}{$korisnici[ispis].username} {/if} </td> <td>{$korisnici[ispis].ime}</td> 
					<td>{$korisnici[ispis].prezime}</td> <td>{$korisnici[ispis].email}</td> {*<td>{if $smarty.session.tip_korisnika == '3'} 
					<a href='jozemberi_uredi_podatke.php?id={$korisnici[ispis].username}'> <img src='img/button_uredi.png' /> </a>{/if} </td>*}
				</tr>
			{/section}
		</table>
	{$pagination}
	<br />