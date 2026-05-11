# Chart SVG Style Guide

> 鏈枃妗ｅ畾涔変簡 `templates/charts/` 涓嬫墍鏈?SVG 鍥捐〃妯℃澘鐨勮瑙夎鑼冦€? 
> 鏂板鎴栦慨鏀瑰浘琛ㄦ椂 **蹇呴』** 閬靛惊浠ヤ笅鏍囧噯锛岀‘淇濆叏搴撹瑙変竴鑷存€с€?
## 0. 涓婃父瑙勮寖寮曠敤

鏈枃妗ｆ槸 **鍥捐〃妯℃澘涓撶敤** 鐨勭編瀛︿笌瀹炵幇瑙勮寖銆傛墍鏈夊浘琛ㄥ悓鏃跺繀椤婚伒瀹堥」鐩骇閫氱敤鎶€鏈害鏉燂細

> **[`references/shared-standards.md`](../../references/shared-standards.md)** 鈥?SVG 绂佺敤鐗规€ч粦鍚嶅崟銆丳PT 鍏煎鎬ф浛浠ｃ€丆anvas 鏍煎紡銆乼span 鍐呰仈瑙勫垯銆佸垎缁勮鑼冦€侀槾褰?鍙犲姞鎶€鏈€佸悗澶勭悊绠＄嚎

浠ヤ笅绔犺妭鎽樺綍浜?shared-standards 涓笌鍥捐〃妯℃澘鏈€瀵嗗垏鐩稿叧鐨勬潯鐩€傚畬鏁寸粏鑺傦紙濡?marker 鏉′欢绾︽潫銆乧lipPath 鏉′欢绾︽潫銆佸姬绾胯矾寰勮绠楀叕寮忕瓑锛夎鏌ラ槄涓婃父鏂囨。銆?
---

## 1. 鑹插僵绯荤粺 (Tailwind CSS Palette)

### 1.1 鏂囨湰棰滆壊

| 鐢ㄩ€?| 鑹插€?| Tailwind Token | 绀轰緥 |
|------|------|----------------|------|
| **涓绘爣棰?* | `#0F172A` | Slate 900 | 鍥捐〃澶ф爣棰?|
| **鏁板€兼爣绛?* | `#0F172A` | Slate 900 | 鏌遍《鏁板€笺€佸叧閿寚鏍?|
| **鍓爣棰?* | `#64748B` | Slate 500 | 鏃ユ湡銆佸崟浣嶈鏄?|
| **鍧愭爣杞存爣绛?* | `#64748B` | Slate 500 | X/Y 杞村埢搴﹀€?|
| **杞存爣棰?/ 鍥句緥** | `#475569` | Slate 600 | "骞磋柂锛堜竾鍏冿級"銆佸浘渚嬫枃瀛?|
| **鏁版嵁鏉ユ簮** | `#94A3B8` | Slate 400 | 椤甸潰搴曢儴鏉ユ簮璇存槑 |
| **鑴氭敞 / 娣″寲鎻愮ず** | `#CBD5E1` | Slate 300 | "鍚勯樁娈靛彲鐏垫椿璋冩暣" |

### 1.2 涓婚鑹诧紙鏁版嵁绯诲垪锛?
| 鑹插悕 | 涓昏壊 | 娣辫壊锛堟笎鍙樼粓鐐癸級 | 鐢ㄩ€?|
|------|------|------------------|------|
| **Blue** | `#3B82F6` | `#2563EB` | 绗?1 绯诲垪锛堥粯璁ら閫夛級 |
| **Emerald** | `#10B981` | `#059669` | 绗?2 绯诲垪 |
| **Amber** | `#F59E0B` | `#D97706` | 绗?3 绯诲垪 |
| **Violet** | `#8B5CF6` | `#7C3AED` | 绗?4 绯诲垪 |
| **Rose** | `#FB7185` | `#E11D48` | 绗?5 绯诲垪 / 璀﹀憡 |
| **Pink** | `#EC4899` | `#BE185D` | 瀵规瘮缁勶紙濡傝澊铦跺浘濂虫€э級 |

> 寰勫悜娓愬彉锛堝姘旀场鍥撅級浣跨敤浜壊鍙樹綋锛歚#60A5FA`銆乣#34D399`銆乣#FBBF24`銆乣#A78BFA`銆乣#FB7185`

### 1.3 璇箟鑹?
| 鐢ㄩ€?| 鑹插€?| 璇存槑 |
|------|------|------|
| 杈炬爣 / 姝ｉ潰 | `#10B981` | Emerald 500 |
| 璀﹀憡 / 涓€?| `#F59E0B` | Amber 500 |
| 鏈揪鏍?/ 璐熼潰 | `#EF4444` | Red 500 |
| 寮傚父鍊兼爣娉?| `#F43F5E` | Rose 500 |

