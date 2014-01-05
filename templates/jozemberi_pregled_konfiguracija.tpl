{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}
{config_load file='jozemberi_ispis.conf'}
	<h1> {$naslov} </h1>
	{if isset($podnaslov)} <h2>{$podnaslov} <h2>{/if}
	{if isset($upozorenje)} <span class='uputa'>{$upozorenje}</span> <br />{/if}
	
{literal}
	<script type="text/javascript">
		$(document).ready(function(){
			var globTrenutnaStr=1;
			
			$("rel^='prettyPhoto'").prettyPhoto();
			
			$("a[rel^='prettyPhoto']").prettyPhoto({animation_speed:'normal',theme:'light_square',slideshow:3000, 
				autoplay_slideshow: false,hideflash: false, theme: 'pp_default'});
				
		
			
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
					url: "jozemberi_pregled_konfiguracija.php",
					data: "page="+page,
					dataType: 'xml',
					success: function(xml){
							var div = $('<div id="sadrzaj"> <br />');
							$(xml).find('konfiguracija').each(function(){
							
								div.append('<table align = "center" class="tablica"> <tr><td style="width:500px;"><b>Naziv konfiguracije:</b> ' + $(this).attr('naziv') + 
								'</td><td style="width:300px;"><b>Kreator:</b> ' + $(this).attr('kreator') + '</td> <td rowspan="3"> <ul  style="list-style-type: none;"class="gallery clearfix"> <li><a href="slike/'+ $(this).attr('slika') +
								'" rel="prettyPhoto[gallery2]"><img align="right" border="1px" height="80" width="120" src="thumbs/'+ $(this).attr('slika') +
								'" alt="'+ $(this).attr('marka') +' '+ $(this).attr('model') +'"/></a> </li></ul></td></tr> <tr><td><b>Marka automobila:</b> ' +$(this).attr('marka') + 
								'</td><td><b>Model:</b> ' +$ (this).attr('model') + '</td></tr> <tr><td><b>Tip automobila:</b> ' +$(this).attr('tip') + 
								'</td><td><b>Tip motora:</b> ' + $(this).attr('motor') + '</td></tr> <tr><td> <b>Godina proizvodnje:</b> ' + $(this).attr('god_proizvodnje') + 
								'</td> <td> <b>Godina modela:</b> ' + $(this).attr('god_modela') + 
								'</td> <td align="right"> <a href="jozemberi_pregled_konfiguracije.php?id_konf=' + 
								$(this).attr('id_konfiguracije') + '">Detaljnije...</a></td> </tr> </table> <br />');
							});
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
			{section name=ispis loop=$konfiguracija}
				<table align='center' class='{#table_class#}'>
					<tr>
						<td style="width:500px;"> <b>Naziv konfiguracije:</b> {$konfiguracija[ispis].naziv} </td>
						<td style="width:300px;"> <b>Kreator:</b> {$konfiguracija[ispis].kreator} </td>
						<td rowspan='3'> <ul  style="list-style-type: none;"class="gallery clearfix"> 
						<li><a href="slike/{$konfiguracija[ispis].slika}" rel="prettyPhoto[gallery2]"><img align='right' border='1px' height="80" width="120" src='thumbs/{$konfiguracija[ispis].slika}' alt='{$konfiguracija[ispis].marka} {$konfiguracija[ispis].model}'/></a> </li></ul></td>
					</tr>
					<tr>
						<td> <b>Marka automobila:</b> {$konfiguracija[ispis].marka} </td>
						<td> <b>Model:</b> {$konfiguracija[ispis].model} </td>
						
					</tr>
					<tr>
						<td> <b>Tip automobila:</b> {$konfiguracija[ispis].tip_automobila} </td>
						<td> <b>Tip motora:</b> {$konfiguracija[ispis].tip_motora} </td>
					</tr>
					<tr>
					<td> <b>Godina proizvodnje:</b> {$konfiguracija[ispis].god_proizvodnje}</td> 
					<td> <b>Godina modela:</b> {$konfiguracija[ispis].god_modela}</td> 
					<td align='right'> {if $vlastita=='ne'}<a href='jozemberi_pregled_konfiguracije.php?id_konf={$konfiguracija[ispis].id_konfiguracije}'>Detaljnije...</a>{else} <a href='jozemberi_pregled_vlastite_konfiguracije.php?id_konf={$konfiguracija[ispis].id_konfiguracije}'>Detaljnije...</a>{/if}</td>
					</tr>
				</table>
				<br />
			{/section}
			<div id="loading"></div>
	<div align='center'>
	{$pagination}
	</div>
	<br />
	
