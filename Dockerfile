# ---------- Etapa 1: Build ----------
FROM node:20-alpine AS builder
WORKDIR /app

# Copia arquivos principais
COPY pnpm-workspace.yaml pnpm-lock.yaml package.json ./
COPY packages ./packages

# Instala pnpm e dependências
RUN npm install -g pnpm
RUN pnpm install --frozen-lockfile

# Faz o build (gera dist/)
RUN pnpm run build

# ---------- Etapa 2: Execução ----------
FROM node:20-alpine AS runner
WORKDIR /app

# Copia apenas o necessário da etapa anterior
COPY --from=builder /app /app

EXPOSE 3000
CMD ["node", "packages/mcp-server-supabase/dist/index.js"]
