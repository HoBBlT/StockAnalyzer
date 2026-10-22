import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

def get_conn():
    return psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASS"),
    )

# --- prices ---
def insert_price(stock_id, date, close, conn):
    with conn.cursor() as cur:
    	cur.execute("""
        	INSERT INTO prices (stock_id, trade_date, close)
        	VALUES (%s, %s, %s)
        	ON CONFLICT (stock_id, trade_date) DO NOTHING;
    	""", (stock_id, date, close))

def get_prices(stock_id, conn):
    with conn.cursor() as cur:
        cur.execute("""
            SELECT trade_date, close FROM prices
            WHERE stock_id=%s
            ORDER BY trade_date ASC;
        """, (stock_id,))
        return cur.fetchall()

# --- history_trends ---
def insert_trend(stock_id, date, sma_short, sma_long, diff, trend, conn):

    # Конвертируем np.float64 → float
    if sma_short is not None:
        sma_short = float(sma_short)
    if sma_long is not None:
        sma_long = float(sma_long)
    if diff is not None:
        diff = float(diff)

    with conn.cursor() as cur:
        cur.execute("""
            INSERT INTO history_trends (
                stock_id, calculated_at, days, sma_short, sma_long, diff_percent, trend
            )
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            ON CONFLICT (stock_id, calculated_at) DO NOTHING;
        """, (stock_id, date, 30, sma_short, sma_long, diff, trend))