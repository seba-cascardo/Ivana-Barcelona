# Ivana Barcelona

> Un juego de detectives para Android — homenaje moderno a *Carmen Sandiego* —
> donde perseguís a la criminal más enigmática del mundo a través de
> ciudades, acentos y modismos. Pixel art retro modernizado, narrativa
> Disco-Elysium-style, gameplay de deducción real.

**Estado del proyecto**: 🌱 *Phase 0 — Cimientos*

---

## ¿De qué va?

Sos detective de una agencia internacional. Ivana Barcelona es la criminal
más escurridiza de la historia. Cada caso te lleva por el mundo: hablás con
informantes, identificás landmarks, leés mentiras, conectás pistas en tu
murder board, emitís órdenes de captura, y al final la confrontás con tus
skills de **Geografía**, **Cultura**, **Empatía** y **Lógica**.

No hay quiz repetitivo: cada NPC tiene personalidad, cada pista exige
deducción real, cada ciudad se siente como un lugar — no una postal.

## Stack

| | |
|---|---|
| **Engine** | Godot 4.x (GDScript) |
| **Render** | Pixel art retro modernizado, viewport `480×270`, snap-to-pixel |
| **Plataformas** | Android (APK) + Windows (testing/desarrollo) |
| **Idioma** | Español argentino (estructura i18n-ready) |
| **Licencia** | MIT (código) + CC-BY-SA 4.0 (assets propios) |

## Cómo correr el proyecto

### Requisitos
- **Godot 4.x** ([descargar](https://godotengine.org/download))
- **JDK 17** (sólo para builds de Android)
- **Android SDK + Build Tools + Platform Tools + NDK** (sólo para builds de Android)

### Windows / desarrollo
1. Cloná este repo: `git clone <url-del-repo>`
2. Abrí Godot 4 y elegí *Import* → seleccioná `project.godot`.
3. Apretá `F5` para correr la escena principal.

### Android / APK
1. Instalá JDK 17 y Android SDK.
2. En Godot: `Editor → Editor Settings → Export → Android` y seteá los paths.
3. `Project → Export → Add… → Android` → configurar.
4. *Export Project* → genera `.apk` debug.
5. Instalar en device con USB debugging habilitado:
   `adb install <ruta-al-apk>`

## Estructura del proyecto

```
ivana-barcelona/
├── docs/                 # Game design, narrative, style guides, pipeline
├── scenes/               # .tscn por área (main, world_map, city, dialogue, ui, cutscenes)
├── scripts/              # GDScript (autoloads, core, data, ui, minigames)
├── assets/               # Sprites, fuentes, audio, shaders
├── data/                 # Casos, ciudades, sospechosos, NPCs (Resources / JSON)
├── localization/         # Tablas de strings (es-AR; futuro multi-idioma)
└── addons/               # Plugins de Godot (Dialogic, Aseprite Wizard, etc.)
```

## Roadmap (alto nivel)

- **Phase 0** — Cimientos (repo, project, docs, build pipeline). ← *Estamos acá.*
- **Phase 1** — Vertical Slice: 1 caso end-to-end, 3 ciudades, captura final.
- **Phase 2** — Pipeline de contenido: sistema data-driven, ~30 ciudades.
- **Phase 3** — Difficulty & Replayability: procedural cases, skill tree, achievements.
- **Phase 4** — Polish & Ship: música original, cinemáticas, listing en stores.

Plan completo y vivo en `docs/game-design.md`.

## Contribuir

Por ahora es un proyecto-pasión personal pero abierto en GitHub. Si te
interesa colaborar (pixel art, música, narrativa, gameplay), abrí un issue
o discusión.

Convenciones rápidas:
- Commits en español, conventional-commits style (`feat:`, `fix:`, `docs:`,
  `chore:`).
- PRs con descripción clara y screenshots/gifs si tocan UX.
- GDScript con type hints estrictos.
- Strings de UI/diálogo siempre vía `tr()` y declarados en
  `localization/strings.csv`.

## Licencias

- **Código**: MIT (ver `LICENSE`).
- **Assets propios**: CC-BY-SA 4.0.
- **Assets de terceros**: registro de atribuciones en `docs/asset-pipeline.md`.

---

*Hecho con cariño desde Buenos Aires, con ayuda de Claude (Anthropic).*