### 1.4 UI 杈呭姪鑹?
| 鐢ㄩ€?| 鑹插€?| 璇存槑 |
|------|------|------|
| **鍧愭爣杞寸嚎** | `#94A3B8` | Slate 400, stroke-width="2" |
| **缃戞牸绾?* | `#E2E8F0` 鎴?`#E0E0E0` | stroke-dasharray="4,4" |
| **涓績鍒嗛殧绾?* | `#CBD5E1` | 濡傝薄闄愬崄瀛楃嚎 |
| **鍗＄墖鑳屾櫙** | `#F8FAFC` / `#F8F9FA` | Slate 50 |
| **鍗＄墖鎻忚竟** | `#E2E8F0` | Slate 200 |
| **琛屽垎闅旂嚎** | `#F1F5F9` | Slate 100锛堟瀬娣★級 |
| **Tint 鑳屾櫙**锛堣摑锛?| `#EFF6FF` | Blue 50 |
| **Tint 鑳屾櫙**锛堢豢锛?| `#ECFDF5` | Emerald 50 |
| **Tint 鑳屾櫙**锛堢孩锛?| `#FFF1F2` | Rose 50 |
| **Tint 鑳屾櫙**锛堥粍锛?| `#FFFBEB` | Amber 50 |

---

## 2. 鎺掔増瑙勮寖

### 2.1 瀛椾綋鏍?
```
font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', 'PingFang SC', 'Microsoft YaHei', sans-serif"
```

- 绾嫳鏂囧満鏅彲鐪佺暐 `'PingFang SC', 'Microsoft YaHei'`
- **绂佹** 浣跨敤 `@font-face`銆佸閮ㄥ瓧浣撱€乣<style>` 鏍囩

### 2.2 瀛楀彿灞傜骇

| 灞傜骇 | 瀛楀彿 | font-weight | 鐢ㄩ€?|
|------|------|-------------|------|
| H1 | `34px` | `bold` (700) | 鍥捐〃涓绘爣棰?|
| H2 | `22px` | `600` | 鍖哄煙鏍囬锛堝"璇︾粏鏁版嵁"锛?|
| Body L | `18-20px` | `600` | 鍏抽敭鏁板€笺€佺櫨鍒嗘瘮 |
| Body M | `15-16px` | `600` | 鏁版嵁鏍囩銆佸垎绫诲悕 |
| Body S | `14px` | 姝ｅ父 | 鍓爣棰樸€佸浘渚嬨€佹潵婧?|
| Caption | `12-13px` | 姝ｅ父 | 鍧愭爣杞村埢搴︺€佹敞閲?|

> **鏈€灏忓瓧鍙蜂笅闄愶細12px**銆傛墍鏈夋枃鏈笉寰楀皬浜?12px銆?
### 2.3 tspan 瑙勮寖

鎵€鏈?`<text>` 鍏冪礌鐨勬枃鏈唴瀹?**蹇呴』** 鍖呰９鍦?`<tspan>` 涓細

```xml
<!-- 姝ｇ‘ -->
<text x="60" y="80" font-size="34" fill="#0F172A">
    <tspan>鍥捐〃鏍囬</tspan>
</text>

<!-- 閿欒 -->
<text x="60" y="80" font-size="34" fill="#0F172A">鍥捐〃鏍囬</text>
```

### 2.4 鍐呰仈鏍煎紡鍖栬鍒欙紙shared-standards SS4锛?
**鍗曢€昏緫琛?= 鍗?`<text>`**銆傚悓涓€琛屽唴闇€瑕佸鑹?澶氱矖缁嗘椂锛岀敤鍐呰仈 `<tspan>` 瀹炵幇锛?*涓嶈**鐢ㄥ涓苟鎺?`<text>`锛?
```xml
<!-- 姝ｇ‘锛氫竴涓?text frame锛屼笁涓?run -->
<text x="100" y="200" font-size="24" fill="#333333">
  瀹炵幇<tspan fill="#3B82F6" font-weight="bold">10鍊?/tspan>鏁堢巼鎻愬崌
</text>

<!-- 閿欒锛氫笁涓嫭绔?text frame锛孭PT 涓棤娉曚綔涓轰竴琛岀紪杈?-->
<text x="100" y="200">瀹炵幇</text>
<text x="160" y="200" fill="#3B82F6">10鍊?/text>
<text x="240" y="200">鏁堢巼鎻愬崌</text>
```

> 鍐呰仈 tspan **涓嶅緱** 鎼哄甫 `x` / `y` / `dy`锛屽惁鍒欏悗澶勭悊浼氬皢鍏舵媶鍒嗕负鐙珛 text frame銆俙dx` 鍙敤浜庡井璋冨瓧璺濄€?
### 2.5 鏁版嵁楂樹寒榛樿琛屼负

