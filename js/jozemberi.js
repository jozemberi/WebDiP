window.onload = function(){
	var inputi = document.getElementsByTagName('input');
	var selecti = document.getElementsByTagName('select');
	var elementi = new Array();
	var len1 = inputi.length;
	var len2 = selecti.length;

	for(var k = 0; k < len1; k++){
		elementi[k] = inputi.item(k);
	}
	
	for(var j=0; j < len2; k++, j++){
		elementi[k] = selecti.item(j); 
	}
	
	var i;	
	for(i=0; i<elementi.length; i++){
		if(elementi[i].type!='hidden' && elementi[i].type!='submit'){			
			elementi[i].addEventListener('focus', imaFokus);
			elementi[i].addEventListener('blur', nemaFokus);
			}
	}

	var red=document.querySelectorAll("tr[id=red]");
	for(i=0; i<red.length; i++){
		red[i].addEventListener('mouseover',promijeniBoju);
		red[i].addEventListener('mouseout',vratiStaruBoju);
	}
	
	var gumbi = document.querySelectorAll('input[type=submit]');
	echo(gumbi);
	var gumb;
	if (gumbi.length > 0) {
	
		gumb = document.querySelector('#login_submit');
		echo(gumb);
		if (gumb!=null) gumb.addEventListener('click', checkLoginForm, true);
	}
	
	if (gumb == null){
		gumb = document.querySelector('#registracija_submit');
		echo(gumb);
		if (gumb!=null){
			gumb.addEventListener('click', checkRegistrationForm, true);
			gumbP = document.querySelector('#provjeri_korisnicko_ime');
			
			gumbP.addEventListener('click', checkKorisnika, true);
			
		}
		
	}
	if (gumb == null){
		gumb = document.querySelector('#kreiraj_gume_submit');
		echo(gumb);
		if (gumb!=null) gumb.addEventListener('click', checkForm, true);
	}
	
	if (gumb == null){
		gumb = document.querySelector('#kreiraj_felge_submit');
		echo(gumb);
		if (gumb!=null) gumb.addEventListener('click', checkForm, true);
	}
	
	if (gumb == null){
		gumb = document.querySelector('#kreiraj_opremu_submit');
		echo(gumb);
		if (gumb!=null) gumb.addEventListener('click', checkForm, true);
	}
	
	if (gumb == null){
		gumb = document.querySelector('#kreiraj_model_submit');
		echo(gumb);
		if (gumb!=null) gumb.addEventListener('click', checkForm, true);
	}
	
	if (gumb == null){
		gumb = document.querySelector('#kreiraj_motor_submit');
		echo(gumb);
		if (gumb!=null) gumb.addEventListener('click', checkForm, true);
	}
	
	if (gumb == null){
		gumb = document.querySelector('#kreiraj_liniju_submit');
		echo(gumb);
		if (gumb!=null) gumb.addEventListener('click', checkForm, true);
	}
	
	if (gumb == null){
		gumb = document.querySelector('#kreiraj_akciju_submit');
		echo(gumb);
		if (gumb!=null) gumb.addEventListener('click', checkForm, true);
	}
	
	if (gumb == null){
		gumb = document.querySelector('#kreiraj_trgovinu_submit');
		echo(gumb);
		if (gumb!=null) gumb.addEventListener('click', checkForm, true);
	}
	
	
	
}

function imaFokus(event){
	event.currentTarget.setAttribute('class','fokus');
}

function nemaFokus(event){
	event.currentTarget.setAttribute('class','');
}

function promijeniBoju(event){
	event.currentTarget.style.backgroundColor='#ADD8E6';
}
function vratiStaruBoju(event){
	event.currentTarget.style.backgroundColor='';
//	event.currentTarget.style.border='';
}

function checkLoginForm(event) {
	echo(event);
	var element = document.getElementById('korIme');
	echo(element);
	if (element != null) {
		var formaLogin = element.form;
		if(provjeriLoginPodatke(formaLogin)) {
		}
		else event.preventDefault();
	}
}

