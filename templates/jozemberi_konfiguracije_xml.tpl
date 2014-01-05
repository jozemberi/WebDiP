<?xml version="1.0" encoding="utf-8"?>
<konfiguracije>
			{section name=i loop=$konfiguracije}
				<konfiguracija
					naziv = "{$konfiguracije[i].naziv}"
					kreator = "{$konfiguracije[i].kreator}"
					marka = "{$konfiguracije[i].marka}"
					model = "{$konfiguracije[i].model}"
					motor = "{$konfiguracije[i].tip_motora}"
					tip = "{$konfiguracije[i].tip_automobila}" 
					god_proizvodnje = "{$konfiguracije[i].god_proizvodnje}" 
					god_modela = "{$konfiguracije[i].god_modela}"
					slika = "{$konfiguracije[i].slika}"
					dat_i_vrij_narudzbe = "{$konfiguracije[i].dat_i_vrij_narudzbe}"
					cijena = "{$konfiguracije[i].cijena}"
					kolicina = "{$konfiguracije[i].kolicina}"
					status_narudzbe = "{$konfiguracije[i].status}"
					id_narudzbe = "{$konfiguracije[i].id_narudzbe}"
					id_konfiguracije="{$konfiguracije[i].id_konfiguracije}"/>
			{/section}
			<pregled_vlastite vlastita = "{$vlastita}"/>
			<paginacija br_paginacija = "{$br_paginacija}"/>
</konfiguracije>