# Alarstudios

Краткое описание:
 
Стэк: Swift  
В дополнительных зависимостях смыла не вижу.
 
Проект с архитектурой MVP + Router (ну можно коодинаторв в целом)
Model - активная инжектит UseCase
Presenter - Простая простойка для декорации юи и абстрации модели от вью
View - это UIViewController
 
UseCase - единица бизнеслогики
- может инжектить только репозитории
- имеет одну публичную функцию invoke
- должен быть покрыт юнит тестами
 
Репозиторий - отвественность репозитория это выбор источника информации сеть, память, база;
- репозиторий  абстракция чтобы логика была изолирована от источника данных;
- репозиторий всегда описывается через протокол;
- в репозитории всегда возврает результат в main;
