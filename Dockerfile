FROM node:22-slim AS build
ENV CI=true
WORKDIR /app
RUN corepack enable && corepack prepare pnpm@latest --activate
COPY pnpm-lock.yaml package.json pnpm-workspace.yaml* ./
COPY . .
RUN pnpm install --frozen-lockfile

FROM node:22-slim AS production
ENV NODE_ENV=production
RUN useradd --user-group --create-home --shell /bin/false appuser
WORKDIR /app
RUN corepack enable && corepack prepare pnpm@latest --activate
COPY --from=build /app /app
RUN chown -R appuser:appuser /app
USER appuser
EXPOSE 3000
CMD ["pnpm", "start-api"]

