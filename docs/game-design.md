# Game Design Document — Ivana Barcelona

> Documento vivo. Última actualización: 2026-04-28 (Phase 0 — esqueleto inicial).

## 1. Pitch

Sos detective de una agencia internacional. Ivana Barcelona es la criminal
más escurridiza de la historia. Cada caso te lleva por el mundo: hablás
con informantes, identificás landmarks, leés mentiras, conectás pistas en
tu murder board, emitís órdenes de captura, y al final la confrontás con
tus skills de **Geografía**, **Cultura**, **Empatía** y **Lógica**.

No hay quiz repetitivo: cada NPC tiene personalidad, cada pista exige
deducción real, cada ciudad se siente como un lugar — no una postal.

## 2. Pilares de diseño

1. **Loop modernizado** (no quiz repetitivo)
2. **4 skills tipo Disco Elysium** (build variety real)
3. **Voz interna** del detective (personalidad sin avatar omnipresente)
4. **Difficulty escala estructuralmente**, no solo en tiempo/vidas
5. **Pixel art retro modernizado** con producción cuidada
6. **Tono argentino auténtico** (vos, modismos, ironía local)

## 3. Loop de juego (un caso)

1. **Briefing** — cinemática + diálogo interactivo con tu jefe.
   - Preguntas opcionales dan contexto extra y/o pistas tempranas.
2. **Mapamundi** — pixelado, animado, con clima/día-noche.
   - Click en ciudad → viaje. Reloj in-game corre con cada acción.
3. **Investigación en ciudad** — 3-5 hotspots con mecánicas variadas:
   - **Diálogo skill-check** estilo Disco Elysium.
   - **Identificación cultural** (música/comida/landmark/idioma) — escala con dificultad real.
   - **Mini-puzzle visual** de evidencia (matching, deducción de patrones).
   - **Stake-out / tail** stealth ligero.
4. **Pasaporte / Murder Board** — vos conectás las pistas (UI con hilos rojos
   pixel art). El juego no las conecta por vos.
5. **Orden de captura + viaje final** — equivocarse cuesta tiempo y reputación.
6. **Confrontación** — diálogo escalonado, skill checks, múltiples finales.

## 4. Las 4 Skills del Detective

| Skill | Define | Ejemplo de uso en diálogo |
|---|---|---|
| **Geografía** | Intuición territorial, lectura de paisaje, clima, urbanismo. | *"Esos zócalos son adoquines marselleses, no de Buenos Aires."* |
| **Cultura** | Memoria enciclopédica de música, comida, idiomas, historia, arte. | *"Esa canción la oíste en una cantina de Lisboa hace tres casos."* |
| **Empatía** | Lectura de personas, detección de mentiras, conexión emocional. | *"El sudor en su sien dice más que sus palabras."* |
| **Lógica** | Deducción, cross-referencing, rigor analítico. | *"Las tres pistas convergen como un teorema."* |

Cada skill influye qué opciones de diálogo se desbloquean, qué pistas
notás, y cómo resolvés puzzles. Suben con uso.

**Build variety**: una corrida con build "Empatía-max" se siente distinta
a una "Lógica-max". Esto es clave para replayability.

## 5. Voz interna del detective

Tipo Disco Elysium: micro-voces internas comentan situaciones según skills.
Ej:
> *Tu Geografía Brain susurra:*
> *"Estos zócalos son adoquines marselleses, no de Buenos Aires."*

Da personalidad al protagonista sin un avatar visible omnipresente.
Permite humor, autoconciencia y escalada narrativa.

**TBD**: cuántas voces (4 = una por skill? más sub-voces?). Iterar en Phase 1.

## 6. Difficulty Scaling REAL

| Rango | Ciudades/caso | NPCs | Pistas | Sospechosos | Tiempo | Otros |
|---|---|---|---|---|---|---|
| **Cadete** | 4-5 | Hablan claro, hint sobre opción correcta | Directas | 1, claro | Generoso | Quicksave libre |
| **Detective** | 6-8 | Ambiguos, requieren read | Cross-reference 2 ciudades | 2-3, distinguir | Justo | Quicksave entre ciudades |
| **Sargento** | 8-10 | Mienten/manipulan | Cross-ref 3+, distractor evidence | 4-5, profile similar | Apretado | Save sólo al cerrar caso |
| **Comisario** | Procedural | Adversariales | Pistas culturales profundas, requieren skills altas | 6+, ambiguos | Strict | Permadeath de rango |

## 7. Casos individuales + Meta-historia

- Cada caso es una misión completa (~1-2hs de juego).
- La cadena de casos va revelando la red criminal de Ivana Barcelona.
- **Final boss = captura de Ivana**, después de 10-15 casos.
- Casos extra post-captura para replay y completionists.

## 8. Roadmap

### Phase 0 — Cimientos (en curso)
Repo + project.godot + docs esqueletos + "Hola Ivana" + builds Win/APK.

### Phase 1 — Vertical Slice
1 caso Cadete end-to-end: 3 ciudades, ~3 NPCs, captura final. Valida
toda la arquitectura antes de escalar contenido.

### Phase 2 — Pipeline de contenido
Sistema data-driven, ~30 ciudades, variedad de mini-juegos pulidos.

### Phase 3 — Difficulty & Replayability
Procedural cases, skill tree, achievements, los 4 rangos diferenciados.

### Phase 4 — Polish & Ship
Música original, cinemáticas, testing en variedad de Android, listing en stores.

## 9. Open questions / TBD

- ¿Cuántas voces internas tiene el detective? (1 por skill o más?)
- ¿El detective tiene un nombre o sos genéricamente "el/la detective"?
- ¿Hay un partner/sidekick recurrente?
- ¿Sistema de "reputación" además de skills?
- ¿Cómo se guarda el progreso entre casos? (continuo vs caso-por-caso)
- ¿Confrontaciones finales tienen mecánica especial o son super-diálogos?
- ¿Hay variedad de "tipos de caso" (robo vs secuestro vs fraude)?

## 10. Referencias

- **Carmen Sandiego** (1985, Brøderbund) — el original que homenajeamos.
- **Disco Elysium** (2019, ZA/UM) — tono, skill checks, internal voice.
- **Eastward / Sea of Stars / Octopath Traveler 2D-HD / Chained Echoes** — estilo visual.
- **Return of the Obra Dinn** — deducción manual, murder board mental.
- **Where in the World is Carmen Sandiego (2015 reboot, Houghton Mifflin)** — antitécnica de qué *no* hacer (gameplay liviano).
