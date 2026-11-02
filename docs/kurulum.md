# EzGUI 3.0 — kurulum ve kullanım

Tek gereksinim: **Minecraft Java 1.21.1** sunucu veya tek oyunculu dünya.
Mod, kütüphane veya ön paket yok — her şey bir datapack.

---

## 1. Kurulum

### 1.1 Dosyaları indir

PR birleştikten sonra (`dev` dalı) ya da doğrudan fork dalından:

```bash
git clone -b feat/1.21.1-guigen https://github.com/ToolkitMC/EzGUI.git
```

Datapack için sadece iki şey gerekir:

```
data/          → tüm fonksiyonlar, item modifier'lar, predicate'ler
pack.mcmeta    → pack_format 48/57 (1.21.1)
```

`tools/`, `docs/`, `README.md` datapack'in çalışması için gerekli **değil**;
sadece menü üretmek/lint için lazım.

### 1.2 Dünyaya koy

Dünya klasörünün içine `datapacks/ezgui/` olarak kopyala:

```
<dünya>/datapacks/ezgui/pack.mcmeta
<dünya>/datapacks/ezgui/data/...
```

Sunucuda aynısı: `world/datapacks/ezgui/`. Çalışırken de kopyalayabilirsin, sonra:

```
/reload
```

Tek oyunculu dünyada: kaydet → `datapacks/` klasörüne at → `/reload`
(veya `/datapack enable "file/ezgui"`).

### 1.3 Doğrula

`/reload` çıktısında hata olmamalı ve sohbette şu satırı görmelisin:

```
[EzGUI] loaded — /trigger ezgui.open
```

Ek kontroller:

```
/datapack list                 → file/ezgui  (enabled)
/function ezgui:core/load      → elle yeniden bootstrap
```

Bir şey bozulduysa ilk bakılacak yer `/reload` log'u; paket lint'ten geçmediyse
şu komut hangi dosyanın kuralı çiğnediğini söyler (Node 18+ gerekir):

```bash
cd tools && npm install && npx tsx src/lint.ts ../data
```

### 1.4 Bu depoda hazır test sunucusu

Workspace'te 1.21.1 sunucusu zaten çalışıyor ve paket ona deploy edilmiş durumda:

```bash
cd /home/user && ./harness/lib/deploy.sh     # data/ → mc/server/world/datapacks/ezgui
node harness/probe/reload_errors.js          # reload + hata taraması
node harness/test/e2e.js                     # 17 uçtan uca kontrol (bot ile)
```

---

## 2. Oyuncu tarafı kullanım

Paket kurulduğu an herkesin kullanabileceği 4 trigger var:

| Komut | Ne yapar |
| --- | --- |
| `/trigger ezgui.open` | Varsayılan menüyü (hub) açar |
| `/trigger ezgui.close` | Açık menüyü kapatır |
| `/trigger ezgui.last` | En son açılan menüyü yeniden açar |
| `/trigger ezgui.save` | Editörde yapılan yerleşim değişikliğini kaydeder |

Gelen menü, oyuncunun kendi **chest minecart'ıdır** (her oyuncuya ayrı, kalıcı
`ezgui.pid` ile). İçine tıklarsın; paket tıklamayı "slot artık benim damgamı taşımıyor"
diye anlar, aksiyonu çalıştırır ve menüyü yeniden boyar.

Menü kendiliğinden kapanır: `timer` (varsayılan 72000 tick = 1 saat) dolar, ESC'ye
basıp kapatırsın veya container'ı kırarsın — üç durumda da container sökülür,
widget eşyaları envantere sızmaz.

### Paketle gelen menüler

| Menü | Nasıl açılır | İçinde ne var |
| --- | --- | --- |
| Hub | `/trigger ezgui.open` | Shop, Settings, Editor, Balance, Close |
| Shop | Hub → Shop | puan maliyeti (`ezgui.coins`), eşya maliyeti (2 wheat), elde boş olma koşulu, 2 sn cooldown, ilerleme çubuğu |
| Settings | Hub → Settings | toggle (ses), sayaç (pin 0–5), cycle (tema), radio (reach) |
| Editor | Hub → Editor | sayfa yakalama ve kaydetme |

