# Redundant! See https://github.com/hackclub/stickersv2


<div align="center">
  <img src="https://assets.hackclub.com/flag-standalone.svg" width="100" alt="Hack Club flag" />
  <h2><a href="https://stickers.hackclub.com">stickers.hackclub.com</a></h2>
  <img src="app/javascript/assets/images/hackClubLogo.png" width="300" alt="Hack Club logo" />
  <p>The Rails 8 + Inertia.js + Svelte 5 codebase powering <a href="https://stickers.hackclub.com">stickers.hackclub.com</a></p>
</div>

---

# Hack Club Stickers

Every Hack Clubber gets free, high-quality stickers. Completing [programs](https://ysws.hackclub.com/) and attending [hackathons](https://hackathons.hackclub.com/) can earn more event-specific merch!

## Features

- Trade stickers with other Hack Clubbers
- Browse an archive of all printed Hack Club stickers
- Submit new sticker designs
- Vote on your favourite designs
- Hack to earn monthly sticker shipments
- Use as an API for sticker designs

## Contributing

- Help archive stickers at [forms.hackclub.com/archive](https://forms.hackclub.com/archive)

## Development Setup

```bash
git clone https://github.com/hackclub/stickers
cd stickers

# Install dependencies
bundle install
pnpm install

# Set up environment
cp .env.example .env
# Edit .env with your credentials

# Set up database
bin/rails db:create db:migrate

# Start the server (runs on port 3100)
bin/dev
```

## Environment Variables

Required environment variables in `.env`:

```bash
# Airtable
AIRTABLE_PAT=your_personal_access_token
AIRTABLE_BASE_ID=your_base_id
AIRTABLE_STICKER_DB_TABLE_ID=your_stickers_table_id
AIRTABLE_DESIGN_TABLE_ID=your_designs_table_id
AIRTABLE_SHOP_TABLE_ID=your_shop_table_id

# OAuth (auth.hackclub.com)
OIDC_CLIENT_ID=your_client_id
OIDC_CLIENT_SECRET=your_client_secret
OIDC_REDIRECT_URI=http://localhost:3100/auth/oidc/callback
```

## API Usage

You can use `stickers.hackclub.com/api/` to get a list of all Hack Club stickers in JSON. Please don't hammer it too hard — let us know what you're up to and we can help you coexist within the rate limit.

### Stickers

- `GET /api/stickers` - List all visible stickers
- `GET /api/stickers/:id` - Get sticker details

### Designs

- `GET /api/designs` - List current user's designs (requires auth)
- `GET /api/designs/all` - List all designs (requires auth)
- `POST /api/designs` - Submit a new design (requires auth)
- `POST /api/designs/:id/vote` - Toggle vote on a design (requires auth)

Our Airtable has no passwords or secrets — if you want a read-only personal access token scoped to the base we can provide it! In general we're happy to help you over DM, but please have a glance over the code first!

## Deployment

### Option 1: Coolify (Recommended)

**Using Docker Compose (app + database):**

1. Create new resource → **Docker Compose**
2. Point to your Git repo
3. Set compose file to `docker-compose.coolify.yml`
4. Set environment variables including `POSTGRES_PASSWORD`
5. Set your domain for the `stickers` service
6. Deploy

**Using Dockerfile (app only):**

1. Create new resource → **Application** → **Dockerfile**
2. Point to your Git repo
3. Set environment variables (see `.env.example`)
4. Set `DATABASE_URL` to your PostgreSQL instance
5. Set your domain
6. Deploy

### Option 2: Docker (Manual)

```bash
# Build and run
docker build -t stickers .
docker run -d -p 80:80 \
  -e SECRET_KEY_BASE="$(rails secret)" \
  -e DATABASE_URL="postgresql://user:pass@host/db" \
  -e AIRTABLE_PAT="..." \
  stickers
```

### Production Environment Variables

| Variable | Description |
|----------|-------------|
| `SECRET_KEY_BASE` | Rails secret (generate with `rails secret`) |
| `DATABASE_URL` | PostgreSQL connection string |
| `AIRTABLE_PAT` | Airtable Personal Access Token |
| `AIRTABLE_BASE_ID` | Airtable base ID |
| `AIRTABLE_STICKER_DB_TABLE_ID` | Stickers table ID |
| `AIRTABLE_SHOP_TABLE_ID` | Shop table ID |
| `AIRTABLE_DESIGN_TABLE_ID` | Designs table ID |
| `OIDC_ISSUER` | `https://auth.hackclub.com` |
| `OIDC_CLIENT_ID` | OIDC client ID |
| `OIDC_CLIENT_SECRET` | OIDC client secret |
| `OIDC_REDIRECT_URI` | `https://your-domain.com/auth/oidc/callback` |

See `.env.example` for a complete list.

---

Made with <3 by [nora](https://github.com/24c02), [euan](https://github.com/EDripper), and [end](https://github.com/System-End).
