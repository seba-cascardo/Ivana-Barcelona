# Art Style Guide — Ivana Barcelona

> Documento vivo. Última actualización: 2026-04-28 (Phase 0 — esqueleto inicial).

## 1. Dirección visual general

**Pixel art retro modernizado**.
- Inspiración clara en Carmen Sandiego original (1985).
- Calidad y técnicas modernas (lighting, parallax, animación rica, palette curada).

Referencias clave:
- **Eastward** — paletas saturadas, escenas atmosféricas, sprite work expresivo.
- **Sea of Stars** — pixel art con lighting moderno, escala HD.
- **Octopath Traveler 2D-HD** — depth-of-field, efectos modernos sobre pixel.
- **Chained Echoes** — pixel art legible a alta densidad de info.
- **Disco Elysium** — *NO* para visual (es ilustrado), sí para portraits expressivos.

## 2. Resolución y escalado

- **Viewport interno**: `360 × 640` (9:16 **PORTRAIT**).
- **Estrategia**: integer scaling, snap-to-pixel, filtro Nearest.
- **Orientation**: portrait (phone-in-hand, target principal).
- **Targets de output**:
  - 1080×1920 (FHD portrait): scale ×3 → 1080×1920. ✅
  - 1440×2560 (QHD portrait): scale ×4 → 1440×2560. ✅
  - 1080×2400 (FHD+ 20:9 portrait): scale ×3 con letterbox vertical leve. ⚠️
  - PC dev: ventana 720×1280 (2× del viewport), simula form factor del device.

**Por qué portrait 360×640**: target real es phone-in-hand. Toda la UI
(pasaporte, murder board con pistas apiladas, diálogo con portrait arriba
+ texto abajo) es naturalmente vertical. Carmen Sandiego clásico era
landscape pero estaba en PC; nosotros somos mobile-first.

**Por qué 360×640 específicamente**: 9:16 puro escala perfecto a phones
1080p y 1440p. Densidad suficiente para portrait + diálogo legible
(~40 chars por línea con font 9px), sprites de personajes 32×48 al
tercio de altura.

## 3. Palette base

**TBD — definir paleta canónica en Phase 0/1**.

Recomendación inicial: paleta limited (~32-48 colores) tipo *Endesga 32*
o *Pico-8 plus* extendida, con sub-paletas por bioma:

- **Buenos Aires nocturno**: morados, ámbar, granate.
- **Mediterráneo**: azules, blancos, ocres.
- **Trópico**: verdes saturados, naranjas, fucsias.
- **Tundra/norte**: cianes desaturados, blancos, púrpuras fríos.
- **Desértico**: arenas, rojos óxido, amarillos.

**Acción Phase 0**: elegir/crear la paleta base y guardarla en
`assets/sprites/_palette.png` o `.gpl` (GIMP palette format,
compatible Aseprite).

## 4. Sprite specs

### Personajes (gameplay sprite)
- Tamaño base: **32×48 px** (cabeza + cuerpo en 3/4 view).
- Frames de animación:
  - Idle: 4 frames @ 6 fps.
  - Talk: 2 frames @ 4 fps (lipsync simple).
  - Walk (futuro): 8 frames @ 12 fps.

### Portraits (diálogo Disco-Elysium-style)
- Tamaño base: **96×128 px** o **128×160 px** (alta resolución pixel).
- 1 frame estático + variaciones de expresión (neutral, sorpresa, mentira-detectada, ríe).
- 2-4 expresiones por personaje principal.

### Backgrounds de ciudad
- Tamaño base: **360×640 px** (cubre el viewport portrait entero) o
  **360×480** si la mitad inferior la ocupa la UI de diálogo.
- Composición: foreground + midground + background con parallax vertical
  o lateral según escena.
- Iluminación bakeada en la imagen (no dynamic lights en MVP).

### UI elements
- Iconografía: **16×16 px** o **32×32 px**.
- Frames de paneles: 9-slice scaling.
- Tipografía: pixel-perfect, ver sección 6.

## 5. Animación

- **12 fps** baseline (clásico animation).
- Idle loops siempre con 2-4 frames mínimo (nunca estático completo —
  se siente muerto).
- Animation Player de Godot para coreografías compuestas.

## 6. Tipografía

**TBD — elegir/comisionar 2 tipografías**:

1. **Sans-serif pixel** para HUD/UI/labels.
   - Refs: m5x7, m6x11 (managore), Departure Mono pixel.
   - Tamaño base: **8 px** o **10 px**.

2. **Serif pixel** para diálogos/portraits.
   - Refs: Old School Adventure, PrintChar21, Pixelify Sans.
   - Tamaño base: **10 px** o **12 px**.

Subpixel positioning: **off** (ya configurado en `project.godot`).

## 7. Lighting y efectos

Permitido (modernización):
- **Parallax** layers en backgrounds.
- **Lighting bakeado** en backgrounds (sombras suaves dibujadas a mano).
- **Particles** pixel art (lluvia, polvo, luciérnagas, humo).
- **Post-processing sutil**: vignette tenue, dither shader opcional, no CRT por default (toggle en accessibility).
- **Dynamic lights 2D** (Godot Light2D) — usar selectivamente, no abusar.

Evitar:
- Smoothing/blur (rompe pixel-perfect).
- Bloom agresivo.
- HDR (innecesario para 2D).
- CRT scanlines on by default (gusto adquirido; ofrecer como toggle).

## 8. Naming conventions de assets

```
assets/sprites/
├── characters/
│   ├── ivana/
│   │   ├── ivana_portrait_neutral.png
│   │   ├── ivana_portrait_smug.png
│   │   ├── ivana_sprite_idle.png
│   │   └── ivana.aseprite          (source)
│   ├── detective/
│   └── npc_<id>/
├── locations/
│   ├── buenos_aires_telmo_bar/
│   │   ├── bg.png
│   │   ├── bg_layer_fg.png
│   │   ├── bg_layer_mid.png
│   │   └── bg_layer_bg.png
│   └── ...
├── ui/
│   ├── hud_passport_frame.png
│   ├── icon_clue.png
│   └── ...
└── icons/
    └── app_icon_1024.png
```

Reglas:
- snake_case en file names.
- Carpeta por personaje/locación.
- `.aseprite` source convive con `.png` exportados.
- Sufijos descriptivos: `_idle`, `_talk`, `_neutral`, `_layer_fg`.

## 9. Pipeline de import a Godot

Ver `asset-pipeline.md` para detalle. Resumen:
1. Trabajás en Aseprite.
2. Exportás `.png` (con strip si animado).
3. Plugin **Aseprite Wizard** o equivalente importa a Godot con frames.
4. Godot import: Filter = Nearest, Mipmaps = off, Repeat = off.

## 10. Open questions / TBD

- Paleta canónica final.
- 2 tipografías finales (sans + serif pixel).
- ¿Usamos Light2D dinámico o todo bakeado?
- ¿Shader CRT toggle por default off / on?
- ¿Cuántas expresiones de portrait por personaje principal?
- ¿Estilo de "transiciones" entre escenas (cut, fade, wipe pixelado)?
