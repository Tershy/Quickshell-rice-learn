# AGENTS.md — Quickshell-rice-learn

Context file for AI agents working in this repository. Read this before making changes.

## Project purpose

Tershy is building a custom desktop environment on Arch Linux from scratch — with full understanding of every component, not by copying pre-made dotfiles. The primary goal is **learning** Quickshell, Hyprland, and Arch Linux internals through hands-on building. Repo: `Tershy/Quickshell-rice-learn`.

**Working style — read this before generating code:**
- **Explain *why*, not just *what*.** Concepts, mechanics, and documentation references ([quickshell.org/docs/v0.3.0](https://quickshell.org/docs/v0.3.0)) before or alongside code, never bare files or snippets without context.
- **Complete, copy-paste-ready code.** Never provide incomplete snippets with `// ...` shortcuts.
- **When asked to simplify or narrow scope, comply immediately without pushback.** Prototyping and simpler architectures win whenever requested.
- **Verify real system state before changes** (`pacman -Ql`, `grep`, `fc-list`, `git status`, etc.) rather than assuming.
- **Backup / commit before risky operations**, never after.
- **Work on topic branches**; open PRs via GitHub rather than local `git merge`.
- **When building multi-file features, explicitly wire components together.** If a component is extracted into its own file, reference and import it; do not duplicate logic inline "just in case." (See Known Pitfalls below.)
- **Language:** Communicate with Tershy in Polish; keep technical identifiers, types, links, and code in English.

---

## Hardware

Dell Vostro 3580:
- **CPU:** Intel Core i5-8265U (8 threads @ 3.90GHz)
- **GPU:** AMD Radeon R5 M435 (discrete) + Intel UHD 620 (integrated)
- **Storage & FS:** 237GB btrfs + Snapper + `limine-snapper-sync` + Limine bootloader
- **RAM:** **7.62GB RAM** (shared with local worker pools/Hermes)

**Low RAM is a real constraint:**
- Prefer `Loader` / `LazyLoader` for infrequently shown UI elements (popups, launchers, menus).
- Avoid source-built AUR packages where `-bin` variants exist (OOM compilation risk).
- Avoid GPU-heavy shaders (plain `Rectangle border` over custom fragment shaders).

---

## Stack

- **Arch Linux (rolling release)** + **Hyprland 0.56.0** (config in Lua: `hyprland.lua`, not hyprlang; main layout: `scrolling`)
- **Quickshell v0.3.0** (Qt6 language server: `/usr/bin/qmlls6`, formatter: `Delgan.qml-format` / `qmlformat`)
- **kitty** (opacity 0.6, font: `Maple Mono NF`) + **fish** (theme: `japanese-navy.theme`, `starship`) + **VS Code / VSCodium**
- **Browser:** Zen Browser
- **Network:** iwd + `impala` / `wlctl` (native Quickshell `Networking` service)
- **Audio:** PipeWire (`Quickshell.Services.Pipewire` + `wpctl` / `pavucontrol`)
- **Wallpaper & Theming:** `awww` (`awww-daemon`) + **Matugen 4.1.0** (Material You palette generation)
- **Display manager & Session:** SDDM + custom `lock.sh` (`~/.local/share/quickshell-lockscreen/lock.sh`)

---

## Color system & Typography

### Palette ("Japanese Navy")
17 mathematically derived colors (5 backgrounds: `crust`, `base`, `surface0`, `surface1`, `overlay`; 3 text tones: `subtext0`, `subtext1`, `text`; 9 accents: `red`, `orange`, `yellow`, `green`, `teal`, `sky`, `blue`, `pink`, `mauve` + bright terminal variants). Reference: `config/Colors.qml`.

### Dynamic Theme Switcher Architecture (Matugen)
- `matugen` generates `config/generated/colors.json` from `~/.config/matugen/templates/quickshell-colors.json.template`.
- **Facade pattern:** `Colors.qml` (`pragma Singleton`, `Quickshell.Io.FileView` + `JsonAdapter` with `watchChanges: true`) dynamically maps Material You keys (`primary`, `surface`, etc.) to semantic palette properties (`Colors.sky`, `Colors.base`, etc.) with fallback defaults.
- Downstream modules remain unchanged and completely agnostic to Matugen.
- **Exception:** `Battery.qml` keeps static warning colors locally (`statusCritical`, `statusWarning`, `statusOk`) — battery thresholds represent safety/system status, not branding, and must remain identifiable regardless of wallpaper.

### Fonts
- **`Maple Mono NF`** is the standard font for all Quickshell UI text and icons (ensures full Nerd Font glyph coverage; `Rubik` is not used for bar icons due to missing glyphs).

---

## Current architecture (Quickshell modules)

Modular layout in `~/.config/quickshell/`:

- **`shell.qml`** — `ShellRoot` entry point. Instantiates `Bar {}`, `AppLauncher {}`, and hosts `IpcHandler` (`target: "launcher"`, functions with explicit `: void` return types).
- **`config/Colors.qml`** — Singleton palette / facade.
- **`modules/bar/`**:
  - **`Bar.qml`** — `PanelWindow` (top-anchored, `implicitHeight: 32`, `color: Colors.base`, `ExclusionMode.Auto`). Visual structure organized into left, center, and right `RowLayout` groups.
  - **`Pill.qml`** — Reusable rounded wrapper (`Rectangle`, `radius: implicitHeight / 2`, `color: Colors.surface0`) for bar items.
  - **`Workspaces.qml`** — 10-workspace repeater with animated roll-out/collapse (`Behavior on width` / `opacity` based on `exists`), `Hyprland.workspaces.values.find(...)`, and click-to-focus `Hyprland.dispatch("workspace ...")`.
  - **`Battery.qml`** — `UPower.displayDevice`, Nerd Font icons, static warning colors.
  - **`Clock.qml`** — `SystemClock` (`SystemClock.Minutes`) formatted via `Qt.formatDateTime`.
  - **`Network.qml`** — `Quickshell.Networking`, dynamic WiFi signal icon tiers, click to launch `kitty -e wlctl`.
  - **`Volume.qml`** — `Quickshell.Services.Pipewire` + `PwObjectTracker`. LPM launches `pavucontrol`, PPM toggles `wpctl set-mute`.
  - **`SystemTray.qml`** — `Quickshell.Services.SystemTray` with hover highlight, LPM activation, and PPM context menu (`modelData.display()`).
  - **`PowerMenuButton.qml` + `PowerMenu.qml`** — `PopupWindow` positioned relative to the bar; executes `hyprlock`, `lock.sh`, `systemctl reboot`, or `systemctl poweroff` via `Quickshell.Io.Process`.
- **`modules/app_launcher/`**:
  - **`AppLauncherState.qml`** — `Singleton` tracking visibility and persistent recent launches (`recentIds`) via `QtCore.Settings`.
  - **`AppLauncher.qml`** — `PanelWindow` on `WlrLayer.Overlay` (`WlrKeyboardFocus.OnDemand`), slide translation animation, fuzzy search across `DesktopEntries.applications.values` (name, genericName, keywords), keyboard navigation (`Keys.onPressed`), and `Quickshell.iconPath(..., true)` with letter fallback.
- **`modules/wallpaper/`**:
  - **`WallpaperState.qml`** — `Singleton` scanning `~/Pictures/Wallpapers` via `find`, triggering `awww` and `matugen image <path> --source-color-index 0`.
- **`modules/border/`**:
  - **`Border.qml`** — Screen frame panels (`Variants` over `Quickshell.screens` with `PanelWindow` for bottom, left, right borders on `WlrLayer.Bottom`).
- **`modules/components/`**:
  - **`ConcaveCurves.qml`** — Reusable inward curved corners (`Shape` + `PathArc` with `CurveRenderer`) for organic bar-to-border transitions (inspired by `caelestia-shell`).
- **`modules/notifications/`**:
  - **`Notifications.qml`** — `NotificationServer` and top-right `PanelWindow` overlay (in development).

---

## Known pitfalls & hard-learned lessons

- **QML imports are strictly per-file.** A child file omitting `import Quickshell` or `import qs.config` fails even if the parent imports it.
- **Always verify APIs against `quickshell.org/docs/v0.3.0`**, never v0.1.0 or generic memory (e.g. `exclusionMode` vs `exclusionZone`).
- **Never duplicate logic inline when a standalone component exists.** Reference it directly (e.g. `SystemTray {}`).
- **`pragma Singleton` requires `Quickshell.Singleton {}`** (not bare `QtObject`) for reloadable singletons.
- **`childrenRect` causes binding loops in Quickshell.** Use `Row`, `Column`, or `Layouts` to calculate sizes.
- **`forceActiveFocus()` on `TextInput` requires `Qt.callLater()`** when invoked in the same frame that `visible` becomes `true`.
- **`Quickshell.iconPath(name, true)` returns empty string for missing icons**, allowing letter fallback (`image://icon/` returns an error placeholder instead of failing gracefully).
- **`IpcHandler` methods require explicit return types** (`function toggle(): void`).
- **Matugen 4.x requires `--source-color-index 0`** in non-interactive CLI calls to prevent blocking on stdin color picker.
- **Hyprland's Lua config accepts plain hex** (`"#39A2CA"`), not just packed `rgba()`.
- **Fish themes are loaded from `.theme` files** in `~/.config/fish/themes/` by filename, not the `# name:` header.
- **Qt6 binaries on Arch are suffixed `6`** (`qmlls6`, `qmlformat6`).
- **Shader borders are GPU-prohibitive** on this hardware; use `Rectangle border`.

---

## Multi-agent / delegation setup (Hermes-side)

- **Primary / orchestrator model:** `nvidia/nemotron-3-super-120b-a12b`
- **Delegate model:** `nvidia/nemotron-3-nano-30b-a3b`
- **`max_concurrent_children`: 2** (low RAM constraint and NIM pool saturation protection).
- **Delegation rule:** Multi-file architectural tasks must be split into **explicit, separate, ordered child tasks** to avoid inline-duplication bugs.

---

## On the horizon (open items)

1. **Screen Frame & Concave Corners (`Border.qml` + `ConcaveCurves.qml` inspired by `caelestia-shell`):**
   - Fix `exclusiveZone` $\rightarrow$ `exclusionMode` (v0.3.0 API compliance) in `Border.qml`.
   - Add missing `borderThickness` and `cornerRadius` properties to `Bar.qml` to fix binding errors.
   - Refine `ConcaveCurves.qml` arc geometry, mirroring, and anchors for seamless corners where the bar meets screen borders.
2. **Matugen dynamic theming pipeline completion:**
   - Connect `config/generated/colors.json` to `config/Colors.qml` using `FileView` + `JsonAdapter` (`watchChanges: true`).
   - Fix `awww` command and `--source-color-index 0` in `modules/wallpaper/WallpaperState.qml`.
   - Add Matugen templates for Hyprland borders (`decorations.lua`) and Kitty (`kitty.conf`).
3. **Wallpaper Picker UI:** Build a visual selector/grid for `WallpaperState.wallpapers`.
4. **Notifications module (`modules/notifications/Notifications.qml`):** Complete `NotificationServer` layout and dismiss interactions.
5. **Power plan control:** Integration via `Quickshell.Services.UPower` `PowerProfiles`.
6. **Custom Lockscreen in Quickshell:** Using `ext-session-lock-v1` protocol, written from scratch (conceptual reference: `Darkkal44/qylock`).
7. **Multi-monitor support for the bar:** Deferred until external monitor connection.
8. **Starship prompt segment styling:** Diagnose rounded capsule glyph alignment (deferred).
9. **Hermes multi-agent delegation test:** Verify "explicit ordered subtasks" against code duplication.

---

## Completed

- Modular refactor of Quickshell bar and configs.
- Snapper snapshot boot verification.
- Power menu with dedicated processes per button and safe `lock.sh` logout.
- Tri-state animated workspace roll-out indicators with clickable dispatch.
- Integrated bar modules: Battery, Clock, Network (`wlctl`), Volume (`Pipewire` / `pavucontrol` / `wpctl`), SystemTray.
- Encapsulated `Pill.qml` bar layout with transparent base.
- Full `AppLauncher.qml` with MRU history persistence, keyboard navigation, and fuzzy search.
- Hyprland 0.56.0 Lua configuration (`modules/*.lua`).
- Terminal styling: Kitty 0.6 opacity + Japanese Navy theme, Fish theme, Fastfetch layout.
- Initial Matugen 4.1.0 setup and `colors.json` template generation.

---
*Last updated: 2026-08-20*

