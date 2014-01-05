{include file='jozemberi_header.tpl' naslov_str=$naslov id_content=$div_id}
	<h1> {$naslov} </h1>
		<img style="z-index: 2" class= 'imgFixed' src='img/login_img.png' alt='login' hspace='20px'/>
					<form action='jozemberi_login.php' method='post' name='logiranje'>
						<table class='login'>
						{if isset($zaboravljena_lozinka) or isset($greskaZabLozinka)}
						
						<tr>
									<td colspan='2'> <span class='uputa'>Vaša lozinka će biti poslana na email </span></td>
						</tr>
						<tr>
								<td> <label for='zabLozinka'>E-mail: </label> </td>
								<td> <input size= '30px'{if isset($greskaZabLozinka)} class='greskaBorderRed' {/if} type='text' name='zabLozinka' id='zabLozinka'/> </td>
								
						</tr>
						<tr>
								<td colspan='2' id='greskaZabLozinka'> {if isset($greskaZabLozinka)} <span class='greskaR' >{$greskaZabLozinka} </span> {/if}</td>
						</tr>
						<tr>
									<td></td>
								<td align='center'> <input type='submit' id='posaljiZabLozinku' name='posaljiZabLozinku' value='Pošalji'/> </td>
						</tr>
						{/if}
						
						
						{if isset($greske.korRacun)}
							<tr>
								<td colspan='2'> {if isset($greske.korRacun)} <span class='greskaR' >{$greske.korRacun} </span> <br />{$greske.link} {/if}</td>
							</tr>
						{/if}
						
						{if !isset($greske.korRacun) and (!isset($zaboravljena_lozinka) and !isset($greskaZabLozinka))}
							{if isset($notLoggedIn)}
								<tr>
									<td colspan='2'> <span class='greskaR' >{$notLoggedIn} </span></td>
								</tr>
							{/if}
							{if isset($poslano)} <tr><td colspan='2' align='right'><span class='zeleno'> {$poslano}</span> </td> </tr>{/if}
							<tr>
								<td> <label for='korIme'> Korisničko ime: </label> </td>
								<td> <input {if isset($greske.korIme)} class='greskaBorderRed' {/if} type='text' name='korIme' id='korIme'
								value = "{ if isset($smarty.post.korIme)}{$smarty.post.korIme}{else}{$cookie_korisnik}{/if}"/> </td>
							</tr>
							
							<tr>
								<td colspan='2' id='korImeError'> {if isset($greske.korIme)} <span class='greskaR' >{$greske.korIme} </span> {/if}</td>
							</tr>
							
							<tr>
								<td> <label for='lozinka'> Lozinka: </label> </td>
								<td> <input {if isset($greske.lozinka)} class='greskaBorderRed' {/if} type='password' name='lozinka' id='lozinka'/> </td>
							</tr>
							
							<tr>
								<td colspan='2' id='lozinkaError'> {if isset($greske.lozinka)} <span class='greskaR' >{$greske.lozinka} </span> {/if}</td>
							</tr>
							
							<tr>
								<td> <a href="jozemberi_login.php?zaboravljena_lozinka=da" > <span class='uputa'>Zaboravljena lozinka? </span> </a> </td>
								<td> <input type='checkbox' name='cheBox' { if isset($smarty.post.ok, $smarty.post.cheBox) } checked {/if} 
								{if $cookie_korisnik != '' and !isset($smarty.post.ok)} checked {/if} id='cheBox'/> <label for='cheBox'> Zapamti me </label></td>
							</tr>
							
							<tr>
									<td> </td>
								<td align='center'> <input type='submit' id='login_submit' name='ok' value='Logiraj se'/> </td>
							</tr>
						{/if}	
						</table>
					</form>	
				{* OpenID *}
					<form action='jozemberi_login.php' method='post' name='logiranjeOpenID'>
						<table class='loginOpenID'>
							<tr> <td colspan='2'> <span class='uputa'> Ukoliko niste registrirani, možete se logirati i preko OpenID-a </span> </td> </tr>
							<tr>
								<td> <label for='openID'> Vaš OpenID URL: </label> </td>
								<td> <input size='40' {if isset($errorOID)} class='greskaBorderRed' {/if} 
								type='text' name='openID' id='openID'/> <input type='submit' name='okOpenID' value='Logiraj se'/> </td>
							</tr>
							<tr> <td colspan='2'>{if isset($errorOID)} <span class='greska'>{$errorOID} </span> {/if} </td> </tr>
						</table>
					</form>
	<img style="z-index: 1" class='login_buy' src='img/order.png' alt='login' hspace='20px'/>