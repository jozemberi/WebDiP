{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}

	<h1> {$naslov} </h1>
		{if isset($uspjesna_aktivacija)}
			<p class = 'zeleno'> Aktivacija uspješna! </p>
			<img src='img/thumbs_up.png' align='right' alt='thumbs_up'/>
		
		{else if isset($link_istekao)}
			<p class = 'crveno'> Aktivacijski kod je istekao. Morate se ponovno registrirati</p>
		{/if}	
		