<?xml version="1.0" encoding="utf-8"?>
<popis_opreme>
			{section name=i loop=$oprema}
				<oprema
					id_opreme = "{$oprema[i].id_opreme}"
					naziv = "{$oprema[i].naziv}"
					proizvodac = "{$oprema[i].proizvodac}"
					opis = "{$oprema[i].opis}"
					cijena = "{$oprema[i].cijena}" 
					slika = "{$oprema[i].slika}"
					dostupno = "{$oprema[i].dostupno}"
					na_akciji = "{$oprema[i].na_akciji}"
					opcijaUredi = "{$oprema[i].opcijaUredi}"
					akcijska_cijena = "{$oprema[i].akcijska_cijena}"
					akcijaValjana = "{$oprema[i].akcijaValjana}"
					kategorija = "{$oprema[i].kategorija}"
					naziv_linije = "{$oprema[i].naziv_linije}"
					kolicina = "{$kolicina}"/>
			{/section}
			<paginacija br_paginacija = "{$br_paginacija}"/>
			<kategorija naziv = "oprema"/>
</popis_opreme>