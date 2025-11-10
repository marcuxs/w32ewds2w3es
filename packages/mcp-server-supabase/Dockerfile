# Etapa de build
FROM node:20-alpine AS builder

WORKDIR /app

# Instala versão compatível do pnpm (v8)
RUN npm install -g pnpm@8

# Copia todos os arquivos do projeto
COPY . .

# Instala dependências (sem exigir todos os workspaces)
RUN pnpm install --ignore-workspace --filter . --prod=false

# Compila o código TypeScript
RUN pnpm run build

# Etapa final (para produção)
FROM node:20-alpine

WORKDIR /app

# Copia apenas os arquivos necessários da etapa anterior
COPY --from=builder /app /app

EXPOSE 5050

CMD ["node", "dist/index.js"]
