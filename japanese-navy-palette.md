# Japanese Navy — Full Color Palette

A complete palette in the style of Dracula/Catppuccin: background ramp, text ramp,
and full accent set. Every color is either one you already picked, or derived by
rotating hue while matching the lightness/saturation range of your existing colors
(documented per-color below) — nothing was picked arbitrarily.

## Backgrounds (darkest → lightest)

| Name       | Hex       | Role                                                | Source |
|------------|-----------|------------------------------------------------------|--------|
| crust      | `#06101A` | Deepest shadow layer — rarely used directly (e.g. under floating popups) | derived: same hue/sat as base, L lowered |
| base       | `#0B1D2F` | Primary background — terminal bg, bar bg             | your original |
| surface0   | `#0C304C` | Elevated surface — popups, inactive borders           | your original |
| surface1   | `#55324C` | Secondary surface, warmer — cards, secondary panels   | your original |
| overlay    | `#345779` | Borders / dividers on top of surfaces                 | derived: between surface0 and midblue |

## Text (lowest → highest emphasis)

| Name      | Hex       | Role                                    | Source |
|-----------|-----------|-------------------------------------------|--------|
| subtext0  | `#738CA5` | Disabled / very muted text                | derived: base hue, low sat, mid light |
| subtext1  | `#9A79A3` | Secondary text, muted UI labels           | your "lavender" — reassigned as subtext role |
| text      | `#D0D9E1` | Primary foreground / body text            | derived: base hue, low sat, high light |

## Accents (full set)

| Name    | Hex       | Role                                          | Source |
|---------|-----------|------------------------------------------------|--------|
| red     | `#A43347` | Errors, destructive actions                    | your "coral" |
| orange  | `#CF9059` | Warnings (secondary)                           | derived: hue 28°, matches accent L/S range |
| yellow  | `#CBA54D` | Warnings (primary), git-modified               | derived earlier (fish/kitty theme session) |
| green   | `#3FA662` | Success, git-added, active/on states           | derived earlier (fish/kitty theme session) |
| teal    | `#46918A` | Secondary info accent, links (alt)             | derived: hue 175°, cool complement to red |
| sky     | `#39A2CA` | Primary accent — active workspace, commands    | your original |
| blue    | `#5198C2` | Secondary accent — mid-tone, less punchy       | your original ("midblue") |
| pink    | `#C092AB` | Highlighted text, notification icons           | your original |
| mauve   | `#9A79A3` | Tertiary accent, alt to lavender in accent role| your original ("lavender") — dual role, see note |

**Note on lavender/mauve dual-listing:** `#9A79A3` is used as *both* `subtext1` (text role)
and `mauve` (accent role) above. This mirrors how Catppuccin itself reuses "overlay" tones
across roles — it's fine as long as you're consistent about *when* you reach for it as text
vs. as an accent, rather than truly needing 9 distinct hues.

## Bright / high-contrast variants (for terminal color8–15 slots)

| Name        | Hex       | Derived from |
|-------------|-----------|--------------|
| bright_red    | `#C0546A` | lightened red |
| bright_green  | `#67C185` | lightened green |
| bright_yellow | `#D5C090` | lightened yellow |
| bright_blue   | `#5198C2` | = blue (already bright enough) |
| bright_pink   | `#B79BBF` | lightened mauve |
| bright_cyan   | `#6FB8DE` | lightened sky |
| bright_white  | `#F0EDEF` | near-white, warm (not pure #FFF — see reasoning below) |
| bright_black  | `#55324C` | = surface1 (reused) |

**Why not pure white (`#FFFFFF`):** high contrast ratio between pure white text and a deep
navy background causes eye strain over long sessions. A slightly warm off-white keeps
readability without the glare (same reasoning Material Design's dark theme guidance gives
for avoiding pure white-on-black).
