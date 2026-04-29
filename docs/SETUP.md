# Setup — Ivana Barcelona

> Cómo dejar el proyecto corriendo en tu máquina local.
> Última actualización: 2026-04-28 (Phase 0 — handoff inicial).

Esta guía cubre: requisitos, instalación, primer run en Windows, y
build de APK Android. Si algo falla, ver sección 6 (troubleshooting).

---

## 1. Requisitos — estado actual (verificado 2026-04-29)

### Mínimos (sólo para correr en Windows)
| Tool | Versión recomendada | Status local |
|---|---|---|
| **Godot 4** | 4.4+ (4.6.2 OK) | ✅ **4.6.2 stable** en `C:\Projects\Ivana Barcelona\Godot_v4.6.2-stable_win64.exe` (portable en root, gitignored) |
| **Git** | 2.40+ | ✅ 2.49.0 |
| **Git LFS** | 3.0+ | ✅ inicializado |

### Adicionales (para build de APK Android)
| Tool | Versión | Status local |
|---|---|---|
| **JDK** | 17+ (Godot pide 17, JDK 21 funciona en práctica) | ✅ **OpenJDK 21.0.5** bundled en `C:\Program Files\Android\Android Studio\jbr\` |
| **Android SDK** | API 33+ | ✅ en `C:\Users\seba_\AppData\Local\Android\Sdk` |
| **Build Tools** | 33+ | ✅ 30.0.3, 35.0.0, 35.0.1, 36.0.0 |
| **Platforms** | android-33+ | ✅ android-33, android-35 |
| **Android NDK** | r25c+ | ✅ r25c (25.2.9519653) — instalado en `D:\android-ndk\android-ndk-r25c\` con junction transparente desde `<SDK>\ndk\25.2.9519653\` |
| **adb** (platform-tools) | última | ✅ 35.0.2 |
| **Android Studio** | (opcional, útil) | ✅ instalado |

### Lo que falta para cerrar Phase 0
- Validar F5 en Godot con viewport 360×640 portrait (pixel-perfect crisp).
- Configurar Godot → Editor Settings → Export → Android con paths.
- Primer build APK debug.

### Paths para configurar en Godot Editor Settings
Cuando abras el Editor → `Editor Settings → Export → Android`:
- **Android SDK Path**: `C:\Users\seba_\AppData\Local\Android\Sdk`
- **Java SDK Path**: `C:\Program Files\Android\Android Studio\jbr`
- **Debug Keystore**: dejar que Godot genere automático en primer export

---

## 2. Instalación paso a paso

### 2.1. Godot 4

1. Descargar el binario portable de https://godotengine.org/download
   - Elegir **Standard** (no .NET — usamos GDScript).
   - Plataforma: Windows 64-bit.
2. Descomprimir en, por ejemplo, `C:\Tools\Godot\`.
3. (Opcional pero recomendado) Agregar al PATH para usar `godot` en CLI:
   - Settings → System → Advanced system settings → Environment Variables.
   - Agregar `C:\Tools\Godot\` al `Path` del usuario.
4. Verificar: `godot --version` debe imprimir `4.x.x.stable`.

### 2.2. Git LFS

```bash
git lfs install
```

Una vez por máquina. Habilita el filtro LFS en tus repos.

Verificar: `git lfs --version`.

### 2.3. JDK 17 (sólo para Android)

Recomendado: **Eclipse Temurin 17** (https://adoptium.net/).

1. Descargar el `.msi` instalador para Windows x64.
2. Instalar; activar la opción "Set JAVA_HOME variable".
3. Verificar:
   ```bash
   java -version
   echo $JAVA_HOME    # bash
   echo %JAVA_HOME%   # cmd
   ```

### 2.4. Android SDK (sólo para Android)

Opción A — Android Studio (recomendada para principiantes):
1. Descargar de https://developer.android.com/studio.
2. Durante setup, instalar:
   - Android SDK Platform 34.
   - Android SDK Build-Tools 34.0.0.
   - Android SDK Platform-Tools.
   - Android NDK (Side by side).
3. SDK queda típicamente en `C:\Users\<user>\AppData\Local\Android\Sdk`.

Opción B — Command-line tools:
1. Descargar `commandlinetools-win-*.zip` de developer.android.com.
2. Descomprimir en `C:\Android\sdk\cmdline-tools\latest\`.
3. Setear `ANDROID_HOME=C:\Android\sdk` (env var).
4. Instalar componentes:
   ```bash
   sdkmanager "platforms;android-34" "build-tools;34.0.0" "platform-tools" "ndk;25.2.9519653"
   ```

### 2.5. Instalar Android NDK

> **Heads-up sobre disco**: el NDK pesa ~2GB extraído. Si tu C: tiene poco espacio, instalalo en otro drive y hacé junction al path esperado por el SDK (estrategia que usamos en esta máquina porque C: está lleno).

#### Opción A — Android Studio GUI (la más fácil si C: tiene ≥3GB libres)
1. Abrir Android Studio.
2. **Settings → Languages & Frameworks → Android SDK** (o **More Actions → SDK Manager** desde welcome).
3. Tab **SDK Tools** → marcar **NDK (Side by side)**.
4. Apply → instalar.

Versión recomendada: `r25c` (numeric: `25.2.9519653`) — battle-tested con Godot 4.x.

#### Opción B — CLI vía `sdkmanager` (requiere `JAVA_HOME` seteado)
```powershell
$env:JAVA_HOME = "C:\Program Files\Android\Android Studio\jbr"
$env:PATH = "$env:JAVA_HOME\bin;$env:PATH"
& "C:\Users\seba_\AppData\Local\Android\Sdk\cmdline-tools\latest\bin\sdkmanager.bat" "ndk;25.2.9519653"
```

Si C: no tiene espacio, sdkmanager se cortará mid-extract. En ese caso usar Opción C.

#### Opción C — NDK en otro drive + junction (workaround para C: lleno)
Lo que hicimos en esta máquina:
1. Descargar NDK directo desde Google a un drive con espacio (ej. D:):
   ```powershell
   Invoke-WebRequest -Uri "https://dl.google.com/android/repository/android-ndk-r25c-windows.zip" -OutFile "D:\android-ndk\android-ndk-r25c-windows.zip"
   Expand-Archive -Path "D:\android-ndk\android-ndk-r25c-windows.zip" -DestinationPath "D:\android-ndk\" -Force
   ```
2. Crear junction al path donde el SDK lo espera:
   ```cmd
   mklink /J "C:\Users\seba_\AppData\Local\Android\Sdk\ndk\25.2.9519653" "D:\android-ndk\android-ndk-r25c"
   ```
3. Verificar:
   ```bash
   ls "C:\Users\seba_\AppData\Local\Android\Sdk\ndk"
   # Debería mostrar: 25.2.9519653 (el junction)
   cat "C:\Users\seba_\AppData\Local\Android\Sdk\ndk\25.2.9519653\source.properties"
   # Debería mostrar la versión real
   ```

Godot, Gradle y sdkmanager ven la junction como si fuera un directorio normal — todo funciona transparente.

### 2.6. Configurar Godot para Android

1. Abrir Godot Editor (`Godot_v4.6.2-stable_win64.exe`).
2. **Editor → Editor Settings → Export → Android**:
   - **Android SDK Path**: `C:\Users\seba_\AppData\Local\Android\Sdk`
   - **Java SDK Path**: `C:\Program Files\Android\Android Studio\jbr`
   - **Debug Keystore**: dejar vacío inicialmente (Godot genera uno automático en primer export).

---

## 3. Clonar y abrir el proyecto

```bash
# Clonar (cuando exista remote — ver sección 5)
git clone <url-del-repo> "C:\Projects\Ivana Barcelona"
cd "C:\Projects\Ivana Barcelona"