鍥捐〃涓殑鍏抽敭鏁版嵁鏂囨湰搴旈粯璁ら珮浜細
- **鏁板€肩粨鏋?* 鈥?鐧惧垎姣斻€佸€嶆暟銆侀噾棰?鈫?`<tspan fill="涓婚鑹? font-weight="bold">`
- **瀵规瘮椤?* 鈥?澧?鍑忋€佽揪鏍?鏈揪鏍?鈫?璇箟鑹诧紙缁?绾級
- **涓嶉珮浜?* 鈥?杩炴帴璇嶃€佹櫘閫氬姩璇嶃€佺粨鏋勬€ф枃瀛楋紙杞存爣绛俱€佸浘渚嬨€侀〉鐮侊級

---

## 3. 闃村奖婊ら暅

缁熶竴浣跨敤 `feFlood` 鏂规锛?*绂佹** 浣跨敤 `feComponentTransfer`锛?
```xml
<filter id="chartShadow" x="-15%" y="-15%" width="130%" height="130%">
    <feGaussianBlur in="SourceAlpha" stdDeviation="2-4"/>
    <feOffset dx="0" dy="1-3" result="offsetBlur"/>
    <feFlood flood-color="#0F172A" flood-opacity="0.08-0.15" result="shadowColor"/>
    <feComposite in="shadowColor" in2="offsetBlur" operator="in" result="shadow"/>
    <feMerge>
        <feMergeNode in="shadow"/>
        <feMergeNode in="SourceGraphic"/>
    </feMerge>
</filter>
```

### 鍙傛暟鍙傝€?
| 鍦烘櫙 | stdDeviation | dy | flood-opacity |
|------|-------------|-----|---------------|
| 閲嶅瀷鍏冪礌锛堢澶淬€佸崱鐗囷級 | 4-6 | 2-4 | 0.12-0.15 |
| 涓瀷鍏冪礌锛堟煴瀛愩€佺浣擄級 | 2-3 | 1-2 | 0.10-0.15 |
| 杞诲瀷鍏冪礌锛堝簳閮ㄥ崱鐗囷級 | 4-6 | 2-4 | 0.06-0.08 |

### 绂佺敤鍒楄〃

- `flood-color="#000000"` 鈫?蹇呴』鐢?`#0F172A`
- `feComponentTransfer` 鈫?鐢?`feFlood` 鏇夸唬
- `flood-opacity > 0.20` 鈫?闃村奖杩囬噸锛屾渶澶?0.15-0.20

### 闃村奖浣跨敤鍘熷垯锛坰hared-standards SS6锛?
> **闃村奖鏄編瀛︽垚鍒嗭紝涓嶆槸榛樿澶勭悊銆?* 鍏嬪埗鑰岄潪涓板瘜鎵嶈兘浜х敓"缁忚繃璁捐"鐨勬劅瑙夈€?"闃村奖琚劅鐭ヨ€岄潪琚湅瑙? 鏄珮绔編瀛︽爣鍑嗐€?
**搴斿姞闃村奖**锛氭诞鍦ㄧ収鐗?褰╄壊闈㈡澘涓婃柟鐨勫崱鐗囥€佸敮涓€鐨勪富 CTA銆佸彔鍔犲眰锛坱ooltip銆乧allout锛?
**涓嶅簲鍔犻槾褰?*锛氳儗鏅潰鏉?鍒嗛殧鏉°€佺綉鏍间腑骞崇瓑鐨勫悓绾у崱鐗囥€佸凡鏈夋弿杈?娓愬彉鐨勫鍣ㄣ€佹鏂囨钀藉鍣ㄣ€佽楗扮嚎/鍥炬爣銆佹繁鑹茶儗鏅笂锛堥粦鑹查槾褰变笉鍙锛?
**姣忛〉棰勭畻**锛氭渶澶?2-3 涓甫闃村奖鍏冪礌銆傜 4 涓渶瑕侀槾褰辨椂锛屽厛绉婚櫎鐜版湁鏌愪釜鐨勯槾褰便€?
**缁熶竴鍏夋簮**锛氬悓椤垫墍鏈?`feOffset` 鐨?`dx`/`dy` 鏂瑰悜蹇呴』涓€鑷达紙榛樿 `dx=0, dy=姝ｅ€糮锛屽厜浠庝笂鏂规潵锛夈€?
**涓ょ骇楂樺害涓婇檺**锛?
| 灞傜骇 | 鍦烘櫙 | dy | stdDeviation | flood-opacity |
|------|------|----|--------------|---------------|
| 鍦伴潰锛堟棤闃村奖锛?| 鑳屾櫙銆佸悓绾х綉鏍煎崱鐗囥€佸垎闅旂嚎銆佹鏂囧鍣?| 鈥?| 鈥?| 鈥?|
| 闈欐 | 鐓х墖/闈㈡澘涓婄殑鍗＄墖銆佹绾?callout | 2-4 | 4-8 | 0.06-0.10 |
| 鎶崌 | 涓?CTA銆佺劍鐐?鎺ㄨ崘鍗＄墖銆佽鐩栧眰 | 6-10 | 10-16 | 0.12-0.20 |

**涓嶈鍫嗗彔**锛氶槾褰?+ 鎻忚竟 + 鍦嗚 + 娓愬彉濉厖鍚屾椂鍑虹幇 = 妯℃澘鎰熴€傚鍣ㄧ殑"鐪嬫垜"棰勭畻寰堝皬锛岄€夊叾涓€鍗冲彲銆?
---

## 4. 娓愬彉瑙勮寖

### 4.1 绾挎€ф笎鍙橈紙鏌辩姸/鏉″舰鍥撅級

```xml
<linearGradient id="barGrad1" x1="0%" y1="0%" x2="0%" y2="100%">
    <stop offset="0%" style="stop-color:#3B82F6;stop-opacity:1" />
    <stop offset="100%" style="stop-color:#2563EB;stop-opacity:1" />
