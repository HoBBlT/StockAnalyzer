import os

from dotenv import load_dotenv
from t_tech.invest import Client, CandleInterval
from datetime import datetime, timedelta

load_dotenv()

def get_candles(figi: str, days=60):
    with Client(token=os.getenv("TINKOFF_TOKEN")) as client:
        response = client.market_data.get_candles(
            figi=figi,
            from_=datetime.utcnow() - timedelta(days=days),
            to=datetime.utcnow(),
            interval=CandleInterval.CANDLE_INTERVAL_DAY
        )
    return response.candles
