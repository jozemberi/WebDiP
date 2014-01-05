<?xml version="1.0" encoding="utf-8"?>
<ocjenjivaci>
			{section name=i loop=$ocjenjivaci}
				<ocjenjivac
					komentator = "{$ocjenjivaci[i].komentator}"
					ocjena = "{$ocjenjivaci[i].ocjena}"/>
			{/section}
</ocjenjivaci>