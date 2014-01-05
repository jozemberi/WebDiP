{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}

	<h1> {$naslov} </h1>
	<br />
		{* Dijagrami su dostupni na sljedećim linkovima:
			<ul>
				<li>
					<a href='jozemberi_era_model.php'>ERA model</a> koji predstavlja potrebnu strukturu tablica za izradu projektnog rješenja 
				</li>
				<li>
					<a href='jozemberi_use_case_dijagrami.php'>Use case dijagrami</a> za interakciju svakog tipa korisnika sa sustavom
				</li>
				<li>
					<a href='jozemberi_dijagrami_sekvence.php'>Dijagrami sekvence</a> za cijeli sustav
				</li>
				<li>
					<a href='jozemberi_navigacijski_dijagrami.php'>Navigacijski dijagrami</a> koji predstavljaju funkcionalnost sustava
				</li>
			</ul>
			
			
			<img class='imgFixed' src='img/thumbs_up.png' hspace='240px' alt='thumbs_up'/>
			*}
{literal}
		<script>
	$(function() {
		$( "#tabs" ).tabs();
		
	});
	</script>

{/literal}

<div class="demo">

<div id="tabs">
	<ul>
		<li><a href="#tabs-1">Opis projektnog zadatka</a></li>
		<li><a href="#tabs-2">Komentar projektnog rješenja</a></li>
		<li><a href="#tabs-3">Korištene tehnologije</a></li>
	</ul>
	<div id="tabs-1">
		<p>Sustav za konfiguraciju pri kupnji automobila. <br /> <br />
		Sustav omogućuje odabir željene opreme automobila te izračun cijene ovisno o odabranoj konfiguraciji. Sustav ima sljedeće korisnike: <br /><br />
		• <b>neregistrirani korisnik</b> je korisnik koji nema korisnički račun na sustavu. Članom sustava može postati u
		slučaju registracije na sustav, bilo putem OpenID računa (Google, Facebook i drugi sustavi koji podržavaju OID) ili
		putem ugrađenog sustava za registraciju korisnika. Korisnik se smatra registriranim tek nakon aktivacije računa putem
		aktivacijske poruke elektroničke pošte (link za aktivaciju vrijedi 24 sati). Neregistrirani korisnik ima mogućnost uvida u
		modele automobila i moguću dodatnu opremu sa cijenama te pregled galerije različitih modela automobila. <br /> <br />
		• <b>registrirani korisnik</b> je korisnik koji ima kreiran i aktiviran korisnički račun. U slučaju tri neuspješne prijave na
		sustav (za redom), korisniku se zaključava pristup sustavu; u tom slučaju se aktiviranje korisničkog računa obavlja od
		strane administratora sustava. U slučaju uspješne prijave na sustav, kreira se korisnička sesija koja traje ili do isteka
		vremena podešenog od strane servera ili do odjave korisnika sa sustava. <br />
		Registrirani korisnik ima sva prava kao i neregistrirani korisnik plus mogućnost kreiranja, spremanja i pregledavanja
		svojih željenih konfiguracija automobila – odabir željenog motora, snage, boje te dodatne opreme prema želji.
		Odabrane stavke se spremaju u košaricu i korisnik može pregledavati sadržaj košarice, vidjeti iznos po stavkama,
		ukupni iznos te brisati suvišne elemente, nakon potvrde narudžba se prosljeđuje. Korisnik također može objaviti neke
		svoje konfiguracije kao javne koje onda drugi korisnici vide u njegovom profilu te ih mogu ocjenjivati i komentirati.
		Korisnik se može pretplatiti na e-mail vijesti o novim tipovima automobila ili posebnim akcijama i pogodnostima. <br /><br />
		• <b>Voditelj trgovine</b> ima sve ovlasti kao i registrirani korisnik uz mogućnost kreiranja tipova automobila, motora,
		dodatne opreme, nekih predefiniranih linija koje imaju određenu dodatnu opremu (comfort, sport i sl.) te određivanja
		cijena svih elemenata uz dodavanje slika za pojedini dio i gotovu konfiguraciju. Voditelj trgovine može pregledavati sve
		naručene modele te im mijenjati status – npr potvrđeno, u proizvodnji, na putu i sl. Korisnicima se šalju e-mail poruke
		sa promjenama statusa njihovih narudžbi. Voditelj također može kreirati posebne vremenski ograničene akcije na
		određene modele ili dijelove opreme (npr. besplatne zimske gume). <br /><br />
		• <b>Administrator sustava </b>ima sva prava kao i voditelj trgovine uz ovlasti upravljanja korisničkim podacima
		svakog korisnika, uvida u statistiku rada sustava, uvid u statistiku pojedinog korisnika (sve prijave, status korisničkog
		računa), blokiranja korisničkih računa u slučaju povrede pravila korištenja (pritužba drugih korisnika, vulgarni
		komentari i tome slično), zamrzavanje korištenja računa na određeno vrijeme (X sati, X dana,...), deaktiviranje
		korisničkih računa u slučaju treće opomene, kreiranje trgovina, postavljanje voditelja. Osim toga, on ima mogućnost
		upravljanja "sustavskim vremenom" radi simuliranja protoka vremena na projektnoj aplikaciji.
		</p>
	</div>
	<div id="tabs-2">
		<p>U izradi ovog web mjesta su kao pomoć korišteni materijali sa predavanja i laboratorijskih vježbi iz kolegija Web dizajn i programiranje (Fakultet organizacije i informatike, Varaždin) te različiti materijali dostupni na Internetu (konkretne biblioteke i skripte navedene su pod "Korištene tehnologije"). <br /> <br /><br />
		
		
		<b>Opis projektnog rješenja/završenost projekta</b> <br /><br />
		
		Što se tiče samog rješenja projektnog zadatka i njegove usklađenosti sa planiranim, prvotno zamišljena i u dokumentaciji prikazana funkcionalnost slanja privatnih poruka na kraju nije implementirana. Razlog tome je kombinacija nedostatka vremena i nepotrebnosti same funkcionalnosti (u specifikaciji projekta se ne traži ta funkcionalnost, korisnici mogu komunicirati preko komentara). <br />
		Iako su funkcionalnosti navedene u specifikaciji projektnog zadatka (koja je dostupna pod "Opis projektnog zadatka") implementirane, sama funkcionalnost i pristupačnost web mjesta prema korisniku bi se mogla dodatno poboljšati (npr. implementacijom opcije pretraživanja modela automobila po marki automobila, godini proizvodnje, cijeni i sl.). <br />
		Većinu tablica iz baze podataka je moguće popunjavati i mijenjati preko formi koje su dostupne unutar samog web mjesta. Većinom se radi o tablicama koje su izravno povezane sa samim funkcionalnostima web mjesta dok se neke pomoćne tablice (npr. tip_korisnika, status_korisnika, boje, marka automobila i sl.) ne mogu mijenjati od strane korisnika iz razloga što se radi o tablicama koje uglavnom sadržavaju konačan skup zapisa (redaka).
		Funkcionalnost njihovog mijenjanja od strane korisnika (najlogičnije administratora sustava) ne bi bila na odmet no, kad zatreba, administrator bi to mogao učiniti i na vrlo jednostavniji način preko phpMyAdmin-a. Sama košarica bi se također mogla poboljšati, moglo bi se staviti da se vidi da li je proizvod na akciji i da li je dostupan (trenutno se mogu odabrati samo proizvodi koji su dostupni te nije vidljivo da li su na akciji). Što se tiče pregleda modela automobila i opreme mogućnost pregleda elementa u originalnoj veličini (klikom na umanjenu sliku) je dostupno kod pregleda modela automobila i pregleda guma dok kod pregleda dodatne opreme i felgi ta opcija trenutno nije implementirana. 
		<br /> <br/><br />
		
		
		<b>Uočeni problemi u radu aplikacije</b> <br /><br />
		
		Iako je većina uočenih problema u radu s aplikacijom ispravljena, još uvijek postoji nekoliko problema na koje treba obratiti pažnju prilikom rada s aplikacijom. Radi se o problemima koji najčešće nastaju nepažnjom korisnika te uglavnom nemaju direktan utjecaj na normalan rad aplikacije. Da se radi o komercijalnoj aplikaciji pronalazak i ispravljanje svih tih problema bi bilo nužno i na kraju krajeva isplativo. Kako se ne radi o komercijalnoj aplikaciji, već o projektu za koji je vremenski rok za predaju i obranu jasno definiran, uočeni problemi koji nisu ispravljeni su: <br />
		- nedostatak provjere, odnosno kontrole, što je korisnik unio (da li zadovoljava domenu atributa u bazi podataka) na nekoliko formi, <br />
		- prilikom ažuriranja podataka korisnika koji je prijavljen sa svojim OpenID korisničkim računom dolazi do pogreške (kod promjene slike jer je username link (OpenID url)), <br /> 
		- uklanjanje artikla iz košarice uklanja taj artikl u potpunosti (npr. ne može se ukloniti 1 komad, a 1 ostaviti).
		
		</p>
	</div>
	<div id="tabs-3">
		<p>Korištene tehnologije: HTML | CSS | PHP | smarty | javascript | ajax <br /> <br />
		<b>Vanjski izvori</b> <br/>
		Biblioteke: <br />
		- <a href='http://jquery.com/' target="_blank">jQuery </a><br />
		- <a href='http://jqueryui.com/' target="_blank">jQueryUI </a> <br /> 
		- <a href='http://mootools.net/' target="_blank">MooTools</a> <br /> <br />
		
		Skripte/tutorijali/plugin-ovi: <br />
		 - <a href='http://davidwalsh.name/mootools-slideshow' target="_blank">David Walsh - Mootools slideshow</a> -> za galeriju modela automobila<br />
		- <a href='http://www.qualitycodes.com/tutorial.php?articleid=25&title=Tutorial-Building-a-shopping-cart-in-PHP' target="_blank" >Richard Clark - Building a shopping cart in PHP</a> -> ideja za implementaciju košarice<br />
		- <a href='http://www.jqueryload.com/jquery-dropdown-menu-with-google-style' target="_blank"> Lucas F. - jQuery Dropdown menu</a> -> korišteno za izradu izbornika <br />
		- <a href='http://www.no-margin-for-errors.com/projects/prettyphoto-jquery-lightbox-clone/' target="_blank">Stephane Caron - prettyPhoto</a> za galerije prilikom pregleda modela automobila, guma itd.<br />
		- <a href='http://www.komodomedia.com/blog/2007/01/css-star-rating-redux/' target="_blank"> Komodo Media - CSS Star Rating Redux</a> -> ideja za implementaciju ocjenjivanja konfiguracija<br />
		- <a href='http://www.9lessons.info/2010/10/pagination-with-jquery-php-ajax-and.html' target="_blank"> Ravi Tamada - Pagination with Jquery, PHP , Ajax and MySQL</a> -> algoritam i css korišten kod implementacije straničenja<br />
		- <a href='http://tutorialzine.com/2010/06/simple-ajax-commenting-system/' target="_blank">Martin Angelov - Simple AJAX Commenting System</a> -> ideja za implementaciju sustava za komentiranje<br />
		- <a href='http://jqueryui.com/demos/tabs/' target="_blank"> jQueryUI - tabs</a> -> korišteno za implementaciju tabova kod detaljnijeg pregleda dokumentacije<br />
		- <a href='http://gitorious.org/lightopenid' target="_blank"> LightOpenID </a> -> korišteno za implementaciju OpenID-a<br />
		- <a href='http://www.white-hat-web-design.co.uk/blog/resizing-images-with-php/' target="_blank"> Simon Jarvis - SimpleImage </a> -> za mijenjanje veličine slike, php<br />
		- <a href='http://www.google.com/recaptcha' target="_blank"> reCaptcha </a> -> za reCaptcha validaciju<br />
		- <a href='http://www.mathias-bank.de/2007/04/21/jquery-plugin-geturlparam-version-2/' target="_blank"> Mathias Bank - getUrlParam </a> -> jQuery plugin, dohvaća parametre iz URL-a<br />
		
		</p>
		
	</div>
</div>

</div>

