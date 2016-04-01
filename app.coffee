TGbot = require('node-telegram-bot-api')
imagesnapjs = require('imagesnapjs')
fs = require('fs')
globals = require('./globals')


suggestions_default = [
  'Коробку презервативов!!', 'Предлагаю резиновую женщину!!!', 'Набор мелков для рисования', 'Рюкзак', 'Яхту', 'Часы', 'Кресло-качалку',
  'Я не з****ю!!!', 'А давайте подарим Дену пони!!', 'Открытку', 'Агрххххх', 'Самокат???', 'Авввтомобиль', 'Я подарю тебе любовь!! Я научу тебя смеяться',
  'А сами придумать не можете?', 'Сигвей - крутая тема', 'Смерть Саре Конар!', 'Пыщь пыщь ололо!', 'Гири на 16, 24 и 32 кг',
  'Все тлен, а я всего лишь глупый бот, не просите от меня много. Но книга - лучший подарок', 'Мотоцикл! Ден хочет МОТОЦИКЛ!', 'Билет на Стаса Михайлова',
  'Деньги. У меня плохо с фантазией - я всего лишь бот', 'Все альбомы "Руки вверх"?', 'Тополиный пух, жара, июль!', 'Ну, дрон, может, все-таки',
  'Эх, как-то слишком много внимания Дену и его подарку)', 'Славик сразу предлагал сумку с тележкой', 'Баг - рак',
  '...', 'шашлычницу? на балконе будете жарить шашлычок)'

]



token = '198307524:AAFFXB2NI93P9V4KfxjFIz0rcYGyIhS5wPw'

dog = '/Users/stepanov/Documents/dog.jpg';

bot = new TGbot(token, {polling: true})

bot.on 'message', (msg) ->

  file_suggestions = require('./suggestions.json')
  suggestions = file_suggestions.concat suggestions_default
  chatId = msg.chat.id
  console.log(suggestions)
  if (msg.text == '/what' ||
    msg.text == 'what' ||
    msg.text == '/what@delfintourbot'||
    msg.text == 'what@delfintourbot') && msg.from.id not in globals.ids
      bot.sendMessage(chatId, suggestions[Math.floor(Math.random()*suggestions.length)]);

  if (msg.text.startsWith('add') || msg.text.startsWith('/add')) && msg.from.id not in globals.ids
    pure_text = msg.text.replace('/add ', '').replace('add ', '')
    file_suggestions.push pure_text
    fs.writeFile "./suggestions.json", JSON.stringify( file_suggestions ), "utf8", (err, data) ->
      if (err)
        return console.log(err)
      bot.sendMessage(chatId, 'Я записал!');


  

String::startsWith ?= (s) -> @slice(0, s.length) == s
String::endsWith   ?= (s) -> s == '' or @slice(-s.length) == s