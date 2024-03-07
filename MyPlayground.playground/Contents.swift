import UIKit

var greeting = "Hello, playground"

import Foundation

/*
 
 Домашнє завдання 3
 
 Частина 2
 
 Є готовий код, але він виконується з помилками. Необхідно їх виправити.
 
 Код нижче умовно можна розділити на 2 секції:
    1 - опис своїх типів (або резервування типів) для їх подальшого використання,
        що виконується не одразу, а десь далі у реалізації сценаріїв, або конкретних дій, або логіки.
    2 - створення констант/змінних для зберігання "екземплярів" (instanse).
        Тобто, щоб звернутися до змінної/поля, або функції, описаної в класі/структурі та записати/прочитати значення,
        необхідно виділити пам'ять, якось її назвати та сказати якого типу вона буде,
        чи простого (String/Int/Double/...), чи того типу, який ви описали (enum/class/struct)
 
 Також, спробуйте подивитись та проаналізувати написаний код - це простенький приклад, як краще і зручніше
 організувати та реалізовувати логіку задач.
 
 Так, можна написати все в одному файлі, або в одному місці і воно працюватиме.
 
 Але, краще відокремити різну логіку в різні області видимості {  } та дати цьому відповідну назву,
 а тоді використовувати, де це необхідно, посилаючись на назву
 
 */


// СЕКЦІЯ 1 - Резервування або опис своїх типів, які будуть використовуватися (ініціюватися та викликатися) у секції 2




// ВИПРАВЛЕННЯ


typealias ProductInfo = (productName: String, price: Double, currency: String, socket: String, processor: String)

enum Discount {
    case regular, vip, none
}

enum ProcessorType: String {
    case intel = "Intel", amd = "AMD", none = ""
}

enum Currency: String {
    case uah = "₴", usd = "$", eur = "€"
}

struct MotherBoard {
    var socket = ""
    var processor: ProcessorType = .none
}

class Product {
    var name: String
    var price: Double
    var currency: Currency
    var motherBoard: MotherBoard
    
    init(name: String, price: Double, currency: Currency, motherBoard: MotherBoard) {
        self.name = name
        self.price = price
        self.currency = currency
        self.motherBoard = motherBoard
    }
    
    func textDescription() -> String {
        let formattedPrice = String(format: "%.2f", price)
        return "Назва продукту: \(name), Ціна: \(currency.rawValue)\(formattedPrice)\nСокет: \(motherBoard.socket), Процесор: \(motherBoard.processor.rawValue)"
    }
}

class Cart {
    var products: [Product] = []
    var discount: Discount = .none
    
    func removeSelectedProduct(at index: Int) {
        if index < products.count {
            products.remove(at: index)
        }
    }
    
    func clear() {
        products.removeAll()
    }
    
    // додано removeAll для видалення всіх продуктів
    
    func totalPrice() -> Double {
        products.reduce(0) { $0 + $1.price }
    }
    
    func discountPercentValue() -> Int {
        switch discount {
        case .regular: return 5
        case .vip: return 15
        case .none: return 0
        }
    }
    
    func totalPriceWithDiscount() -> Double {
        let total = totalPrice()
        return total - (total * Double(discountPercentValue()) / 100.0)
    }
}

class DataMapper {
    func products(from productInfoList: [ProductInfo]) -> [Product] {
        productInfoList.map { info in
            let currency = Currency(rawValue: info.currency) ?? .uah
            let processor = ProcessorType(rawValue: info.processor) ?? .none
            let motherBoard = MotherBoard(socket: info.socket, processor: processor)
            return Product(name: info.productName, price: info.price, currency: currency, motherBoard: motherBoard)
        }
    }
}

class Screen {
    func printCart(cart: Cart, currency: Currency) {
        var resultStringToPrint = "------------------------ Обрана валюта: \(currency.rawValue) ---------------------------\n"
        
        cart.products.enumerated().forEach { index, product in
            let priceInSelectedCurrency = convertPrice(product.price, from: product.currency, to: currency)
            resultStringToPrint += "\(index + 1). Назва продукту: \(product.name), Ціна: \(currency.rawValue) \(String(format: "%.2f", priceInSelectedCurrency))\n"
        }
        
        resultStringToPrint += "---------------------------------------------------------------------"
        print(resultStringToPrint)
    }
    
    private func convertPrice(_ price: Double, from originalCurrency: Currency, to targetCurrency: Currency) -> Double {
       
        return price
    }
}

// додана функція сonvertPrice – для відобреження конвертування



// КІНЕЦЬ СЕКЦІЇ 1



// СЕКЦІЯ 2 - Використання типів, описаних у секції 1


/*
 
 Пункт 1
 
 1  Розкоментуйте код нижче
    між коментарем:
        Початок коду сценарію для Пункт 1
    та коментарем:
        Кінець коду сценарію для Пункт 1

 2 Запустіть код і в консолі побачите друк чеку для всіх продуктів у корзині Користувача
 3 Користувач має VIP знижку (discount), але йому друкується чек з ціною без урахування знижки
 
 Необхідно виправити код виконання сценарію, щоб користувачу друкувався чек з ціною, яка враховує знижку VIP
 
 !! Код з Пункту 1 буде використовуватися у сценарію Пункта 2
 
 */

