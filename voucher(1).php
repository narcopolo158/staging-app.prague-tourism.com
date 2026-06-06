<?php
declare(strict_types=1);

/** Voucher PDF (§10) — "Modern Travel Pass". One A4 page, card-based layout,
 *  single sans family + mono for codes, restrained brand red, calm hierarchy,
 *  GetYourGuide-style meeting-point map. Renders sections that have data;
 *  ?demo=1 (seller only) fills placeholders. Bilingual (host + EN).
 *  Amounts: TOTAL / PAID (DEPOSIT) / TO PAY (REST). Static map via GOOGLE_MAPS_KEY.
 *  Pure-PHP (tFPDF + phpqrcode), no Composer. Seller never sees margin/bonus. */

define('PTI_BASE', __DIR__ . '/app');
require PTI_BASE . '/bootstrap.php';
Session::start();
if (!Auth::isStation() || Auth::expired()) { redirect("/"); }
$a = Auth::actor();

$sid = (int) ($_GET['sale'] ?? 0);
$DEMO = isset($_GET['demo']);
$sale = $sid ? (Database::all("SELECT * FROM sales WHERE id=? AND tenant_id=?", [$sid, (int) $a['tenant_id']])[0] ?? null) : null;
if (!$sale) { redirect('/'); }
$items   = Database::all("SELECT * FROM sale_items WHERE sale_id=? ORDER BY id", [$sid]);
$voucher = Database::all("SELECT * FROM vouchers WHERE sale_id=? ORDER BY id LIMIT 1", [$sid])[0] ?? null;
$cust    = $sale['customer_id'] ? (Database::all("SELECT name FROM customers WHERE id=?", [(int) $sale['customer_id']])[0] ?? null) : null;
$sellerName = (string)((Database::all("SELECT name FROM sellers WHERE id=?", [(int) $sale['seller_id']])[0]['name'] ?? ($DEMO ? 'Jan Novák' : '')));
$lang = $voucher['language'] ?? 'en';
$it = $items[0] ?? null;
$snap = $it ? (json_decode((string) $it['snapshot_json'], true) ?: []) : [];
$pinfo = ($it && $it['product_id']) ? (Database::all(
    "SELECT p.meeting_point_address,p.map_url,p.voucher_redemption_type,p.order_instructions,p.languages,
            p.duration_minutes,p.included,p.excluded,p.what_to_bring,p.important_info,p.cancellation_policy,p.meeting_point_note,
            ag.id AS agency_id, ag.name AS agency, ag.contact_phone, ag.contact_email, ag.order_instructions AS ag_oi
     FROM products p JOIN agencies ag ON ag.id=p.agency_id WHERE p.id=?", [(int) $it['product_id']])[0] ?? []) : [];
$pickup = $it ? (Database::all("SELECT address,pickup_time FROM pickups WHERE sale_item_id=? LIMIT 1", [(int) $it['id']])[0] ?? null) : null;

$pti_er = error_reporting(E_ALL & ~E_DEPRECATED & ~E_WARNING & ~E_NOTICE);
ob_start();
require PTI_BASE . '/lib/font/unifont/ttfonts.php';
if (!defined('FPDF_FONTPATH')) { define('FPDF_FONTPATH', PTI_BASE . '/lib/font/'); }
require PTI_BASE . '/lib/tfpdf.php';
require PTI_BASE . '/lib/phpqrcode/qrlib.php';

function vczk($n): string { return number_format((float) $n, 0, ',', "\u{00A0}") . "\u{00A0}Kč"; }
function veur($n): string { return $n === null ? '' : number_format((float) $n, 0, ',', "\u{00A0}") . "\u{00A0}€"; }
function fmt_dur($m): string { $m=(int)$m; if($m<=0) return ''; $h=intdiv($m,60); $mm=$m%60; if($h&&$mm) return $h.' h '.$mm.' min'; if($h) return $h.' h'; return $mm.' min'; }
function lines($t): array { $t=trim((string)$t); if($t==='') return []; return array_values(array_filter(array_map('trim', preg_split('/\r\n|\r|\n/', $t)), fn($x)=>$x!=='')); }
$lng = $lang;
function L2(string $h, string $en): string { global $lng; return ($lng !== 'en') ? $h . ' / ' . $en : $en; }

$seatLine = '';
if (!empty($snap['seating'])) { $sn0 = trim((string)($snap['seats_note'] ?? '')); $seatLine = L2('Sezení: ', 'Seating: ') . ($sn0 !== '' ? $sn0 : L2('volné sezení v rámci kategorie', 'free seating within your category')); }
$dt = ($it && $it['ticket_date']) ? date('d.m.Y', strtotime((string) $it['ticket_date'])) : ($DEMO ? '08.06.2026' : '—');
$tm = ($it && $it['ticket_time']) ? substr((string) $it['ticket_time'], 0, 5) : ($DEMO ? '19:00' : '');
$chips = []; foreach (($snap['chosen'] ?? []) as $c) { if (!empty($c['value'])) $chips[] = $c['value']; }
$pid0 = $it ? (int) $it['product_id'] : 0;
$PERSON_DIMS = ['passenger_type', 'audience', 'ticket_type'];
$dimTypeByLabel = [];
if ($pid0) {
    foreach (Database::all("SELECT label, type FROM pricing_dimensions WHERE product_id=?", [$pid0]) as $dd) {
        $dimTypeByLabel[(string) $dd['label']] = (string) $dd['type'];
    }
}
$isGenericUnit = fn(string $v): bool => (bool) preg_match('/^\s*(per\s*person|per\s*booking|per\s*group|per\s*pax|pp|osoba|osob)\s*$/i', $v);
$itemChosen = []; $choiceSet = [];
foreach ($items as $gx) {
    if ((int) $gx['product_id'] !== $pid0) { continue; }
    $gs = json_decode((string) $gx['snapshot_json'], true) ?: [];
    if (!empty($gs['is_addon'])) { continue; }
    $pers = [];
    foreach (($gs['chosen'] ?? []) as $c) {
        $val = (string) ($c['value'] ?? ''); if ($val === '') { continue; }
        $type = $dimTypeByLabel[(string) ($c['label'] ?? '')] ?? '';
        if (in_array($type, $PERSON_DIMS, true)) {
            if (!$isGenericUnit($val)) { $pers[] = $val; }   // skip generic "Per person"
        } else {
            $choiceSet[$val] = true;                          // variant / zone / seating / season → "Volba"
        }
    }
    $itemChosen[] = ['qty' => (int) $gx['qty'], 'pers' => $pers];
}
$addonParts = [];
foreach ($items as $axx) { if ((int) $axx['product_id'] !== $pid0) continue; $asn = json_decode((string) $axx['snapshot_json'], true) ?: []; if (empty($asn['is_addon'])) continue; $addonParts[] = (int) $axx['qty'] . '× ' . (string) ($asn['addon_label'] ?? 'Add-on'); }
$addonLine = $addonParts ? (L2('Doplňky: ', 'Add-ons: ') . implode(', ', $addonParts)) : '';
$gParts = [];
foreach ($itemChosen as $ic) {
    $gParts[] = $ic['qty'] . '× ' . ($ic['pers'] ? implode(' ', $ic['pers']) : L2('host', 'guest'));
}
$guests = $gParts ? implode('   ·   ', $gParts) : ($DEMO ? '1× Adult' : '');
$choiceVals = array_keys($choiceSet);
$choiceLine = $choiceVals ? (L2('Volba: ', 'Option: ') . implode(', ', $choiceVals)) : '';
$langsTxt = trim((string) ($pinfo['languages'] ?? '')); if ($langsTxt === '' && $DEMO) $langsTxt = 'EN · DE · CS';
if (!empty($snap['tour_lang_cs']) || !empty($snap['tour_lang_en'])) {
    $chosenLang = L2((string) ($snap['tour_lang_cs'] ?? ''), (string) ($snap['tour_lang_en'] ?? ''));
    if ($chosenLang !== '') { $langsTxt = $chosenLang; }
}
$redeem = !empty($pinfo['voucher_redemption_type']) ? ucfirst(str_replace('_', ' ', (string) $pinfo['voucher_redemption_type'])) : ($DEMO ? 'Direct entry' : '');

$V = [
  'cat'=>$DEMO&&!$snap?'Big Bus Tours':(string)($snap['category'] ?? ''),
  'operator'=>(string)($snap['agency'] ?? ($pinfo['agency'] ?? ($DEMO?'Prague Boats':''))),
  'name'=>(string)($snap['product_name'] ?? ($it?('#'.(int)$it['product_id']):($DEMO?'Crystal Dinner Cruise':''))),
  'name_en'=>(string)($snap['product_name_en'] ?? ($DEMO?'on the Vltava river':'')),
  'option'=>(count($itemChosen)>1 && $commonVals)?implode(', ',$commonVals):($chips?implode(', ',$chips):($DEMO?'Standard option':'')),
  'duration'=>(fmt_dur($pinfo['duration_minutes']??0)?:($DEMO?'3 h':'')), 'languages'=>$langsTxt,
  'group'=>$DEMO?L2('Dospělí i děti','Adults & children'):'',
  'validity'=>$DEMO?L2('Platí pro zvolený termín','Valid for the booked date'):'',
  'lead'=>(string)($cust['name'] ?? ($DEMO?'Dušan':'')),
  'date'=>$dt,'time'=>$tm,'guests'=>$guests,'redeem'=>$redeem,
  'meet_addr'=>(trim((string)($snap['meeting_address'] ?? '')) ?: trim((string)($pinfo['meeting_point_address'] ?? ($DEMO?'Rašínovo nábřeží 2, Praha 2 (molo Pravý břeh)':'')))),
  'meet_note'=>(!empty($snap['is_pickup'])
     ? ('Hotel pickup'.(trim((string)($snap['pickup_time']??''))!==''?' at '.trim((string)$snap['pickup_time']):L2(' — čas potvrdí agentura',' — time confirmed by the agency')).(trim((string)($pinfo['meeting_point_note']??''))!==''?'. '.trim((string)$pinfo['meeting_point_note']):''))
     : (trim((string)($pinfo['meeting_point_note'] ?? '')) ?: (string)($pinfo['order_instructions'] ?? ($pinfo['ag_oi'] ?? ($DEMO?L2('Dostavte se 15 minut před začátkem. Hledejte stojan PTI.','Arrive 15 minutes before start. Look for the PTI sign.'):''))))),
  'map_url'=>trim((string)($pinfo['map_url'] ?? '')),
  'pickup'=>$pickup,
  'included'=>(lines($pinfo['included']??'') ?: ($DEMO?['Entry / activation as booked','On-board audio guide','English-speaking staff']:[])),
  'excluded'=>(lines($pinfo['excluded']??'') ?: ($DEMO?['Gratuities','Hotel transfer','Food & drinks']:[])),
  'bring'=>(lines($pinfo['what_to_bring']??'') ?: ($DEMO?[L2('Tento voucher (tisk/mobil)','This voucher (print or phone)'),L2('Doklad totožnosti','Photo ID')]:[])),
  'info'=>(trim((string)($pinfo['important_info']??'')) ?: ($DEMO?L2('Děti vítány v doprovodu dospělého. Bezbariérový přístup na vyžádání. Smart-casual oblečení.','Children welcome with an adult. Step-free access on request. Smart-casual dress code.'):'')),
  'cancel'=>(trim((string)($pinfo['cancellation_policy']??'')) ?: ($DEMO?L2('Bezplatné storno do 24 h před začátkem; poté nevratné.','Free cancellation up to 24 h before start; non-refundable afterwards.'):'')),
  'pin'=>((string)($sale['pin'] ?? '') ?: ($DEMO?'4821':'')),
];

$isBigBus = ((int)($pinfo['agency_id'] ?? 0) === 1);
$bbBase = (isset($_SERVER['HTTP_HOST']) ? ((($_SERVER['HTTPS'] ?? '')!=='' ? 'https' : 'https').'://'.$_SERVER['HTTP_HOST']) : '');
$bbPdf  = $bbBase.'/assets/bigbus-prague-stops.pdf';
$bbStop = 'https://www.bigbustours.com/en/prague/find-a-bus-stop';

/* palette (per design review) */
$RED=[227,30,36]; $INK=[17,24,39]; $MUT=[107,114,128]; $SURF=[250,248,244]; $BORD=[231,226,216];
$WHITE=[255,255,255]; $OK=[17,138,78]; $OKBG=[224,242,231]; $WARNBG=[255,246,216]; $WARNLINE=[233,210,140];
$GOLD=[184,137,58]; $GOLDL=[214,176,120];   // brand gold (foil accents / icons / flourishes)

class PtiPDF extends tFPDF {
  function RoundedRect($x,$y,$w,$h,$r,$style='',$corners='1234'){
    $k=$this->k;$hp=$this->h;$op=($style=='F')?'f':(($style=='FD'||$style=='DF')?'B':'S');$M=4/3*(sqrt(2)-1);
    $this->_out(sprintf('%.2F %.2F m',($x+$r)*$k,($hp-$y)*$k));
    $xc=$x+$w-$r;$yc=$y;$this->_out(sprintf('%.2F %.2F l',$xc*$k,($hp-$yc)*$k));
    (strpos($corners,'2')===false)?$this->_out(sprintf('%.2F %.2F l',($x+$w)*$k,($hp-$y)*$k)):$this->_AArc($xc+$r*$M,$yc,$x+$w,$yc+$r-$r*$M,$x+$w,$yc+$r);
    $xc=$x+$w;$yc=$y+$h-$r;$this->_out(sprintf('%.2F %.2F l',$xc*$k,($hp-$yc)*$k));
    (strpos($corners,'3')===false)?$this->_out(sprintf('%.2F %.2F l',($x+$w)*$k,($hp-($y+$h))*$k)):$this->_AArc($x+$w,$yc+$r*$M,$xc-$r+$r*$M,$y+$h,$xc-$r,$y+$h);
    $xc=$x+$r;$yc=$y+$h;$this->_out(sprintf('%.2F %.2F l',$xc*$k,($hp-$yc)*$k));
    (strpos($corners,'4')===false)?$this->_out(sprintf('%.2F %.2F l',$x*$k,($hp-($y+$h))*$k)):$this->_AArc($xc-$r*$M,$y+$h,$x,$yc-$r+$r*$M,$x,$yc-$r);
    $xc=$x;$yc=$y+$r;$this->_out(sprintf('%.2F %.2F l',$x*$k,($hp-$yc)*$k));
    (strpos($corners,'1')===false)?($this->_out(sprintf('%.2F %.2F l',$x*$k,($hp-$y)*$k))&&$this->_out(sprintf('%.2F %.2F l',($x+$r)*$k,($hp-$y)*$k))):$this->_AArc($x,$yc-$r*$M,$xc+$r-$r*$M,$y,$xc+$r,$y);
    $this->_out($op);
  }
  function _AArc($x1,$y1,$x2,$y2,$x3,$y3){$h=$this->h;$this->_out(sprintf('%.2F %.2F %.2F %.2F %.2F %.2F c',$x1*$this->k,($h-$y1)*$this->k,$x2*$this->k,($h-$y2)*$this->k,$x3*$this->k,($h-$y3)*$this->k));}

  /* ---- doplněné primitivy (perforace, guilloché, mikrotext, ikony, Code128, SetAlpha) ---- */
  function Circle($x,$y,$r,$style=''){ $this->Ellipse($x,$y,$r,$r,$style); }
  function Ellipse($x,$y,$rx,$ry,$style=''){
    $op=($style=='F')?'f':(($style=='FD'||$style=='DF')?'B':'S'); $lx=4/3*(sqrt(2)-1)*$rx; $ly=4/3*(sqrt(2)-1)*$ry; $k=$this->k; $h=$this->h;
    $this->_out(sprintf('%.2F %.2F m %.2F %.2F %.2F %.2F %.2F %.2F c',($x+$rx)*$k,($h-$y)*$k,($x+$rx)*$k,($h-($y-$ly))*$k,($x+$lx)*$k,($h-($y-$ry))*$k,$x*$k,($h-($y-$ry))*$k));
    $this->_out(sprintf('%.2F %.2F %.2F %.2F %.2F %.2F c',($x-$lx)*$k,($h-($y-$ry))*$k,($x-$rx)*$k,($h-($y-$ly))*$k,($x-$rx)*$k,($h-$y)*$k));
    $this->_out(sprintf('%.2F %.2F %.2F %.2F %.2F %.2F c',($x-$rx)*$k,($h-($y+$ly))*$k,($x-$lx)*$k,($h-($y+$ry))*$k,$x*$k,($h-($y+$ry))*$k));
    $this->_out(sprintf('%.2F %.2F %.2F %.2F %.2F %.2F c',($x+$lx)*$k,($h-($y+$ry))*$k,($x+$rx)*$k,($h-($y+$ly))*$k,($x+$rx)*$k,($h-$y)*$k));
    $this->_out($op);
  }
  function PerfLine($x1,$x2,$y,$dash=1.3,$gap=1.3,$lw=0.3){ $this->SetLineWidth($lw); $x=$x1; while($x<$x2){ $xe=min($x+$dash,$x2); $this->Line($x,$y,$xe,$y); $x=$xe+$gap; } }
  function Guilloche($cx,$cy,$R,$rgb,$a=5,$b=4,$steps=240,$lw=0.1){ $this->SetDrawColor($rgb[0],$rgb[1],$rgb[2]); $this->SetLineWidth($lw); $px=null;$py=null;
    for($i=0;$i<=$steps;$i++){ $t=2*M_PI*$i/$steps; $rr=$R*(0.72+0.28*cos($b*$t)); $x=$cx+$rr*cos($a*$t); $y=$cy+$rr*sin($a*$t); if($px!==null)$this->Line($px,$py,$x,$y); $px=$x;$py=$y; } }
  function MicrotextFrame($x,$y,$w,$h,$text,$rgb,$size=3.0){ $this->SetFont('Mono','',$size); $this->SetTextColor($rgb[0],$rgb[1],$rgb[2]);
    $rep=str_repeat($text.'  ',220); $this->SetXY($x,$y-1.2); $this->Cell($w,3,substr($rep,0,(int)($w*1.6)),0,0,'L'); $this->SetXY($x,$y+$h-1.6); $this->Cell($w,3,substr($rep,0,(int)($w*1.6)),0,0,'L');
    $n=(int)($h/2.3); $ch=str_repeat('PRAGUE TOURIST INFO  ',40); for($i=0;$i<$n;$i++){ $c=$ch[$i % strlen($ch)]; $this->SetXY($x-0.4,$y+$i*2.3); $this->Cell(2,2.3,$c,0,0,'C'); $this->SetXY($x+$w-1.6,$y+$i*2.3); $this->Cell(2,2.3,$c,0,0,'C'); } }
  function IconCalendar($x,$y,$s,$c){ $this->SetDrawColor($c[0],$c[1],$c[2]);$this->SetLineWidth(0.3); $this->RoundedRect($x,$y+0.15*$s,$s,$s*0.85,0.4,'D'); $this->Line($x,$y+0.38*$s,$x+$s,$y+0.38*$s); $this->Line($x+0.28*$s,$y,$x+0.28*$s,$y+0.22*$s); $this->Line($x+0.72*$s,$y,$x+0.72*$s,$y+0.22*$s); }
  function IconUsers($x,$y,$s,$c){ $this->SetDrawColor($c[0],$c[1],$c[2]);$this->SetLineWidth(0.3); $this->Circle($x+0.32*$s,$y+0.3*$s,0.16*$s,'D'); $this->RoundedRect($x+0.12*$s,$y+0.5*$s,0.4*$s,0.45*$s,0.18*$s,'D'); $this->Circle($x+0.7*$s,$y+0.34*$s,0.13*$s,'D'); }
  function IconClock($x,$y,$s,$c){ $this->SetDrawColor($c[0],$c[1],$c[2]);$this->SetLineWidth(0.3); $this->Circle($x+0.5*$s,$y+0.5*$s,0.42*$s,'D'); $this->Line($x+0.5*$s,$y+0.5*$s,$x+0.5*$s,$y+0.24*$s); $this->Line($x+0.5*$s,$y+0.5*$s,$x+0.7*$s,$y+0.56*$s); }
  function IconGlobe($x,$y,$s,$c){ $this->SetDrawColor($c[0],$c[1],$c[2]);$this->SetLineWidth(0.3); $this->Circle($x+0.5*$s,$y+0.5*$s,0.42*$s,'D'); $this->Ellipse($x+0.5*$s,$y+0.5*$s,0.18*$s,0.42*$s,'D'); $this->Line($x+0.08*$s,$y+0.5*$s,$x+0.92*$s,$y+0.5*$s); }
  public $c128=['212222','222122','222221','121223','121322','131222','122213','122312','132212','221213','221312','231212','112232','122132','122231','113222','123122','123221','223211','221132','221231','213212','223112','312131','311222','321122','321221','312212','322112','322211','212123','212321','232121','111323','131123','131321','112313','132113','132311','211313','231113','231311','112133','112331','132131','113123','113321','133121','313121','211331','231131','213113','213311','213131','311123','311321','331121','312113','312311','332111','314111','221411','431111','111224','111422','121124','121421','141122','141221','112214','112412','122114','122411','142112','142211','241211','221114','413111','241112','134111','111242','121142','121241','114212','124112','124211','411212','421112','421211','212141','214121','412121','111143','111341','131141','114113','114311','411113','411311','113141','114131','311141','411131','211412','211214','211232','233111','200000'];
  function Code128($x,$y,$code,$w,$h){ $kB=' !"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~'.chr(127);
    $d=[]; for($i=0;$i<strlen($code);$i++){ $p=strpos($kB,$code[$i]); if($p===false)continue; $d[]=$p; } $sum=104; foreach($d as $k=>$v){ $sum+=$v*($k+1); } $d[]=$sum%103; $d[]=106; $d[]=107; array_unshift($d,104);
    $mods=0; foreach($d as $v){ $s=$this->c128[$v]; for($j=0;$j<6;$j++)$mods+=(int)$s[$j]; } $mw=$w/$mods; $cur=$x; $this->SetFillColor(0,0,0);
    foreach($d as $v){ $s=$this->c128[$v]; for($j=0;$j<6;$j++){ $bw=(int)$s[$j]*$mw; if($bw>0 && $j%2===0)$this->Rect($cur,$y,$bw,$h,'F'); $cur+=$bw; } } }
  public $extgstates=[];
  function SetAlpha($alpha,$bm='Normal'){ $gs=$this->AddExtGState(['ca'=>$alpha,'CA'=>$alpha,'BM'=>'/'.$bm]); $this->SetExtGState($gs); }
  function AddExtGState($p){ $n=count($this->extgstates)+1; $this->extgstates[$n]['parms']=$p; return $n; }
  function SetExtGState($gs){ $this->_out(sprintf('/GS%d gs',$gs)); }
  protected function _enddoc(){ if(!empty($this->extgstates) && $this->PDFVersion<'1.4') $this->PDFVersion='1.4'; parent::_enddoc(); }
  protected function _putextgstates(){ for($i=1;$i<=count($this->extgstates);$i++){ $this->_newobj(); $this->extgstates[$i]['n']=$this->n; $this->_put('<</Type /ExtGState'); $p=$this->extgstates[$i]['parms']; $this->_put(sprintf('/ca %.3F',$p['ca'])); $this->_put(sprintf('/CA %.3F',$p['CA'])); $this->_put('/BM '.$p['BM']); $this->_put('>>'); $this->_put('endobj'); } }
  protected function _putresources(){ $this->_putextgstates(); parent::_putresources(); }
  protected function _putresourcedict(){ parent::_putresourcedict(); $this->_put('/ExtGState <<'); foreach($this->extgstates as $k=>$g) $this->_put('/GS'.$k.' '.$g['n'].' 0 R'); $this->_put('>>'); }
}

$pdf = new PtiPDF('P','mm','A4'); $pdf->SetAutoPageBreak(false); $pdf->SetMargins(15,14,15);
foreach ([['Sans','','DejaVuSans.ttf'],['Sans','B','DejaVuSans-Bold.ttf'],['Mono','','DejaVuSansMono.ttf'],['Mono','B','DejaVuSansMono-Bold.ttf'],['Serif','','DejaVuSerif.ttf'],['Serif','B','DejaVuSerif-Bold.ttf']] as $f){ $pdf->AddFont($f[0],$f[1],$f[2],true); }

$tmpdir = uploads_dir().'/tmp'; if (!is_dir($tmpdir)) { @mkdir($tmpdir,0775,true); } $tmpFiles=[];
function qr_for(string $url): ?string { global $tmpdir,$tmpFiles; if(!is_dir($tmpdir)||!is_writable($tmpdir))return null; $f=$tmpdir.'/qr_'.bin2hex(random_bytes(5)).'.png'; try{QRcode::png($url,$f,QR_ECLEVEL_M,4,1);}catch(Throwable $e){return null;} if(!is_file($f))return null; $tmpFiles[]=$f; return $f; }
function http_get(string $url,int $t=5): ?string { if(function_exists('curl_init')){$ch=curl_init($url);curl_setopt_array($ch,[CURLOPT_RETURNTRANSFER=>true,CURLOPT_TIMEOUT=>$t,CURLOPT_FOLLOWLOCATION=>true,CURLOPT_USERAGENT=>'PTI']);$r=curl_exec($ch);$c=(int)curl_getinfo($ch,CURLINFO_HTTP_CODE);curl_close($ch);return($r!==false&&$c>=200&&$c<300)?$r:null;} $ctx=stream_context_create(['http'=>['timeout'=>$t],'https'=>['timeout'=>$t]]);$r=@file_get_contents($url,false,$ctx);return $r!==false?$r:null; }
function static_map_for(string $addr): ?string { $dir=uploads_dir().'/maps'; if(!is_dir($dir))@mkdir($dir,0775,true); $msize='640x156'; $cache=$dir.'/'.sha1($addr.'|'.$msize).'.png'; if(is_file($cache)&&filesize($cache)>800)return $cache; $g=(string)(Env::get('GOOGLE_MAPS_KEY','')??''); if($g==='')return null; $q=rawurlencode($addr.', Praha, Czechia'); $url="https://maps.googleapis.com/maps/api/staticmap?center=$q&zoom=15&size=$msize&scale=2&maptype=roadmap&markers=".rawurlencode('color:0xE31E24|').$q."&language=en&key=$g"; $png=http_get($url,5); if($png===null||strlen($png)<800)return null; $im=@imagecreatefromstring($png); if(!$im)return null; @imagepng($im,$cache); imagedestroy($im); return (is_file($cache)&&filesize($cache)>800)?$cache:null; }
function tc($p,$c){$p->SetTextColor($c[0],$c[1],$c[2]);} function fc($p,$c){$p->SetFillColor($c[0],$c[1],$c[2]);} function dc($p,$c){$p->SetDrawColor($c[0],$c[1],$c[2]);}

$isDep=!empty($sale['is_deposit']); $totalC=(float)$sale['total_czk'];
$paidC=$sale['paid_czk']!==null?(float)$sale['paid_czk']:$totalC;
$restC=$sale['balance_czk']!==null?(float)$sale['balance_czk']:0.0;

$pdf->AddPage(); $W=180; $X=15;

/* ===== 0. fixní ochranná/značková vrstva (pod obsahem) ===== */
// mikrotext vlasový rámeček po obvodu (světle zlatý) — prémiové + mírná ochrana
$pdf->MicrotextFrame(8,9,194,280,'PRAGUE TOURIST INFO  ·  '.(string)$sale['voucher_number'].'  ·  ',$GOLDL,3.0);
// ghost monogram „PTI" (skutečná průhlednost přes SetAlpha) — velké, světlé, za obsahem
$pdf->SetAlpha(0.05); tc($pdf,$RED); $pdf->SetFont('Serif','B',150); $pdf->SetXY(0,118); $pdf->Cell(210,60,'PTI',0,0,'C'); $pdf->SetAlpha(1);
tc($pdf,$INK);

/* ===== 1. top bar: logo · paid · voucher/pin · QR ===== */
$mImg=PTI_BASE.'/lib/img/pti-masthead.png';
if (is_file($mImg)) $pdf->Image($mImg,$X,14,44);          // small brand
$qr=qr_for((string)$sale['voucher_number']);
if($qr){ $pdf->Image($qr,171,13,24,24,'PNG'); tc($pdf,$MUT); $pdf->SetFont('Mono','',6); $pdf->SetXY(165,37); $pdf->Cell(30,3,L2('Ukaž při check-inu','Show at check-in'),0,0,'C'); }
// paid chip
$paidLbl=$isDep?L2('ZÁLOHA','DEPOSIT PAID'):L2('ZAPLACENO','PAID'); fc($pdf,$OKBG); $pdf->RoundedRect(112,14,46,6.5,3.25,'F'); tc($pdf,$OK); $pdf->SetFont('Mono','B',7); $pdf->SetXY(112,14.5); $pdf->Cell(46,5.5,'✓  '.$paidLbl,0,0,'C');
// voucher no + pin + issued (right block, left of QR)
tc($pdf,$MUT); $pdf->SetFont('Mono','',6.4); $pdf->SetXY(96,23.5); $pdf->Cell(70,3.4,strtoupper(L2('Číslo voucheru','Voucher No.')),0,2,'R');
tc($pdf,$INK); $pdf->SetFont('Mono','B',12.5); $pdf->SetX(96); $pdf->Cell(70,6,(string)$sale['voucher_number'],0,2,'R');
tc($pdf,$MUT); $pdf->SetFont('Mono','',7); $pdf->SetX(96); $pdf->Cell(70,4,($V['pin']!==''?'PIN '.$V['pin'].'    ·    ':'').L2('Vydáno','Issued').' '.date('d.m.Y',strtotime((string)$sale['created_at'])),0,0,'R');
// Code128 čísla voucheru (skenovatelné na turniketu) — v prázdné mezeře pásu (mezi logem a číslem)
$pdf->Code128(60,29.5,(string)$sale['voucher_number'],46,6.5);
// zlatá „foil" linka + perforace = horní útržek (pass stub) k odtržení / ukázání u check-inu
dc($pdf,$GOLD);  $pdf->SetLineWidth(0.5); $pdf->Line($X,39.4,$X+$W,39.4);
dc($pdf,$GOLDL); $pdf->SetLineWidth(0.2); $pdf->Line($X,40.0,$X+$W,40.0);
dc($pdf,$BORD);  $pdf->PerfLine($X,$X+$W,41.0,1.4,1.4,0.25);

/* ===== 2. hero card: product + price ===== */
$y=44; $hh=23; fc($pdf,$SURF); dc($pdf,$BORD); $pdf->RoundedRect($X,$y,$W,$hh,3,'FD');
$pdf->Guilloche($X+$W-15,$y+$hh/2,8.5,[222,205,176],5,4,220,0.1);  // jemná ochranná ozdoba (foil tint)
if($V['operator']!==''){ tc($pdf,$RED); $pdf->SetFont('Mono','B',7.5); $pdf->SetXY($X+6,$y+4); $pdf->Cell(130,3.6,strtoupper($V['operator']),0,2); }
tc($pdf,$INK); $pdf->SetFont('Serif','B',16.5); $pdf->SetXY($X+6,$y+(($V['operator']!=='')?8.2:5.7)); $pdf->Cell(130,9,$V['name'],0,2);
if ($seatLine !== '') { $V['info'] = $seatLine . ($V['info'] !== '' ? "\n" . $V['info'] : ''); }
if ($choiceLine !== '') { $V['info'] = $choiceLine . ($V['info'] !== '' ? "\n" . $V['info'] : ''); }
if ($addonLine !== '') { $V['info'] = $addonLine . ($V['info'] !== '' ? "\n" . $V['info'] : ''); }
$sub=trim(($V['name_en']?$V['name_en']:'').($V['option']?($V['name_en']?'  ·  ':'').$V['option']:''));
if($sub!==''){ tc($pdf,$MUT); $pdf->SetFont('Sans','',10); $pdf->SetX($X+6); $pdf->Cell(130,5,$sub,0,0); }
// cena z hero boxu odebrána — částka je jen dole u TOTAL

/* ===== 3. booking tiles ===== */
$y=$y+$hh+5; $tiles=[[L2('Datum a čas','Date & time'),$V['date'].($V['time']?'  '.$V['time']:'')],[L2('Hosté','Guests'),$V['guests']]];
if($V['duration'])$tiles[]=[L2('Délka','Duration'),$V['duration']]; if($V['languages'])$tiles[]=[L2('Jazyk','Language'),$V['languages']];
$nT=count($tiles); $gap=3.5; $tw=($W-$gap*($nT-1))/$nT; $tx=$X;
foreach($tiles as $t){ fc($pdf,$WHITE); dc($pdf,$BORD); $pdf->RoundedRect($tx,$y,$tw,17,2.5,'FD');
  $ix=$tx+$tw-7.6; $iy=$y+3; $L0=$t[0];
  if(stripos($L0,'Datum')!==false||stripos($L0,'Date')!==false) $pdf->IconCalendar($ix,$iy,5,$GOLD);
  elseif(stripos($L0,'Hosté')!==false||stripos($L0,'Guest')!==false) $pdf->IconUsers($ix,$iy,5,$GOLD);
  elseif(stripos($L0,'Délka')!==false||stripos($L0,'Duration')!==false) $pdf->IconClock($ix,$iy,5,$GOLD);
  else $pdf->IconGlobe($ix,$iy,5,$GOLD);
  tc($pdf,$MUT);$pdf->SetFont('Mono','B',6); $pdf->SetXY($tx+3,$y+3); $pdf->MultiCell($tw-9,3,strtoupper($t[0]),0,'L');
  tc($pdf,$INK);$pdf->SetFont('Sans','B',9.5); $pdf->SetXY($tx+3,$y+8.2); $pdf->MultiCell($tw-5,4,$t[1],0,'L'); $tx+=$tw+$gap; }
$y+=17+2.5;
// secondary line
$bits=[]; if($V['lead'])$bits[]=L2('Vedoucí','Lead').': '.$V['lead']; if($V['redeem'])$bits[]=L2('Typ','Type').': '.$V['redeem']; if($V['validity'])$bits[]=L2('Platnost','Validity').': '.$V['validity']; if($V['group'])$bits[]=L2('Skupina','Group').': '.$V['group'];
if($bits){ tc($pdf,$MUT); $pdf->SetFont('Sans','',8.4); $pdf->SetXY($X+1,$y); $pdf->MultiCell($W-2,4.2,implode('     ·     ',$bits),0,'L'); }

/* ===== 4. meeting point ===== */
if($isBigBus){
  $y=$pdf->GetY()+4;
  tc($pdf,$RED); $pdf->SetFont('Mono','B',7); $pdf->SetXY($X,$y); $pdf->Cell($W,4,strtoupper(L2('Nástup','Boarding')),0,2);
  $ry=$pdf->GetY()+1.2;
  tc($pdf,$INK); $pdf->SetFont('Sans','B',11); $pdf->SetXY($X,$ry); $pdf->MultiCell($W-46,5,L2('Nastupte na kterékoli z 18 zastávek na obou trasách (červená a zelená).','Hop on at any of the 18 stops on both routes (Red and Green).'),0,'L');
  tc($pdf,$INK); $pdf->SetFont('Sans','',8.8); $pdf->SetX($X); $pdf->MultiCell($W-46,4.2,L2('Hledejte červený patrový Big Bus.','Look for the red double-decker Big Bus.'),0,'L');
  // two QR codes (route map PDF + find nearest stop)
  $q1=qr_for($bbPdf); $q2=qr_for($bbStop); $qx=$X+$W-44;
  if($q1){ fc($pdf,$WHITE); dc($pdf,$BORD); $pdf->RoundedRect($qx,$ry,20,20,2,'FD'); $pdf->Image($q1,$qx+1,$ry+1,18,18,'PNG'); tc($pdf,$MUT); $pdf->SetFont('Mono','',5.6); $pdf->SetXY($qx-2,$ry+20.5); $pdf->Cell(24,3,L2('Mapa zastávek','Route & stops map'),0,0,'C'); }
  if($q2){ fc($pdf,$WHITE); dc($pdf,$BORD); $pdf->RoundedRect($qx+24,$ry,20,20,2,'FD'); $pdf->Image($q2,$qx+25,$ry+1,18,18,'PNG'); tc($pdf,$MUT); $pdf->SetFont('Mono','',5.6); $pdf->SetXY($qx+22,$ry+20.5); $pdf->Cell(24,3,L2('Najdi zastávku','Find nearest stop'),0,0,'C'); }
  $pdf->SetY(max($pdf->GetY(), $ry+24));
}
elseif($V['meet_addr']!==''){
  $y=$pdf->GetY()+4;
  tc($pdf,$RED); $pdf->SetFont('Mono','B',7); $pdf->SetXY($X,$y); $pdf->Cell($W,4,strtoupper(L2('Místo srazu','Meeting point')),0,2);
  $ry=$pdf->GetY()+1.2;
  $murl=$V['map_url']?:('https://www.google.com/maps/search/?api=1&query='.rawurlencode($V['meet_addr'].', Praha'));
  $qm=qr_for($murl); $qsz=20;
  if($qm){
    fc($pdf,$WHITE); dc($pdf,$BORD); $pdf->RoundedRect($X+$W-$qsz-2,$ry,$qsz+2,$qsz+2,2,'FD');
    $pdf->Image($qm,$X+$W-$qsz-1,$ry+1,$qsz,$qsz,'PNG');
    $cap=($lng==='cs')?'Naskenuj – Google mapa':(($lng==='de')?'Karte scannen':'Scan for Google map');
    tc($pdf,$MUT); $pdf->SetFont('Mono','',6); $pdf->SetXY($X+$W-$qsz-34,$ry+$qsz+3); $pdf->Cell($qsz+34,3,$cap,0,0,'R');
  }
  $tw = $qm ? ($W-$qsz-8) : $W;
  tc($pdf,$INK); $pdf->SetFont('Sans','B',11.5); $pdf->SetXY($X,$ry); $pdf->MultiCell($tw,5,$V['meet_addr'],0,'L');
  if($V['meet_note']){ tc($pdf,$INK); $pdf->SetFont('Sans','B',8.8); $pdf->SetX($X); $pdf->MultiCell($tw,4.3,$V['meet_note'],0,'L'); }
  $rowBottom=max($pdf->GetY(), $ry+$qsz+5);
  $map=static_map_for($V['meet_addr']);
  if($map){ $my=$rowBottom+2.5; $mh=44; fc($pdf,$WHITE); $pdf->Image($map,$X,$my,$W,$mh,'PNG'); dc($pdf,$BORD); $pdf->RoundedRect($X,$my,$W,$mh,3,'D'); $pdf->SetY($my+$mh); }
  else { $pdf->SetY($rowBottom); }
}

/* ===== 5. included / not included / bring ===== */
$lists=[]; if($V['included'])$lists[]=[L2('V ceně','Included'),$V['included'],'✓',$OK]; if($V['excluded'])$lists[]=[L2('Není v ceně','Not included'),$V['excluded'],'✕',$RED]; if($V['bring'])$lists[]=[L2('Vezměte s sebou','What to bring'),$V['bring'],'•',$MUT];
if($lists){ $y=$pdf->GetY()+4; $nL=count($lists); $gap=4; $cw=($W-$gap*($nL-1))/$nL; $cx=$X; $maxb=0;
  foreach($lists as $L){ $by=$y; tc($pdf,$MUT);$pdf->SetFont('Mono','B',6.6);$pdf->SetXY($cx,$by);$pdf->Cell($cw,3.6,strtoupper($L[0]),0,2);
    $pdf->SetY($by+4.8);
    foreach($L[1] as $li){ tc($pdf,$L[3]);$pdf->SetFont('Sans','B',9);$pdf->SetX($cx);$pdf->Cell(4,4.3,$L[2],0,0); tc($pdf,$INK);$pdf->SetFont('Sans','',8.6);$pdf->MultiCell($cw-4,4.3,$li,0,'L'); }
    $maxb=max($maxb,$pdf->GetY()); $cx+=$cw+$gap; }
  $pdf->SetY($maxb); }

/* ===== 6. important info & cancellation (soft beige) ===== */
if($V['info']!=='' || $V['cancel']!==''){ $y=$pdf->GetY()+4;
  // measure height roughly
  $h=6; if($V['info']!=='')$h+=8; if($V['cancel']!=='')$h+=6;
  fc($pdf,$WARNBG);dc($pdf,$WARNLINE); $pdf->RoundedRect($X,$y,$W,$h,3,'FD');
  tc($pdf,[140,110,30]);$pdf->SetFont('Mono','B',6.6);$pdf->SetXY($X+6,$y+3);$pdf->Cell($W-12,3.4,strtoupper(L2('Důležité informace & storno','Important info & cancellation')),0,2);
  if($V['info']!==''){ tc($pdf,$INK);$pdf->SetFont('Sans','',8.6);$pdf->SetX($X+6);$pdf->MultiCell($W-12,4,$V['info'],0,'L'); }
  if($V['cancel']!==''){ tc($pdf,$INK);$pdf->SetFont('Sans','B',8.6);$pdf->SetX($X+6);$pdf->MultiCell($W-12,4,$V['cancel'],0,'L'); }
  $pdf->SetY($y+$h); }

/* ===== 7. payment summary card ===== */
$y=$pdf->GetY()+4; $ph=18; fc($pdf,$WHITE);dc($pdf,$BORD); $pdf->RoundedRect($X,$y,$W,$ph,3,'FD');
$cw=$W/3; dc($pdf,$BORD); $pdf->Line($X+$cw,$y+3,$X+$cw,$y+$ph-3); $pdf->Line($X+2*$cw,$y+3,$X+2*$cw,$y+$ph-3);
$pcell=function($cx,$lbl,$val,$col) use($pdf,$MUT,$cw,$y){ $pdf->SetXY($cx+6,$y+3.5);tc($pdf,$MUT);$pdf->SetFont('Mono','B',6.4);$pdf->Cell($cw-10,3.6,$lbl,0,2);tc($pdf,$col);$pdf->SetFont('Sans','B',12);$pdf->SetX($cx+6);$pdf->Cell($cw-10,6.5,$val,0,0); };
$pcell($X,'TOTAL',vczk($totalC).($sale['total_eur']!==null?' / '.veur($sale['total_eur']):''),$INK);
$pcell($X+$cw,'PAID'.($isDep?' (DEPOSIT)':''),vczk($paidC),$INK);
$pcell($X+2*$cw,'TO PAY'.($isDep?' (REST)':''),vczk($restC),$restC>0?$RED:$OK);
$pm=$sale['payment_method']==='card'?L2('kartou','by card'):L2('hotově','in cash');
tc($pdf,$MUT);$pdf->SetFont('Mono','',6.2);$pdf->SetXY($X,$y+$ph+1);$pdf->Cell($W/2,3.2,strtoupper(L2('Platba','Payment')).': '.$pm,0,0,'L');
if($sale['total_eur']!==null){ $pdf->SetX($X+$W/2);$pdf->Cell($W/2,3.2,L2('Účtováno v CZK · EUR jen orientační (1 € ≈ 25 Kč)','Charged in CZK · EUR indicative (€1 ≈ 25 CZK)'),0,0,'R'); }
$pdf->SetY($y+$ph+5);

/* ===== 8. need help + manage booking (two cards) ===== */
$y=$pdf->GetY(); $ch=21; $cw=(180-5)/2;
fc($pdf,$SURF);dc($pdf,$BORD); $pdf->RoundedRect($X,$y,$cw,$ch,3,'FD'); $pdf->RoundedRect($X+$cw+5,$y,$cw,$ch,3,'FD');
tc($pdf,$MUT);$pdf->SetFont('Mono','B',6.4);$pdf->SetXY($X+5,$y+3.5);$pdf->Cell($cw-8,3.4,strtoupper(L2('Potřebujete pomoc?','Need help?')),0,2);
tc($pdf,$INK);$pdf->SetFont('Sans','B',9.5);$pdf->SetX($X+5);$pdf->Cell($cw-8,5,$V['operator'],0,2);
tc($pdf,$MUT);$pdf->SetFont('Sans','',8.4);$pdf->SetX($X+5);$pdf->MultiCell($cw-8,4,trim(($pinfo['contact_phone']??($DEMO?'+420 222 244 244':'')).(!empty($pinfo['contact_email'])?'  ·  '.$pinfo['contact_email']:($DEMO?'  ·  info@bigbustours.cz':''))),0,'L');
$rx=$X+$cw+5;
tc($pdf,$MUT);$pdf->SetFont('Mono','B',6.4);$pdf->SetXY($rx+5,$y+3.5);$pdf->Cell($cw-8,3.4,strtoupper(L2('Správa rezervace','Manage your booking')),0,2);
tc($pdf,$INK);$pdf->SetFont('Sans','',8.6);$pdf->SetX($rx+5);$pdf->MultiCell($cw-8,4.1,L2('Číslo','Ref.').': '.$sale['voucher_number'].($V['pin']!==''?'   ·   PIN '.$V['pin']:''),0,'L');
$pdf->SetX($rx+5);$pdf->MultiCell($cw-8,4.1,L2('Linka PTI','PTI service').': +420 257 213 420',0,'L');
$pdf->SetY($y+$ch);

/* seller (small print, not important for the client) */
if($sellerName!==''){ tc($pdf,$MUT); $pdf->SetFont('Sans','',7); $pdf->SetXY($X,$pdf->GetY()+2.5); $pdf->Cell($W,3.4,L2('Voucher vystavil','Issued by').': '.$sellerName,0,0,'R'); }

/* ===== footer ===== */
$fy=284; dc($pdf,$BORD); $pdf->Line($X,$fy,$X+$W,$fy);
tc($pdf,$INK);$pdf->SetFont('Sans','B',8.5);$pdf->SetXY($X,$fy+1.6);$pdf->Cell($W,4,'Prague Tourist Information s.r.o.',0,2,'C');
tc($pdf,$MUT);$pdf->SetFont('Sans','',7.6);$pdf->SetX($X);
$pdf->Cell($W,3.4,'Mostecká 53/4, 118 00 Praha 1 – Malá Strana   ·   +420 257 213 420   ·   +420 606 155 373',0,2,'C');
$pdf->SetX($X);$pdf->Cell($W,3.4,'info@prague-tourism.com   ·   www.prague-tourism.com',0,0,'C');

$out=$pdf->Output('S'); foreach($tmpFiles as $f){@unlink($f);} while(ob_get_level()>0){ob_end_clean();} error_reporting($pti_er);
header('Content-Type: application/pdf'); header('Content-Disposition: inline; filename="'.(string)$sale['voucher_number'].'.pdf"'); header('Content-Length: '.strlen($out)); echo $out;
