Описание: Проект для анализа акций: собирает данные о ценах через Tinkoff Invest API, сохраняет их в PostgreSQL и вычисляет тренд за последний месяц.

Технологии: Python 3.13+ PostgreSQL Pandas Tinkoff Invest API (через t-tech-investments) python-dotenv для хранения токена

Для запуска вставте свои значения в .env файл. Файл .env.example это пример.
python -m venv venv
venv\Scripts\activate.bat
pip install -r requirements.txt
set SSL_TBANK_VERIFY=True
python main.py