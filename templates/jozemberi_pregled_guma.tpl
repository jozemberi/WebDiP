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
				autoplay_slideshow: true,hideflash: false});
				
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
					url: "jozemberi_pregled_guma.php",
					data: "page="+page,
					dataType: 'xml',
					success: function(xml){
							var div = $('<div id="sadrzaj"><br />');
							var subdiv ='';
							$(xml).find('guma').each(function(){
								subdiv += '<table align = "center" class="tablica"> <tr><td style="width: 400px;"><b>Naziv:</b> ' + $(this).attr('naziv') + 
								'</td><td style="width: 300px;"><b>Širina:</b> ' + $(this).attr('sirina') + '</td> <td rowspan="4"> <ul  style="list-style-type: none;"class="gallery clearfix"><li><a href="slike/' + 
								$(this).attr('slika') + '" rel="prettyPhoto[gallery2]"><img align="right" border="1px" height="100px" width="150px" src="thumbs/'+ 
								$(this).attr('slika') + '" alt="'+ $(this).attr('naziv') + '"/></a> </li></ul></td></tr> <tr><td><b>Visina:</b> ' + 
								$(this).attr('visina') + 
								'</td><td><b>Promjer:</b> ' +$ (this).attr('promjer') + '</td></tr> <tr><td><b>Vrsta:</b> ' +$(this).attr('vrsta') + 
								'</td><td><b>Tip:</b> ' + $(this).attr('tip') + '</td></tr><tr><td> <b>Dostupno:</b><input type="checkbox" name="dostupno" value="da" disabled="true"';
								if ($(this).attr("dostupno") == "1") subdiv += 'checked="true"/></td> <td> <b>Na akciji:</b> <input type="checkbox" name="na_akciji" value="da" disabled="true"';
								else subdiv += '/></td> <td> <b>Na akciji:</b> <input type="checkbox" name="na_akciji" value="da" disabled="true"';
								if ($(this).attr("na_akciji") == "1") subdiv+= 'checked="true"/></td></tr>';
								else subdiv+= '/></td></tr>';
								subdiv += '<tr><td><span style="color:darkblue"><b>Cijena:</b> </span> ' +$(this).attr('cijena') + 
										' kn</td>';
								subdiv += '<td>';
								if($(this).attr("na_akciji") == "1" && $(this).attr("akcijaValjana")=="da") subdiv +='<span style="color:red"><b> Akcijska cijena:</b> </span>' + $(this).attr("akcijska_cijena") +' kn';
								
								subdiv+= '</td><td align="right">';
									
								if ($(this).attr("opcijaUredi") == "da") subdiv += ' <a href="jozemberi_kreiranje_ponude_gume.php?update=' + $(this).attr("id_gume") +'">Uredi</a>';
								
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
			{section name=ispis loop=$gume}
				<table align='center' class='{#table_class#}'>
					<tr>
						<td style="width: 400px;"> <b>Naziv:</b> {$gume[ispis].naziv} </td>
						<td style="width: 300px;"> <b>Širina:</b> {$gume[ispis].sirina} </td>
						<td rowspan="4"> <ul  style="list-style-type: none;"class="gallery clearfix"> 
						<li><a href="slike/{$gume[ispis].slika}" rel="prettyPhoto[gallery2]"><img align='right' height='100px' width='150px' border='1px' src='thumbs/{$gume[ispis].slika}' alt='{$gume[ispis].naziv}'/></a> </li></ul>

					{*	<img align='right' height="100px" width="100px" src="{$gume[ispis].slika}" alt="{$gume[ispis].naziv}"/> *}
					</td> 
					</tr>
					<tr>
						<td> <b>Visina:</b> {$gume[ispis].visina} </td>
						<td> <b>Promjer:</b> {$gume[ispis].promjer} </td>
					</tr>
					<tr>
						<td> <b>Vrsta:</b> {$gume[ispis].vrsta} </td>
						<td> <b>Tip:</b> {$gume[ispis].tip} </td>
					</tr>
					
					<tr>
						<td> <b>Dostupno:</b>
						<input type="checkbox" name="dostupno" value="da" disabled="true" {if $gume[ispis].dostupno == '1'} checked="true"{/if}/></td>
						<td> <b>Na akciji:</b> 
						<input type="checkbox" name="na_akciji" value="da" disabled="true" {if $gume[ispis].na_akciji == '1'} checked="true"{/if}/></td>
					</tr>
					
					<tr>
						<td> <span style='color:darkblue'><b>Cijena:</b> </span>{$gume[ispis].cijena} kn</td>
						<td> {if $gume[ispis].na_akciji == 1 && $gume[ispis].akcijaValjana =="da"}<span style='color:red'><b> Akcijska cijena:</b> </span>{$gume[ispis].akcijska_cijena} kn {/if}</td>
						<td align="right"> {if $gume[ispis].opcijaUredi == 'da'} <a href="jozemberi_kreiranje_ponude_gume.php?update={$gume[ispis].id_gume}">Uredi</a>{/if} </td>
					</tr>
				</table>
				<br />
			{/section}
			<div id="loading"></div>
	<div align='center'>
	{$pagination}
	</div>
	<br />