</linearGradient>
```

- 鏂瑰悜锛氫粠浜埌娣憋紙椤跺埌搴?鎴?宸﹀埌鍙筹級
- 姣忎釜娓愬彉 ID 搴旇涔夊寲锛歚barGrad1`銆乣leftGrad`銆乣actualBarBlue`

### 4.2 寰勫悜娓愬彉锛堟皵娉″浘锛?
```xml
<radialGradient id="bubbleGrad1" cx="30%" cy="30%">
    <stop offset="0%" style="stop-color:#60A5FA;stop-opacity:0.9" />
    <stop offset="100%" style="stop-color:#2563EB;stop-opacity:0.7" />
</radialGradient>
```

- 楂樺厜鍋忓乏涓婃柟 (`cx="30%" cy="30%"`)
- 杈圭紭 opacity 闄嶄綆鑷?0.7锛屽埗閫犻€氶€忔劅

---

## 5. 缁撴瀯瑙勮寖

### 5.1 灞傜骇鍒嗙粍锛坰hared-standards SS4 Grouping锛?
浣跨敤 `<g id="...">` 杩涜璇箟鍒嗙粍锛屼究浜?PPT 涓€愪釜鎿嶄綔/鍔ㄧ敾锛?
```xml
<g id="chartArea">        <!-- 鍥捐〃涓讳綋 -->
    <g id="bar-1">...</g>  <!-- 姣忎釜鏁版嵁鍏冪礌鐙珛鍒嗙粍 -->
    <g id="bar-2">...</g>
</g>
<g id="legend">            <!-- 鍥句緥鍖哄煙 -->
    <g id="legend-high">...</g>
</g>
<g id="detailList">        <!-- 璇︽儏闈㈡澘 -->
    <g id="list-items">
        <g id="item-1">...</g>
    </g>
</g>
```

**鍒嗙粍鍗曞厓鍙傝€?*锛堟潵鑷?shared-standards锛夛細

| 鍒嗙粍鍗曞厓 | 鍖呭惈鍐呭 |
|---------|---------|
| 鍗＄墖/闈㈡澘 | 鑳屾櫙 rect + 闃村奖锛堝閫傜敤锛? 鍥炬爣 + 鏍囬 + 姝ｆ枃 |
| 娴佺▼姝ラ | 缂栧彿鍦?+ 鍥炬爣 + 鏍囩 + 鎻忚堪 |
| 鍒楄〃椤?| 鍦嗙偣/缂栧彿 + 鍥炬爣 + 鏍囬 + 鎻忚堪 |
| 鍥炬爣-鏂囧瓧缁勫悎 | 鍥炬爣鍏冪礌 + 鐩搁偦鏍囩 |
| 椤靛ご | 鏍囬 + 鍓爣棰?+ 瑁呴グ |
| 瑁呴グ闆嗙兢 | 鐩稿叧瑁呴グ褰㈢姸锛堢幆銆佺悆銆佺偣锛?|

