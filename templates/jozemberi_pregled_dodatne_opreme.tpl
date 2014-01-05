{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}
{config_load file='jozemberi_ispis.conf'}
	<h1> {$naslov} </h1>
	{if isset($podnaslov)} <h2>{$podnaslov} <h2>{/if}
	{if isset($upozorenje)} <span class='uputa'>{$upozorenje}</span> <br />{/if}
	
{literal}
	<script type="text/javascript">
		$(document).ready(function(){
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
					url: "jozemberi_pregled_dodatne_opreme.php",
					data: "page="+page,
					dataType: 'xml',
					success: function(xml){
							var div = $('<div id="sadrzaj"> <br />');
							var subdiv ='';
							$(xml).find('oprema').each(function(){
								subdiv+='<table align = "center" class="tablica"> <tr><td style="width: 360px;"><b>Naziv:</b> ' + $(this).attr('naziv') + 
								'</td><td style="width: 240px;"><b>Proizvođač:</b> ' + $(this).attr('proizvodac') + '</td> <td rowspan="4"> <img align="right" height="100px" border="1px" width="100px" src="thumbs/' + 
								$(this).attr('slika') + '" alt="Oprema"/></td></tr> <tr><td> <b>Kategorija:</b> '+ $(this).attr('kategorija') +'</td><td> <b>Predef. linija:</b> '+ $(this).attr('naziv_linije') +'</td></tr><tr><td colspan="2"><b>Opis:</b> ' +$(this).attr('opis') + 
								'</td></tr> <tr><td> <b>Dostupno:</b><input type="checkbox" name="dostupno" value="da" disabled="true"';
								if ($(this).attr("dostupno") == "1") subdiv += 'checked="true"/></td> <td> <b>Na akciji:</b> <input type="checkbox" name="na_akciji" value="da" disabled="true"';
								else subdiv += '/></td> <td> <b>Na akciji:</b> <input type="checkbox" name="na_akciji" value="da" disabled="true"';
								if ($(this).attr("na_akciji") == "1") subdiv+= 'checked="true"/></td></tr>';
								else subdiv+= '/></td></tr>';
								subdiv += '<tr><td><span style="color:darkblue"><b>Cijena:</b> </span> ' +$(this).attr('cijena') + 
										' kn</td>';
								subdiv += '<td>';
								if($(this).attr("na_akciji") == "1" && $(this).attr("akcijaValjana")=="da") subdiv +='<span style="color:red"><b> Akcijska cijena:</b> </span>' + $(this).attr("akcijska_cijena") +' kn';
								
								subdiv+= '</td><td align="right">';
									
								if ($(this).attr("opcijaUredi") == "da") subdiv += ' <a href="jozemberi_kreiranje_ponude_dodatna_oprema.php?update=' + $(this).attr("id_opreme") +'">Uredi</a>';
								
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
			{section name=ispis loop=$oprema}
				<table align='center' class='{#table_class#}'>
					<tr>
						<td style="width: 360px;"> <b>Naziv:</b> {$oprema[ispis].naziv} </td>
						<td style="width: 240px;"> <b>Proizvođač:</b> {$oprema[ispis].proizvodac} </td>
						<td rowspan="4"> <img align='right' border="1px" height="100px" width="100px" src="thumbs/{$oprema[ispis].slika}" alt="{$oprema[ispis].naziv}"/></td>
					</tr>
					<tr>
						<td> <b>Kategorija:</b> {$oprema[ispis].kategorija} </td>
						<td> <b>Predef. linija:</b> {$oprema[ispis].naziv_linije} </td>
						
					</tr>
					<tr>
						<td colspan="2"> <b>Opis:</b> {$oprema[ispis].opis} </td>
					</tr>
					
					
					<tr>
						<td> <b>Dostupno:</b>
						<input type="checkbox" name="dostupno" value="da" disabled="true" {if $oprema[ispis].dostupno == '1'} checked="true"{/if}/></td>
						<td> <b>Na akciji:</b> 
						<input type="checkbox" name="na_akciji" value="da" disabled="true" {if $oprema[ispis].na_akciji == '1'} checked="true"{/if}/></td>
					</tr>
					
					<tr>
						<td> <span style='color:darkblue'><b>Cijena:</b> </span>{$oprema[ispis].cijena} kn</td>
						<td> {if $oprema[ispis].na_akciji == 1 && $oprema[ispis].akcijaValjana =="da"}<span style='color:red'><b> Akcijska cijena:</b> </span>{$oprema[ispis].akcijska_cijena} kn {/if}</td>
						<td align="right"> {if $oprema[ispis].opcijaUredi == 'da'} <a href="jozemberi_kreiranje_ponude_dodatna_oprema.php?update={$oprema[ispis].id_opreme}">Uredi</a>{/if} </td>
					</tr>
				</table>
				<br />
			{/section}
			<div id="loading"></div>
	<div align='center'>
	{$pagination}
	</div>
	<br />
