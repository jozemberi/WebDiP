<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>
		<title>{$naslov_str}</title>
		<script type="text/javascript" src="js/jozemberi.js"></script>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.11/jquery-ui.min.js"></script>
		<link type="text/css" rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7/themes/smoothness/jquery-ui.css"/>
		
		<link rel='shortcut icon' href='img/wp_icon.ico' type='image/x-icon' />
		<link rel='stylesheet' type='text/css' href='css/jozemberi.css'/>
		
		<link rel="stylesheet" type="text/css" href="css/fixedMenu_style2.css" />
		<link rel="stylesheet" href="css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
	<script src="js/jquery.prettyPhoto.js" type="text/javascript" charset="utf-8"></script>
	
	 <script type="text/javascript" src="js/jquery.fixedMenu.js"></script>
	
		
	
	
		<script type='text/javascript' src='chrome-extension://bfbmjmiodbnnpllbbbfblcplfjjepjdn/js/injected.js'></script>
		
		{literal}
		<script  type="text/javascript">
         $('document').ready(function(){
             $('.menu').fixedMenu();
        });
        </script>
		{/literal}
	</head>
	<body>
		<div id='wrap'>	
			<div id='header'> <a href='jozemberi_home.php'> <img src='img/logo.png' alt='logo' align='left' width='125px' vspace='35' hspace='10' border='none' /></a> <span class='tekstZaglavlja'>Sustav za konfiguraciju pri kupnji automobila</span> </div>
	
		<div id='navigation'>
			<div class="menu">
				<ul>
					<li>
						<a href="jozemberi_home.php"> Početna </a> 
					</li>
					<li>
						<a href="#">Pregled<span class="arrow"></span></a>
						<ul>
							{if isset($smarty.session.username) and $smarty.session.tip_korisnika=='3'}
							<li><a href="jozemberi_pregled_statistike.php?page=1&status=0">Statistike</a></li>
							<li style='border-bottom: 1px solid black;'><a href="jozemberi_pregled_trgovina.php">Trgovina</a></li>
							{/if}
							{if isset($smarty.session.username) and ($smarty.session.tip_korisnika=='2' or $smarty.session.tip_korisnika=='3')}
							<li style='border-bottom: 1px solid black;'><a href="jozemberi_pregled_narucenih_konfiguracija.php">Naručenih konfiguracija</a></li>
							{/if}
							{if isset($smarty.session.username)}
							<li style='border-bottom: 1px solid black;'><a href="jozemberi_pregled_konfiguracija.php?korisnik={$smarty.session.username}">Vlastitih konfiguracija</a></li>
							{/if}
							<li><a href="jozemberi_pregled_konfiguracija.php">Javnih konfiguracija</a></li>
							<li><a href="jozemberi_pregled_modela_automobila.php">Modela automobila</a></li>
							<li><a href="jozemberi_pregled_dodatne_opreme.php">Dodatne opreme</a></li>
							<li><a href="jozemberi_pregled_guma.php">Guma</a></li>
							<li><a href="jozemberi_pregled_felgi.php">Felgi</a></li>
							<li><a href="jozemberi_galerija.php">Galerije</a></li>
						</ul>
					</li>
					{if isset($smarty.session.username)}
					<li>
						<a href="#">Kreiranje<span class="arrow"></span></a>
						<ul>
							{if isset($smarty.session.username) and $smarty.session.tip_korisnika=='3'}
							<li style='border-bottom: 1px solid black;'><a href="jozemberi_kreiranje_trgovine.php">Trgovine</a></li>
							{/if}
							{if isset($smarty.session.username) and ($smarty.session.tip_korisnika=='2' or $smarty.session.tip_korisnika=='3')}
							<li><a href="jozemberi_kreiranje_ponude_gume.php">Ponude - gume</a></li>
							<li><a href="jozemberi_kreiranje_ponude_felge.php">Ponude - felge</a></li>
							<li><a href="jozemberi_kreiranje_ponude_dodatna_oprema.php">Ponude - dodatna oprema</a></li>
							<li><a href="jozemberi_kreiranje_ponude_modeli_automobila.php">Ponude - modeli automobila</a></li>
							<li><a href="jozemberi_kreiranje_ponude_motor.php">Ponude - motor</a></li>
							<li><a href="jozemberi_kreiranje_predefiniranih_linija.php">Predefiniranih linija</a></li>
							<li><a href="jozemberi_kreiranje_vijesti.php">Vijesti</a></li>
							<li style='border-bottom: 1px solid black;'><a href="jozemberi_kreiranje_akcije.php">Akcije</a></li>
							{/if}
							<li><a href="jozemberi_odabir_osnovne_konfiguracije.php">Nove konfiguracije</a></li>
						</ul>
					</li>
					{/if}
					
					{if isset($smarty.session.username) and $smarty.session.tip_korisnika=='3'}
					<li>
						<a href="#">Upravljanje<span class="arrow"></span></a>
						<ul>
							{if isset($smarty.session.username) and $smarty.session.tip_korisnika=='3'}
								<li> <a href='jozemberi_ispis_korisnika.php?page=1&status=0'>Korisničkim podacima</a> </li>
							{/if}
							{if isset($smarty.session.username) and $smarty.session.tip_korisnika=='3'}
								<li> <a href='jozemberi_virtualno_vrijeme.php'> Sustavskim Vremenom</a></li>
								<li> <a href='jozemberi_konfiguracija_stranicenja.php'> Straničenjem</a></li>
							{/if}
						</ul>
					</li>
					{/if}
					
					<li><a href="jozemberi_dokumentacija.php">Dokumentacija</a></li>
						
						
					<li>
						<a href="#">Kontakt<span class="arrow"></span></a>
						<ul>
							<li><a href="https://www.facebook.com/josip.zemberi" target="_BLANK">Facebook</a></li>
							<li><a href="http://www.linkedin.com/profile/view?id=156014531" target="_BLANK">LinkedIn</a></li>
							<li><a href="mailto:jozemberi@foi.hr" target="_BLANK">e-mail</a></li>
						</ul>
					</li>
				</ul> 
				
				{if isset ($smarty.session.username)}
					<span style='float:right;'>
						<a href="jozemberi_uredi_podatke.php"> <img class='profilna_slika_small' src="thumbs/{$smarty.session.profilna_slika}"/> </a>
						<a href="jozemberi_uredi_podatke.php">{$smarty.session.username}</a>
						<a href='jozemberi_login.php?logout="da"'>Logout</a>
					</span>
				{else}
					<span style='float:right;'>
						<a href='jozemberi_login.php'>Prijava</a>
						<a href='jozemberi_registracija.php'>Registracija</a>		
					</span>
				{/if}	
			</div>
			
		</div>
		<div id='{$id_content}'> 