**鍛藉悕绾﹀畾**锛氫娇鐢ㄦ弿杩版€?`id`锛堝 `card-1`銆乣step-discover`銆乣header`銆乣footer`锛夈€?
> 鍙湁 `<g opacity="...">` 琚姝紙瑙?SS2锛夈€傜函缁撴瀯 `<g>` 鏄繀闇€鐨勩€?
### 5.2 viewBox

鍥哄畾涓?`0 0 1280 720`锛圥PT 16:9锛夛紝涓嶅彲淇敼銆?
### 5.3 鑳屾櫙

棣栬濮嬬粓涓虹櫧鑹插叏灞忚儗鏅細
```xml
<rect width="1280" height="720" fill="#FFFFFF"/>
```

### 5.4 鏁版嵁鏉ユ簮

浣嶄簬椤甸潰搴曢儴锛屽浐瀹氭牸寮忥細
```xml
<text x="60" y="695" font-family="..." font-size="14" fill="#94A3B8">
    <tspan>鏁版嵁鏉ユ簮: XXX</tspan>
</text>
```

---

## 6. SVG 绂佺敤鐗规€т笌鍏煎鎬э紙shared-standards SS1-2锛?
### 6.1 缁濆绂佹

| 绂佺敤鐗规€?| 鏇夸唬鏂规 |
|---------|---------| 
| HTML 鍛藉悕瀹炰綋锛坄&nbsp;` `&mdash;` `&copy;` `&ndash;` `&reg;` `&hellip;` `&bull;` 鈥︼級 | 鐩存帴鍐欏師鐢?Unicode 瀛楃锛坄鈥擿 `鈥揱 `漏` `庐` `鈫抈 NBSP 鈥︼級 |
| 鏂囨湰/灞炴€у€间腑瑁稿啓 `& < > " '` | 蹇呴』鍐欐垚 XML 瀹炰綋 `&amp;` `&lt;` `&gt;` `&quot;` `&apos;` |
| `<style>` / `class` | 鍐呰仈灞炴€э紙`id` 鍦?`<defs>` 鍐呭悎娉曪級 |
| `<foreignObject>` | `<text>` + `<tspan>` |
| `mask` | 鍙犲姞閬僵鐭╁舰 / gradient overlay |
| `<symbol>` + `<use>` | 鐩存帴鍐欏嚭瀹屾暣鍏冪礌 |
| `textPath` | 鎵嬪姩鎺掑垪 `<text>` |
| `@font-face` | 绯荤粺瀛椾綋鏍?|
| `<animate*>` / `<set>` | 鏃狅紙PPT 渚у鐞嗗姩鐢伙級 |
| `<script>` / event 灞炴€?| 鏃?|
| `<iframe>` | 鏃?|

### 6.2 PPT 鍏煎鎬ф浛浠?
| 绂佹璇硶 | 姝ｇ‘鏇夸唬 |
|---------|----------|
| `fill="rgba(255,255,255,0.1)"` | `fill="#FFFFFF" fill-opacity="0.1"` |
| `<g opacity="0.2">...</g>` | 鍦ㄦ瘡涓瓙鍏冪礌涓婂崟鐙缃?`fill-opacity` / `stroke-opacity` |
| `<image opacity="0.3"/>` | 鍦?image 鍚庡彔鍔?`<rect fill="鑳屾櫙鑹? opacity="0.7"/>` |

### 6.3 鏉′欢鍏佽

| 鐗规€?| 鏉′欢 | 杞崲缁撴灉 |
|------|------|----------|
| `marker-start` / `marker-end` | `<marker>` 鍦?`<defs>` 涓紝`orient="auto"`锛屽舰鐘朵负涓夎/鑿卞舰/鍦?| DrawingML `<a:headEnd>` / `<a:tailEnd>` |
| `clipPath` on `<image>` | `<clipPath>` 鍦?`<defs>` 涓紝鍗曞瓙鍏冪礌锛?*浠呯敤浜?image** | DrawingML `<a:prstGeom>` / `<a:custGeom>` |
| `stroke-dasharray` | 浣跨敤棰勮鍊?`4,4` / `2,2` / `8,4` / `8,4,2,4` | PPTX `<a:prstDash>` |
| `text-decoration` | `underline` / `line-through` | PPTX 鍘熺敓鏂囨湰鏍煎紡 |
| `transform="rotate(...)"` | 鎵€鏈夊厓绱犵被鍨嬪潎鏀寔 | PPTX `<a:xfrm rot="...">` |

> 瀹屾暣鏉′欢绾︽潫瑙?[`shared-standards.md`](../../references/shared-standards.md) SS1.1锛坢arker 绾︽潫锛夊拰 SS1.2锛坈lipPath 绾︽潫锛夈€?
### 6.4 铏氱嚎棰勮瀵圭収

