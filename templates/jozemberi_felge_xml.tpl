<?xml version="1.0" encoding="utf-8"?>
<popis_felgi>
			{section name=i loop=$felge}
				<felga
					id_felge = "{$felge[i].id_felge}"
					naziv = "{$felge[i].naziv}"
					promjer = "{$felge[i].promjer}"
					boja = "{$felge[i].boja}"
					cijena = "{$felge[i].cijena}" 
					slika = "{$felge[i].slika}"
					dostupno = "{$felge[i].dostupno}"
					na_akciji = "{$felge[i].na_akciji}"
					opcijaUredi = "{$felge[i].opcijaUredi}"
					akcijska_cijena = "{$felge[i].akcijska_cijena}"
					akcijaValjana = "{$felge[i].akcijaValjana}"
					kolicina = "{$kolicina}"/>
			{/section}
			<paginacija br_paginacija = "{$br_paginacija}"/>
			<kategorija naziv = "felge"/>
</popis_felgi>