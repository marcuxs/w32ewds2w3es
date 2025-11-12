# ---------- Etapa 1: Build ----------
FROM node:20-alpine AS builder

WORKDIR /app

# Copia apenas os arquivos essenciais
COPY pnpm-workspace.yaml pnpm-lock.yaml package.json ./
COPY packages ./packages

# Instala pnpm e dependências
RUN npm install -g pnpm
RUN pnpm install --frozen-lockfile

# Compila o código TypeScript
RUN pnpm run build

# ---------- Etapa 2: Runtime ----------
FROM node:20-alpine

WORKDIR /app

# Copia tudo da etapa anterior
COPY --from=builder /app /app

# Instala apenas as dependências de produção
RUN npm install -g pnpm && pnpm install --prod

# Expõe a porta (se seu serviço MCP roda em 3000)
EXPOSE 3000

# Comando correto para rodar o servidor Supabase MCP
CMD ["node", "packages/mcp-server-supabase/dist/index.cjs"]