| SVG 鍊?| PPTX 棰勮 | 閫傜敤鍦烘櫙 |
|--------|-----------|---------|
| `4,4` | Dash | 閫氱敤铏氱嚎銆佸垎闅旂嚎 |
| `2,2` | Dot (sysDot) | 鍗犱綅杞粨銆佺粏杈规 |
| `8,4` | Long dash | 鏃堕棿绾胯繛鎺ャ€佹祦绋嬬澶?|
| `8,4,2,4` | Long dash-dot | 鎶€鏈浘绾搞€佸昂瀵哥嚎 |

---

## 7. 鏃ц壊鏄犲皠閫熸煡琛?
鍦ㄧ淮鎶ゆ棫妯℃澘鏃讹紝浣跨敤浠ヤ笅鏄犲皠蹇€熸浛鎹細

| 鏃ц壊 (Material/Flat) | 鈫?| 鏂拌壊 (Tailwind) | 瑙掕壊 |
|----------------------|---|-----------------|------|
| `#2C3E50` | 鈫?| `#0F172A` | 涓绘枃鏈?|
| `#7F8C8D` | 鈫?| `#64748B` | 鍓枃鏈?|
| `#5D6D7E` | 鈫?| `#475569` | 鍥句緥鏂囨湰 |
| `#95A5A6` | 鈫?| `#94A3B8` | 鏁版嵁鏉ユ簮 |
| `#BDC3C7` | 鈫?| `#CBD5E1` | 娣″寲鍏冪礌 |
| `#2196F3` / `#1976D2` | 鈫?| `#3B82F6` / `#2563EB` | 钃濊壊绯诲垪 |
| `#4CAF50` / `#388E3C` | 鈫?| `#10B981` / `#059669` | 缁胯壊绯诲垪 |
| `#FF9800` / `#F57C00` | 鈫?| `#F59E0B` / `#D97706` | 姗欒壊绯诲垪 |
| `#E91E63` | 鈫?| `#F43F5E` | 寮傚父鍊?|
| `#000000` (shadow) | 鈫?| `#0F172A` | 闃村奖搴曡壊 |

---

## 8. 鍗犱綅鍐呭瑙勮寖 (Placeholder Content Strategy)

鏃㈢劧杩欎簺 SVG 鏂囦欢鏄緵 AI 鍚庣画璋冪敤鐨勨€滄ā鏉库€濓紝瀹冧滑鐨勬牳蹇冧环鍊煎湪浜庡睍绀?**鍥惧舰缁撴瀯銆佹帓鐗堢害鏉熶笌瑙嗚绌洪棿**锛岃€屼笉鏄紶閫掔湡瀹炵殑涓氬姟鏁版嵁銆傚洜姝わ紝鍐欏叆妯℃澘鐨勬枃鏈唴瀹瑰簲閬靛惊浠ヤ笅鈥滃崰浣嶅師鍒欌€濓細

### 8.0 鍏ㄨ嫳鏂囧師鍒?(English-Only Rule)
**寮哄埗瑕佹眰**锛氭墍鏈夊浘琛ㄦā鏉夸腑鐨勫崰浣嶆枃鏈紙鍖呮嫭鏍囬銆佸壇鏍囬銆佸潗鏍囪酱銆佸浘渚嬨€佹暟鎹妭鐐广€佽鎯呮弿杩板強搴曢儴鏉ユ簮璇存槑锛?*蹇呴』鍏ㄩ儴浣跨敤鑻辨枃缂栧啓**銆?- **鐩殑**锛氱‘淇濆悗缁嚜鍔ㄥ寲绠＄嚎涓殑 LLM 鑳藉鏇寸簿鍑嗗湴杩涜璇箟鐞嗚В鍜岀粨鏋勫寲鍐呭鏄犲皠锛屽悓鏃惰嫳鏂囧崟璇嶇殑澶╃劧闀垮害鐗瑰緛鏇存槗浜庡湪妯℃澘涓睍绀烘帓鐗堟椂鐨勬崲琛岄€昏緫涓庣┖闂磋竟鐣屻€?
### 8.1 缁撴瀯杈圭晫婕旂ず
- **灞曠ず鏈€澶у搴?鎹㈣閫昏緫**锛氬埢鎰忎娇鐢ㄥ吀鍨嬮暱搴︾殑瀛楃涓诧紙濡備袱鍒颁笁涓瘝鐨勭煭璇€佸琛?`tspan`锛夋潵鏄庣‘灞曠ず鏂囨湰妗嗙殑杈圭晫銆傝繖鏍疯兘纭繚 AI 濉叆鐪熷疄鏂囨湰鏃舵湁鐩磋鐨勫弬鑰冿紝闃叉婧㈠嚭銆?- **灞曠ず鏁版嵁鏍煎紡**锛氫娇鐢ㄨ兘浣撶幇瀹屾暣鏍煎紡鐗瑰緛鐨勫崰浣嶆暟鍊硷紙濡?`$1,234.5M`銆乣98.5%`锛夎€屼笉浠呮槸绠€鍗曠殑 `10`锛屼互楠岃瘉绗﹀彿鍜屽瓧绗﹀搴︽槸鍚﹂€傞厤銆?
### 8.2 閫氱敤鎬т笌涓珛鎬?- 浣跨敤閫氱敤銆佷笓涓氱殑鍟嗕笟鍗犱綅绗︼紝閬垮厤杩囦簬鍨傜洿鎴栧叿璞＄殑鐗瑰畾涓氬姟鏁版嵁锛堥櫎闈炶妯℃澘鏈韩鍏锋湁寮虹儓鐨勮涓氬睘鎬э級銆?- **鎺ㄨ崘鍋氭硶**锛氫娇鐢?`Category A`銆乣Q1 Revenue`銆乣Strategic Objective`銆乣Phase 01`銆?- **閬垮厤鍋氭硶**锛氫娇鐢ㄥ叿浣撶殑闀跨瘒鐜板疄鏁版嵁锛堝鈥滄煇鏌愬搧鐗?023骞寸壒绉嶈澶囬攢閲忓垎鏋愨€濓級銆?
### 8.3 瑙嗚骞宠　
- 鍗犱綅鏂囨湰搴斿綋鍦ㄨ瑙変笂淇濇寔鍥捐〃鐨勫钩琛℃€э紙渚嬪铦磋澏鍥惧乏鍙虫枃鏈暱搴﹀簲澶ц嚧鐩哥瓑锛屽垪琛ㄦ枃鏈簲闀跨煭閿欒惤鏈夎嚧锛夛紝浠ヤ究璁╀汉涓€鐪肩湅娓呭浘琛ㄧ殑甯冨眬璁捐鎰忓浘銆?
---

