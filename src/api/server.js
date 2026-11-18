const { Client } = require('pg');

// Factor 3 (Config): Усі налаштування беруться виключно зі змінних оточення
const client = new Client({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
});

client.connect()
  .then(() => console.log('Backend успішно підключився до PostgreSQL!'))
  .catch(err => console.error('Помилка підключення до БД:', err.stack));

// Factor 9 (Disposability): Обробка сигналу для коректного завершення роботи
process.on('SIGTERM', () => {
  console.log('Отримано SIGTERM, коректно завершуємо процеси...');
  client.end();
  process.exit(0);
});

console.log("API Server працює. Очікування запитів...");