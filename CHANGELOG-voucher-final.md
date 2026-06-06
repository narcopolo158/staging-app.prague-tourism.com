# PTI — UI/UX dodávka #7: Voucher PDF „po" (ostrá integrace do voucher.php)

Reálná integrace do vašeho `code/voucher.php` (tFPDF + phpqrcode). Dotaženo z handoff balíku.
**Beze změny dat, datového toku, čísla voucheru, PIN-flow.** Výstup zůstává **validní 1× A4 PDF**.
Prodejce nevidí marži/bonus (nezměněno). Diff: 105 řádků, **samé přídavky** (žádný řádek logiky odebrán).

## Soubor v dodávce
- `voucher.php` — jediný měněný soubor (overlay). **Žádné nové fonty se nepřikládají** — `DejaVuSerif`
  TTF už jsou ve vašem `app/lib/font/unifont/`; metriky si tFPDF vygeneruje při prvním renderu
  (jako u ostatních DejaVu). Stačí nahradit `voucher.php`.

## Co přibylo (vše ověřeno reálným renderem na vašem tFPDF + DejaVu + phpqrcode)
Do třídy `PtiPDF` doplněny primitivy (vedle vašich `RoundedRect`/`_AArc`):
`Circle/Ellipse`, `PerfLine`, `Guilloche`, `MicrotextFrame`, `Icon{Calendar,Users,Clock,Globe}`,
`Code128` a `SetAlpha` (ExtGState — skutečná průhlednost; PDF se proto hlásí jako 1.4).

Kreslicí tok (přídavky, dle priorit §5 zadání — **bez zásahu do stávajícího layoutu/dat**):
1. **Horní „pass stub" — perforace + zlatá foil linka** místo prosté dělící čáry pod hlavičkou.
   Horní pás (logo · PAID · číslo voucheru · QR · nově Code128) tím čte jako **odtrhávací útržek**
   s tím nejdůležitějším k check-inu. (priorita #1)
2. **Značkový serif** (`DejaVuSerif Bold`) na hero název produktu + **zlaté foil akcenty**. (priorita #2)
3. **Ochranné flourishe:** jemné **guilloché** razítko v hero kartě, vlasový **mikrotext rámeček**
   po obvodu (obsahuje i číslo voucheru), velký **ghost monogram „PTI"** přes `SetAlpha` za obsahem. (priorita #3)
4. **Code 128** čísla voucheru v horním pásu + **vektorové ikony** dlaždic (kalendář/lidé/hodiny/glóbus). (priorita #4)

Vše jsou buď **fixní overlay** (mikrotext, monogram, foil/perforace, barcode) nebo **in-place**
(serif název, ikony v dlaždicích, guilloché v hero) — proto **nezasahují do dynamického toku** (GetY)
a **drží se 1 strana** i u dlouhého obsahu.

## Ověřeno
- `php -l voucher.php` — bez chyb.
- Render přes přiložené tFPDF + phpqrcode + DejaVu (harness s mock daty): **1 strana A4** (`pdfinfo`).
- **Skenovatelnost:** `zbarimg` dekóduje **Code128 → `PTI-2026-000001`** i oba QR (check-in / mapa).
- **Robustnost na reálných scénářích** (pravidlo §6): vyrenderováno i pro **Big Bus** (nástupní blok
  se 2 QR) a **zálohu** (DEPOSIT PAID, PAID 500 / TO PAY 800) — **stále 1 strana**, bez kolizí.
- Diakritika CZ/EN/DE OK (DejaVu). Serif (DejaVuSerif) pokrývá háčky — ověřeno.

Ukázky: `sample-voucher-PO-nahled.png` (+ `sample-voucher-PO.pdf`), bonus `sample-voucher-PO-bigbus.pdf`,
pro porovnání `sample-voucher-PRED-nahled.png`.

## Poznámky / drobnosti
- **Fraunces:** zadání ho zmiňuje jako volitelný (priorita #2). V balíku nebyl, použil jsem
  **DejaVuSerif** (garantovaná CZ/EN/DE diakritika, bez rabbit-hole). Až dodáte statické TTF
  Fraunces (s diakritikou), je to záměna 1:1 ve `AddFont(...)` + změna `'Serif'` → `'Fraunces'`.
- **QR** zůstávají vaše (phpqrcode → `Image`), logo `pti-masthead.png` beze změny (v mém harnessu
  chybí jen proto, že asset nebyl v balíku — ve vašem nasazení se vykreslí).
- **Ticket „notches"** (vykrojené půlkruhy do hran) jsem záměrně nepoužil: vyžadovaly by barevné
  pozadí stránky pro kontrast, což by změnilo bílý ráz voucheru. Perforace + foil linka dávají
  „stub" dojem na bílé čistě.
- **Heads-up k fontům (netýká se mé změny):** přiložené `dejavu*.mtx.php` cache mají v sobě absolutní
  build cestu k TTF (`/home/claude/pti/code/...`). Když `originalsize` sedí, tFPDF neregeneruje a při
  embedování by tu cestu otevíral — na cizím stroji selže. Na vašem to evidentně funguje (cache vznikly
  u vás / složka je zapisovatelná). Jen ať to víte: na novém hostu nechte `unifont/` **zapisovatelnou**
  (tFPDF si cache přegeneruje) — týká se i nového `Serif`.