function checkRegistrationForm(event){
	echo(event);
	var element = document.getElementById('korIme');
	echo(element);
	if (element != null) {
		var formaRegistration = element.form;
		if(provjeriRegistrationPodatke(formaRegistration)) {
			//formaRegistration.submit();
		}
		else event.preventDefault();
	}
}

function checkForm(event) {
	echo(event);
	var element = document.getElementById('naziv');
	echo(element);
	if (element != null) {
		var forma = element.form;
		if(provjeriFormu(forma)) {
			window.alert('Podaci su uspješno poslani.');
		}
		else event.preventDefault();
	}
}

function checkKorisnika(event) {
	echo(event);
	var element = document.getElementById('korIme');
	echo(element);
	event.preventDefault();
	if (element != null) {
		var errs = document.querySelectorAll("span.dobro");
		for(i = 0; i < errs.length; i++) {
			errs[i].parentNode.removeChild(errs[i]);
		}
		var errs = document.querySelectorAll("span.greskaKorIme");
		for(i = 0; i < errs.length; i++) {
			errs[i].parentNode.removeChild(errs[i]);
		}
		odgFunkcije = provjeraKorisnika(element);
		element.focus();
			
	}
			
		//provjeraKorisnika(element);
		//var forma = element.form;
		//if(provjeriFormu(forma)) {
		//	window.alert('Podaci su uspješno poslani.');
		//}
	//}
}

function provjeriFormu(forma) {
	var isOk = true;
	var errs = document.querySelectorAll("span.greska");
	for(i = 0; i < errs.length; i++) {
		errs[i].parentNode.removeChild(errs[i]);
	}
	
	var prviKriv = false;    
	
	for(i = 0; i < forma.elements.length; i++) {
		echo(forma.elements[i]);
		var el = forma.elements[i];
		el.className = '';
		if (el.value == '' && (el.type != 'checkbox') && el.id != 'slikaUpdate') {
			if(prviKriv == false){
				prviKriv = true;
				el.focus();
			}
			isOk = false;
			el.className = 'greskaBorderRed';
			var errMsg = document.createElement('span');
			errMsg.innerHTML='<br />Ovo je obavezno polje!';
			errMsg.className='greska';
			el.parentNode.appendChild(errMsg);
		}
		if((el.name == 'vrsta_gume' || el.name=='tip_gume' || el.name=='kategorija' || el.name=='motor' || el.name=='tip' || el.name=='satPoc' || el.name=='danPoc' || el.name=='mjesecPoc' || el.name=='satZav' || el.name=='danZav' || el.name=='mjesecZav' || el.name=='drzava' || el.name=='voditelj' ||
			el.name=='marka' || el.name=='mjenjac') && el.value=='0'){
			if(prviKriv == false){
				prviKriv = true;
				el.focus();
			}
			isOk = false;
				el.className = 'greskaBorderRed';
				var errMsg = document.createElement('span');
			errMsg.innerHTML='<br />Ovo je obavezno polje!';
			errMsg.className='greska';
			el.parentNode.appendChild(errMsg);
		}
	}
	return isOk;
}



function provjeriLoginPodatke(forma) {
	var isOk = true;
	var errs = document.querySelectorAll("span.greskaR");
	for(i = 0; i < errs.length; i++) {
		errs[i].parentNode.removeChild(errs[i]);
	}
	
	var prviKriv = false;    
	
	for(i = 0; i < forma.elements.length; i++) {
		echo(forma.elements[i]);
		var el = forma.elements[i];
		el.className = '';
		if (el.value == '' && (el.type != 'checkbox')) {
			if(prviKriv == false){
				prviKriv = true;
				el.focus();
			}
			isOk = false;
			el.className = 'greskaBorderRed';
			var imeVar=el.name + 'Error';
			var naziv;
			if(el.name=='korIme') naziv='korisničko ime';
			else naziv='lozinku';
			errorMessage = "<span class='greskaR' > Molim unesite " + naziv + "</span>";
			document.getElementById(imeVar).innerHTML = errorMessage;
		}
	}
	return isOk;
}