// Початок коду сценарію для Пункт 1

/*

print("SCENARIO 1:\n")

// Створюємо константу для зберігання "екземпляру" (instanse) ResponseFromServer
let responseFromServer = ResponseFromServer()
// Створюємо константу для зберігання списку товарів, які отримали з сервера,
// у якомусь не дуже зручному форматі (у даному випадку Tuples)
let receivedProducts = responseFromServer.sourceProducts
// Створюємо константу для зберігання "екземпляру" (instanse) DataMapper
let dataMapper = DataMapper()

// Створюємо константу для зберігання "екземпляру" (instanse) Cart
let cart = Cart()
// Звертаємось до поля (змінної класу Cart), щоб записати в неї масив сконвертованих даних
cart.products = dataMapper.products(from: receivedProducts)
// Звертаємось до поля (змінної класу Cart), щоб записати значення discount
cart.discount = .none

// Створюємо константу для зберігання "екземпляру" (instanse) Screen
let screen = Screen()
// Викликаємо метод printCheck для друку у консоль
// і передаємо константу cart як параметр у функцію
screen.printCheck(cart: cart)

*/

// Кінець коду сценарію для Пункт 1


/*
 
 Пункт 2
 
 Опис сценарію пункта 2:
 
    Інший розробник, який писав код, дуже поспішав і не первірив його виконання,
    відправив додаток на тестування і поїхав у своїх справах.

    Тестувальник звернувся до вас з проханням швидко виправити знайдений критичний баг і надіслав наступний опис:
    
    1 Користувач обрав три продукти
    2 Користувач вирішив очистити кошик, натиснувши кнопку Clear,
    3 Додаток аварійно завершився (crash)
 
    Задача:
    - Виправити crash, який виникає при натисканні на кнопку Clear
    - Якщо кошик порожній і користувач натискає кнопку "Оформити замовлення",
      замість чеку з нулями має виводитись текст:
        "Кошик пустий. Для оформлення замовлення додайте хоча б один товар"
 
    * Примітка:
        Дію кнопки Clear виконує функція з назвою clear()
 
 
 1  Розкоментуйте код нижче
    між коментарем:
        Початок коду сценарію для Пункт 2
    та коментарем:
        Кінець коду сценарію для Пункт 2

 2 Запустіть код і ви побачите підсвітку червоним, що є crash
 
 Необхідно знайти та виправити помилку, щоб не було crash
 
 !! Код з Пункту 1 буде використовуватися у сценарію Пункта 3
 
 */


// Початок коду сценарію для Пункт 2

/*
 
print("\nSCENARIO 2:\n")

// Користувач додає три товари у кошик
cart.products = dataMapper.products(from: responseFromServer.get3Products())
// Користувач натискає десь на екрані кнопку "Очистити кошик" (Clear)
cart.clear()

// Користувач натискає кнопку "Оформити замовлення", щоб побачити чек
screen.printCheck(cart: cart)

 */

// Кінець коду сценарію для Пункт 2



/*
 
 Пункт 3
 
 Опис сценарію пункта 3:
 
    Інший розробник, який писав код, відійшов по каву, а його кіт пробігся по клавіатурі.
    Коли розробник повернувся, то не помітив ніяких змін (тому, що не підключив git, де видно всі зміни 😅)
    і відправив build (збірку/додаток) на тестування.

    Тестувальник звернувся до вас з проханням швидко виправити знайдений баг і надіслав наступний опис:
    
    1 Користувач обрав додав продукти (кількість не має значення)
    2 Користувач вирішив подивитись ціни у різних валютах
    3 Коли кооистувач зміню валюту на USD або EUR - символ валюти змінюється, а ціна залишається у гривнях
 
    Задача:
    - Виправити логіку відображення цін відповідно до обраної валюти
 
 
 1  Розкоментуйте код нижче
    між коментарем:
        Початок коду сценарію для Пункт 3
    та коментарем:
        Кінець коду сценарію для Пункт 3

 2 Запустіть код і ви побачите в консолі 3 списки товарів з цінами у різних валютах
 
 Необхідно знайти та виправити помилку, щоб ціни відповідали обраній валюті
 
 */


// Початок коду сценарію для Пункт 3

/*

print("\nSCENARIO 3:\n")

// Користувач обирає якусь кількість товарів
cart.products = dataMapper.products(from: responseFromServer.sourceProducts)

// Користувач натискає кнопку зміни валюти на UAH
screen.printCart(cart: cart, currency: .uah)
// Користувач натискає кнопку зміни валюти на USD
screen.printCart(cart: cart, currency: .usd)
// Користувач натискає кнопку зміни валюти на EUR
screen.printCart(cart: cart, currency: .eur)

 */
 
// Кінець коду сценарію для Пункт 3


// КІНЕЦЬ СЕКЦІЇ 2
