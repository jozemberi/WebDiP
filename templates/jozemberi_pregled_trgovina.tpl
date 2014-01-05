{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}
{config_load file='jozemberi_ispis.conf'}
	<h1> {$naslov} </h1>
	{if isset($podnaslov)} <h2>{$podnaslov} <h2>{/if}
	{if isset($upozorenje)} <span class='uputa'>{$upozorenje}</span> <br />{/if}
	
<br />
			{section name=ispis loop=$trgovina}
				<table align='center' class='{#table_class#}'>
					<tr>
						<td style="width: 250px;"> <b>Naziv:</b> {$trgovina[ispis].naziv} </td>
						<td style="width: 250px;"> <b>Voditelj:</b> {$trgovina[ispis].voditelj_trgovine} </td>
						<td> <b>Država:</b> {$trgovina[ispis].drzava} </td>
					
					</tr>
					<tr>
						<td> <b>Županija:</b> {$trgovina[ispis].zupanija} </td>
						<td> <b>Grad:</b> {$trgovina[ispis].grad} </td>
						<td> <a href="jozemberi_kreiranje_trgovine.php?update={$trgovina[ispis].id_trgovine}">Promijeni podatke</a> </td>
					</tr>
				</table>
				<br />
			{/section}
			<div id="loading"></div>
	<div align='center'>
	{$pagination}
	</div>
	<br />
