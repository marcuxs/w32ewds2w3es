# Etapa de build
FROM node:20-alpine AS builder

WORKDIR /app

# Instala pnpm
RUN npm install -g pnpm

# Copia os arquivos do projeto
COPY . .

# Instala dependências ignorando workspaces ausentes
RUN pnpm install --ignore-workspace-root-check --filter ./...

# Compila o código TypeScript
RUN pnpm run build

# Etapa final (para produção)
FROM node:20-alpine

WORKDIR /app

# Copia apenas os arquivos necessários da etapa anterior
COPY --from=builder /app /app

EXPOSE 5050

CMD ["node", "dist/index.js"]
