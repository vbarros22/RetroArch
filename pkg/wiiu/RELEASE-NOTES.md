**Beta** build of RetroArch for the Wii U running **Aroma**. Unofficial: please report problems here, not to libretro.
*Versão beta do RetroArch para Wii U com Aroma. Não oficial: relate os problemas aqui, não ao libretro.*

### Install / Instalação
1. Extract `RetroArch-WiiU-Aroma.zip` to the root of the SD card (merge folders).
   *Extraia na raiz do cartão SD, mesclando as pastas.*
2. Put your BIOS files in `retroarch/cores/system/` (PlayStation: `scph5501.bin`).
   *Coloque as BIOS em `retroarch/cores/system/`.*
3. Launch **RetroArch** from the Wii U menu.
   *Abra o RetroArch pelo menu do Wii U.*

Full guide (Portuguese): `LEIA-ME-WiiU.md` in the zip.

### New in 0.3 / Novidades da 0.3
- **Close Content** no longer freezes the menu until a button is pressed.
  *"Fechar conteúdo" não trava mais o menu até apertar um botão.*
- **Ozone menu**: selection boxes are drawn again (only one corner showed, at the top left).
  *Menu Ozone: as caixas de seleção voltaram (só aparecia um canto, no alto à esquerda).*
- **CHD scanning**: PlayStation, Mega-CD and PC Engine CD games in `.chd` now reach the playlists.
  *Jogos em `.chd` de PS1, Mega-CD e PC Engine CD agora entram nas playlists.*
- **Genesis Plus GX**: exiting through HOME after a Mega-CD game no longer hangs the console.
  *Sair pelo HOME depois de um jogo de Mega-CD não trava mais o console.*
- **FinalBurn Neo** is back as two smaller cores, **Neo-Geo** (also Neo Geo CD) and **CPS-1/CPS-2**: the full core is too big for the Wii U.
  *O FinalBurn Neo voltou em dois núcleos menores, Neo-Geo (com Neo Geo CD) e CPS-1/CPS-2.*
- Big-endian fixes: **PC Engine** sprites were mirrored; **Neo Geo CD** music was distorted.
  *Sprites do PC Engine saíam espelhados; a música do Neo Geo CD saía estourada.*
- The menu selection bar no longer drifts after games with a rotated screen (WonderSwan, vertical arcade).
  *A faixa de seleção do menu não sai mais do lugar depois de jogos com tela girada.*

### Cores included / Núcleos incluídos (23)
| System | Core | Tested on hardware |
|---|---|---|
| NES / Famicom Disk System | FCEUmm, Nestopia | ✅ (FDS: use Nestopia) |
| SNES | Snes9x, Snes9x 2010 | ✅ |
| PlayStation | PCSX ReARMed (Lightrec) | ✅ most games 50–60 fps |
| Mega Drive / Master System / 32X / Mega-CD | Genesis Plus GX, PicoDrive | ✅ |
| Game Boy / Color | Gambatte, Gearboy | ✅ |
| Game Boy Advance | VBA Next | ✅ |
| PC Engine / CD | Beetle PCE Fast | ✅ |
| WonderSwan / Color | Beetle Cygne | ✅ |
| Neo Geo Pocket / Color | Beetle NeoPop | ✅ |
| Virtual Boy | Beetle VB | ✅ |
| MSX / MSX2 / ColecoVision | blueMSX | ✅ |
| Atari 2600 / Lynx | Stella 2014, Handy | ✅ (Lynx needs `lynxboot.img`) |
| Arcade | FB Alpha 2012, MAME 2003-Plus | ✅ |
| Neo Geo / Neo Geo CD | FinalBurn Neo (Neo-Geo) | ✅ |
| CPS-1 / CPS-2 | FinalBurn Neo (CPS-1/CPS-2) | ✅ |
| DOOM / Cave Story | PrBoom, NXEngine | ✅ |

### Known issues / Problemas conhecidos
- **Thumbnails do not download**: libretro's thumbnail server has been serving an empty index since 20 Nov 2026, for every platform. They will come back when the server does.
  *As capas não baixam: o servidor da libretro está vazio desde 20/11/2026, para todas as plataformas.*
- **PlayStation "Threaded Rendering"** is off by default: it speeds some games up (Tekken 3, CTR) but hangs others (Need for Speed III). Enable it per game in Core Options if you want to try.
- Sound can stutter when a PlayStation game drops below 60 fps.
- Hacks and translations are not added by the automatic scan (they are not in the database): use **Manual Scan**.
  *Hacks e traduções não entram pela busca automática: use a Busca manual.*
- PicoDrive takes longer than Genesis Plus GX to open Mega-CD games in CHD.
- Do **not** use the online Core Updater: official cores are not built for this version.
- External drives: FAT32 only.

### Report a problem / Relatar problema
Open an issue with the game, the core and, if possible, a UDP log (`escutar-log.ps1` in the zip; see the guide).