function provjeriRegistrationPodatke(forma) {
	var isOk = true;
	var errs = document.querySelectorAll("span.greska");
	for(i = 0; i < errs.length; i++) {
		errs[i].parentNode.removeChild(errs[i]);
	}
	var errs = document.querySelectorAll("span.greskaKorIme");
		for(i = 0; i < errs.length; i++) {
			errs[i].parentNode.removeChild(errs[i]);
		}
	var errs = document.querySelectorAll("span.dobro");
		for(i = 0; i < errs.length; i++) {
			errs[i].parentNode.removeChild(errs[i]);
		}
	
	var prviKriv = false;
	var odgFunkcije = true;
	
	for(i = 0; i < forma.elements.length; i++) {
		echo(forma.elements[i]);
		var el = forma.elements[i];
		el.className = '';
		
		if (el.value == '' && (el.type!='checkbox') && el.id !='zupanija' && el.id !='grad' && el.id !='postanski_broj' && el.id !='ulica' && el.id !='kucni_broj' && el.id !='telefon') {
			el.className = 'greskaBorderRed';
			var errMsg = document.createElement('span');
			var naziv;
			if(el.name == 'korIme') naziv='korisničko ime';
			if(el.name == 'email') naziv='email';
			if(el.name == 'lozinka') naziv='lozinku';
			if(el.name == 'potLozinke') naziv='potvrdu lozinke';
			if(el.name == 'ime') naziv='ime';
			if(el.name == 'prezime') naziv='prezime';
			if(el.name == 'avatar') naziv='avatar';
			if(el.name == 'godina') naziv='datum rođenja';
			
			if(el.name=='avatar') errMsg.innerHTML='<br />Niste odabrali ' + naziv;
			else errMsg.innerHTML='<br />Niste unijeli ' + naziv;
			if(el.name == 'korIme') errMsg.className='greskaKorIme';
			else errMsg.className='greska';
			el.parentNode.appendChild(errMsg);
			if(prviKriv == false){
				prviKriv = true;
				el.focus();
			}
			isOk = false;
		}
		
		else if (el.name == 'korIme'){
			odgFunkcije = provjeraKorisnika(el);
			if(odgFunkcije==false) isOk=false;
			
			if(prviKriv == false && odgFunkcije==false){
				prviKriv = true;
				el.focus();
			}
		}	
		
		else if (el.name == 'email'){
			odgFunkcije = provjeraEmaila(el);
			if(odgFunkcije==false) isOk=false;
			if(prviKriv == false && odgFunkcije==false){
				prviKriv = true;
				el.focus();
			}
		}
		
		else if (el.name == 'lozinka'){
			odgFunkcije = provjeraLozinke(el);
			if(odgFunkcije==false)isOk=false;
			if(prviKriv == false && odgFunkcije==false){
				prviKriv = true;
				el.focus();
			}
		}

		else if (el.name == 'potLozinke'){
			odgFunkcije = provjeraPotvrdeLozinke(el);
			if(odgFunkcije==false)isOk=false;
			if(prviKriv == false && odgFunkcije==false){
				prviKriv = true;
				el.focus();
			}
		}
		
		else if (el.name == 'ime'){
			odgFunkcije = provjeraImena(el);
			if(odgFunkcije==false)isOk=false;
			if(prviKriv == false && odgFunkcije==false){
				prviKriv = true;
				el.focus();
			}
		}
		
		else if (el.name == 'prezime'){
			odgFunkcije = provjeraPrezimena(el);
			if(odgFunkcije==false)isOk=false;
			if(prviKriv == false && odgFunkcije==false){
				prviKriv = true;
				el.focus();
			}
		}
	}
	checkbox = document.getElementById('priUvKor');
	if(checkbox.checked==false){
		checkbox.className = 'greskaBorderRed';
		var errMsg = document.createElement('span');
		errMsg.innerHTML='Niste prihvatili uvjete korištenja';
		errMsg.className='greska';
		checkbox.parentNode.appendChild(errMsg);
		isOk=false;
	}
	
	return isOk;
}


