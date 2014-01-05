{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}
{config_load file='jozemberi_ispis.conf'}
	<h1> {$naslov} </h1>
	{if isset($podnaslov)} <h2>{$podnaslov} <h2>{/if}
	{if isset($upozorenje)} <span class='uputa'>{$upozorenje}</span> <br />{/if}
	
{literal}
	<script type="text/javascript">
		$(document).ready(function(){
			var globTrenutnaStr=1;
			var globBrojPaginacija=1;
			var globSelected=0;
			
			function loading_show(){
				$('#loading').html("<img src='img/loading.gif'/>").fadeIn('fast');
			}
			
			function loading_hide(){
				$('#loading').fadeOut('fast');
			}                
			
			loadData(1);
			
			function loadData(page){
                loading_show();  
                $.ajax({
					type: "POST",
					url: "jozemberi_pregled_narucenih_konfiguracija.php",
					data: "page="+page,
					dataType: 'xml',
					success: function(xml){
							var div = $('<div id="sadrzaj"> <br />');
							var subdiv ='';
							$(xml).find('konfiguracija').each(function(){
							
								subdiv+='<table align = "center" class="tablica"> <tr><td style="width:400px;"><b>Naziv konfiguracije:</b> ' + $(this).attr('naziv') + 
								'</td> <td> <b>Naručitelj: </b>'+ $(this).attr('kreator') +'</td><td rowspan="4"> <img height="100px" width="100px" src="thumbs/' + 
								$(this).attr('slika') + '" alt="Automobil"/></td></tr> <tr><td><b>Marka automobila:</b> ' +$(this).attr('marka') + '</td><td><b>Model:</b> ' +$ (this).attr('model') + '</td><tr><td colspan="2"> <b>Datum i vrijeme narudžbe:</b> '+ $(this).attr('dat_i_vrij_narudzbe')+'</td> </tr></tr> <tr><td><b>Cijena:</b> ' +$(this).attr('cijena') + 
								' kn</td><td><b>Količina:</b> ' + $(this).attr('kolicina') + '</td></tr> <tr><td> <b>Status:</b> ';
								if($(this).attr('status_narudzbe')=='1'){
									subdiv+='<select name="status_narudzbe"><option selected="true" value="1"> Nije još potvrđena</option><option value="2"> Potvrđena</option><option value="3"> Stigla</option><option value="4"> Stigla i preuzeta</option></select></td><td> <input type="submit" id="promijeni_status" value="Promijeni u odabrani status" class="id_narudzbe='+$(this).attr('id_narudzbe')+'&narucitelj='+$(this).attr('kreator') +'&id_konfiguracije='+ $(this).attr('id_konfiguracije')+'"/> </td><td align="right"> <a href="jozemberi_pregled_konfiguracije.php?id_konf=' + $(this).attr('id_konfiguracije') + '">Detaljnije...</a></td> </tr> </table> <br />';
								}
								if($(this).attr('status_narudzbe')=='2'){
									subdiv+='<select name="status_narudzbe"><option value="1"> Nije još potvrđena</option><option selected="true" value="2"> Potvrđena</option><option value="3"> Stigla</option><option value="4"> Stigla i preuzeta</option></select></td><td> <input type="submit" id="promijeni_status" name="promijeni" value="Promijeni u odabrani status" class="id_narudzbe='+$(this).attr('id_narudzbe')+'&narucitelj='+$(this).attr('kreator') +'&id_konfiguracije='+ $(this).attr('id_konfiguracije')+'"/> </td><td align="right"> <a href="jozemberi_pregled_konfiguracije.php?id_konf=' + $(this).attr('id_konfiguracije') + '">Detaljnije...</a></td> </tr> </table> <br />';
								}
								if($(this).attr('status_narudzbe')=='3'){
									subdiv+='<select name="status_narudzbe"><option value="1"> Nije još potvrđena</option><option value="2"> Potvrđena</option><option selected="true" value="3"> Stigla</option><option value="4"> Stigla i preuzeta</option></select></td><td> <input type="submit" id="promijeni_status" name="promijeni" value="Promijeni u odabrani status" class="id_narudzbe='+$(this).attr('id_narudzbe')+'&narucitelj='+$(this).attr('kreator') +'&id_konfiguracije='+ $(this).attr('id_konfiguracije')+'"/> </td><td align="right"> <a href="jozemberi_pregled_konfiguracije.php?id_konf=' + $(this).attr('id_konfiguracije') + '">Detaljnije...</a></td> </tr> </table> <br />';
								}
								if($(this).attr('status_narudzbe')=='4'){
									subdiv+='<select name="status_narudzbe"><option value="1"> Nije još potvrđena</option><option value="2"> Potvrđena</option><option value="3"> Stigla</option><option selected="true" value="4"> Stigla i preuzeta</option></select></td><td> <input type="submit" id="promijeni_status" name="promijeni" value="Promijeni u odabrani status" class="id_narudzbe='+$(this).attr('id_narudzbe')+'&narucitelj='+$(this).attr('kreator') +'&id_konfiguracije='+ $(this).attr('id_konfiguracije')+'"/> </td><td align="right"> <a href="jozemberi_pregled_konfiguracije.php?id_konf=' + $(this).attr('id_konfiguracije') + '">Detaljnije...</a></td> </tr> </table> <br />';
								}
							});
							div.append(subdiv);
							div.append('</div>');
							
							var br_paginacija;
							$(xml).find('paginacija').each(function(){
								br_paginacija = $(this).attr('br_paginacija');
							});
						
						$("#content").ajaxComplete(function(){
							$('.tablica').hide();
							$('#sadrzaj').hide();
							$('br').hide();
							$('.pagination').hide();
							if(br_paginacija > 1)pagination(br_paginacija);
							globBrojPaginacija=br_paginacija;
							loading_hide();
							
							$('#container').append(div);
						});
					}
				});
			}
		
				$('#content .pagination li.active').live('click',function(){
					$('#gmbPrva, #gmbPrethodna, #gmbSljedeca, #gmbZadnja,#page'+globTrenutnaStr).removeClass('inactive');
					$('#gmbPrva, #gmbPrethodna, #gmbSljedeca, #gmbZadnja,#page'+globTrenutnaStr).addClass('active');
					$('#gmbPrva, #gmbPrethodna, #gmbSljedeca, #gmbZadnja,#page'+globTrenutnaStr).css({"color":"#006699", "background-color":"#f2f2f2"});
					
					var idElementa= $(this).attr('id');
					var page;
					if(idElementa=='gmbPrethodna') page=globTrenutnaStr-1;
					else if(idElementa=='gmbSljedeca') page=globTrenutnaStr+1;
					else page = parseInt ($(this).attr('p'));
					
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
					
					loadData(page);   
                });     

			function pagination(no_of_paginations){
					var per_page = 3;
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
				
				$("select").live('change',function(){
				//change(function () {
					  
					globSelected = $(this).val();
					//alert("selected" + globSelected);
					  //$("div").text(str);
					  //.change()
				});
							
				$('#promijeni_status').live('click',function(e){
					e.preventDefault();
					//var status = $('select[name="status_narudzbe"] option[selected="true"]').val();
					var status = globSelected;
					var data = $(this).attr("class");
					data += '&status=' + status;
					
					//alert(status);
					//alert(data);
					var ok = confirm("Želite li promijeniti status ove narudžbe");
					if(ok==true){
						loading_show();
						//var podaci='akcija=naruci&id_konf=' + id_konf;
						$.ajax({
								type: "POST",
								url: "jozemberi_pregled_narucenih_konfiguracija.php",
								data: data,
								//dataType: 'xml',
								success: function(){
									loading_hide();
									alert('Konfiguraciji je promijenjen status. Naručitelju konfiguracije je poslan email o promijeni statusa.');
									loadData(globTrenutnaStr);
									
								},
								error: function(xhr, ajaxOptions, thrownError) {
								alert(xhr.statusText);
								alert(thrownError);
								}
						});
			}
					
				});
				
            });

		</script>
{/literal}
	
<div id="container">
            
</div>	<br />
{*
			{section name=ispis loop=$konfiguracija}
				<table align='center' class='{#table_class#}'>
					<tr>
						<td colspan = "2"> <b>Naziv konfiguracije:</b> {$konfiguracija[ispis].naziv} </td>
						<td rowspan='3'> <img height='100px' width='100px' src='thumbs/{$konfiguracija[ispis].slika}' alt='Automobil'/></td>
					</tr>
					
					<tr>
					<td> <b>Naručitelj:</b> {$konfiguracija[ispis].kreator} </td>
					<td> <b>Datum narudžbe:</b> {$konfiguracija[ispis].dat_i_vrij_narudzbe}</td> 
					</tr>
					
					<tr>
						<td> <b>Marka automobila:</b> {$konfiguracija[ispis].marka} </td>
						<td> <b>Model:</b> {$konfiguracija[ispis].model} </td>
						
					</tr>
					
					<tr>
						<td> <b>Cijena:</b> {$konfiguracija[ispis].cijena} kn</td>
						<td> <b>Količina:</b> {$konfiguracija[ispis].kolicina} kom</td>
					</tr>
					<tr>
					<td> <b>Status:</b> 
					<select name='status_narudžbe'>
					<option {if $konfiguracija[ispis].status =='1'} selected='selected' {/if} value="1"> Nije još potvrđena</option>
					<option {if $konfiguracija[ispis].status =='2'} selected='selected' {/if} value="2"> Potvrđena</option>
					<option {if $konfiguracija[ispis].status =='3'} selected='selected' {/if} value="3"> Stigla</option>
					<option {if $konfiguracija[ispis].status =='4'} selected='selected' {/if} value="4"> Stigla i preuzeta</option>
					</select></td>
					
					<td> <input type="submit" id="promijeni_status" name="promijeni" value="Promijeni u odabrani status"/> </td>
					
					<td align='right'> {if $vlastita=='ne'}<a href='jozemberi_pregled_konfiguracije.php?id_konf={$konfiguracija[ispis].id_konfiguracije}'>Detaljnije...</a>{else} <a href='jozemberi_pregled_vlastite_konfiguracije.php?id_konf={$konfiguracija[ispis].id_konfiguracije}'>Detaljnije...</a>{/if}</td>
					</tr>
				</table>
				<br />
			{/section}
			*}
			<div id="loading"></div>
			<div id='paginacijaJQ'style="padding-left: 200px"> {$pagination} </div>
{*	<div align='center'>
	{$pagination}
	</div> *}
	<br />
	