## 9. 娉ㄥ唽鍒?charts_index.json

鏂板 SVG 妯℃澘鍚庯紝**蹇呴』** 鍦?[`charts_index.json`](./charts_index.json) 涓櫥璁帮紝鍚﹀垯 Strategist 閫夊瀷鏃朵笉浼氬彂鐜板畠銆?
### 9.1 鐧昏浣嶇疆

| 浣嶇疆 | 鏄惁蹇呭～ | 浣滅敤 |
|------|---------|------|
| `charts.<key>` | **蹇呭～** | 妯℃澘鑷韩鐨勫厓鏁版嵁锛坙abel / summary / keywords锛?|
| `categories.<group>.charts[]` | **蹇呭～** | 褰掑叆涓€涓涔夌被鍒紙comparison / trend / strategy 绛夛級 |
| `quickLookup.<intent>[]` | 瑙嗘儏鍐?| 褰撴ā鏉胯兘鏈嶅姟浜庢煇涓珮棰戞剰鍥炬椂鎸傚叆瀵瑰簲妗讹紙ranking / kpi / journey 绛夛級 |

### 9.2 瀛楁瑙勮寖

```json
"<key>": {
  "label": "<浜虹被鍙鍚嶇О>",
  "summary": "Pick for <鍐呭褰㈡€?+ 瑙勬ā>. Skip if <鍙嶄緥 鈫?鏇夸唬妯℃澘>.",
  "keywords": ["<鍚屼箟璇?/ 涓嫳鏂囧埆鍚?/ 琛屼笟鏈>"]
}
```

- **`key`** = SVG 鏂囦欢鍚嶅幓鎺?`.svg`锛屼笅鍒掔嚎灏忓啓锛堝 `bullet_chart`锛?- **`summary`** 鏄?*閫夊瀷鍙?*锛屼笉鏄弿杩板彞銆傝娉曡 `meta.summaryGrammar`锛氬厛璇翠粈涔堟椂鍊欓€夊畠锛屽啀鐢?`Skip if ... (use <other_key>)` 鎸囧悜鏈€瀹规槗娣锋穯鐨勫厔寮熸ā鏉?- **`keywords`** 鐢ㄤ簬鍏抽敭璇嶅尮閰嶏紝瑕嗙洊涓嫳鏂囧埆鍚嶄笌鍏稿瀷涓氬姟鍦烘櫙璇?
### 9.3 鍙嶄緥

