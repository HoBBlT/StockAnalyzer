from db import get_conn, insert_price, get_prices, insert_trend
from api import get_candles
from indicators import calculate_trend

def process_ticker(stock_id: int, figi: str):
    try:
        candles = get_candles(figi, days=60)
    except Exception as e:
        print(f"{stock_id}: ошибка при получении свечей - {e}")
        return

    # сохранение цен
    for c in candles:
        close_price = float(c.close.units + c.close.nano / 1e9)  #units - целая часть,nano - десятичная в 10^9
        insert_price(stock_id, c.time.date(), close_price)

    # анализ
    price_data = get_prices(stock_id)
    if len(price_data) < 30:
        trend_val = "NOT_ENOUGH_DATA"
        sma_short = sma_long = diff = None
    else:
        result = calculate_trend(price_data)
        sma_short = result["sma_short"]
        sma_long = result["sma_long"]
        diff = result["diff_pct"]
        trend_val = result["trend"].upper()  # 'UP'/'DOWN'

    insert_trend(
        stock_id=stock_id,
        date=price_data[-1][0] if price_data else None,
        sma_short=sma_short,
        sma_long=sma_long,
        diff=diff,
        trend=trend_val
    )
    print(f"{figi}: тренд записан → {trend_val}")


if __name__ == "__main__":
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("SELECT id, figi FROM stocks;")
    stocks = cur.fetchall()
    cur.close()
    conn.close()

    for stock_id, figi in stocks:
        process_ticker(stock_id, figi)
