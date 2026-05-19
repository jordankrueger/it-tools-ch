# CH static-fork Dockerfile template
#
# Build args:
#   BUILDER_IMAGE — node base image (default: node:20-alpine)
#   PKG_MANAGER   — npm | pnpm (default: npm)
#   PREFIX        — path prefix served from this container (e.g., "pdf", "image", "tools")
#   BUILD_CMD     — build script name (default: "build")
#                   snapotter override: "turbo build --filter=@snapotter/web"
#   DIST_PATH     — path to built output dir relative to /app (default: "dist")
#                   snapotter override: "apps/web/dist"
#
# Per-fork overrides (set in Coolify / docker-compose):
#   bentopdf:  PKG_MANAGER=npm  PREFIX=pdf     BUILD_CMD=build          DIST_PATH=dist
#   snapotter: PKG_MANAGER=pnpm PREFIX=image   BUILD_CMD="turbo build --filter=@snapotter/web"  DIST_PATH=apps/web/dist
#   it-tools:  PKG_MANAGER=pnpm PREFIX=tools   BUILD_CMD=build          DIST_PATH=dist

ARG BUILDER_IMAGE=node:20-alpine
FROM ${BUILDER_IMAGE} AS build
WORKDIR /app

ARG PKG_MANAGER=pnpm
ARG PREFIX=tools
ARG BUILD_CMD=build

# Copy lockfiles first so Docker layer cache is effective for both npm and pnpm forks
COPY package*.json pnpm-lock.yaml* pnpm-workspace.yaml* turbo.json* ./
COPY . .

# BASE_URL tells Vite where assets will be served from (e.g., /pdf/)
ENV BASE_URL=/${PREFIX}/

RUN if [ "$PKG_MANAGER" = "pnpm" ]; then \
      corepack enable && pnpm install --frozen-lockfile && pnpm run ${BUILD_CMD}; \
    else \
      npm ci && npm run ${BUILD_CMD}; \
    fi

# Copy built output into nginx under the prefix path
ARG DIST_PATH=dist

FROM nginx:alpine
ARG PREFIX=tools
ARG DIST_PATH=dist
COPY --from=build /app/${DIST_PATH}/ /usr/share/nginx/html/${PREFIX}/
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
