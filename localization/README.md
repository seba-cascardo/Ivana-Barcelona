# Localización

Toda string de UI/diálogo/narrativa debe vivir en `strings.csv` y referenciarse
en código vía `tr("KEY")`.

## Idioma actual

- **es** (Español argentino) — único idioma soportado en MVP.

## Cómo agregar una nueva string

1. Abrir `strings.csv` (text editor o Godot built-in CSV editor).
2. Agregar fila: `KEY_DESCRIPTIVE_UPPERCASE,texto en español`
3. Usar en código: `label.text = tr("KEY_DESCRIPTIVE_UPPERCASE")`

## Cómo agregar un nuevo idioma (futuro)

1. Agregar columna al CSV: `keys,es,en`
2. Traducir cada fila en la nueva columna.
3. Re-importar el CSV en Godot Editor (auto-detect).
4. Agregar el locale en `Project Settings → Internationalization → Locale`.

## Convenciones de keys

- `TITLE_*` — títulos de pantalla.
- `BUTTON_*` — texto de botones.
- `DIALOG_<NPC_ID>_<LINE_ID>` — líneas de diálogo de NPCs.
- `CASE_<CASE_ID>_*` — strings específicas de un caso.
- `SKILL_<SKILL_NAME>_*` — strings relacionadas a skills.
- `RANK_*` — rangos del detective.
- `HINT_*` — hints contextuales.

## Nota sobre interpolación

Para strings con variables, usar placeholders `{name}` y `format()`:

```gd
label.text = tr("WELCOME_DETECTIVE").format({"name": "Sebastián"})
```
