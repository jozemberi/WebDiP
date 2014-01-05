<?xml version="1.0" encoding="utf-8"?>
<modeli_automobila>
			{section name=i loop=$modeli_automobila}
				<osnovna_konfiguracija
					marka = "{$modeli_automobila[i].marka}"
					model = "{$modeli_automobila[i].model}"
					motor = "{$modeli_automobila[i].tip_motora}"
					tip = "{$modeli_automobila[i].tip_automobila}" 
					snaga = "{$modeli_automobila[i].snaga}"
					radni_obujam = "{$modeli_automobila[i].radni_obujam}"
					mjenjac = "{$modeli_automobila[i].mjenjac}"
					br_stupnjeva = "{$modeli_automobila[i].br_stupnjeva}"
					cijena = "{$modeli_automobila[i].cijena}"
					god_proizvodnje = "{$modeli_automobila[i].god_proizvodnje}" 
					god_modela = "{$modeli_automobila[i].god_modela}"
					slika = "{$modeli_automobila[i].slika}"
					dostupno = "{$modeli_automobila[i].dostupno}"
					na_akciji = "{$modeli_automobila[i].na_akciji}"
					akcijska_cijena = "{$modeli_automobila[i].akcijska_cijena}"
					akcijaValjana = "{$modeli_automobila[i].akcijaValjana}"
					opcijaUredi = "{$modeli_automobila[i].opcijaUredi}"
					id_osnovne_konfiguracije ="{$modeli_automobila[i].id_osnovne_konfiguracije}"/>
			{/section}
</modeli_automobila>