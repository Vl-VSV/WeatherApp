#  Weather

### Основная информация
- **Минимально поддерживаемая версия:** iOS 15.0 для iPhone
- **Поддерживаемые ориентации:** Portrait

### UI
* Решил сделать UI минималистичным из-за отсутствия макета, чтобы сэкономить время на его разработке
* Поддерживается темная тема

### Архитектура
* Использован фреймворк **SwiftUI** и архитектура **MVVM** из-за малого размера приложения, отсутствия необходимости в тестировании и длительной поддержки

### Локализация
* Полностью локализовано под русский и английский языки

### Модульность
* Приложение небольшое, поэтому не разбито на много модулей
* NetworkLayer вынесен в отдельный модуль в качестве примера

### Трудности
* Получение прогноза по дням на будущее оказалось неудобным (желание получить запрос по дням), поэтому пришлось получать данные на несколько дней и фильтровать их
* Локализация не всегда корректно работает у API: есть города, в которых в русской локализации приходит название на английском
* Затруднения с предложениями по городам при поиске: API не предоставляет возможности для запроса городов, и времени на поиск и подключение другого API не было. Зашивка хардкод массива с городами также не лучшее решение, поэтому было принято решение использовать список стран из NSLocale и взять несколько примеров, с которыми API работает корректно
