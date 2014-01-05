{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}
	<h1> {$naslov} </h1>
	<br />
        <form action action='jozemberi_virtualno_vrijeme.php' method="post" name='Pomak'>
			<table class='tablicaV' align='center'>
				<tr><td colspan='2'> <a href='http://arka.foi.hr/PzaWeb/PzaWeb2004/config/vrijeme.html' target='_BLANK'> Postavi pomak </a></td> </tr>
				<tr>
					<td><span class='plavo'>Stvarno vrijeme: </span></td> <td><span class='plavo'>{$smarty.now|date_format:"%d. %m. %Y. %H:%M:%S"}</span> </td>
				</tr>
				<tr>
					<td> <span class='zeleno'>Vrijeme sustava: </span></td> <td><span class='zeleno'>{$virtualno_vrijeme|date_format:"%d. %m. %Y. %H:%M:%S"} </span></td>	
				</tr>
				
				<tr>
					<td colspan='2' align='center'> <input type="submit" name="preuzmiPomak" value="Preuzmi pomak"/> </td>
				</tr>
			</table>
        </form>
		<br />
		<img src='img/car_clock.png' alt'sat' hspace='245px'>