function xmlhttpPost(strURL) {
    var xmlHttpReq = false;
    var self = this;
    // Mozilla/Safari
    if (window.XMLHttpRequest) {
        self.xmlHttpReq = new XMLHttpRequest();
    }
    // IE
    else if (window.ActiveXObject) {
        self.xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
    }
	
    self.xmlHttpReq.open('POST', strURL, true);
    self.xmlHttpReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    self.xmlHttpReq.onreadystatechange = function() {
        if (self.xmlHttpReq.readyState == 4) {
			if(self.xmlHttpReq.status == 200){
				var xml = self.xmlHttpReq.responseXML;
				var postoji = xml.getElementsByTagName('postoji')[0].firstChild.nodeValue;
				if(postoji == '1') {
					korIme=document.getElementById('korIme');
					korIme.className = 'greskaBorderRed';
					var errMsg = document.createElement('span');
					errMsg.innerHTML='<br />Korisničko ime je zauzeto';
					errMsg.className='greskaKorIme';
					korIme.parentNode.appendChild(errMsg);
				}
				else{
					korIme=document.getElementById('korIme');
					korIme.className = '';
					var errMsg = document.createElement('span');
					errMsg.innerHTML='<br />Korisničko ime je slobodno';
					errMsg.className='dobro';
					korIme.parentNode.appendChild(errMsg);
				
				
				
				}
			}
		}
	}
	
    self.xmlHttpReq.send(null);
}

function provjeraKorisnika(el){
	korIme=el;

	if (korIme.value.length < 6) {
		korIme.className = 'greskaBorderRed';
		var errMsg = document.createElement('span');
		errMsg.innerHTML='<br />Korisničko ime ima manje od 6 znakova'; 
		errMsg.className='greskaKorIme';
		korIme.parentNode.appendChild(errMsg);
		return false;
	}
	
	else xmlhttpPost('_jozemberi_provjera_korisnika.php?kor=' + korIme.value);
	return true;
}

function provjeraPotvrdeLozinke(el){
	lozinka = document.getElementById('lozinka');
	potvrdaLozinke=el;
	
	if (lozinka.value != "" && potvrdaLozinke.value != "" && lozinka.value != potvrdaLozinke.value) {
		potvrdaLozinke.className = 'greskaBorderRed';
		var errMsg = document.createElement('span');
		errMsg.innerHTML='<br />Potvrda lozinke nije točna '; 
		errMsg.className='greska';
		potvrdaLozinke.parentNode.appendChild(errMsg);
		return false;
	}
	
	else return true;

}

