# nellesen.dev

Static host for demos and portfolio pieces. A tiny [Caddy](https://caddyserver.com)
image serves the `public/` directory; deployed on Coolify (`coolify-eck.nellesen.dev`)
with auto-deploy on push to `main`.

## Routing model

`file_server` serves `<dir>/index.html` automatically — **a subfolder is a route**:

```
public/index.html          ->  https://nellesen.dev
public/grafana/index.html  ->  https://nellesen.dev/grafana
public/<slug>/index.html   ->  https://nellesen.dev/<slug>
```

No config per page. Drop a folder, push, done.

## Publish a page

From this repo:

```bash
mkdir -p public/<slug>
cp /path/to/page.html public/<slug>/index.html
git add public/<slug> && git commit -m "publish <slug>" && git push
```

…or, from the `job-ai` repo, use the helper (copies + commits + pushes here):

```bash
node tools/site/publish.mjs <source.html> <slug>
```

Coolify rebuilds the Caddy image and the page is live in ~30s. HTML is served
`no-cache`, so a redeploy is visible immediately; static assets get a long cache.

## Local preview

```bash
docker build -t nellesen-dev . && docker run --rm -p 8080:80 nellesen-dev
# open http://localhost:8080
```

## Infrastructure

- **Build pack:** Dockerfile · **Exposed port:** 80 · **Domain:** `nellesen.dev`
- Provisioned / redeployed via the Coolify CLI in `mazl-io/job-ai` →
  `tools/coolify/` (`provision-nellesen-dev.mjs`, `coolify.mjs`).
- TLS + routing handled by Coolify's edge proxy; this container only speaks HTTP on :80.
