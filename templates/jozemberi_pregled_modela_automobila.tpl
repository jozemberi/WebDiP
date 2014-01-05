{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}
{config_load file='jozemberi_ispis.conf'}
	<h1> {$naslov} </h1>
	{if isset($podnaslov)} <h2>{$podnaslov} <h2>{/if}
	{if isset($upozorenje)} <span class='uputa'>{$upozorenje}</span> <br />{/if}
	
{literal}
	<script type="text/javascript">
		$(document).ready(function(){
			$("rel^='prettyPhoto'").prettyPhoto();
			
			$("a[rel^='prettyPhoto']").prettyPhoto({animation_speed:'normal',theme:'light_square',slideshow:3000, 
				autoplay_slideshow: false,hideflash: false, theme: 'pp_default'});
				
		
			var globTrenutnaStr=1;
			
			function loading_show(){
				$('#loading').html("<img src='img/loading.gif'/>").fadeIn('fast');
			}
			
			function loading_hide(){
				$('#loading').fadeOut('fast');
			}                
			
			function loadData(page){
                loading_show();  
                $.ajax({
					type: "POST",
					url: "jozemberi_pregled_modela_automobila.php",
					data: "page="+page,
					dataType: 'xml',
					success: function(xml){
							var div = $('<div id="sadrzaj"> <br />');
							var subdiv='';
							$(xml).find('osnovna_konfiguracija').each(function(){
								subdiv+='<table align = "center" class="tablica"> <tr><td style="width: 380px;"><b>Marka automobila:</b> ' + $(this).attr('marka') + 
								'</td><td style="width: 300px;"><b>Model:</b> ' + $(this).attr('model') + '</td> <td rowspan="6"> <ul  style="list-style-type: none;"class="gallery clearfix"> <li><a href="slike/'+ $(this).attr('slika') +
								'" rel="prettyPhoto[gallery2]"><img align="right" border="1px" height="120" width="180" src="thumbs/'+ $(this).attr('slika') +
								'" alt="'+ $(this).attr('marka') + $(this).attr('model') +'"/></a> </li></ul></td></tr> <tr><td><b>Godina proizvodnje:</b> ' +$(this).attr('god_proizvodnje') + 
								'</td><td><b>Godina modela:</b> ' +$ (this).attr('god_modela') + '</td></tr> <tr><td><b>Tip automobila:</b> ' +$(this).attr('tip') + 
								'</td><td><b>Tip motora:</b> ' + $(this).attr('motor') + '</td></tr> <tr><td> <b>Snaga motora:</b> ' + $(this).attr('snaga') + 
								'</td> <td> <b>Radni obujam:</b> ' + $(this).attr('radni_obujam') + 
								'</td> </tr> <tr><td><b>Mjenjač:</b> ' +$(this).attr('mjenjac') + 
								'</td><td><b>Broj stupnjeva:</b> ' +$ (this).attr('br_stupnjeva') + '</td></tr><tr><td> <b>Dostupno:</b><input type="checkbox" name="dostupno" value="da" disabled="true"';
								
								if ($(this).attr("dostupno") == "1") subdiv += 'checked="true"/></td> <td> <b>Na akciji:</b> <input type="checkbox" name="na_akciji" value="da" disabled="true"';
								else subdiv += '/></td> <td> <b>Na akciji:</b> <input type="checkbox" name="na_akciji" value="da" disabled="true"';
								if ($(this).attr("na_akciji") == "1") subdiv+= 'checked="true"/></td></tr>';
								else subdiv+= '/></td></tr>';
								subdiv += '<tr><td><span style="color:darkblue"><b>Cijena:</b> </span> ' +$(this).attr('cijena') + 
										' kn</td>';
								subdiv += '<td>';
								if($(this).attr("na_akciji") == "1" && $(this).attr("akcijaValjana")=="da") subdiv +='<span style="color:red"><b> Akcijska cijena:</b> </span>' + $(this).attr("akcijska_cijena") +' kn';
								
								subdiv+= '</td><td align="right">';
									
								if ($(this).attr("opcijaUredi") == "da") subdiv += ' <a href="jozemberi_kreiranje_ponude_modeli_automobila.php?update=' + $(this).attr("id_osnovne_konfiguracije") +'">Uredi</a>';
								
								subdiv+= '</td></tr></table> <br />';
								
							});
							div.append(subdiv);
							div.append('</div>');
						$("#content").ajaxComplete(function(){
							$('.tablica').hide();
							$('#sadrzaj').hide();
							$('br').hide();
							
							loading_hide();
							$('#container').append(div);
							$("rel^='prettyPhoto'").prettyPhoto();
							$("a[rel^='prettyPhoto']").prettyPhoto({animation_speed:'normal',theme:'light_square',slideshow:3000, 
							autoplay_slideshow: false,hideflash: false, theme: 'pp_default'});
			
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
				
            });

		</script>
{/literal}
	
<div id="container">
            
</div>	<br />
			{section name=ispis loop=$modeli_automobila}
				<table align='center' class='{#table_class#}'>
					<tr>
						<td style="width: 380px;"> <b>Marka automobila:</b> {$modeli_automobila[ispis].marka} </td>
						<td style="width: 300px;"> <b>Model:</b> {$modeli_automobila[ispis].model} </td>
						
						<td rowspan="6"> 
						<ul  style="list-style-type: none;"class="gallery clearfix"> 
						<li><a href="slike/{$modeli_automobila[ispis].slika}" rel="prettyPhoto[gallery2]"><img align='right' border='1px' height="120" width="180" src='thumbs/{$modeli_automobila[ispis].slika}' alt='{$modeli_automobila[ispis].marka} {$modeli_automobila[ispis].model}'/></a> </li></ul>
		
						</td>
					</tr>
					<tr>
						<td> <b>Tip automobila:</b> {$modeli_automobila[ispis].tip_automobila} </td>
						<td> <b>Tip motora:</b> {$modeli_automobila[ispis].tip_motora} </td>
					</tr>
					<tr>
						<td> <b>Snaga motora:</b> {$modeli_automobila[ispis].snaga} </td>
						<td> <b>Radni obujam:</b> {$modeli_automobila[ispis].radni_obujam} </td>
					</tr>
					<tr>
					<td> <b>Godina proizvodnje:</b> {$modeli_automobila[ispis].god_proizvodnje}</td> 
					<td> <b>Godina modela:</b> {$modeli_automobila[ispis].god_modela}</td> 
					</tr>
					<tr>
						<td> <b>Mjenjač:</b> {$modeli_automobila[ispis].mjenjac} </td>
						<td> <b>Broj stupnjeva:</b> {$modeli_automobila[ispis].br_stupnjeva} </td>
					</tr>
					
					<tr>
						<td> <b>Dostupno:</b>
						<input type="checkbox" name="dostupno" value="da" disabled="true" {if $modeli_automobila[ispis].dostupno == '1'} checked="true"{/if}/></td>
						<td> <b>Na akciji:</b> 
						<input type="checkbox" name="na_akciji" value="da" disabled="true" {if $modeli_automobila[ispis].na_akciji == '1'} checked="true"{/if}/></td>
					</tr>
					
					<tr>
						<td> <span style='color:darkblue;'><b>Cijena:</b></span> {$modeli_automobila[ispis].cijena} kn</td>
						<td> {if $modeli_automobila[ispis].na_akciji == 1 && $modeli_automobila[ispis].akcijaValjana =="da"}<span style='color:red'><b> Akcijska cijena:</b> </span>{$modeli_automobila[ispis].akcijska_cijena} kn {/if}</td>
						<td align="right"> {if $modeli_automobila[ispis].opcijaUredi == 'da'} <a href="jozemberi_kreiranje_ponude_modeli_automobila.php?update={$modeli_automobila[ispis].id_osnovne_konfiguracije}">Uredi</a>{/if} </td>
					</tr>
				</table>
				<br />
			{/section}
			<div id="loading"></div>
	<div align='center'>
	{$pagination}
	</div>
	<br />
	
