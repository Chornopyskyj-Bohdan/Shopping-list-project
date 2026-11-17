# Етап 1: Збірка фронтенду
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
COPY . .
# Генерує статику
RUN npm run build

# Етап 2: Роздача статики через Nginx
# Використовує готовий unprivileged образ, який працює від імені non-root (port 8080)
FROM nginxinc/nginx-unprivileged:alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 8080