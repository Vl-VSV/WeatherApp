#  Weather

Тестовое задание

### Основная информация
- **Минимально поддерживаемая версия:** iOS 15.0 для iPhone
- **Поддерживаемые ориентации:** Portrait

### UI
* Решил сделать UI минималистичным из-за отсутствия макета, чтобы сэкономить время на его разработке
* Поддерживается темная тема

### Архитектура
* Использован фреймворк **SwiftUI** и архитектура **MVVM**

### Локализация
* Полностью локализовано под русский и английский языки

### Модульность
* Приложение небольшое, поэтому не разбито на много модулей
* NetworkLayer вынесен в отдельный модуль в качестве примера

### Трудности
* Получение прогноза по дням на будущее оказалось неудобным (желание получить запрос по дням), поэтому пришлось получать данные на несколько дней и фильтровать их
* Локализация не всегда корректно работает у API: есть города, в которых в русской локализации приходит название на английском

