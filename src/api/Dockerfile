# Етап 1: Встановлення залежностей (Buider)
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./

RUN npm install
COPY . .

# Етап 2: Середовище виконання (Runtime)
FROM node:20-alpine
WORKDIR /app
# Створення непривілейованого користувача (Security)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Копіюємо лише необхідне з етапу builder
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/server.js ./

# Перемикаємось на безпечного користувача
USER appuser

EXPOSE 3000
CMD ["npm", "start"]