# Client onboarding protocol

**For the Forge GTM account holder.** This is the Track 1 process: setting up the system for a new client from scratch. Follow this after a client has submitted their intake form.

---

## Overview

The goal is to go from intake form submission to a fully configured `Brand-Shared` fork that the production system can read. This involves:

1. Retrieving the intake submission from `Client-Submissions`
2. Accessing the brand files the client has shared
3. Extracting brand and tone of voice values using the encoder files in `Brand-Shared/references/`
4. Populating the client's fork of `Brand-Shared`
5. Verifying the setup renders correctly before handing over to the client

---

## Step 1: Retrieve the intake submission

When a client submits the intake form, a structured markdown file is committed automatically to the private `AskerJ-pers/Client-Submissions` repo.

File path pattern:
```
submissions/[client-slug]/[YYYY-MM-DD]-intake.md
```

GitHub will notify you of the commit. Read through the full submission before proceeding.

---

## Step 2: Access the client's brand files

The intake form asks clients to share a Google Drive, Dropbox, or WeTransfer link containing their brand files. Open the link and download:

- Brand guidelines document (PDF or Word)
- Logo files (ideally SVG or PDF)
- Any existing marketing materials provided as reference

If the client indicated they have no brand guidelines or vector logo files, note this before proceeding. You will need to handle these cases manually. Do not proceed to the encoder steps without at minimum a colour palette and some written materials to derive tone from.

---

## Step 3: Run the brand encoder

Open `Brand-Shared/references/brand-encoder.md` and work through it using the brand guidelines you downloaded.

The encoder covers:

- Brand name
- Colour palette (8 CSS variable roles — extract hex codes from their guidelines)
- Logo files (identify which variants you have)
- Typeface
- Colour usage rules
- Typography rules
- Additional brand notes

Once complete, use your populated encoder to update:

- `tokens.css` — replace the placeholder hex values with the client's actual values
- `tokens.json` — same colour replacement, plus update `brand.name`
- `brand/` folder — replace the placeholder SVG files with the client's actual logo files

If the client does not have SVG logos, request them. PNG logos cannot be used directly. If you need to convert, use a vector tracing tool and verify the output before committing.

---

## Step 4: Run the tone of voice encoder

Open `Brand-Shared/references/tov-encoder.md` and work through it using the brand guidelines, tone of voice document (if they have one), and any written materials the client has provided.

Use the intake submission as supplementary context: the "what you do," "differentiators," and "customer voice" fields are useful starting points.

Once complete, use your populated encoder to update:

- `references/tone-of-voice.md` — replace the template content with the client's extracted voice
- `references/brand-guidelines.md` — add the colour and typography rules you extracted

---

## Step 5: Scrape and review online presence

Visit the URLs provided in the intake form: website, LinkedIn, any other social profiles. Read through the existing copy with the tone of voice encoder in mind.

Look for:

- Patterns the guidelines did not explicitly describe
- Voice that is inconsistent with the guidelines (the live copy is often more accurate)
- Product names, feature names, or terminology used in a specific way
- Customer language in comments, reviews, or case studies

Update `tone-of-voice.md` if you find anything that changes or sharpens the extraction.

---

## Step 6: Verify rendering

Before handing over, run a test render in each of the content-type repos:

1. Open the repo in Claude Code
2. Ask Claude Code to produce a test asset using one of the existing templates
3. Confirm the brand colours, logo, and typeface appear correctly in the rendered output
4. Check that copy produced by Claude Code matches the client's voice

If something does not render correctly, check the submodule pointer is up to date and the token values are valid CSS.

---

## Step 7: Brief the client

Once setup is verified:

1. Share the relevant content-type repo URLs with the client team
2. Provide the workflow guide (`Artefact 4`) so they can begin producing materials
3. Walk through a first asset with them if this is their first session

---

## Setup checklist

- [ ] Intake submission retrieved from `Client-Submissions`
- [ ] Brand files downloaded from client-provided sharing link
- [ ] Brand encoder completed
- [ ] `tokens.css` and `tokens.json` updated with client's hex values
- [ ] `tokens.json` `brand.name` updated
- [ ] Logo SVG files placed in `brand/` folder (dark, light, mark)
- [ ] `--logo-w` and `--logo-h` updated in `tokens.css` if logo proportions differ from 186 x 32px
- [ ] Tone of voice encoder completed
- [ ] `references/tone-of-voice.md` updated
- [ ] `references/brand-guidelines.md` updated
- [ ] Online presence reviewed and encoder updated if needed
- [ ] Test render verified in at least 1 content-type repo
- [ ] Submodule pointer updated in all consumer repos
- [ ] Changes committed and pushed to client's `Brand-Shared` fork
- [ ] Client briefed with repo URLs and workflow guide
