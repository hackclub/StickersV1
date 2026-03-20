<div align="center">
  <img
    src="https://assets.hackclub.com/flag-standalone.svg"
    width="100"
    alt="Hack Club flag"
  />

  <h2>
    <a href="https://stickers.hackclub.com">stickers.hackclub.com</a>
  </h2>

  <img
    src="src/lib/assets/images/hackClubLogo.png"
    width="300"
    alt="Hack Club logo"
  />
  <p>
    The Rails 8 + Inertia.js + Svelte 5 codebase powering
    <a href="https://stickers.hackclub.com">stickers.hackclub.com</a>
  </p>
</div>

<hr style="margin-top: 0.1rem; margin-bottom: 0;">

<h1>Hack Club Stickers</h1>

<p>
  Every Hack Clubber gets free, high-quality stickers. Completing
  <a href="https://ysws.hackclub.com/">programs</a> and attending
  <a href="https://hackathons.hackclub.com/">hackathons</a>
  can earn more event-specific merch!
</p>

<h3>Features</h3>
<ul>
  <li>Trade stickers with other Hack Clubbers</li>
  <li>Browse an archive of all printed Hack Club stickers</li>
  <li>Submit new sticker designs</li>
  <li>Vote on your favourite designs</li>
  <li>Hack to earn monthly sticker shipments</li>
  <li>Use as an API for sticker designs</li>
</ul>

<h3>Contributing</h3>
<ul>
  <li>
    Help archive stickers at
    <a href="https://forms.hackclub.com/archive">forms.hackclub.com/archive</a>
  </li>
</ul>

<h3>Development Setup</h3>

<pre>
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
</pre>

<h3>Environment Variables</h3>

<p>Required environment variables in <code>.env</code>:</p>

<pre>
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
</pre>

<h3>API Usage</h3>

<p>You can use <code>stickers.hackclub.com/api/</code> to get a list of all Hack Club stickers in JSON. Please don't hammer it too hard — let us know what you're up to and we can help you coexist within the rate limit.</p>

<h4>Stickers</h4>
<ul>
  <li><code>GET /api/stickers</code> - List all visible stickers</li>
  <li><code>GET /api/stickers/:id</code> - Get sticker details</li>
</ul>

<h4>Designs</h4>
<ul>
  <li><code>GET /api/designs</code> - List current user's designs (requires auth)</li>
  <li><code>GET /api/designs/all</code> - List all designs (requires auth)</li>
  <li><code>POST /api/designs</code> - Submit a new design (requires auth)</li>
  <li><code>POST /api/designs/:id/vote</code> - Toggle vote on a design (requires auth)</li>
</ul>

Our Airtable has no passwords or secrets — if you want a read-only personal access token scoped to the base we can provide it!
In general we're happy to help you over DM, but please have a glance over the code first!

<h3>Deployment</h3>

<p>The app is deployed using Docker. To deploy:</p>

<pre>
# Build assets for production
bin/rails assets:precompile
</pre>

<p>deploy with Docker directly:</p>

<pre>
docker build -t stickers .
docker run -p 3000:3000 --env-file .env stickers
</pre>

<p>
  Made with &lt;3 by
  <a href="https://github.com/24c02">nora</a>,
  <a href="https://github.com/EDripper">euan</a>, and
  <a href="https://github.com/System-End">end</a>.
</p>
