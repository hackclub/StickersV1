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
    The Svelte and Ruby codebase powering
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

<h3>To spin up the codebase</h3>
<pre>
git clone https://github.com/hackclub/stickers
cp .env.example .env
npm install
npm run dev

In a separate terminal
cd backend
cp .env.example .env
Edit .env 
bundle config set --local path 'vendor/bundle'
bundle install
bundle exec rackup config.ru -p 9292
</pre>

<h3>API Usage</h3>
<p>You can use the prod backend to get a list of all hackclub stickers in JSON, prod backend is https://fccg0c4s0kcggwk0k4s8wggc.a.selfhosted.hackclub.com. Please don't hammer it to hard, let us know what you're up to and we can help you coexist within the rate limit. Locally the backend is ran on port 9292 and exposes the following endpoints:</p>

<h4>Authentication</h4>
<ul>
  <li><code>GET /auth/login</code> - Redirects to OIDC provider for login</li>
  <li><code>GET /auth/oidc/callback</code> - OAuth callback handler</li>
  <li><code>GET /auth/logout</code> - Clears session and logs out</li>
  <li><code>GET /auth/me</code> - Returns current authenticated user (requires auth)</li>
</ul>

<h4>Stickers</h4>
<ul>
  <li><code>GET /stickers</code> - List all stickers</li>
  <li><code>GET /stickers/:id</code> - Get sticker details (requires auth)</li>
</ul>

<h4>Designs</h4>
<ul>
  <li><code>GET /designs</code> - List current user's designs (requires auth)</li>
  <li><code>GET /designs/all</code> - List all designs (requires auth)</li>
  <li><code>POST /designs</code> - Submit a new design (requires auth)</li>
  <li><code>POST /designs/:id/vote</code> - Toggle vote on a design (requires auth)</li>
</ul>

<h4>Shop</h4>
<ul>
  <li><code>GET /shop</code> - List all shop items</li>
  <li><code>GET /shop/:id</code> - Get shop item details</li>
</ul>

Our airtable has no sensitive data, if you want a read only personal access token scoped to the base we can provide it!
In general we're happy to help you over DM, but please have a glance over the code first!

<p>
  Made with &lt;3 by
  <a href="https://github.com/24c02">nora</a> and
  <a href="https://github.com/EDripper">euan</a>.
</p>
