<?xml version="1.0" encoding="utf-8"?>
<komentari>
			{section name=i loop=$komentari}
				<komentar
					username_komentatora = "{$komentari[i].username_komentatora}"
					dat_i_vrij_komentara = "{$komentari[i].dat_i_vrij_komentara}"
					komentar_korisnika = "{$komentari[i].komentar}"
					avatar = "{$komentari[i].avatar}"
					id_komentara ="{$komentari[i].id_komentara}"
					ima_podkomentare ="{$komentari[i].ima_podkomentare}"
					prijavljen = "{$komentari[i].prijavljen}"/>
			{/section}
			<paginacija br_paginacija = "{$br_paginacija}"/>
			<prijava prijavljen = "{$prijavljen}"/>
</komentari>