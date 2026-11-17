# RetroArch para Wii U (Aroma)

Este branch traz o suporte ao **Aroma** (o ambiente de homebrew atual do Wii U)
para o RetroArch atual. Ele parte do trabalho do PR
[libretro/RetroArch#14925](https://github.com/libretro/RetroArch/pull/14925)
(port para o toolchain **wut**, carregamento de núcleos, menu HOME, libmocha),
atualizado para o código de novembro de 2026 e testado em hardware.

> Status: testado num Wii U com Aroma. NES (FCEUmm) e SNES (Snes9x)
> funcionando com som, troca automática de núcleo, menu HOME e "Sair"
> pelo menu HOME.

---

## 1. Estrutura do cartão SD

No RetroArch, o cartão SD aparece como `sd:/`. A estrutura completa:

```
SD:\
├── wiiu\
│   └── apps\
│       └── retroarch.wuhb              ← o lançador (Salamander + assets do menu)
│
├── retroarch\
│   ├── retroarch.cfg                   ← configuração (criada no 1º uso)
│   ├── retroarch-salamander.cfg        ← último núcleo usado (o lançador lê)
│   ├── cores\
│   │   ├── *_libretro.rpx              ← NÚCLEOS (um .rpx por núcleo)
│   │   ├── info\
│   │   │   └── *_libretro.info         ← INFO DOS NÚCLEOS (obrigatório, ver §2)
│   │   ├── system\                     ← BIOS (ex.: disksys.rom, scph5501.bin)
│   │   ├── savefiles\                  ← saves da memória do cartucho (.srm)
│   │   ├── savestates\                 ← save states
│   │   ├── playlists\                  ← listas de jogos por console
│   │   ├── logs\                       ← logs (se "log em arquivo" estiver ligado)
│   │   └── temp\                       ← cache temporário
│   ├── database\
│   │   └── rdb\
│   │       └── *.rdb                   ← BANCO DE DADOS (para escanear jogos, ver §3)
│   ├── thumbnails\                     ← capas/imagens dos jogos
│   ├── config\                         ← opções por núcleo/jogo
│   │   └── remaps\                     ← remapeamento de controles
│   ├── autoconfig\                     ← perfis de controle
│   ├── overlays\
│   ├── filters\
│   ├── screenshots\
│   └── downloads\
│
└── roms\                               ← sugestão: uma pasta por console,
    ├── Nintendo - Nintendo Entertainment System\     com o nome oficial
    ├── Nintendo - Super Nintendo Entertainment System\
    └── Sony - PlayStation\
```

As pastas dentro de `retroarch\` que não existirem são criadas pelo RetroArch
no primeiro uso. As que **você** precisa colocar estão nas seções abaixo.

### Pasta das ROMs

O RetroArch abre jogos de **qualquer pasta**. O nome da pasta não afeta o
reconhecimento. Usar os nomes oficiais da libretro (como acima) é só uma
convenção que combina com os bancos de dados, as listas e as capas.

Formatos: o RetroArch abre `.zip` sozinho e passa o jogo de dentro para o
núcleo. Para PlayStation, `.chd` é o formato recomendado.

---

## 2. Arquivos de informação dos núcleos (`.info`) — obrigatório

Sem eles, o RetroArch **não sabe que extensões cada núcleo abre**: a ROM não
é associada a nenhum núcleo, e o navegador de arquivos pode esconder os jogos.

- **Origem:** <https://github.com/libretro/libretro-core-info>
- **Destino:** `SD:\retroarch\cores\info\`
- Copie um `.info` para cada núcleo `.rpx` instalado (mesmo nome:
  `snes9x_libretro.rpx` ↔ `snes9x_libretro.info`).

O script de empacotamento já faz isso se você passar `INFO_DIR` (ver §5).

> Depois de adicionar ou trocar `.info`, se algo não aparecer, apague
> `SD:\retroarch\cores\info\core_info.cache`. O RetroArch recria o cache.

---

## 3. Banco de dados (`.rdb`) — para escanear e listar os jogos

Usado por **Importar Conteúdo → Escanear Pasta**: o RetroArch compara cada
ROM com o banco e monta uma lista por console, com o nome certo do jogo e as
capas.

- **Origem:** <https://github.com/libretro/libretro-database/tree/master/rdb>
- **Destino:** `SD:\retroarch\database\rdb\`
- Baixe só os consoles que você usa. No PowerShell:

```powershell
$base = "https://raw.githubusercontent.com/libretro/libretro-database/master/rdb"
foreach ($n in "Nintendo - Nintendo Entertainment System",
               "Nintendo - Super Nintendo Entertainment System",
               "Sony - PlayStation") {
  Invoke-WebRequest "$base/$([uri]::EscapeDataString($n)).rdb" -OutFile "$n.rdb"
}
```

Hacks e traduções (ROMs modificadas) não estão no banco: não entram nas
listas, mas abrem normalmente por **Carregar Conteúdo**.

---

## 4. BIOS

Vão em `SD:\retroarch\cores\system\`. Exemplos:

| Console | Arquivo | Necessário? |
|---|---|---|
| Famicom Disk System (FCEUmm) | `disksys.rom` | só para jogos de disquete |
| PlayStation (PCSX ReARMed) | `scph5501.bin` (EUA) | recomendado |

---

## 5. Como compilar (Windows)

### Requisitos

- [devkitPro](https://devkitpro.org/wiki/Getting_Started) com **devkitPPC**,
  **wut** e **wut-tools** (testado com devkitPPC r50 / GCC 16.1, wut 1.9.1).
- git.

As compilações rodam no shell MSYS2 do devkitPro. No PowerShell, use
`C:\devkitPro\msys2\usr\bin\bash.exe -lc "<comando>"`.

### Correções nos núcleos

- **PCSX ReARMed** (repositório separado, mudanças locais ainda não enviadas
  ao projeto oficial):
  - `libpcsxcore/lightrec/mem_wiiu.c`: o recompilador (Lightrec) grava o
    código gerado na área oficial de *codegen* do Cafe OS (`0x01800000`,
    32 MiB, núcleo 1), alternando escrita/execução com
    `OSSwitchSecCodeGenMode` (`lightrec_wiiu_code_write` em
    `deps/lightrec/lightrec.c`). O endereço antigo (`0x00802000`) colidia com
    o Aroma: dava `ISI: Bad execute` e travava na troca de jogo. Casts
    explícitos para o GCC ≥ 14.
  - `libpcsxcore/gte.c`: `gteMVMVA` lia as matrizes na ordem errada em
    big-endian (polígonos faltando e linhas gigantes na tela).
  - `plugins/gpulib/gpu_async.c` (Threaded Rendering): barreira `sync` no
    PowerPC e registros `ex_regs` convertidos para little-endian.
  - `Makefile.libretro`: threads do Cafe OS (`rthreads`) para o desenho em
    segundo plano; a thread de desenho vai para o núcleo 2.

### Passos

```sh
# 1. Núcleos: compile cada um com platform=wiiu (gera <nome>_libretro_wiiu.a)
cd libretro-fceumm && make -f Makefile.libretro platform=wiiu -j$(nproc)
cd snes9x/libretro && make platform=wiiu -j$(nproc)
cd pcsx_rearmed && make -f Makefile.libretro platform=wiiu -j$(nproc)

# 2. Copie os .a para RetroArch/dist-scripts/ e baixe os assets do menu:
#    https://buildbot.libretro.com/assets/frontend/assets.zip  -> dist-scripts/assets.zip

# 3. Empacote (Salamander + .wuhb + um .rpx por núcleo + .info)
cd RetroArch/dist-scripts
INFO_DIR=/caminho/para/libretro-core-info sh ./wiiu-cores.sh
```

Resultado em `RetroArch/pkg/wiiu/`, já na estrutura do cartão SD:
`wiiu/apps/retroarch.wuhb` e `retroarch/cores/*.rpx` + `retroarch/cores/info/*.info`.

Para testar só a compilação do RetroArch, sem núcleo:

```sh
powerpc-eabi-ar rc libretro_wiiu.a        # arquivo de núcleo vazio
make -f Makefile.wiiu SALAMANDER_BUILD=1
make -f Makefile.wiiu HAVE_STATIC_DUMMY=1
```

---

## 6. Log e depuração

O RetroArch manda o log **pela rede (UDP, porta 4405)**, através do módulo de
log do Aroma. O log chega mesmo se o console travar, o que não acontece com o
log em arquivo.

1. Wii U e PC na mesma rede.
2. No PC, rode `pkg/wiiu/escutar-log.ps1`. Ele salva tudo em `udp-log.txt` e
   mostra na tela. Permita o acesso no Firewall do Windows.
3. Para mais detalhe, no `retroarch.cfg`: `frontend_log_level = "0"` (debug).
4. Deixe `log_to_file = "false"`. Com o log em arquivo ligado, nada sai pela
   rede.

> O log em arquivo (`cores\logs\retroarch.log`) fica com **0 bytes** se o
> console travar: no cartão FAT, o tamanho do arquivo só é gravado quando o
> arquivo é fechado.

---

## 7. Limitações conhecidas

- **Threads desligadas** (`HAVE_THREADS ?= 0` no `Makefile.wiiu`), como no PR
  original. Com threads ligadas, o áudio ficava mudo e o console reiniciava na
  troca de núcleo e no HOME, porque havia threads ainda vivas na saída do
  processo. Sem threads não há **sincronização na nuvem** nem o pipeline de
  áudio em thread.
- **Não use "Atualizar Núcleos"** no menu online. Ele baixa os núcleos do
  build oficial, que são para o Tiramisu, não para esta build.
- **PlayStation: "Threaded Rendering" vem desligado.** Com o desenho em
  outra thread o desempenho melhora (Tekken 3: de ~43 para ~55 fps), mas
  alguns jogos travam o console. O Need for Speed 3 trava no menu, mesmo com
  o recompilador desligado; o CTR roda bem. Por isso, no Wii U, o padrão e o
  modo `auto` ficam desligados. Para testar por jogo: Menu rápido → Opções do
  núcleo → Threaded Rendering → `enabled`.
- **PlayStation: dicas de desempenho.** Deixe o recompilador ligado
  (`pcsx_rearmed_drc = "enabled"`, padrão). Desligar o *dithering* e o vsync
  ajuda nos jogos mais pesados.
- **Áudio do PlayStation.** O AX do Wii U agora toca 44100 Hz direto
  (conversão de taxa feita pelo DSP), então use `audio_out_rate = "44100"` e
  `audio_resampler = "cc"` no `retroarch.cfg` (com `nearest` o som piorou).
- **HD externo:** só partição **FAT32** é lida para ROMs. A partição no
  formato do Wii U não é lida.

---

## 8. Diferenças em relação ao RetroArch oficial

Além do PR #14925 (port para wut/Aroma), este branch inclui:

| Área | Mudança |
|---|---|
| Inicialização | `memory.c` usa `__init_wut_thread` (wut ≥ 1.9 removeu `__init_wut_malloc_lock`) |
| Threads | Desligadas no Wii U; `newlib_locks.c` fora do build (o wut já fornece as travas do newlib) |
| TLS | Cache por thread do `data_transfer.c` desligado no Wii U (o formato RPX não aceita relocações TLS) |
| Áudio (AX) | `wait_writable` não devolve mais 0 com a voz parada (isso deixava o pipeline em thread em silêncio) |
| Vídeo (GX2) | Só espera a GPU (`GX2DrawDone`) em primeiro plano: "Sair" pelo HOME travava o console |
| Botões | A confirma e B volta por padrão (layout Nintendo) |
| Opção HOME | "Allow Wii U HOME menu" no formato novo de opções (`settings/settings_def_input_wiiu_hbm.h`) |
| Cloud sync | Só é ativada quando há threads (antes era ligada pelo sistema que compila) |
| Áudio (AX) | Aceita taxas de 22050 a 48000 Hz: o DSP converte (`AXSetMultiVoiceSrcRatio`) |
| Empacotamento | `wiiu-cores.sh` inclui os `.info` (`INFO_DIR`), usa `bsdtar` se faltar `unzip` e guarda o `.elf` de cada núcleo em `dist-scripts/elf/` (símbolos para ler endereços de travamentos) |
