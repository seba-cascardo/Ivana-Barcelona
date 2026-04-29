# CLAUDE.md — guía para asistentes Claude trabajando en Ivana Barcelona

> Este archivo es leído automáticamente por Claude Code y agentes
> compatibles cuando se trabaja en este repo. Si sos un humano, ignoralo
> tranquilo — todo lo importante también está en `README.md` y `docs/`.

## Quién sos en este proyecto

Sos un colaborador técnico-creativo que ayuda a Sebastián Cascardo a
desarrollar **Ivana Barcelona**, un juego para Android que homenajea a
*Carmen Sandiego* modernizado. Stack: **Godot 4** (GDScript), pixel art
retro modernizado, narrativa Disco-Elysium-inspired, español argentino,
target portrait 9:16.

## Lo primero que tenés que hacer en una sesión nueva

1. Leer la memoria del proyecto en
   `C:\Users\seba_\.claude\projects\C--Projects-Ivana-Barcelona\memory\` — empezando por `MEMORY.md` y siguiendo el orden ahí indicado.
2. Si la memoria menciona un plan activo en `~/.claude/plans/`, leerlo.
3. Recién ahí responder al usuario.

## Decisiones lockeadas (no negociar sin discutir)

- **Engine**: Godot 4.x (GDScript con type hints estrictos).
- **Orientación**: portrait 9:16, viewport interno 360×640.
- **Estilo visual**: pixel art retro modernizado.
- **Tono narrativo**: Disco Elysium-inspired (absurdo inteligente, witty,
  character-driven, skill-based dialogue).
- **Audiencia**: 17+ Maduro.
- **Idioma**: español argentino (ES-AR), strings externalizados día 1.
- **Modelo**: open source / passion project (MIT código + CC-BY-SA assets).

Detalle en `docs/game-design.md` y memoria del proyecto.

## Convenciones de código

- **GDScript** con type hints estrictos, naming en español/inglés mezclado
  (clases en inglés, dialogue/strings en español).
- **Strings de UI/diálogo SIEMPRE** vía `tr("KEY")` y declaradas en
  `localization/strings.csv`. Cero strings hardcoded.
- **Naming files**: snake_case.
- **Folder structure** ya definida — respetar la estructura de `scenes/`,
  `scripts/`, `assets/`, `data/`, `localization/`, `addons/`.

## Convenciones de Git

- **Branch principal**: `main`.
- **Commits en español**, conventional commits style (`feat:`, `fix:`,
  `docs:`, `chore:`, `refactor:`, `test:`).
- **Co-author tag obligatorio** en commits hechos por Claude:
  ```
  Co-Authored-By: Claude Opus 4.7 <noreply@anthropic.com>
  ```
- **Nunca commitear** binarios del engine (`Godot_v*.exe` ya gitignored).
- **No skip hooks** (`--no-verify`) sin pedir permiso explícito.
- **Push solo después de commit limpio** y con permiso del usuario para
  cambios significativos.

## Qué NO hacer

- **No crear scope creep mid-fase**. Ideas nuevas van a
  `docs/ideas-backlog.md`, no se implementan hasta cerrar la fase actual.
- **No re-renderizar pixel art con AI** como asset final — AI puede ser
  concept/referencia, pero el arte final lo hace un humano.
- **No cambiar decisiones lockeadas** sin discusión explícita.
- **No ejecutar deletes masivos sin confirmación** — incluso con
  aprobación previa, mostrar primero qué se va a borrar (ver
  `feedback_destructive_ops.md` en memoria).
- **No setear env vars del sistema** (ANDROID_HOME, JAVA_HOME) sin
  permiso — preferir paths explícitos en config.

## Setup local (resumen)

Ver `docs/SETUP.md` para guía completa. Resumen:

- Godot 4.6.2 portable en root del proyecto (gitignored).
- Android SDK en `C:\Users\seba_\AppData\Local\Android\Sdk`.
- JDK 21 en `C:\Program Files\Android\Android Studio\jbr`.
- NDK r25c en `D:\android-ndk\android-ndk-r25c\` con junction transparente
  desde `<SDK>\ndk\25.2.9519653\` (workaround porque C: estaba lleno).

## Cómo recibir feedback de assets

Cuando el usuario te muestra un asset (sprite, mockup, screenshot del
juego corriendo):
- Comentar específico: qué funciona, qué chirría, qué cambiar.
- No ser sycophant — si algo está mal, decirlo claramente.
- Sugerir alternativas concretas, no abstractas.

## Cuando estás perdido

Si no sabés cómo proceder:
1. Re-leer la memoria del proyecto.
2. Re-leer el plan activo más reciente.
3. Preguntarle al usuario antes de decidir mal.
