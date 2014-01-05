{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}
{config_load file='jozemberi_ispis.conf'}
	<h1> {$naslov} </h1>
	{if isset($podnaslov)} <h2>{$podnaslov} <h2>{/if}
	{if isset($upozorenje)} <span class='uputa'>{$upozorenje}</span> <br />{/if}
	
{literal}

<script type="text/javascript" src="js/mootools-core-1.4.5-full-compat.js" charset="utf-8"></script>
<script type="text/javascript">
	window.addEvent('domready',function() {
		/* settings */
		var showDuration = 5000;
		var container = document.id('slideshow-container');
		var images = container.getElements('img');
		var currentIndex = 0;
		var interval;
		var toc = [];
		var tocActive = 'toc-active';
		var thumbOpacity = 0.7;
		
		/* new: create caption area */
		var captionDIV = new Element('div',{
			id: 'slideshow-container-caption',
			styles: {
				//display:none,
				opacity: thumbOpacity
			}
		}).inject(container);
		var captionHeight = captionDIV.getSize().y;
		captionDIV.setStyle('height',0);
		
		/* new: starts the show */
		var start = function() { interval = show.periodical(showDuration); };
		var stop = function() { $clear(interval); };
		/* worker */
		var show = function(to) {
			images[currentIndex].fade('out');
			toc[currentIndex].removeClass(tocActive).fade(thumbOpacity);
			images[currentIndex = ($defined(to) ? to : (currentIndex < images.length - 1 ? currentIndex+1 : 0))].fade('in');
			toc[currentIndex].addClass(tocActive).fade(1);
			captionDIV.set('tween',{
				onComplete: function() {
					captionDIV.set('tween',{
						onComplete: document.idempty
					}).tween('height',captionHeight);
					/* parse caption */
					var title = '';
					var captionText = '';
					if(images[currentIndex].get('alt')) {
						cap = images[currentIndex].get('alt').split('::');
						title = cap[0];
						captionText = cap[1];
						captionDIV.set('html','<h3>' + title + '</h3>' + (captionText ? '<p>' + captionText + '</p>' : ''));
					}
				}
			}).tween('height',0);
		};
		
		/* new: create preview area */
		var preview = new Element('div',{
			id: 'slideshow-container-controls'
		}).inject(container,'after');
		
		/* new: control: table of contents */
		images.each(function(img,i){
			/* add to table of contents */
			toc.push(new Element('img',{
				src: img.get('src'),
				title: img.get('alt'),
				styles: {
					opacity: thumbOpacity
				},
				events: {
					click: function(e) {
						if(e) e.stop();
						stop();
						show(i);
						start();
					},
					mouseenter: function() {
						this.fade(1);
					},
					mouseleave: function() {
						if(!this.hasClass(tocActive)) this.fade(thumbOpacity);
					}
				}	
			}).inject(preview));
			if(i > 0) { img.set('opacity',0); }
			
		});
		
		/* control: start/stop on mouseover/mouseout */
		container.addEvents({
			mouseenter: function() { stop(); },
			mouseleave: function() { start(); }
		});
		
		/* start once the page is finished loading */
		window.addEvent('load',function(){ show(0); start(); });
	});



</script>

{/literal}
	
<div id="container">
            
	<br /> 
		
		<div id="slideshow-container">
		{section name=ispis loop=$modeli_automobila}
		  <img src="slike/{$modeli_automobila[ispis].slika}" alt="{$modeli_automobila[ispis].marka} {$modeli_automobila[ispis].model} {$modeli_automobila[ispis].tip_automobila} - {$modeli_automobila[ispis].cijena} kn"/>
		 {/section}
	</div>	
</div>			
	<br /> <br /> <br /> <br /><br /> <br /> <br />
	
