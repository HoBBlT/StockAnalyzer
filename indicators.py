import pandas as pd

def calculate_trend(prices, sma_short=7, sma_long=30):
    """prices — список (date, close)"""
    df = pd.DataFrame(prices, columns=["date", "close"])
    df["sma_short"] = df["close"].rolling(sma_short).mean()
    df["sma_long"] = df["close"].rolling(sma_long).mean()
    df["diff_pct"] = (df["sma_short"] - df["sma_long"]) / df["sma_long"] * 100
    df["trend"] = df["diff_pct"].apply(lambda x: "up" if x > 0 else "down")
    return df.tail(1).iloc[0]  # только последний день