鉂?鍙啓"鏄粈涔?锛歚"summary": "Bidirectional comparison chart for two datasets"`
鉁?鍐?浣曟椂閫?锛歚"summary": "Pick for two mirrored datasets sharing a common axis (age pyramid, A/B). Skip for >2 sides (use grouped_bar_chart)."`

鉂?鍙斁杩?`charts.<key>` 鑰屽繕璁?`categories` 鈥斺€?杩欐牱妯℃澘浼?瀛ゅ効鍖?锛孲trategist 娴忚绫诲埆鏃剁湅涓嶅埌瀹冦€?
---

## 10. 妫€鏌ユ竻鍗?
鏂板鎴栦慨鏀瑰浘琛ㄥ悗锛岄€愰」妫€鏌ワ細

### 鍩虹鏍￠獙
- [ ] `xmllint --noout` 閫氳繃
- [ ] viewBox 涓?`0 0 1280 720`
- [ ] 棣栬涓虹櫧鑹茶儗鏅?`<rect width="1280" height="720" fill="#FFFFFF"/>`

### 鑹插僵
- [ ] 鏃犳棫鑹叉畫鐣欙紙`grep` 楠岃瘉锛岃涓嬫柟鍛戒护锛?- [ ] 闃村奖 `flood-color` 涓?`#0F172A`锛宱pacity 灏忎簬绛変簬 0.20
- [ ] 鏁版嵁鏉ユ簮鐢?`#94A3B8`

### 鎺掔増
- [ ] 鏃?`font-size < 12` 鐨勬枃鏈?- [ ] 鎵€鏈?`<text>` 鍐呭鍖呰９ `<tspan>`
- [ ] 鍚屼竴琛屽鏍煎紡鐢ㄥ唴鑱?`<tspan>`锛?*闈?*澶氫釜骞舵帓 `<text>`
- [ ] 鍐呰仈 `<tspan>` 涓嶆惡甯?`x` / `y` / `dy`
- [ ] 鏍囬 34px銆佸壇鏍囬 18px銆佹潵婧?14px

### 缁撴瀯
- [ ] 涓昏鍏冪礌鏈夎涔夊寲 `<g id="...">`
- [ ] 鏃?`<style>`銆乣class`銆乣<foreignObject>`銆乣mask`銆乣rgba()`
- [ ] `<g>` 鏍囩鏃?`opacity` 灞炴€?- [ ] 鏂囨湰瀛楃涓哄師鐢?Unicode锛坄鈥擿 `漏` `鈫抈 NBSP 绛夛級锛屾棤 HTML 鍛藉悕瀹炰綋锛坄&nbsp;` `&mdash;` `&copy;` 绛夛級锛涜８ `& < >` 宸茶浆涔変负 `&amp; &lt; &gt;`

### 闃村奖
- [ ] 浣跨敤 `feFlood` 鏂规锛堥潪 `feComponentTransfer`锛?- [ ] 鍚岄〉闃村奖 `dx`/`dy` 鏂瑰悜涓€鑷?- [ ] 姣忛〉甯﹂槾褰卞厓绱犱笉瓒呰繃 3 涓?
### 娉ㄥ唽锛堜粎鏂板妯℃澘鏃讹級
- [ ] `charts_index.json` 鐨?`charts.<key>` 宸茬櫥璁?label / summary / keywords
- [ ] `summary` 鍐欐垚閫夊瀷鍙ワ紙`Pick for ... Skip if ... (use <other>)`锛夛紝涓嶆槸鎻忚堪鍙?- [ ] 宸插姞鍏?`categories.<group>.charts[]` 涓悎閫傜殑绫诲埆
- [ ] 鑻ユ湇鍔′簬楂橀鎰忓浘锛屽凡鍔犲叆 `quickLookup.<intent>[]`

### 鍧愭爣鏍″噯鏍囪锛坈alculator-supported 鍥捐〃蹇呭～锛?- [ ] 鐭╁舰鍧愭爣绯诲浘琛紙bar / horizontal_bar / grouped_bar / stacked_bar / line / area / stacked_area / scatter / waterfall / pareto / butterfly锛夊寘鍚?`<!-- chart-plot-area: x_min,y_min,x_max,y_max -->` 鏍囪
- [ ] Pie / donut / radar 鍥捐〃鍖呭惈 `<!-- chart-plot-area: <type> | center: cx,cy | radius: r -->` 鏍囪
- [ ] 鏍囪浣嶄簬 `<g id="chartArea">` 鍐呫€佸潗鏍囪酱涔嬪悗銆佹暟鎹厓绱犱箣鍓?- [ ] 鍧愭爣鍊间笌杞寸嚎鐨勫疄闄?SVG 鍧愭爣涓€鑷?
### 楠岃瘉鍛戒护
```bash
# 涓€閿牎楠?f="your_chart.svg"
xmllint --noout "skills/slides-creator/templates/charts/$f" && echo "XML OK" || echo "XML FAIL"
echo "Old colors:" && grep -c '#2C3E50\|#7F8C8D\|#95A5A6\|#5D6D7E\|#000000' "skills/slides-creator/templates/charts/$f"
echo "Small fonts:" && grep -c 'font-size="[0-9]"' "skills/slides-creator/templates/charts/$f"
```
