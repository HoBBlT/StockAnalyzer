import os
from dotenv import load_dotenv
from db import get_conn
from t_tech.invest import Client

load_dotenv()
TOKEN = os.getenv("TINKOFF_TOKEN")

def main():
    ticker = input("Введите тикер бумаги:\n")
    try:
        conn = get_conn()

        with Client(TOKEN) as client:
            response = client.instruments.find_instrument(query=ticker)

            if not response.instruments:
                print("Тикер не найден")
                return

            print(f"Найдено вариантов: {len(response.instruments)}")

            for i, inst in enumerate(response.instruments, start=1):
                print(f"\n--- Вариант {i} ---")
                print("Название:", inst.name)
                print("Ticker:", inst.ticker)
                print("UID:", inst.uid)
                print("FIGI:", inst.figi)
                print("Class code:", inst.class_code)
	    
	            # Получение цены последней сделки
                
                # Использование figi для запроса
                last_prices = client.market_data.get_last_prices(figi=[inst.figi])
                
                if last_prices.last_prices:
                    price = last_prices.last_prices[0].price
                    price_value = price.units + price.nano / 1e9
                    print(f"Последняя цена: {price_value}")
                else:
                    print("Цена не найдена")
            while True:
                # 1. Получаем ввод от пользователя (всегда строка)
                num_str = input("Выберите номер инструмента:\n")
    
                # 2. Проверяем, состоит ли строка только из цифр
                if num_str.isdigit():
                    num = int(num_str)-1  # Переводим строку в число
                    break  # Выходим из цикла, проверка пройдена
                else:
                    print("Ошибка! Вы ввели не цифру. Попробуйте еще раз.\n")
            with conn.cursor() as cur:
                cur.execute("""
        	        INSERT INTO stocks (ticker, name, uid, figi)
        	        VALUES (%s, %s, %s, %s)
                    ON CONFLICT (figi) DO NOTHING;
    	            """, (response.instruments[num].ticker, response.instruments[num].name, response.instruments[num].uid,response.instruments[num].figi))
                conn.commit()
    except Exception as e:
        print(f"{e}")
    finally:
        if conn is not None:
            conn.close()


if __name__ == "__main__":
    main()