# Etapa de build
FROM node:20-alpine AS builder

WORKDIR /app

# Instala dependências básicas do sistema
RUN apk add --no-cache python3 make g++ \
    && npm install -g pnpm@8

# Copia tudo (inclui pnpm-workspace.yaml e todos os pacotes)
COPY . .

# Instala dependências do workspace completo
RUN pnpm install --frozen-lockfile

# Compila o pacote específico do MCP Server Supabase
RUN pnpm --filter @supabase/mcp-server-supabase run build

# Etapa final (somente o que precisamos para rodar)
FROM node:20-alpine

WORKDIR /app

COPY --from=builder /app/packages/mcp-server-supabase/dist ./dist
COPY --from=builder /app/packages/mcp-server-supabase/package.json ./

EXPOSE 5050
CMD ["node", "dist/index.js"]
