import telebot
from telebot import types

TOKEN = '8931223238:AAFeyEYZKhBMjj7C8_qLm0vMEPw7AjH3ypA'
bot = telebot.TeleBot(TOKEN)

WEB_APP_URL = 'https://aboode2004.github.io/mssd/'

@bot.message_handler(commands=['start', 'help'])
def send_welcome(message):
    markup = types.InlineKeyboardMarkup()
    web_app = types.WebAppInfo(url=WEB_APP_URL)
    btn = types.InlineKeyboardButton(text='🎨 فتح مصمم أغلفة التقارير', web_app=web_app)
    markup.add(btn)
    bot.send_message(message.chat.id, 'مرحباً بك! اضغط على الزر أدناه لفتح التطبيق المصغر:', reply_markup=markup)

print('Bot is running...')
bot.infinity_polling()
