Описание: Проект для анализа акций: собирает данные о ценах через Tinkoff Invest API, сохраняет их в PostgreSQL и вычисляет тренд за последний месяц.

Технологии: Python 3.13+ PostgreSQL Pandas Tinkoff Invest API (через t-tech-investments) python-dotenv для хранения токена

Создание бд и загрузка дампа из файла в PostgreSQL вставте свои пути для поиска используйте:
where /r . "createdb.exe"

"вашпуть\createdb.exe" -U postgres -h localhost stocksdb1
"вашпуть\psql.exe" -U postgres -h localhost -d stocksdb1 -f "путь до файла schema.sql"


Для запуска главного файла вставте свои значения в .env файл. Файл .env.example это пример.
python -m venv venv
venv\Scripts\activate.bat
pip install -r requirements.txt
set SSL_TBANK_VERIFY=True
python main.py


Для добавления тикера необходимо заупстить TikerData.py