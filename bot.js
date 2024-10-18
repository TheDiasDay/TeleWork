const TelegramBot = require('node-telegram-bot-api');
require('dotenv').config();

// Получите токен из файла .env
const token = process.env.TELEGRAM_BOT_TOKEN;

// Создайте экземпляр бота
const bot = new TelegramBot(token, { polling: true });

// Обработчик команды /start
bot.onText(/\/start/, (msg) => {
    const chatId = msg.chat.id;

    // Создаем клавиатуру с кнопкой Mini App
    const options = {
        reply_markup: {
            inline_keyboard: [
                [
                    {
                        text: 'Открыть Mini App',
                        web_app: {
                            url: 'https://your-mini-app-url.com', // Замените на ваш URL Mini App
                        },
                    },
                ],
            ],
        },
    };

    bot.sendMessage(chatId, 'Добро пожаловать в моего бота! Нажмите на кнопку ниже, чтобы открыть Mini App.', options);
});

// Обработчик текстовых сообщений
bot.on('message', (msg) => {
    const chatId = msg.chat.id;
    bot.sendMessage(chatId, `Вы написали: ${msg.text}`);
});