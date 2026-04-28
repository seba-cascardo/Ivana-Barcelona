# Asset Pipeline — Ivana Barcelona

> Documento vivo. Última actualización: 2026-04-28 (Phase 0 — esqueleto inicial).

## 1. Workflow general

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  Concept    │ →  │  Aseprite   │ →  │  Export PNG │ →  │  Godot      │
│  (sketch,   │    │  (pixel     │    │  (con strip │    │  (import +  │
│   moodbrd)  │    │   art work) │    │   si anim)  │    │   uso)      │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
                                              │
                                              ▼
                                       Aseprite Wizard
                                       plugin parsea
                                       frames a SpriteFrames
```

## 2. Pixel art — Aseprite

**Tool**: Aseprite (~$20 pago) o LibreSprite (fork OSS gratis).

**Settings recomendados**:
- New file: 32×48 (personaje), 96×128 (portrait), 480×270 (background).
- Color mode: RGBA.
- Background: transparent.
- Pixel ratio: 1:1.
- Color palette: cargar paleta canónica del proyecto (TBD,
  `assets/sprites/_palette.gpl`).

**Naming en Aseprite**:
- 1 archivo `.aseprite` por personaje/locación.
- Layers nombrados: `body`, `face`, `hair`, `accessories`, `shadow`, etc.
- Tags por animación: `idle`, `talk`, `walk`, `surprise`, etc.

**Export**:
- File → Export Sprite Sheet.
- Sheet type: *Horizontal strip* o *Packed*.
- JSON data: ON (genera metadata para Aseprite Wizard plugin de Godot).
- Output:
  - `.png` → `assets/sprites/<carpeta>/<nombre>.png`
  - `.json` → al lado del PNG.
- Source `.aseprite` → committearlo en la misma carpeta (LFS).

## 3. Backgrounds de ciudad

Estructura por background:

```
assets/sprites/locations/<ciudad>_<lugar>/
├── bg_full.aseprite        ← source con todas las layers
├── bg_layer_bg.png         ← lejano (sky, sun)
├── bg_layer_mid.png        ← medio (edificios distantes)
├── bg_layer_fg.png         ← cercano (props, gente)
└── bg_composite.png        ← fallback no-parallax
```

Rendering en Godot:
- 3-4 `Sprite2D` o `ParallaxLayer` con velocidades distintas.
- ParallaxBackground si la cámara se mueve.
- Estático con sub-pixel jitter sintético si la cámara no se mueve (opcional).

## 4. Import a Godot

### Sprites individuales
1. Drag PNG a `assets/sprites/...`.
2. Click PNG en FileSystem → tab *Import*:
   - Texture: Filter = `Nearest`.
   - Mipmaps: `Off`.
   - Repeat: `Off` (a menos que sea tile).
3. Re-import.

### Sprites animados (con Aseprite Wizard plugin)
1. Instalar plugin **Aseprite Wizard** desde AssetLib o git.
2. Project → Tools → *Aseprite Wizard* → seleccionar `.aseprite`.
3. Plugin genera `SpriteFrames` resource automáticamente.
4. Asignar `SpriteFrames` a `AnimatedSprite2D` en escena.

### Audio
1. Drag `.ogg` o `.wav` a `assets/audio/...`.
2. Para `.ogg` musicales: Import tab → Loop = `On` (si aplica).
3. `.wav` chico: import como AudioStreamWAV (default).

### Fonts
1. Drag `.ttf` a `assets/fonts/`.
2. Import tab → en `FontFile`:
   - `Antialiasing` = `None` (pixel-perfect).
   - `Subpixel positioning` = `Disabled` (pixel-perfect).
   - `Force Auto-hinter` = off.

## 5. Naming conventions

- **snake_case** en file names: `ivana_portrait_neutral.png`.
- **Carpetas** por entity: `ivana/`, `buenos_aires_telmo_bar/`.
- **Sufijos**:
  - `_idle`, `_talk`, `_walk` → animaciones.
  - `_neutral`, `_smug`, `_surprise` → expresiones.
  - `_layer_fg`, `_layer_mid`, `_layer_bg` → parallax layers.
  - `_source.aseprite` → opcional, pero clarifica que es source.

## 6. Pixel-perfect — checklist por asset

Antes de aceptar un asset en main:
- [ ] Filter = Nearest en import.
- [ ] No subpixel positioning (sprites alineados a enteros).
- [ ] Tamaño es múltiplo o coherente con grilla 16/32/48.
- [ ] No anti-aliasing residual del software de origen.
- [ ] No drop-shadow blur — usar pixel shadow dibujado.
- [ ] En context (Godot scene): se ve crisp, sin smearing.

## 7. Compresión y peso

Target: **APK final < 100 MB** (sino Google Play obliga a usar AAB
con asset packs, complica deploy).

Estrategias:
- **PNG**: usar `pngquant` o similar para comprimir lossy con calidad 80-90%.
- **OGG**: quality 5-6 para música, quality 3-4 para SFX largos.
- **Texturas grandes**: considerar atlas con TexturePacker / Godot built-in atlas.
- **Audio loopable corto**: preferir loops bien diseñados de 30-60s sobre tracks largos.

## 8. Registro de atribuciones (third-party assets)

Cualquier asset NO original debe registrarse acá. Formato:

```markdown
### <nombre del asset>
- **Source**: <URL>
- **Author**: <name>
- **License**: <CC0 / CC-BY / CC-BY-SA / etc.>
- **Used in**: <ruta al archivo en repo>
- **Modifications**: <none / cropped / palette-shifted / etc.>
- **Date added**: YYYY-MM-DD
```

### *(actualmente vacío — no third-party assets en Phase 0)*

## 9. Sourcing — recursos comunes

| Tipo | Sitio | Licencias típicas |
|---|---|---|
| Sprites/tiles libres | OpenGameArt.org | CC0, CC-BY |
| Itch.io packs | itch.io/game-assets | Var (revisar caso a caso) |
| Música libre | Freesound.org | CC0, CC-BY |
| SFX | Freesound.org, sfxr (generador) | CC0 |
| Fuentes pixel | Managore (m5x7, m6x11) — gratuitas | CC-BY o personal-use |
| Paletas | lospec.com/palette-list | Generalmente libres |

**Verificar siempre licencia exacta antes de incluir**.

## 10. Versionado de assets binarios (Git LFS)

Los binarios pesados van por LFS (configurado en `.gitattributes`).
Verificar que un asset entró por LFS:

```bash
git lfs ls-files
# Debe listar el archivo binario.
```

Si no aparece, hay un misconfig en `.gitattributes`. **Antes de commit**:

```bash
git check-attr filter <ruta-al-asset>
# Debe devolver: <ruta>: filter: lfs
```

## 11. Open questions / TBD

- ¿Aseprite o LibreSprite como tool oficial recomendada?
- ¿Tenemos ya un artist de pixel para comisionar Phase 1, o el usuario hace los assets?
- ¿Compositor de música — TBD.
- ¿Strategy de atlasing: por escena, por personaje, global?
- ¿Generamos 2x/3x previews para PRs en GitHub o el ojo crisp es suficiente?
