{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}
{config_load file='jozemberi_ispis.conf'}
	<h1> {$naslov} </h1>
	{if isset($podnaslov)} <h2>{$podnaslov} <h2>{/if}
	{if isset($upozorenje)} <span class='uputa'>{$upozorenje}</span> <br /> {/if}
	
{literal}
	
	 <script type="text/javascript">
		$(document).ready(function(){
		
			$("rel^='prettyPhoto'").prettyPhoto();
			
			$("a[rel^='prettyPhoto']").prettyPhoto({animation_speed:'normal',theme:'light_square',slideshow:3000, 
				autoplay_slideshow: true,hideflash: false});
			
			var id_konf=0;
			var globTrenutnaStr=1;
			var globPrethodnaStr=0;
			var globPrikazOcjena=false;
			var globBrojPaginacija=1;
			
			var otvoreniPodkomentari = [];
					
			$.getScript("js/_getURLParam.js", function(){
				id_konf = $(document).getUrlParam("id_konf");
				loadData(1,id_konf); 
			});
			
			function loadData(page, id_konf){
				
				$.ajax({
					type: "POST",
					url: "_jozemberi_slanje_komentara.php",
					data: "page=" + page + "&id_konf=" + id_konf,
					dataType: 'xml',
					success: function(xml){
						var id_sadrzaj = '<div id="sadrzaj' + page +'">';
						var div = $(id_sadrzaj);
						var subdiv ='';
						var prijavljen ='ne';
						$(xml).find('prijava').each(function(){
							prijavljen = $(this).attr('prijavljen');
						});
				
						$(xml).find('komentar').each(function(){
							subdiv+='<div class="comment" id="komentar' + $(this).attr('id_komentara') +'" style="border: dotted #191970 1px;"><div class="dateKom" style="float:right; margin-top:0px; font-size: 12px; font-family: courier; color:#191970;">'+
							$(this).attr('dat_i_vrij_komentara') + '</div> <div class="avatarKor"><img height="40px" width="40px" src="thumbs/' + 
							$(this).attr('avatar') + 
							'" alt="avatar"/></div><div class="username_komentatora"><span>' + $(this).attr('username_komentatora') + 
							'</span></div> <p style="border: none;">' + $(this).attr('komentar_korisnika')+ 
							'  </p>'; 
							
							if($(this).attr('ima_podkomentare')=='1'){
								subdiv+='<div class="opcije" align="right"> <a href="' + $(this).attr('id_komentara') +'">podkomentari</a>';
								if(prijavljen == 'da'){
									subdiv+='<input type="radio" name="odgovori" value="' + 
									$(this).attr('id_komentara') + '"/> odgovori';
								}
								subdiv+='</div></div>';
							}
							
							else{
								if(prijavljen =='da'){
								subdiv+='<div class="opcije" align="right"><input type="radio" name="odgovori" value="' + 
								$(this).attr('id_komentara') + '"/> odgovori';
								}
								else{
									subdiv+='<div align="right"><input style="display:none;"type="radio" name="odgovori" value="' + 
									$(this).attr('id_komentara') + '"/></div></div>';
								}
								subdiv+='</div></div>';
							
							}
						
						
						});
						div.append(subdiv);
						div.append('</div>');
						
						var br_paginacija;
						$(xml).find('paginacija').each(function(){
							br_paginacija = $(this).attr('br_paginacija');
						});
			
						$('#container').ajaxComplete(function(e, xhr, options) {
							if (options.url == '_jozemberi_slanje_komentara.php'){ 
								$('#container').empty();
								$('#container').append(div);
								$('.pagination').hide();
								if(br_paginacija > 1)pagination(br_paginacija);
								globBrojPaginacija=br_paginacija;
							}	
						}); 
					}//success
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
				
				//slanje komentara       
				$('#addCommentForm').submit(function(e){
					e.preventDefault();
					var komentar = $('textarea[name=komentar]');
					if(komentar.val()=="") {
						$('textarea[name=komentar]').css({"border":"solid red 1px"});
					}
					
					else{
						$('textarea[name=komentar]').css({"border":"1px solid #ccc"});
						var nadkomentar = $('input[name=odgovori]:radio:checked').val();
						if(nadkomentar == null) nadkomentar='nula';
						else $('input[name=odgovori]:radio').removeAttr("checked");
						
						var podaci = 'id_konf=' + id_konf + '&nadkomentar=' + nadkomentar + '&komentar=' + encodeURIComponent(komentar.val());
						$.ajax({
							
							url: "_jozemberi_upis_komentara.php", 
							type: "POST",  
							data: podaci,     
							cache: false, 
						
							success: function (br_paginacija) {  
								if(nadkomentar == 'nula'){
									document.getElementById('komentar').value='';
									$("#komentar").focus();
									loadData(br_paginacija,id_konf);	
									globTrenutnaStr=br_paginacija;
								}
								else{
									document.getElementById('komentar').value='';
									$("#komentar").focus();
									loadData(globTrenutnaStr,id_konf);	//??
									
									otvoreniPodkomentari =[];
									ucitajPodkomentare(nadkomentar);
								}
							} 
						
						});
					}//else
				});
							
				function pagination(no_of_paginations){
					var per_page = 10;
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
				
				//ocjenjivanje
				$('.star-rating li a').click(function(e){
					e.preventDefault();
			
					var ocjena = parseInt ($(this).attr('href'));
					
					var ocjenaPostotak= ocjena*20 + "%";
					$('#treOcjena').css({"width": "" + ocjenaPostotak});
					
					var data = 'ocjena=' + ocjena + '&id_konf=' + id_konf;
					
						$.ajax({
							url: "_jozemberi_upis_ocjene.php", 
							type: "POST",      
							data: data,  
							dataType: 'xml',
							//cache: false, 
							success: function (xml) {
								var prosjek;
								
								$(xml).find('ocjena').each(function(){
								prosjek = $(this).attr('prosjek');
								});
								$('.ispisOcjena').text(prosjek);
							},
							error: function(xhr, ajaxOptions, thrownError) {
								alert(xhr.statusText);
								alert(thrownError);
							}
						});
				});
				
				$('.ispisOcjena').click(function(e){
					e.preventDefault();
					if(globPrikazOcjena==false){
							
							var data = 'glasaci=da&id_konf=' + id_konf;
							$.ajax({
								url: "_jozemberi_upis_ocjene.php", 
								type: "POST",
		   
								data: data,     
								dataType: 'xml',
								
								success: function (xml) {
									var div = $('<span class="uputa">');
									div.append('<span class="greska"> ocjene | </span>');
									$(xml).find('ocjenjivac').each(function(){
										div.append( $(this).attr('komentator') + ' : ' + $(this).attr('ocjena')+ '<span class="greska"> | </span>');
					
									});
									div.append('</span>');
									
									
									$("#KiO").ajaxComplete(function(e, xhr, options) {
										if (options.url == '_jozemberi_upis_ocjene.php') { // Or whatever test you may need
											$('#KiO').append(div);
										}									
									});//ajaxComplete								
								}	
							});
							globPrikazOcjena=true;
						}
						else{
							$('#KiO span').hide();
							globPrikazOcjena=false;
							}
				
				});
			
				$('.opcije a').live('click',function(e){
					e.preventDefault();
					
					var id_komentara = parseInt ($(this).attr('href'));    
					ucitajPodkomentare(id_komentara);
					
				
				});
				
				function ucitajPodkomentare(id_komentara){ 
				var removeMe=null;
				
					$.each( otvoreniPodkomentari, function(i, v) {
						if( v.id == id_komentara) {
						   removeMe = i;
						   
						}
						
					 });
					
				if(removeMe != null){
						otvoreniPodkomentari.splice(removeMe,1);
						$('#sadrzaj'+id_komentara).hide('slow');
					}	
				else{
					otvoreniPodkomentari.push({'id':id_komentara});

					var podaci='id_komentara=' + id_komentara;
					$.ajax({
						type: "POST",
						url: "_jozemberi_slanje_podkomentara.php",
						data: podaci,
						dataType: 'xml',
						
						success: function(xml){
							var id_podkomentara = '<div id="sadrzaj' + id_komentara +'">';
							var div = $(id_podkomentara);
							var subdiv ='';
							$(xml).find('podkomentar').each(function(){
								subdiv += '<div class="podkomentar" style="padding-left:120px;"> <div class="comment" style="border: dotted #191970 1px;"><div class="dateKom" style="float:right; margin-top:0px; font-size: 12px; font-family: courier; color:#191970;">'+
								$(this).attr('dat_i_vrij_komentara') + '</div> <div class="avatarKor"><img height="40px" width="40px"src="thumbs/' + 
								$(this).attr('avatar') + 
								'" alt="avatar"/></div><div class="username_komentatora"><span>' + $(this).attr('username_komentatora') + 
								'</span></div> <p style="border: none;">' + $(this).attr('komentar_korisnika')+ 
								'  </p></div></div>'; 
							});
							
							div.append(subdiv);
							div.append('</div>');
								
							$('#komentar'+id_komentara).bind("ajaxComplete", function(e, xhr, options) {
									if (options.url == '_jozemberi_slanje_podkomentara.php'){ 
										$('#komentar'+id_komentara).after(div);
							
									}
									
								});
							
							},//succses
							error: function(xhr, ajaxOptions, thrownError) {
								alert(xhr.statusText);
								alert(thrownError);
							}	
						});	
				}//else
				}//funkcija	
			 });
		</script> 
	
{/literal}
	
	<br />
				<table align='center' class='{#table_class#}'>
					<tr>
						<td> <b>Naziv konfiguracije:</b> {$konfiguracija.naziv} </td>
						<td> <b>Kreator:</b> {$konfiguracija.kreator} </td>
						<td> </td>
					</tr>
					<tr> <td colspan='3'> <span class='podnaslov'>Osnovna konfiguracija </span> <td></tr>
					<tr>
						<td> <b>Marka automobila:</b> {$konfiguracija.marka} </td>
						<td> <b>Model:</b> {$konfiguracija.model} </td>
						<td rowspan='5'>
							<ul  style="list-style-type: none;"class="gallery clearfix"> 
								<li>
									<a href="slike/{$konfiguracija.slika}" rel="prettyPhoto[gallery2]">
										<img align='right' border='1px' height='100px' width='150px' src='thumbs/{$konfiguracija.slika}' 
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
					<tr> <td colspan='3'><b>Cijena:</b> {$konfiguracija.cijena} kn <td></tr>
					{* Gume *}
					<tr> <td colspan='3'> <span> <hr /></span> </td></tr>
					<tr> <td colspan='3'> <span class='podnaslov'>Gume </span> <td></tr>
					{section name=i loop=$gume}
					<tr>
						<td> <b>Naziv:</b> {$gume[i].naziv} </td>
						<td> <b>Širina:</b> {$gume[i].sirina} </td>
						<td rowspan='4'> <ul  style="list-style-type: none;"class="gallery clearfix"> 
						<li><a href="slike/{$gume[i].slika}" rel="prettyPhoto[gallery2]"><img align='right' border='1px' height='100px' width='150px' src='thumbs/{$gume[i].slika}' alt='{$gume[i].naziv}'/></a> </li></ul></td>
						
					</tr>
					<tr>
						<td> <b>Visina:</b> {$gume[i].visina} </td>
						<td> <b>Promjer:</b> {$gume[i].promjer} </td>
					</tr>
					<tr>
						<td> <b>Vrsta:</b> {$gume[i].vrsta} </td>
						<td> <b>Tip:</b> {$gume[i].tip} </td>
					</tr>
					<tr>
						<td> <b>Cijena:</b> {$gume[i].cijena} kn </td>
						<td> <b>Količina:</b> {$gume[i].kolicina} kom </td>
					</tr>
					<tr> <td colspan='3'> <span> <br /></span></td></tr>
					{/section}
					
					{* Felge *}
					<tr> <td colspan='3'> <span> <hr /></span> </td></tr>
					<tr> <td colspan='3'> <span class='podnaslov'>Felge </span> <td></tr>
					{section name=i loop=$felge}
					<tr>
						<td> <b>Naziv:</b> {$felge[i].naziv} </td>
						<td> <b>Boja:</b> {$felge[i].boja} </td>
					
						<td rowspan='3'> <ul  style="list-style-type: none;"class="gallery clearfix"> 
						<li><a href="slike/{$felge[i].slika}" rel="prettyPhoto[gallery2]"><img align='right' border='1px' height='80px' width='80px' src='thumbs/{$felge[i].slika}' alt='{$felge[i].naziv}'/></a> </li></ul></td>
						
					</tr>
					
					<tr>
						<td> <b>Cijena:</b> {$felge[i].cijena} </td>
						<td> <b>Količina:</b> {$felge[i].kolicina} </td>
					</tr>
					<tr>
						<td> <b>Promjer:</b> {$felge[i].promjer} </td>
					</tr>
					<tr> <td colspan='3'> <span> <br /></span></td></tr>
					{/section}
					
					{* Dodatna Oprema *}
					<tr> <td colspan='3'> <span> <hr /></span> </td></tr>
					<tr> <td colspan='3'> <span class='podnaslov'>Dodatna Oprema </span> <td></tr>
					{section name=i loop=$oprema}
					<tr>
						<td> <b>Naziv:</b> {$oprema[i].naziv} </td>
						<td> {if isset($oprema[i].proizvodac)}<b>Proizvođač:</b> {$oprema[i].proizvodac} {/if} </td>
					{*	<td rowspan='3'> <img align='right' height='120px' width='120px' src='{$oprema[i].slika}' alt='Dodatna Oprema'/></td> *}
						<td rowspan='3'> <ul  style="list-style-type: none;"class="gallery clearfix"> 
						<li><a href="slike/{$oprema[i].slika}" rel="prettyPhoto[gallery2]"><img align='right' border='1px' height='100px' width='100px' src='thumbs/{$oprema[i].slika}' alt='{$oprema[i].naziv}'/></a> </li></ul></td>
						
					</tr>
					<tr>
						<td colspan='2' align='justify'> <b>Opis: <br /></b> {$oprema[i].opis} </td>
					</tr>
					<tr>
						<td> <b>Cijena:</b> {$oprema[i].cijena} </td>
						<td> <b>Količina:</b> {$oprema[i].kolicina} </td>
					</tr>
					<tr> <td colspan='3'> <span> <br /></span></td></tr>
					{/section}
				</table>
				
				<div id='KiO' style='padding-left:80px; padding-right:80px; padding-top:10px;'> </div>
			
				<div>	{if isset($ocjenaPostotak)}	
				<br />
			
				<span style='margin-left:100px'> Vaša ocjena ove konfiguracije: </span> 
					<span class="inline-rating">
						<ul class="star-rating">
							<li id='treOcjena' class="current-rating" style="width:{$ocjenaPostotak}%;"> </li>
							<li><a href="1" title="1/5" class="one-star">1</a></li>
							<li><a href="2" title="2/5" class="two-stars">2</a></li>
							<li><a href="3" title="3/5" class="three-stars">3</a></li>
							<li><a href="4" title="4/5" class="four-stars">4</a></li>
							<li><a href="5" title="5/5" class="five-stars">5</a></li>
						</ul>
					</span>
				{/if}
					<span style='margin-left:100px;' >Prosječna ocjena: {if $prosjek!=0} <a href="#" title='Tko je glasao' class='ispisOcjena'>{$prosjek}</a>/5{else} <a href="#" title='Tko je glasao' class='ispisOcjena'>Nema</a>{/if} </span>
				
				</div>
			
				<br />
			
<div id="container" align='center'>
           
</div>	
	
<div id="loading"></div>

	 <div id='paginacijaJQ'style="padding-left: 200px"> {$pagination} </div>
	<br />
	
	
<div align='center'>	
{if isset($ocjenaPostotak)}	
<div id="addCommentContainer">
	<p>Dodaj komentar</p>
	<form id="addCommentForm" method="POST" action="#">
    	<div>
            <textarea name="komentar" id="komentar" cols="20" rows="5"></textarea>
            
            <input type="submit" id="submit" value="Pošalji komentar" />
        </div>
    </form>
</div>
{/if}
</div>