# Si el remote no existe aún, ya tenés el proyecto local en
# C:\Projects\Ivana Barcelona\

# Activar Git LFS para este repo
git lfs install --local
git lfs pull
```

Abrir en Godot:
1. Godot Editor → **Import**.
2. Seleccionar `C:\Projects\Ivana Barcelona\project.godot`.
3. Click *Import & Edit*.

Godot va a generar la carpeta `.godot/` automáticamente con caches —
esa carpeta está ignorada en `.gitignore` (es local).

---

## 4. Primer run

### 4.1. Windows (instantáneo, sin emulador)

Con el proyecto abierto en Godot:
1. `F5` o botón ▶️ "Play".
2. Si pregunta *"There is no main scene set"*, debería tomar `scenes/main/main.tscn` automáticamente. Si no, *Project → Project Settings → Application → Run → Main Scene*.
3. Debería abrirse una ventana 1920×1080 con:
   - Fondo morado oscuro.
   - Título "IVANA BARCELONA" en ámbar.
   - "Build 0.0.1 — Phase 0 cimientos".
   - Hint: "presioná ESPACIO para verificar pixel-perfect".

**Test pixel-perfect**: presionar ESPACIO toggle un overlay de grilla.
La grilla debe verse limpia, con cada celda escalada a integer múltiple
del píxel interno (en 720×1280 dev window = scale ×2 sobre 360×640).

### 4.2. Android — APK debug

Con SDK + JDK configurados:
1. *Project → Export… → Add… → Android*.
2. Configurar:
   - **Architectures**: `arm64-v8a` (mayoría de devices modernos), opcional `armeabi-v7a` (devices viejos).
   - **Package → Unique Name**: `com.cascardo.ivana.barcelona` (o lo que prefieras).
   - **Permissions**: ninguno por ahora (Phase 0).
3. *Export Project (Debug)* → genera `.apk` en la ruta que elijas (ej. `builds/ivana-barcelona-debug.apk`).
4. Instalar en device:
   ```bash
   adb install builds/ivana-barcelona-debug.apk
   ```
5. Abrir la app en el device. Debería ver lo mismo que en Windows,
   adaptado a la pantalla del teléfono.

---

## 5. GitHub remote (opcional pero recomendado)

El repo está inicializado localmente pero **no tiene remote aún**.
Cuando quieras crearlo:

### Opción A — `gh` CLI (rápido)
```bash
cd "C:\Projects\Ivana Barcelona"
gh repo create ivana-barcelona --public --source=. --remote=origin --description "Detective game homenaje a Carmen Sandiego — Godot 4, pixel art, ES-AR"
git push -u origin main
```

### Opción B — manual (web)
1. Ir a https://github.com/new.
2. Nombre: `ivana-barcelona`. Visibility: Public. **No** inicializar con README/license/gitignore (ya los tenemos).
3. Crear repo.
4. Localmente:
   ```bash
   git remote add origin https://github.com/<tu-user>/ivana-barcelona.git
   git push -u origin main
   ```

---

## 6. Troubleshooting

### "Godot dice: Project file is corrupt"
- Probable causa: edité `project.godot` a mano y Godot no le gustó algún campo.
- Solución: backup del archivo, abrir en Godot, dejá que regenere los campos faltantes, comparar y mergear.

### "Android export falla: No SDK path"
- Verificar `Editor → Editor Settings → Export → Android → Android SDK Path` apunta a un dir válido.
- Verificar `JAVA_HOME` está seteado y apunta a JDK 17.

### "No keystore"
- Primera vez: dejá que Godot genere el debug keystore automático.
- Si no genera, crear manual:
  ```bash
  keytool -keyalg RSA -genkeypair -alias androiddebugkey -keypass android -keystore debug.keystore -storepass android -dname "CN=Android Debug,O=Android,C=US" -validity 9999
  ```
  Apuntar `Debug Keystore` en Editor Settings a este archivo.

### "Pixel art se ve borroso"
- Verificar `Project Settings → Rendering → Textures → Canvas Textures → Default Texture Filter = Nearest`.
- Verificar `Project Settings → Rendering → 2D → Snap → Snap 2D Transforms to Pixel = ON`.
- En el sprite individual: Inspector → CanvasItem → Texture → Filter = `Nearest with Mipmaps` o `Nearest`.

### "APK > 100 MB"
- Comprimir audio (`.ogg` quality 5 en lugar de 8).
- Atlas las texturas (TexturePacker o Godot built-in atlas).
- Si sigue grande: usar **AAB** (Android App Bundle) en lugar de APK,
  que permite asset packs (sólo Google Play los soporta).

### "git push falla con LFS errors"
- `git lfs install` (una vez por máquina).
- Verificar `.gitattributes` está commiteado (lo está).
- Si push falla: `git lfs push origin main --all`.

---

## 7. Próximos pasos después de Phase 0

Cuando todo lo de arriba ande, cerramos Phase 0 con este checklist:

- [ ] Godot 4 instalado y `godot --version` funciona.
- [ ] Proyecto abre en Editor sin errores rojos.
- [ ] `F5` corre la escena "Hola Ivana" en Windows con pixel-perfect.
- [ ] JDK 17 + Android SDK + NDK instalados.
- [ ] APK debug se exporta sin errores.
- [ ] APK instala y corre en device físico (o AVD).
- [ ] Test ESPACIO en device: grilla pixel-perfect crisp.
- [ ] (Opcional) Remote en GitHub creado y push exitoso.

Si algo de esto falla, lo investigamos antes de pasar a Phase 1.

Phase 1 es **vertical slice de un caso completo** — ver `docs/game-design.md`.
