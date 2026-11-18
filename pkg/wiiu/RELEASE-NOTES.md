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

### Cores included / Núcleos incluídos (21)
| System | Core | Tested on hardware |
|---|---|---|
| NES / Famicom Disk System | FCEUmm, Nestopia | ✅ (FDS: use Nestopia) |
| SNES | Snes9x, Snes9x 2010 | ✅ Snes9x |
| PlayStation | PCSX ReARMed (Lightrec) | ✅ most games 50–60 fps |
| Mega Drive / Master System / 32X / Mega-CD | Genesis Plus GX, PicoDrive | ✅ |
| Game Boy / Color | Gambatte, Gearboy | ✅ |
| Game Boy Advance | VBA Next | ✅ |
| PC Engine / CD | Beetle PCE Fast | ✅ |
| WonderSwan / Color | Beetle Cygne | ✅ |
| Neo Geo Pocket / Color | Beetle NeoPop | ✅ |
| MSX / MSX2 / ColecoVision | blueMSX | ✅ |
| Arcade | FB Alpha 2012, MAME 2003-Plus | ✅ |
| Virtual Boy | Beetle VB | not yet |
| Atari 2600 / Lynx | Stella 2014, Handy | not yet |
| DOOM / Cave Story | PrBoom, NXEngine | not yet |

### What works / O que funciona
- Runs on current Aroma; HOME menu, exit and switching games work.
- A confirms, B goes back (Nintendo layout).
- PlayStation: dynamic recompiler in the official codegen area, big-endian graphics fixes, threaded SPU (sound on core 0).
- Audio tuned for the Wii U (44.1 kHz through the AX DSP, rate control on).

### Known issues / Problemas conhecidos
- **PlayStation "Threaded Rendering"** is off by default: it speeds some games up (Tekken 3, CTR) but hangs others (Need for Speed III). Enable it per game in Core Options if you want to try.
- Sound can stutter when a PlayStation game drops below 60 fps.
- **FinalBurn Neo is not included**: the full core is too big for the Wii U loader and hangs. Use FB Alpha 2012 or MAME 2003-Plus for arcade games. Neo Geo CD needs FBNeo, so it is not available yet.
- Do **not** use the online Core Updater: official cores are not built for this version.
- External drives: FAT32 only.

### Report a problem / Relatar problema
Open an issue with the game, the core and, if possible, a UDP log (`escutar-log.ps1` in the zip; see the guide).
