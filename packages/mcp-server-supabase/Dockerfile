# ---------- Etapa 1: Build ----------
FROM node:20-alpine AS builder

WORKDIR /app

# Copia os arquivos necessários
COPY package*.json ./
COPY tsconfig.json ./

# Instala dependências
RUN npm install --legacy-peer-deps

# Compila o código TypeScript
RUN npm run build

# ---------- Etapa 2: Execução ----------
FROM node:20-alpine

WORKDIR /app

COPY --from=builder /app/packages/mcp-server-supabase/dist ./dist
COPY package*.json ./

RUN npm install --omit=dev --legacy-peer-deps

EXPOSE 5050

CMD ["node", "dist/index.js"]