Para testi için:

```
/scoreboard players set <oyuncu> ezgui.coins 100
```

(`ezgui.coins` ilk açılışta `hooks/on_open_main` tarafından 100'e ayarlanır.)

---

## 3. Kendi menünü yapmak

İki yol var; ikisi de aynı `ezgui:defs` verisini üretir.

### 3.1 Oyun içi (kod yazmadan)

1. Hub → **Editor** (menü 4). Bu sayfa `editable:1b` olarak işaretli.
2. Container'ın içine istediğin eşyaları koy — her dolu slot bir widget olur.
3. **Save layout** (lime dye, slot 25) ya da `/trigger ezgui.save`.
4. Tanımı dışa al:

```
/data get storage ezgui:defs menus.4
```

Editörün yazdığı şey `ezgui:defs` storage'ıdır ve bu storage dünyayla birlikte
kaydedilir (`world/data/command_storage_ezgui.dat`) — yani sunucuyu kapatıp açsan da
orada durur. **Ama** her `/reload` ve her açılışta `menu/defs.mcfunction` çalışıp
paketle gelen menüleri (1–4) yeniden merge eder; bu yüzden *yerleşik* menülerde
editörle yaptığın değişiklik bir sonraki reload'da üretilen hâline döner. Kalıcı
olması için iki seçenek:

* düzeni `tools/menus/main.ts` içine taşı ve `npx tsx src/cli.ts` ile yeniden üret
  (sürüm kontrolüne girer — önerilen), veya
* kendi `data merge` dosyanı `defs.mcfunction`'dan **sonra** çalışacak şekilde
  `data/minecraft/tags/function/load.json` listesine ekle (kendi menülerin 1–4 ile
  çakışmadığı sürece).

Kendi menünü (ör. id 10) editörle kuruyorsan çakışma olmaz: reload onu silmez,
sadece paketle gelen id'lere dokunur.

> Not: Editör *yerleşimi* kaydeder (eşya, isim, lore, slot). Maliyet/koşul/aksiyon
> gibi davranışlar tanımda kalır — bunları 3.2'deki gibi TS tarafında veya
> `/data modify storage ezgui:defs ...` ile eklersin.

### 3.2 TypeScript ile (önerilen, sürüm kontrolüne girer)

`tools/menus/main.ts` içindeki listeye yeni bir menü ekle:

```ts
import { buildPack, mkText, type MenuSpec, type PackSpec } from "../src/core/build.ts";

const QUEST: MenuSpec = {
  id: "quests",                       // örnek: /trigger ezgui.open yerine op:{open:"quests"}
  display: "Quests",
  container: { entity: "minecraft:chest_minecart", y: 1 },
  timer: 20 * 60 * 60,                // 1 saat
  init: ["ezgui.quest_stage"],        // açılışta 0'a seed edilen score'lar
  pages: [
    {
      index: 0,
      name: "Görevler",
      widgets: [
        // düz buton: 3 coin öder, 4 bread verir, ses çalar
        {
          slot: 10,
          item: "minecraft:bread",
          name: mkText("Bread × 4", { color: "gold" }),
          lore: [mkText("Fiyat: 3 coin", { color: "gray" })],
          cost: [{ score: "ezgui.coins", n: 3, fail: mkText("3 coin lazım.", { color: "red" }) }],
          ops: [{ give: "minecraft:bread", n: 4 }, { sound: "minecraft:entity.villager.yes" }],
        },
        // toggle: ezgui.snd score'unu 0/1 çevirir
        {
          slot: 12,
          item: "minecraft:bell",
          score: "ezgui.snd",
          kind: "toggle",
          options: [
            { item: "minecraft:bell", name: mkText("Ses: KAPALI", { color: "gray" }) },
            { item: "minecraft:bell", name: mkText("Ses: AÇIK", { color: "green" }), glint: true },
          ],
          ops: [{ toggle: "ezgui.snd" }],
        },
        // başka menüye geçiş
        { slot: 22, item: "minecraft:arrow", name: mkText("Geri", {}), ops: [{ open: "main" }] },
      ],
    },
  ],
};
```

Sonra üret ve doğrula:

```bash
cd tools
npm install                  # ilk seferde
npx tsx src/cli.ts           # defs.mcfunction + gen/* + item modifier'lar yeniden yazılır
npx tsx src/lint.ts ../data  # macro kuralları: 0 hata beklenir
```

Deploy → `/reload` → menüyü aç.

### Widget türleri

| `kind` / alan | Ne yapar | Sürücü score |
| --- | --- | --- |
| düz buton (`ops` var) | tıklanınca aksiyonlar | — |
| `kind: "toggle"` + `score` | iki durum (off/on) | 0 / 1 |
| `kind: "cycle"` + `score` | N durat arasında döner | 0…N-1 |
| `kind: "radio"` + `score` + `value` | seçili değer eşleşince işaretli | karşılaştırma |
| `kind: "progress"` + `score` + `max` + `cells` | skora göre dolan bar | 0…max |
| `kind: "indicator"` + `states[].matches` | aralığa göre görünüm | herhangi |
| `kind: "label"` / `"separator"` | tıklanamaz, sadece görüntü | — |

Tür **tanımdan** gelir (`toggle:"ezgui.snd"`, `cycle:1b`, `radio:1b`, `progress:1b`
işaretleri), "score'u var mı" diye tahmin edilmez — bu yüzden bir sayacı yanlışlıkla
toggle gibi çizmez.

### Aksiyonlar (`ops`)

| Op | Parametre | Etki |
| --- | --- | --- |
| `{ open: "menu" }` | menü id/adı | o menüyü açar |
| `{ close: true }` | — | menüyü kapatır |
| `{ page: 1 }` | sayfa no | sayfa değiştirir |
| `{ toggle: "score" }` | score | 0↔1 çevirir |
| `{ add: 1, score, min, max }` | sayı | topla, aralığa sıkıştır |
| `{ set: 0, score }` | sayı | yaz |
| `{ give: "minecraft:x", n: 2 }` | eşya | envantere verir |
| `{ sound: "minecraft:..." }` | ses | çalar |
| `{ msg: "metin" }` | metin | sohbete yazar |
| `{ cmd: "/..." }` | komut | oyuncu olarak çalıştırır |
| `{ fn: "ns:func" }` | fonksiyon | kendi fonksiyonunu çağırır |
| `{ url, label }` | adres | tıklanabilir link |
| `{ draw: true }` | — | sayfayı yeniden boyar |

Maliyet (`cost`) ve koşul (`cond`/`fail`) tıklamadan **önce** toplu kontrol edilir;
biri tutmazsa hiçbir şey çekilmez.

---

## 4. Bakım notları

* **Reload güvenli:** açık menüler kapanır, `on_close` çalışır, sahipsiz container'lar
  boşaltılıp silinir, envanterde kalan widget eşyaları temizlenir.
* **1.21.1 macro kuralı:** bir fonksiyonun `$(...)` değişkenleri çağrı anındaki
  snapshot'tan okunur; aynı çağrı içinde yazdığın değeri göremez. Bu yüzden paket
  "hesapla" ve "yaz" adımlarını ayrı dosyalara böler — kendi fonksiyonunu yazarken de
  aynı kurala uy (`docs/3.0-runtime.md`).
* **Lint her zaman çalışsın:** eksik macro anahtarı tek satırı değil, o çağrının
  tamamını sessizce iptal eder; lint bunu deploy'dan önce yakalar.
* **Sürüm:** `pack.mcmeta` 1.21.1 (`pack_format 48`, `supported_formats 48–57`).
  1.21.5+ için `click_event`/`custom_data` alanları değişir; `op_link.mcfunction`
  içinde tek yerde toplanmış durumda.
