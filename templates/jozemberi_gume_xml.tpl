<?xml version="1.0" encoding="utf-8"?>
<popis_guma>
			{section name=i loop=$gume}
				<guma
					id_gume = "{$gume[i].id_gume}"
					naziv = "{$gume[i].naziv}"
					sirina = "{$gume[i].sirina}"
					visina = "{$gume[i].visina}"
					promjer = "{$gume[i].promjer}"
					vrsta = "{$gume[i].vrsta}"
					tip = "{$gume[i].tip}" 
					cijena = "{$gume[i].cijena}" 
					slika = "{$gume[i].slika}"
					dostupno = "{$gume[i].dostupno}"
					na_akciji = "{$gume[i].na_akciji}"
					opcijaUredi = "{$gume[i].opcijaUredi}"
					akcijska_cijena = "{$gume[i].akcijska_cijena}"
					akcijaValjana = "{$gume[i].akcijaValjana}"
					kolicina = "{$kolicina}"/>
			{/section}
			<paginacija br_paginacija = "{$br_paginacija}"/>
			<kategorija naziv = "gume"/>
</popis_guma>