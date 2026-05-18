---
name: Signal & Spectrum
colors:
  surface: '#f7f9ff'
  surface-dim: '#d3dbe5'
  surface-bright: '#f7f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#edf4ff'
  surface-container: '#e7eef9'
  surface-container-high: '#e2e9f4'
  surface-container-highest: '#dce3ee'
  on-surface: '#151c24'
  on-surface-variant: '#44474c'
  inverse-surface: '#2a3139'
  inverse-on-surface: '#eaf1fc'
  outline: '#75777d'
  outline-variant: '#c4c6cd'
  surface-tint: '#515f74'
  primary: '#303e51'
  on-primary: '#ffffff'
  primary-container: '#475569'
  on-primary-container: '#bbcae1'
  inverse-primary: '#b9c7df'
  secondary: '#5d5f5f'
  on-secondary: '#ffffff'
  secondary-container: '#dfe0e0'
  on-secondary-container: '#616363'
  tertiary: '#004633'
  on-tertiary: '#ffffff'
  tertiary-container: '#086047'
  on-tertiary-container: '#8dd8b8'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d5e3fc'
  primary-fixed-dim: '#b9c7df'
  on-primary-fixed: '#0d1c2e'
  on-primary-fixed-variant: '#3a485b'
  secondary-fixed: '#e2e2e2'
  secondary-fixed-dim: '#c6c6c7'
  on-secondary-fixed: '#1a1c1c'
  on-secondary-fixed-variant: '#454747'
  tertiary-fixed: '#a6f2d1'
  tertiary-fixed-dim: '#8bd6b6'
  on-tertiary-fixed: '#002116'
  on-tertiary-fixed-variant: '#00513b'
  background: '#f7f9ff'
  on-background: '#151c24'
  surface-variant: '#dce3ee'
typography:
  headline-lg:
    fontFamily: IBM Plex Sans
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: IBM Plex Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: IBM Plex Sans
    fontSize: 20px
    fontWeight: '500'
    lineHeight: 28px
  body-lg:
    fontFamily: IBM Plex Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: IBM Plex Sans
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-mono:
    fontFamily: IBM Plex Mono
    fontSize: 13px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.05em
  label-caps:
    fontFamily: IBM Plex Sans
    fontSize: 12px
    fontWeight: '700'
    lineHeight: 16px
    letterSpacing: 0.08em
  headline-lg-mobile:
    fontFamily: IBM Plex Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  base: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  gutter: 12px
  margin-mobile: 16px
  margin-desktop: 24px
---

## Brand & Style

The design system is engineered for the precision-oriented amateur radio operator. It prioritizes clarity, technical utility, and rapid data interpretation. The aesthetic is **Technical Minimalism**: a clean, systematic approach that balances the high information density required for signal monitoring with a high-contrast, airy interface that prevents cognitive fatigue during long sessions.

The emotional response should be one of "calm control." By utilizing a refined, professional color palette and generous white space, the system transforms complex radio data—frequencies, waterfalls, and logs—into a legible and sophisticated workspace. The style is predominantly flat, using structural alignment and clean borders rather than heavy skeuomorphism to maintain a modern, "instrument-grade" feel.

## Colors

The color palette is rooted in functional utility and maximum legibility.
- **Primary Actions:** Professional Slate Blue (`#475569`) is used for primary buttons, active states, and navigation headers, providing a grounded, trustworthy anchor for the UI.
- **Secondary Surfaces:** Pure White (`#FFFFFF`) acts as the secondary color, used for primary content cards, working areas, and to provide maximum contrast against technical data.
- **Data & Success:** Deep Emerald (`#065F46`) is reserved for critical data points, active signal indicators, and successful connection logs.
- **Base & Neutral:** The canvas and secondary elements use a light neutral palette (`#D9E0EB`), which minimizes glare while providing enough structure for fine-grained text.

## Typography

The design system exclusively utilizes **IBM Plex Sans** to leverage its "engineered" personality. Its humanist-meets-industrial terminals ensure that alphanumeric strings (like callsigns and frequencies) remain distinguishable at small sizes.

- **Data Readouts:** For frequency displays and signal coordinates, use the Monospaced variant (IBM Plex Mono) to ensure character alignment in live-updating data streams.
- **Hierarchy:** Use bold weights sparingly for primary labels. Most "technical" metadata should be rendered in the `body-md` or `label-caps` styles to maximize screen real estate.
- **Contrast:** High-density views should use `label-mono` for all numeric values to maintain a "dashboard" aesthetic.

## Layout & Spacing

This design system employs a **Fixed Grid** approach for the main dashboard to ensure signal graphs and control panels remain in predictable locations. 

- **Density:** A tight 4px baseline grid allows for high information density. 
- **Desktop:** A 12-column grid with narrow 12px gutters, allowing for side-by-side placement of "Waterfalls" and "Logbooks."
- **Mobile:** Elements reflow into a single-column stack, prioritizing the "Tuning" interface and primary signal readout at the top of the viewport. 
- **Grouping:** Use the `md` (16px) spacing for logical sectioning, while using `sm` (8px) for internal component padding to maintain a compact, "instrument" feel.

## Elevation & Depth

To maintain a minimalist profile, the design system avoids heavy shadows. 

- **Tonal Layers:** Depth is primarily communicated through surface color and subtle borders. The main background uses the neutral tint, while active "Secondary" containers or data blocks use **Pure White** to indicate a different functional zone.
- **Soft Shadows:** Only "floating" elements like dropdown menus or active tooltips receive a shadow. Use a very diffused, low-opacity shadow: `0px 4px 12px rgba(71, 85, 105, 0.08)`.
- **Active States:** Instead of elevation, use "In-set" highlights or border-weight changes to indicate a selected frequency or active control.

## Shapes

The shape language is **Soft**. A consistent 8px (`rounded-lg`) corner radius is applied to all primary containers, cards, and input fields. This softens the technical nature of the data, making the app feel approachable. Smaller elements like tags, chips, and checkboxes use the 4px (`rounded-md`) standard to maintain precision in tight spaces.

## Components

- **Buttons:** Primary buttons use a solid Slate Blue fill with white text. Secondary buttons use a Pure White background with a Slate Blue border.
- **Data Cards:** These should have a subtle 1px border of `#D9E0EB` and a Pure White background. Use a Slate Blue top-accent for primary data modules.
- **Input Fields:** Use a Pure White background fill with a subtle neutral border. On focus, the border changes to Slate Blue.
- **Chips/Tags:** Used for "Band" selection (e.g., 20m, 40m). Active chips should use a Deep Emerald background with white text; inactive chips use the light neutral background.
- **Signal Meters:** Horizontal bars should use a background of light neutral (`#D9E0EB`), with the active "level" indicated in Deep Emerald.
- **Log Lists:** High-density rows with alternating subtle background tints. Use IBM Plex Mono for the "Time" and "Frequency" columns.