# CH Patches Notice

This is the CampaignHelp fork of **it-tools-ch** (upstream: https://github.com/CorentinTh/it-tools).

## What this branch modifies

The `ch-patches` branch carries CampaignHelp branding and deployment configuration on top of the upstream `main`. Specifically:

- **Branding layer:** `public/ch-branding.css`, `public/ch-header.js`, `public/ch-footer.html`, `public/ch-logo.png` — a thin overlay injected into the upstream HTML. Does not modify upstream business logic.
- **Build config:** `vite.config` adjusted to emit assets under the deployed path prefix (e.g., `/pdf/`, `/image/`).
- **Container build:** `Dockerfile` and `nginx.conf` added/replaced for serving the fork under its prefix path.

## Viewing the diff

```bash
git fetch upstream
git diff upstream/main..ch-patches
```

## Licensing

This branch is provided under the same license as the upstream project. See `LICENSE` in this repo for the canonical text.

## Contact

Issues with the CH fork specifically (not upstream): https://campaign.help/contact

Upstream bug reports and feature requests should go to https://github.com/CorentinTh/it-tools.
