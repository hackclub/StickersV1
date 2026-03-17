
# =============================================================================
# BACKEND (Ruby/Puma)
# =============================================================================
FROM ruby:3.3-alpine AS backend
RUN apk add --no-cache build-base tzdata
WORKDIR /app
COPY backend/Gemfile backend/Gemfile.lock ./
RUN bundle config set --local path 'vendor/bundle'
RUN bundle config set --local without 'development test'
RUN bundle install
COPY backend/ .
EXPOSE 9292
CMD ["bundle", "exec", "puma", "-p", "9292", "-e", "production"]

# =============================================================================
# FRONTEND (SvelteKit/Node)
# =============================================================================

FROM node:22-alpine AS frontend
RUN corepack enable && corepack prepare pnpm@latest --activate
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm run build
RUN pnpm prune --prod
EXPOSE 3000
CMD ["node", "build"]
