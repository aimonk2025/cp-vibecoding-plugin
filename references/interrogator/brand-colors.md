# Brand Colors Interactive Flow

Interactively define brand color palette. Every color gets a hex value.

## Table of Contents

- [Entry Point](#entry-point) - Initial question (has colors?)
- [Path 1: Has Existing Colors](#path-1-user-has-existing-colors) - Capture hex codes
- [Path 2: Help Me Choose](#path-2-help-me-choose-no-existing-colors) - Mood + industry suggestions
- [Path 3: Have Primary Only](#path-3-have-primary-need-rest) - Generate from primary
- [Dark Mode](#dark-mode-question) - Light/dark theme choice
- [Semantic Colors](#semantic-colors) - Success/error/warning/info
- [Final Confirmation](#final-confirmation) - Review and save
- [Palette Presets](#palette-presets-by-mood--industry) - Ready-made palettes by mood

---

## Entry Point

This flow is triggered from `design.md` after initial style questions.

```
BRAND COLORS

Let's define your color palette.

Do you have existing brand colors?

[1] Yes, I have specific colors (hex codes, brand guide)
[2] No, help me choose colors
[3] I have a primary color but need help with the rest
```

---

## Path 1: User Has Existing Colors

```
EXISTING BRAND COLORS

Great! Let's capture your palette.

PRIMARY COLOR
Enter your primary brand color (hex code):
Example: #3B82F6, #10B981, #8B5CF6

> [user input]

---

Got it: [COLOR PREVIEW] [hex]

Now let's complete the palette:

SECONDARY COLOR
Do you have a secondary brand color?
[1] Yes → Enter hex: ___
[2] No → I'll suggest one based on your primary

---

ACCENT COLOR (optional)
Do you have an accent/highlight color?
[1] Yes → Enter hex: ___
[2] No → Skip (I'll derive from primary)

---

NEUTRAL PALETTE
For backgrounds, text, and borders - do you have specific grays?
[1] Yes → Enter your gray palette
[2] No → I'll generate neutrals that complement your brand colors
```

After collecting:
```
YOUR BRAND PALETTE

Primary:    [###] #XXXXXX
Secondary:  [###] #XXXXXX
Accent:     [###] #XXXXXX (if provided)

Neutrals (auto-generated to complement):
Background: [###] #FAFAFA
Surface:    [###] #FFFFFF
Border:     [###] #E5E5E5
Text:       [###] #171717
Text Muted: [###] #737373

Semantic (suggested):
Success:    [###] #22C55E
Error:      [###] #EF4444
Warning:    [###] #F59E0B
Info:       [###] #3B82F6

---
Does this palette work?
[1] Yes, looks good
[2] Adjust neutrals
[3] Adjust semantic colors
[4] Start over
```

---

## Path 2: Help Me Choose (No Existing Colors)

### Step 1: Mood Selection

```
COLOR MOOD

What feeling should your app convey to users?

[1] Professional & Trustworthy
    → Blues, teals, grays. Think: banking, enterprise, healthcare.

[2] Energetic & Bold
    → Oranges, reds, yellows. Think: fitness, food delivery, startups.

[3] Calm & Natural
    → Greens, earth tones, soft blues. Think: wellness, sustainability, meditation.

[4] Modern & Minimal
    → Monochrome with single accent. Think: SaaS, developer tools, portfolios.

[5] Playful & Creative
    → Purples, pinks, vibrant combos. Think: social apps, gaming, kids.

[6] Luxury & Premium
    → Deep colors, golds, blacks. Think: fashion, high-end services.

Pick 1-6:
```

### Step 2: Industry Context

```
INDUSTRY CONTEXT

What's your app's domain? This helps with color associations.

[1] Technology / SaaS
[2] Healthcare / Wellness
[3] Finance / Business
[4] E-commerce / Retail
[5] Education / Learning
[6] Entertainment / Media
[7] Food / Hospitality
[8] Other: ___
```

### Step 3: Generate Palettes

Based on mood + industry, generate 3 options:

```
SUGGESTED PALETTES

Based on: [Mood] + [Industry]

---

OPTION A: [Palette Name]
Primary:    [###] #3B82F6  (Trustworthy Blue)
Secondary:  [###] #1E40AF  (Deep Navy)
Accent:     [###] #06B6D4  (Fresh Cyan)
Background: [###] #F8FAFC  (Cool White)
Text:       [###] #0F172A  (Near Black)

Best for: Apps that need to feel established and reliable.

---

OPTION B: [Palette Name]
Primary:    [###] #0EA5E9  (Sky Blue)
Secondary:  [###] #6366F1  (Soft Indigo)
Accent:     [###] #22D3EE  (Electric Cyan)
Background: [###] #FFFFFF  (Pure White)
Text:       [###] #1E293B  (Slate)

Best for: Modern apps that want to feel fresh and approachable.

---

OPTION C: [Palette Name]
Primary:    [###] #2563EB  (Royal Blue)
Secondary:  [###] #7C3AED  (Violet)
Accent:     [###] #F59E0B  (Warm Amber)
Background: [###] #FAFAFA  (Soft Gray)
Text:       [###] #18181B  (Zinc)

Best for: Apps that want a bit of personality while staying professional.

---

Which palette?
[A] Option A
[B] Option B
[C] Option C
[D] None - show me different options
[E] I'd like to customize one of these
```

### Step 4: Customization (if needed)

```
CUSTOMIZE PALETTE

Starting from Option [X]:

Which color do you want to adjust?
[1] Primary - currently #XXXXXX
[2] Secondary - currently #XXXXXX
[3] Accent - currently #XXXXXX
[4] Background - currently #XXXXXX
[5] Text - currently #XXXXXX
[6] Done customizing
```

---

## Path 3: Have Primary, Need Rest

```
BUILD FROM PRIMARY

Enter your primary brand color (hex):
> [user input]

---

Building palette from [###] #XXXXXX...

GENERATED COMPLEMENTARY PALETTE

Your Primary: [###] #XXXXXX

Suggested additions:
Secondary:  [###] #XXXXXX  (Darker shade of primary)
Accent:     [###] #XXXXXX  (Complementary color)
Background: [###] #XXXXXX  (Tinted neutral)
Surface:    [###] #XXXXXX  (Card backgrounds)
Text:       [###] #XXXXXX  (High contrast)
Text Muted: [###] #XXXXXX  (Secondary text)

---
[1] Accept this palette
[2] Want a different secondary
[3] Want a different accent
[4] Show alternative palettes
```

---

## Dark Mode Question

After palette is confirmed:

```
DARK MODE

Does your app need dark mode?

[1] Yes, dark mode required
[2] Light mode only
[3] Both, with light as default
[4] Both, with dark as default
```

If dark mode selected:
```
DARK MODE PALETTE

I'll generate dark mode variants of your colors:

Light Mode          →    Dark Mode
Background #FAFAFA  →    #0A0A0A
Surface    #FFFFFF  →    #171717
Border     #E5E5E5  →    #262626
Text       #171717  →    #FAFAFA
Text Muted #737373  →    #A3A3A3

Primary, secondary, accent stay the same (or slightly adjusted for dark backgrounds).

---
[1] Accept dark mode palette
[2] Adjust dark mode colors
```

---

## Semantic Colors

```
SEMANTIC COLORS

These are used for feedback states (success, error, warning, info).

Default suggestions:
Success: [###] #22C55E (Green)
Error:   [###] #EF4444 (Red)
Warning: [###] #F59E0B (Amber)
Info:    [###] #3B82F6 (Blue)

[1] Use these defaults
[2] Customize semantic colors
```

---

## Final Confirmation

```
BRAND COLORS COMPLETE

Your final palette:

BRAND
Primary:    [###] #XXXXXX
Secondary:  [###] #XXXXXX
Accent:     [###] #XXXXXX

NEUTRALS
Background: [###] #XXXXXX
Surface:    [###] #XXXXXX
Border:     [###] #XXXXXX
Text:       [###] #XXXXXX
Text Muted: [###] #XXXXXX

SEMANTIC
Success:    [###] #XXXXXX
Error:      [###] #XXXXXX
Warning:    [###] #XXXXXX
Info:       [###] #XXXXXX

DARK MODE: [Yes/No]
[If yes, show dark mode values]

---
[1] Confirm - Save this palette
[2] Make changes
[3] Start over

Confirming will save these colors for DESIGN_SYSTEM.md generation.
```

---

## Palette Presets by Mood + Industry

### Professional + Technology
```
Ocean Depth:     Primary #0369A1, Secondary #0C4A6E, Accent #06B6D4
Slate Modern:    Primary #3B82F6, Secondary #1E40AF, Accent #8B5CF6
Corporate Trust: Primary #2563EB, Secondary #1D4ED8, Accent #10B981
```

### Energetic + E-commerce
```
Sunset Burst:    Primary #F97316, Secondary #EA580C, Accent #FBBF24
Cherry Pop:      Primary #E11D48, Secondary #BE123C, Accent #FB7185
Electric Lime:   Primary #84CC16, Secondary #65A30D, Accent #FACC15
```

### Calm + Wellness
```
Forest Calm:     Primary #059669, Secondary #047857, Accent #34D399
Ocean Serenity:  Primary #0891B2, Secondary #0E7490, Accent #67E8F9
Earth Ground:    Primary #78716C, Secondary #57534E, Accent #A8A29E
```

### Modern + SaaS
```
Mono Accent:     Primary #18181B, Secondary #27272A, Accent #3B82F6
Purple Haze:     Primary #7C3AED, Secondary #6D28D9, Accent #A78BFA
Midnight:        Primary #1E293B, Secondary #0F172A, Accent #38BDF8
```

### Playful + Social
```
Candy Pop:       Primary #EC4899, Secondary #DB2777, Accent #F472B6
Grape Soda:      Primary #8B5CF6, Secondary #7C3AED, Accent #C4B5FD
Tropical:        Primary #14B8A6, Secondary #0D9488, Accent #FBBF24
```

### Luxury + Premium
```
Noir Gold:       Primary #18181B, Secondary #27272A, Accent #D4AF37
Deep Burgundy:   Primary #881337, Secondary #9F1239, Accent #FCD34D
Midnight Velvet: Primary #1E1B4B, Secondary #312E81, Accent #C7D2FE
```

---

## Exit to Design.md

After colors confirmed:
```
COLORS SAVED

Brand palette captured. Returning to Design & UX questions.

Next: Typography, Layout, Components...
```

Continue with remaining design.md questions (typography, layout, etc.)
