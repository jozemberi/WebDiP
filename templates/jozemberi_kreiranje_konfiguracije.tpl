{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}
{config_load file='jozemberi_ispis.conf'}
	<h1> {$naslov} </h1>
	{if isset($podnaslov)} <h2>{$podnaslov} <h2>{/if}
	{if isset($upozorenje)} <span class='uputa'>{$upozorenje}</span> <br /> <br />{/if}
	
{literal}
	 <script type="text/javascript">
		$(document).ready(function(){	
		
		
			function enableBeforeUnload() {
				message = "Vaše promjene nisu spremljene!";
				window.onbeforeunload = function (e) {
				
					e = e || window.event;

					// For IE and Firefox prior to version 4
					if (e) e.returnValue = message;

					// For Chrome, Safari and Opera 12+
					return message;
					
					
				};
			}
			function disableBeforeUnload() {
				window.onbeforeunload = null;
			}
			enableBeforeUnload();
		
			$("rel^='prettyPhoto'").prettyPhoto();
			$("a[rel^='prettyPhoto']").prettyPhoto({animation_speed:'normal',theme:'light_square',slideshow:3000, 
													autoplay_slideshow: true,hideflash: false});
			
			var id_konf=0;
			var globTrenutnaStr=1;
			var globPrethodnaStr=0;
			var globBrojPaginacija=1;
			var ukupnaCijenaKonfiguracije = parseFloat ($('input[name=ukupnaCijena]').val());
					
			$.getScript("js/_getURLParam.js", function(){
				id_konf = $(document).getUrlParam("id_konf");
				loadData(1,id_konf); 
			});
			
$('input[name=kategorija]:radio').change(function() {
	loadData(1,id_konf);
});			
			
function loadData(page, id_konf){
				var kategorija = $('input[name=kategorija]:radio:checked').val();
				
				$.ajax({
					type: "POST",
					url: "jozemberi_kreiranje_konfiguracije.php",
					data: "page=" + page + "&id_konf=" + id_konf + '&kategorija=' + kategorija,
					dataType: 'xml',
					success: function(xml){
						
						var kategorija;
						$(xml).find('kategorija').each(function(){
							kategorija = $(this).attr('naziv');
						});
						if(kategorija=='gume'){
							var div = $('<div id="sadrzajGume"> <br />');
								$(xml).find('guma').each(function(){
									div.append('<table align = "center" class="tablicaV2"> <tr><td style="width: 380px;"><b>Naziv:</b> ' + $(this).attr('naziv') + 
									'</td><td style="width: 300px;"><b>Širina:</b> ' + $(this).attr('sirina') + '</td> <td rowspan="3"> <img align="right" height="100px" width="150px" src="thumbs/' + 
									$(this).attr('slika') + '" alt="Guma"/></td></tr> <tr><td><b>Visina:</b> ' +$(this).attr('visina') + 
									'</td><td><b>Promjer:</b> ' +$ (this).attr('promjer') + '</td></tr> <tr><td><b>Vrsta:</b> ' +$(this).attr('vrsta') + 
									'</td><td><b>Tip:</b> ' + $(this).attr('tip') + '</td></tr> <tr><td><span style="color:darkblue"><b>Cijena:</b> </span> ' + $(this).attr('cijena') + ' kn<td><span style="color:darkblue"><b>količina:</b> </span> <input type="text" name="kolicina" id="gumekolicina'+ $(this).attr('id_gume') +'" size="1" value = "4" /></td>	</td><td><div class="dodajKonfiguraciji" align="right"> <a href="' + $(this).attr('id_gume') +'" name="gume">dodaj konfiguraciji</a> </td></tr></table> <br />');
								});
								div.append('</div>');
		
						}//if
						else if(kategorija=='felge'){
							var div = $('<div id="sadrzajFelge"> <br />');
								$(xml).find('felga').each(function(){
									div.append('<table align = "center" class="tablicaV2"> <tr><td style="width: 380px;"><b>Naziv:</b> ' + $(this).attr('naziv') + 
									'</td><td style="width: 300px;"><b>Boja:</b> ' + $(this).attr('boja') + '</td> <td rowspan="2"> <img align="right" height="80px" width="80px" src="thumbs/' + 
									$(this).attr('slika') + '" alt="Felga"/></td></tr> <tr><td colspan="2"><b>Promjer:</b> ' +$(this).attr('promjer') + 
									'</td></tr>  <tr><td><span style="color:darkblue"><b>Cijena:</b> </span> ' + $(this).attr('cijena') + ' kn<td><span style="color:darkblue"><b>količina:</b> </span> <input type="text" name="kolicina" id="felgekolicina'+ $(this).attr('id_felge') +'" size="1" value = "4" /></td>	</td><td><div class="dodajKonfiguraciji" align="right"> <a href="' + $(this).attr('id_felge') +'" name="felge">dodaj konfiguraciji</a> </td></tr></table> <br />');
								});
								div.append('</div>');
						}//if
						
						else if(kategorija=='oprema'){
							var div = $('<div id="sadrzajOprema"> <br />');
								$(xml).find('oprema').each(function(){
									div.append('<table align = "center" class="tablicaV2"> <tr><td style="width: 380px;"><b>Naziv:</b> ' + $(this).attr('naziv') + 
									'</td><td style="width: 300px;"><b>Proizvođač:</b> ' + $(this).attr('proizvodac') + '</td> <td rowspan="2"> <img align="right" height="100px" width="100px" src="thumbs/' + 
									$(this).attr('slika') + '" alt="Oprema"/></td></tr> <tr><td colspan="2"><b>Opis:</b> ' +$(this).attr('opis') + 
									'</td></tr> <tr><td><span style="color:darkblue"><b>Cijena:</b> </span> ' + $(this).attr('cijena') + ' kn<td><span style="color:darkblue"><b>Količina:</b> </span> <input type="text" name="kolicina" id="opremakolicina'+ $(this).attr('id_opreme') +'" size="1" value = "1" /></td>	</td><td><div class="dodajKonfiguraciji" align="right"> <a href="' + $(this).attr('id_opreme') +'" name="oprema">dodaj konfiguraciji</a> </td></tr></table> <br />');
								});
								div.append('</div>');
						}//if
						
						var br_paginacija;
						$(xml).find('paginacija').each(function(){
							br_paginacija = $(this).attr('br_paginacija');
						});
			
						$('#container').ajaxComplete(function(e, xhr, options) {
							if (options.url == 'jozemberi_kreiranje_konfiguracije.php'){ 
								$('#container').empty();
								$('#container').append(div);
								$('.pagination').hide();
								if(br_paginacija > 1)pagination(br_paginacija);
								globBrojPaginacija=br_paginacija;
							}	
						}); 
					}//succses
				});
			} // loadData
			
$('#content .pagination li.active').live('click',function(){
					$('#gmbPrva, #gmbPrethodna, #gmbSljedeca, #gmbZadnja,#page'+globTrenutnaStr).removeClass('inactive');
					$('#gmbPrva, #gmbPrethodna, #gmbSljedeca, #gmbZadnja,#page'+globTrenutnaStr).addClass('active');
					$('#gmbPrva, #gmbPrethodna, #gmbSljedeca, #gmbZadnja,#page'+globTrenutnaStr).css({"color":"#006699", "background-color":"#f2f2f2"});
					
					var idElementa= $(this).attr('id');
					var page;
					if(idElementa=='gmbPrethodna') page=globTrenutnaStr-1;
					else if(idElementa=='gmbSljedeca') page=globTrenutnaStr+1;
					else page = parseInt ($(this).attr('p'));
					
					if(globPrethodnaStr!=globTrenutnaStr)globPrethodnaStr=globTrenutnaStr;
					globTrenutnaStr=page;
					
					$('#page'+page).css({"color":"#fff", "background-color":"#006699"});
					if(page == 1){
						$('#gmbPrva').removeClass("active");
						$('#gmbPrva').addClass('inactive');
						$('#gmbPrva').css({"color":"#bababa", "background-color":"#ededed"});
						$('#gmbPrethodna').removeClass("active");
						$('#gmbPrethodna').addClass('inactive');
						$('#gmbPrethodna').css({"color":"#bababa", "background-color":"#ededed"});
					}
					
					var zadnjaStr= $('#gmbZadnja').attr('p');
					if(idElementa=='gmbZadnja' || page==zadnjaStr){
						$('#gmbSljedeca').removeClass("active");
						$('#gmbSljedeca').addClass('inactive');
						$('#gmbSljedeca').css({"color":"#bababa", "background-color":"#ededed"});
						$('#gmbZadnja').removeClass("active");
						$('#gmbZadnja').addClass('inactive');
						$('#gmbZadnja').css({"color":"#bababa", "background-color":"#ededed"});
					}
					
					loadData(page, id_konf);   
                });//pagination
							
function pagination(no_of_paginations){
					var per_page = 10;
					//var page=1;
					var page= globTrenutnaStr;
					var cur_page = page;
					var previos_btn = true;
					var next_btn = true;
					var first_btn = true;
					var last_btn = true;
					var start_loop;
					var end_loop;
					var i;
					
					if (cur_page >= 7) {
						var start_loop = cur_page - 3;
						if (no_of_paginations > cur_page + 3)
							end_loop = cur_page + 3;
						else if (cur_page <= no_of_paginations && cur_page > no_of_paginations - 6) {
							start_loop = no_of_paginations - 6;
							end_loop = no_of_paginations;
						} else {
							end_loop = no_of_paginations;
						}
						
					} else {
						start_loop = 1;
						if (no_of_paginations > 7)
							end_loop = 7;
						else
							end_loop = no_of_paginations;
					}
					
					var pag = '<div class="pagination">';
					
					pag+='<ul>';
					
					// FOR ENABLING THE FIRST BUTTON
					var jedan=1;
					if (first_btn && cur_page > 1) {
						pag+='<li p="' + jedan + '" id="gmbPrva" class="active">Prva</li>';
					} else if (first_btn) {
						pag+='<li p="1" id="gmbPrva" class="inactive">Prva</li>';
					}

					// FOR ENABLING THE PREVIOUS BUTTON
					if (previos_btn && cur_page > 1) {
						var pre = cur_page - 1;
						pag+='<li p="' + pre +'" id="gmbPrethodna" class="active">Prethodna</li>';
					} else if (previos_btn) {
						pag+='<li id="gmbPrethodna" class="inactive">Prethodna</li>';
					}
					for (i = start_loop; i <= end_loop; i++) {

						if (cur_page == i)
							pag+='<li p="' + i +'" id="page' + i +'" style="color:#fff;background-color:#006699;"class="active">'+ i + '</li>';
						else
							pag+='<li p="'+ i + '" id="page' + i + '" class="active">' + i + '</li>';
					}

					// TO ENABLE THE NEXT BUTTON
					if (next_btn && cur_page < no_of_paginations) {
						var nex = cur_page + 1;
						pag+='<li p="' + nex +'" id="gmbSljedeca" class="active">Sljedeća</li>';
					} else if (next_btn) {
						pag+='<li id="gmbSljedeca" class="inactive">Sljedeća</li>';
					}

					// TO ENABLE THE END BUTTON
					if (last_btn && cur_page < no_of_paginations) {
						pag+='<li p=' + no_of_paginations + '" id="gmbZadnja" class="active">Zadnja</li>';
					} else if (last_btn) {
						pag+='<li p="' + no_of_paginations + '" id="gmbZadnja" class="inactive">Zadnja</li>';
					}
					
					pag+='</ul></div>'; 
					$('#paginacijaJQ').append(pag);
				
				}
				
				
				//$('.opcije a').live('click',function(e){
$('.dodajKonfiguraciji a').live('click',function(e){
					e.preventDefault();
					
					var pid = parseInt ($(this).attr('href'));
					var imeKat = ($(this).attr('name'));
					var kol = $('#'+imeKat+'kolicina'+pid).val();
					dodajElementKonfiguraciji(pid, imeKat, kol);
					//alert(imeKat);
				});
				
$('.ukloni a').live('click',function(e){		
					e.preventDefault();
					var pid = parseInt ($(this).attr('href'));  
					var imeKat = ($(this).attr('name'));
					var kol = $('#kolicina'+pid).val();
					var cij = $('#cijena'+pid).val();
					ukloniElement(pid, imeKat, kol, cij);
					
});		

			
function dodajElementKonfiguraciji(pid, imeKat, kol){ 
				var akc='dodaj';
				var podaci='pid=' + pid + '&imeKat=' + imeKat + '&kol=' + kol + '&akc=dodaj';
					$.ajax({
						type: "POST",
						url: "jozemberi_kreiranje_konfiguracije.php",
						data: podaci,
						dataType: 'xml',
						
						success: function(xml){
						   var kategorija;
							$(xml).find('kategorija').each(function(){
								kategorija = $(this).attr('naziv');
							});
							
							if(kategorija=='gume'){
								var id_elementa = '<div id="sadrzajGume' + pid +'">';
								var div = $(id_elementa);
								var subdiv ='';
								$(xml).find('guma').each(function(){
									var ukupnoStavka = parseFloat($(this).attr('cijena')) * parseFloat($(this).attr('kolicina'));
									ukupnaCijenaKonfiguracije += parseFloat($(this).attr('cijena')) * parseFloat($(this).attr('kolicina'));
									
									$('input[name=ukupnaCijena]').val(ukupnaCijenaKonfiguracije.toFixed(2));
									subdiv += '<table align = "center" class="tablica"> <tr><td colspan="2"><b>Naziv:</b> ' + $(this).attr('naziv') + 
									'</td><td style="width: 200px;"><b>Širina:</b> ' + $(this).attr('sirina') + '</td> <td rowspan="3"> <img align="right" height="80px" width="120px" src="thumbs/' + 
									$(this).attr('slika') + '" alt="Guma"/></td></tr> <tr><td colspan="2"><b>Visina:</b> ' +$(this).attr('visina') + 
									'</td><td><b>Promjer:</b> ' +$ (this).attr('promjer') + '</td></tr> <tr><td colspan="2"><b>Vrsta:</b> ' +$(this).attr('vrsta') + 
									'</td><td><b>Tip:</b> ' + $(this).attr('tip') + '</td></tr> <tr><td><span style="color:darkblue"><b>Cijena:</b> </span> ' +$(this).attr('cijena') + 
									' kn <input type="hidden" name="cijena" id="cijena'+ $(this).attr('id_gume') +'" size="1" value = "'+$(this).attr('cijena') + '" /></td><td><span style="color:darkblue"><b>Količina:</b> </span> ' +$(this).attr('kolicina') + 
									' kom <input type="hidden" name="kolicina" id="kolicina'+ $(this).attr('id_gume') +'" size="1" value = "'+$(this).attr('kolicina') + '" /></td><td><span style="color:darkblue"><b>Ukupno:</b></span> '+ ukupnoStavka.toFixed(2)  +' kn </td><td><div class="ukloni" align="right"> <a href="' + $(this).attr('id_gume') +'" name="gume">ukloni</a> </td></tr></table>'; 
								});
								
								div.append(subdiv);
								div.append('</div>');
							}//if
							
							if(kategorija=='felge'){
								var id_elementa = '<div id="sadrzajFelge' + pid +'">';
								var div = $(id_elementa);
								var subdiv ='';
								$(xml).find('felga').each(function(){
									var ukupnoStavka = parseFloat($(this).attr('cijena')) * parseFloat($(this).attr('kolicina'));
									ukupnaCijenaKonfiguracije += parseFloat($(this).attr('cijena')) * parseFloat($(this).attr('kolicina'));
									
									$('input[name=ukupnaCijena]').val(ukupnaCijenaKonfiguracije.toFixed(2));
									subdiv += '<table align = "center" class="tablica"> <tr><td colspan="2"><b>Naziv:</b> ' + $(this).attr('naziv') + 
									'</td><td style="width: 200px;"><b>Boja:</b> ' + $(this).attr('boja') + '</td> <td rowspan="2"> <img align="right" height="100px" width="100px" src="thumbs/' + 
									$(this).attr('slika') + '" alt="Felga"/></td></tr> <tr><td colspan="3"><b>Promjer:</b> ' +$ (this).attr('promjer') + '</td></tr> <tr><td><span style="color:darkblue"><b>Cijena:</b> </span> ' +$(this).attr('cijena') + 
									' kn <input type="hidden" name="cijena" id="cijena'+ $(this).attr('id_felge') +'" size="1" value = "'+$(this).attr('cijena') + '" /> </td><td><span style="color:darkblue"><b>   Količina:</b> </span> ' +$(this).attr('kolicina') + 
									' kom <input type="hidden" name="kolicina" id="kolicina'+ $(this).attr('id_felge') +'" size="1" value = "'+$(this).attr('kolicina') + '" /> </td><td><span style="color:darkblue"><b>Ukupno:</b></span> '+ ukupnoStavka.toFixed(2)  +' kn </td><td><div class="ukloni" align="right"> <a href="' + $(this).attr('id_felge') +'" name="felge">ukloni</a>  </td></tr></table>'; 
								});
								
								div.append(subdiv);
								div.append('</div>');
							}//if
							
							if(kategorija=='oprema'){
								var id_elementa = '<div id="sadrzajOprema' + pid +'">';
								var div = $(id_elementa);
								var subdiv ='';
								$(xml).find('oprema').each(function(){
									var ukupnoStavka = parseFloat($(this).attr('cijena')) * parseFloat($(this).attr('kolicina'));
									ukupnaCijenaKonfiguracije += parseFloat($(this).attr('cijena')) * parseFloat($(this).attr('kolicina'));
								
									$('input[name=ukupnaCijena]').val(ukupnaCijenaKonfiguracije.toFixed(2));
									subdiv += '<table align = "center" class="tablica"> <tr><td colspan="2"><b>Naziv:</b> ' + $(this).attr('naziv') + 
									'</td><td style="width: 200px;"><b>Proizvođač:</b> ' + $(this).attr('proizvodac') + '</td> <td rowspan="2"> <img align="right" height="100px" width="100px" src="thumbs/' + 
									$(this).attr('slika') + '" alt="Oprema"/></td></tr> <tr><td colspan="3"><b>Opis:</b> ' +$(this).attr('opis') + 
									'</td></tr> <tr><td><span style="color:darkblue"><b>Cijena:</b> </span> ' +$(this).attr('cijena') + 
									' kn <input type="hidden" name="cijena" id="cijena'+ $(this).attr('id_opreme') +'" size="1" value = "'+$(this).attr('cijena') + '" /></td><td><span style="color:darkblue"><b>Količina:</b> </span> ' +$(this).attr('kolicina') + 
									' kom <input type="hidden" name="kolicina" id="kolicina'+ $(this).attr('id_opreme') +'" size="1" value = "'+$(this).attr('kolicina') + '" /></td><td><span style="color:darkblue"><b>Ukupno:</b></span> '+ ukupnoStavka.toFixed(2)  +' kn </td><td><div class="ukloni" align="right"> <a href="' + $(this).attr('id_opreme') +'" name="oprema">ukloni</a> </td></tr></table>'; 
								});
								
								div.append(subdiv);
								div.append('</div>');
							}//if
							
							$('#'+ id_konf).bind("ajaxComplete", function(e, xhr, options) {
									if (options.url == 'jozemberi_kreiranje_konfiguracije.php' && akc=='dodaj'){ 
										
										$('#'+id_konf).after(div);
									}
									
								});
							
							},//succses
							error: function(xhr, ajaxOptions, thrownError) {
								alert(xhr.statusText);
								alert(thrownError);
							}

							
						});
				
			}//funkcija
			
			function ukloniElement(pid, imeKat, kol, cij){ 
				var akc='ukloni';
				var podaci='pid=' + pid + '&imeKat=' + imeKat + '&kol=' + kol + '&akc=ukloni';
					$.ajax({
						type: "POST",
						url: "jozemberi_kreiranje_konfiguracije.php",
						data: podaci,
						success: function(){
						ukupnaCijenaKonfiguracije -= cij * kol;
								$('input[name=ukupnaCijena]').val(ukupnaCijenaKonfiguracije.toFixed(2));
						$('#'+ id_konf).bind("ajaxComplete", function(e, xhr, options) {
							if (options.url == 'jozemberi_kreiranje_konfiguracije.php' && akc=='ukloni'){ 
								
								if(imeKat=='gume') $('#sadrzajGume'+pid).remove();
								if(imeKat=='felge') $('#sadrzajFelge'+pid).remove();
								if(imeKat=='oprema') $('#sadrzajOprema'+pid).remove();
							}
						});
						
						},
						error: function(xhr, ajaxOptions, thrownError) {
								alert(xhr.statusText);
								alert(thrownError);
							}
						});
			}
			$('#spremiKonfiguracijuForm').submit(function(e){	
				e.preventDefault();
				var naziv_konf = $('input[name=naziv_konfiguracije]:text').val();
				var javnaValue = $('input[name=javna]:checkbox:checked').val();
				if(javnaValue == 'javna') javna='true';
				else javna='default';
				var boja = $('select[name=boja]').val();
				
				var podaci='id_konf=' + id_konf + '&ukupnaCijenaKonfiguracije=' + ukupnaCijenaKonfiguracije + '&naziv_konf=' + naziv_konf + 
							'&boja=' + boja + '&javna=' + javna;
				$.ajax({
						type: "POST",
						url: "jozemberi_kreiranje_konfiguracije.php",
						data: podaci,
						success: function(){
							$('#kreKonf').empty();
							$('.pagination').hide();
							disableBeforeUnload();
							$('#kreKonf').after('<p class = "zeleno"> Konfiguracija je uspješno spremljena!</p> <br /><img src="img/thumbs_up.png" align="right" alt="thumbs_up"/> <br /><br /><br /><br /><br /><br /><br />');
						}
				});

			});
	});
		</script> 
	
