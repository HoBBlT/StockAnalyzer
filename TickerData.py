import os
from dotenv import load_dotenv

from t_tech.invest import Client

load_dotenv()
TOKEN = os.getenv("TINKOFF_TOKEN")

def main():
    ticker = "YDEX"

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


if __name__ == "__main__":
    main()