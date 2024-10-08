# language: ru

# Тестовые данные:
  # $Логин_БД user
  # $Пароль_БД pass

@db-tests
Функция: Добавление нового продукта в базу данных

  Предыстория:
    Допустим к БД выполнено подключение "H2" с параметрами:
      | field        | value        |
      | Пользователь | #{Логин_БД}  |
      | Пароль       | #{Пароль_БД} |

  @correct
  Структура сценария: Проверка добавления корректных данных в таблицу FOOD БД
  Проверка корректности добавления нового товара в таблицу FOOD
  базы данных тестового стенда посредством выполнения SQL запроса
    * из БД выбирается строка запросом "Получение первого свободного ID"
    * к БД выполняется запрос "Добавление продукта" c параметрами:
      | field        | value                       |
      | ID           | #field{Первый свободный ID} |
      | БД_Название     | <бд_название>               |
      | БД_Тип          | <бд_тип>                    |
      | БД_Экзотический | <бд_экзотический>           |
    * из БД выбирается строка запросом "Получение последнего занятого ID"
    * к БД выполняется запрос "Получение продукта" c параметрами:
      | field | value                        |
      | ID    | #field{Последний занятый ID} |
    * количество элементов коллекции "Получение продукта" не равно нулю
    * выбран элемент коллекции "Получение продукта" с индексом "0"
    * значение поля "БД_Название" равно "<бд_название>"
    * значение поля "БД_Экзотический" равно "<бд_экзотический>"
    * значение поля "БД_Тип" равно "<бд_тип>"
    * из БД выбирается строка запросом "Получение последнего занятого ID"
    * к БД выполняется запрос "Удаление продукта" c параметрами:
      | field | value                        |
      | ID    | #field{Последний занятый ID} |
    * закрыто подключение к БД

    Примеры:
      | бд_название | бд_тип    | бд_экзотический |
      | Мандарин    | FRUIT     | 1               |
      | Огурец      | VEGETABLE | 0               |