function provjeraLozinke(el){
	lozinka = el;
	if (lozinka.value.length < 6) {
		lozinka.className = 'greskaBorderRed';
		var errMsg = document.createElement('span');
		errMsg.innerHTML='<br />Lozinka ima manje od 6 znakova'; 
		errMsg.className='greska';
		lozinka.parentNode.appendChild(errMsg);
		return false;
	}
	
	else if (!lozinka.value.match(/[0-9]/)) {
		lozinka.className = 'greskaBorderRed';
		var errMsg = document.createElement('span');
		errMsg.innerHTML='<br />Lozinka mora sadržavati barem jedan broj'; 
		errMsg.className='greska';
		lozinka.parentNode.appendChild(errMsg);
		return false;
	}

	else if (!lozinka.value.match(/[A-Z]/)) {
		lozinka.className = 'greskaBorderRed';
		var errMsg = document.createElement('span');
		errMsg.innerHTML='<br />Lozinka mora sadržavati barem jedno veliko slovo'; 
		errMsg.className='greska';
		lozinka.parentNode.appendChild(errMsg);
		return false;
	}
	
	else if (!lozinka.value.match(/[a-z]/)) {
		lozinka.className = 'greskaBorderRed';
		var errMsg = document.createElement('span');
		errMsg.innerHTML='<br />Lozinka mora sadržavati barem jedno malo slovo'; 
		errMsg.className='greska';
		lozinka.parentNode.appendChild(errMsg);
		return false;
	}
	
	else if (!lozinka.value.match (/\W/)){  
		lozinka.className = 'greskaBorderRed';
		var errMsg = document.createElement('span');
		errMsg.innerHTML='<br />Lozinka mora sadržavati barem jedan poseban znak (#, !, . i sl.)';
		errMsg.className='greska';
		lozinka.parentNode.appendChild(errMsg);
		return false;
	}
	
	else return true;
}

function provjeraImena(el){
	ime = el; 
	if (!ime.value.match(/^[A-ZŽĆČŠĐ]/)) {
		ime.className = 'greskaBorderRed';
		var errMsg = document.createElement('span');
		errMsg.innerHTML='<br />Ime mora početi s velikim slovom'; 
		errMsg.className='greska';
		ime.parentNode.appendChild(errMsg);
		return false;
	}
	
	else if (!ime.value.match(/[a-zžćčšđ]/)) {
		ime.className = 'greskaBorderRed';
		var errMsg = document.createElement('span');
		errMsg.innerHTML='<br />Ime mora sadržavati mala slova'; 
		errMsg.className='greska';
		ime.parentNode.appendChild(errMsg);
		return false;
	}
	
	else if (!ime.value.match(/^[A-ZŽĆČŠĐ][a-zžćčšđ]+$/)) {
		ime.className = 'greskaBorderRed';
		var errMsg = document.createElement('span');
		errMsg.innerHTML='<br />Ime mora sadržavati samo slova'; 
		errMsg.className='greska';
		ime.parentNode.appendChild(errMsg);
		return false;
	}
	
    else return true;
}

function provjeraPrezimena(el){
	prezime = el; 
	if (!prezime.value.match(/^[A-ZŽĆČŠĐ]/)) {
		prezime.className = 'greskaBorderRed';
		var errMsg = document.createElement('span');
		errMsg.innerHTML='<br />Prezime mora početi s velikim slovom'; 
		errMsg.className='greska';
		prezime.parentNode.appendChild(errMsg);
		return false;
	}
	
	else if (!prezime.value.match(/[a-zžćčšđ]/)) {
		prezime.className = 'greskaBorderRed';
		var errMsg = document.createElement('span');
		errMsg.innerHTML='<br />Prezime mora sadržavati mala slova'; 
		errMsg.className='greska';
		prezime.parentNode.appendChild(errMsg);
		return false;
	}
	
	else if (!prezime.value.match(/^[A-ZŽĆČŠĐ][a-zžćčšđ]+$/)) {
		prezime.className = 'greskaBorderRed';
		var errMsg = document.createElement('span');
		errMsg.innerHTML='<br />Prezime mora sadržavati samo slova'; 
		errMsg.className='greska';
		prezime.parentNode.appendChild(errMsg);
		return false;
	}
	
    else return true;
}

function provjeraEmaila(el){
	email = el; 
	if (!email.value.match(/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)) {
		email.className = 'greskaBorderRed';
		var errMsg = document.createElement('span');
		errMsg.innerHTML='<br />Neispravna email adresa'; 
		errMsg.className='greska';
		email.parentNode.appendChild(errMsg);
		return false;	
		}
		
	else return true;
}

function echo(objekt) {
	console.log(objekt);
}