{/literal}
	
	<br />		<div id='kreKonf'>
				<table align='center' class='{#table_class#}'>
					<tr>
						<td> <b>Naziv konfiguracije:</b> <input type='text' name='naziv_konfiguracije' id='naziv_konfiguracije' size='30' value = "{ if isset($smarty.post.spremi) }{$smarty.post.naziv_konfiguracije}{/if}"/>  <input type="checkbox" name="javna" value="javna" /> Javna</td>
						<td> <form id="spremiKonfiguracijuForm" method="POST" action="#">
						<input type="submit" id="spremiKonfiguraciju" value="Spremi konfiguraciju" /> </td>
						</form>
					</tr>
				</table>
				<table align='center' class='{#table_class#}' id="{$konfiguracija.id_osnovne_konfiguracije}">
					<tr> <td colspan='3'> <span class='podnaslov'> Odabrana osnovna konfiguracija </span> <td></tr>
					<tr>
						<td> <b>Marka automobila:</b> {$konfiguracija.marka} </td>
						<td> <b>Model:</b> {$konfiguracija.model} </td>
						<td rowspan='5'>
							<ul  style="list-style-type: none;"class="gallery clearfix"> 
								<li>
									<a href="{$konfiguracija.slika}" rel="prettyPhoto[gallery2]">
										<img align='right' height='100px' width='150px' src='thumbs/{$konfiguracija.slika}' 
										alt='{$konfiguracija.marka}  {$konfiguracija.model}'/>
									</a> 
								</li>
							</ul>
						</td>
					</tr>
					
					
					<tr>
						<td> <b>Godina proizvodnje:</b> {$konfiguracija.god_proizvodnje}</td> 
						<td> <b>Godina modela:</b> {$konfiguracija.god_modela}</td> 
					</tr>
					<tr>
					<td> <b>Tip automobila:</b> {$konfiguracija.tip_automobila} </td>
						<td> <b>Tip motora:</b> {$konfiguracija.tip_motora} </td>
					</tr>
					<tr>
						<td> <b>Snaga motora:</b> {$konfiguracija.snaga} </td>
						<td> <b>Radni obujam:</b> {$konfiguracija.radni_obujam} </td>
						
					</tr>
					<tr>
						<td> <b>Mjenjač:</b> {$konfiguracija.mjenjac} </td>
						<td> <b>Broj stupnjeva:</b> {$konfiguracija.br_stupnjeva} </td>
					</tr>
					
					<tr>
						<td> <b>Dostupno:</b>
						<input type="checkbox" name="dostupno" value="da" disabled="true" {if $konfiguracija.dostupno == '1'} checked="true"{/if}/></td>
						<td> <b>Na akciji:</b> 
						<input type="checkbox" name="na_akciji" value="da" disabled="true" {if $konfiguracija.na_akciji == '1'} checked="true"{/if}/></td>
					</tr>
					
					<tr> <td><b>Cijena:</b> {$konfiguracija.cijena} kn </td> 
					<td> {if $konfiguracija.na_akciji == 1 && $konfiguracija.akcijaValjana =="da"}<span style='color:red'><b> Akcijska cijena:</b> </span>{$konfiguracija.akcijska_cijena} kn {/if}</td>
					<td align="right"><b>Boja:</b> 
					 <select name='boja' style='width:120px; text-align:left;'>
					{section name=i loop=$boja}
					<option value="{$boja[i].id_boje}">{$boja[i].naziv}</option>
					{/section}
					</select></td>
					</tr>
				</table>
				
				<table id='ukupnaCijena' align='center' class='{#table_class#}'>
					<tr> <td colspan='3'> <b>Ukupna cijena konfiguracije:</b> <input type="text" name="ukupnaCijena" readonly="readonly" 
					{if $konfiguracija.na_akciji == 1 && $konfiguracija.akcijaValjana =="da"} value="{$konfiguracija.akcijska_cijena}" {else}value="{$konfiguracija.cijena}" {/if} size="10"/> kn
					</td> </tr> 
				</table>
				<br />
				<table align='center' class='{#table_class#}'>
					<tr> <td colspan='3'> Odabir kategorije opreme: 
					<input type="radio" name="kategorija" value="gume" checked='checked'/> Gume 
					<input type="radio" name="kategorija" value="felge"/> Felge
					<input type="radio" name="kategorija" value="oprema"/> Dodatna oprema
					</td> </tr> 
				</table>
	<div id="container"> </div>		
	</div>
<div id="loading"></div>

	 <div id='paginacijaJQ'style="padding-left: 200px"> {$pagination} </div>
	<br />
	