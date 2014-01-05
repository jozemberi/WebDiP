<?xml version="1.0" encoding="utf-8"?>
<podkomentari>
			{section name=i loop=$podkomentari}
				<podkomentar
					username_komentatora = "{$podkomentari[i].username_komentatora}"
					dat_i_vrij_komentara = "{$podkomentari[i].dat_i_vrij_komentara}"
					komentar_korisnika = "{$podkomentari[i].komentar}"
					avatar = "{$podkomentari[i].avatar}"
					id_komentara ="{$podkomentari[i].id_komentara}"/>
			{/section}
</podkomentari>