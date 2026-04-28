# Audio Style Guide — Ivana Barcelona

> Documento vivo. Última actualización: 2026-04-28 (Phase 0 — esqueleto inicial).

## 1. Dirección sonora general

Sound design moderno, con guiños retro pero **sin chiptune puro
nostálgico**. La ambición es estar más cerca de:
- **Disco Elysium** — atmósferas inmersivas, jazzy, melancólicas.
- **Cuphead** — instrumentación viva (jazz, swing).
- **Sea of Stars / Chained Echoes** — orquestal-electrónico moderno.
- **Hotline Miami** — synth + pulse para tensión (selectivo).

**No** queremos:
- Chiptune NES limpio (sería un retro-fetiche pero no encaja con el
  pixel art moderno + tono Disco Elysium).
- Stock royalty-free obvio.

## 2. Música — tracks por categoría

| Categoría | Mood | Loop length | Notas |
|---|---|---|---|
| **Menu / Title** | Misterio elegante, signature de la franquicia | ~1:30 | Identifica el juego en 5 segundos. |
| **Mapamundi** | Curiosidad, viaje, atmospheric | ~2:00 | Loopable sin cuts notorios. |
| **Ciudad ambient** | Específico por bioma/ciudad (jazz BA, salsa Caribe, klezmer Estambul, etc.) | ~2:00 | Variantes culturales. |
| **Diálogo / investigación** | Sub-bed, no protagonista | ~1:30 | No tapa voz interna ni texto. |
| **Tensión / persecución** | Pulse, urgente | ~1:00 | Para tail/stake-out. |
| **Confrontación final** | Climax, dramático | ~2:00 | Por caso con variaciones. |
| **Captura exitosa** | Triunfo melancólico (Disco Elysium-coded, no power fantasy) | ~0:40 | Stinger. |
| **Captura fallida** | Bittersweet, no game-over agresivo | ~0:40 | Stinger. |

**Phase 1 mínimo**: Menu, Mapamundi, Ciudad (1 variante), Tensión, Captura exitosa.

## 3. SFX — categorías

### UI
- Click button (suave, no agresivo).
- Hover button.
- Open menu / passport.
- Close menu.
- Tab switch.
- Notification ping (pista nueva, info importante).

### Diálogo
- Letra-a-letra typewriter (suave, distinto por personaje opcional).
- Skill check success.
- Skill check failure.
- Internal voice cue (campanita sutil, distinta por skill).

### Mapa / viaje
- Click ciudad.
- Travel transition (avión? barco? abstracto?).
- Reloj tick (cuando el tiempo avanza).

### Ambient / locación
- Loops de ambient por bioma (lluvia, café, mercado, calle, bar).
- Pasos del detective (pixel-perfect en superficies distintas).

### Captura / final
- Warrant emitido (sello pesado).
- Captura exitosa (stinger).
- Captura fallida (stinger).

**Phase 1 mínimo**: ~30 SFX cubriendo UI + diálogo + 1 set ambient.

## 4. Voice acting

**MVP: NO**.
- Costo prohibitivo para passion project.
- Inconsistente con Disco Elysium reference (que sí tiene VO, pero post-game-arc).
- Texto + portraits + voz interna interna lograda con SFX sutiles
  (typewriter, internal cue) es suficiente.

**Futuro**: si el juego escala, considerar VO selectivo (solo Ivana en
confrontaciones finales? jefe en briefings?).

## 5. Mezcla y mastering

- **Música**: -18 LUFS integrated, peaks a -3 dBFS.
- **SFX**: peaks a -6 dBFS, headroom para layering.
- **Loops**: validar transiciones limpias en Audacity (no clicks).

Audio bus structure en Godot:
- Master
  - Music
  - SFX
  - UI
  - Voice (futuro)

## 6. Formato de archivos

- **Música**: `.ogg` Vorbis quality 5-6. Loopable con metadata `LOOP_START` / `LOOP_END` cuando aplique.
- **SFX**: `.wav` 16-bit 44.1 kHz para sounds cortos; `.ogg` para ambients largos.
- **Voice (futuro)**: `.ogg` Vorbis quality 4 (compresión más agresiva).

Naming: `category_subcategory_descriptor.ext`.
Ejemplos:
- `music_menu_main.ogg`
- `music_city_buenos_aires_night.ogg`
- `sfx_ui_click_soft.wav`
- `sfx_dialogue_typewriter_default.wav`
- `sfx_voice_internal_geografia.wav`

## 7. Sourcing — dónde conseguir audio

Dado que somos OSS / passion project:
1. **Original**: comisionar / componer (LMMS, Reaper, FamiTracker, Bosca Ceoil).
2. **CC0 / CC-BY**: Freesound.org, OpenGameArt, Itch.io free music packs.
3. **Licenciado individual**: si encontramos algo perfecto, comprar derecho de uso para juego comercial (aunque sea OSS).

Registro de atribuciones en `asset-pipeline.md`.

## 8. Open questions / TBD

- ¿Director musical? (componer todo nosotros vs comisionar a un músico).
- ¿Voz interna distinta acústicamente por skill? (ej. Empatía = voz cálida femenina, Lógica = voz seca masculina, Geografía = voz susurrada con eco, Cultura = voz teatral). **Recomendación**: explorar en Phase 2.
- ¿Música adaptativa (capas que entran/salen según tensión)? Ambicioso, ver en Phase 3.
- ¿Acentos regionales en SFX de ambient? (mercado mexicano vs napolitano).
