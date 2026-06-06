# PTI-162 — UX doladění success.php (akční lišta + stavová hláška)

Navazuje na overlay 162 (kolega vyzval „pošli UX/UI expertovi na doladění"). **Žádná změna prvků,
akcí, dat, tříd tlačítek ani markupu** — `success.php` se nedotýkám, takže CSP zůstává čisté.
Celé je to **CSS, scoped pod `.success-wrap` / `.success-actions`** (nic jiného neovlivní).

## Co se zlepšilo (jen vzhled/uspořádání)
1. **Logické seskupení lišty bez změny DOM:** doručovací akce (Otevřít voucher · WhatsApp ·
   Poslat e-mailem · Poslat agentuře) zůstávají vlevo, **navigace (Správa prodeje · Nový prodej)
   se odsadí doprava** (`.success-actions a[href^="/sales.php"]{margin-left:auto}`). Robustní
   i když se „Poslat agentuře" nezobrazí.
2. **„Nový prodej" = hlavní další krok** prodejce → decentní brand zvýraznění (zůstává odkaz/btn-s).
3. **Lišta v toku, vzdušná** (ne sticky), s mezerou mezi zalomenými řádky; drží uniformní velikosti z 162.
4. **E-mail pole těsněji k tlačítkům** — čte se jako „zadej → pošli".
5. **Stavová hláška jako čistý pill s ikonou** (`✓` u úspěchu, `!` v kolečku u chyby), scoped —
   `.inline-note` jinde (např. poznámka k doplatku) zůstává beze změny.

## Soubory
- `FIX-success-bar.css` — blok k vložení na **konec `app.css`** (s komentářem proč).
- `app-162.css` — vaše 162 `app.css` už s připnutým blokem (když nasazujete celý soubor).
- `preview-success-bar.html` — porovnání PŘED/PO (otevřít v Edge/Firefoxu; interní WebKit flex zkresluje).

## Pozn.
- `success.php`, `voucher.php`, `lang/*`, `Mailer.php` z balíku **needituju** — jsou v pořádku;
  tohle je čistě kosmetika lišty, kterou kolega označil k doladění.
- Barevnost tlačítek (WhatsApp zelená, brand červená, obrysová) ponechána dle 162; když budete
  chtít jinou hierarchii (např. „Otevřít voucher" jako jediný plný primár), je to scoped a snadno změním.
