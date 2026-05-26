Требования:
    -- Сервер/VM/ПК/etc. на Debian Trixie
    -- Вышеуказанная платформа должна соответствовать техническим требованиям Docker Engine 29.5.2
    -- Вышеуказанная платформа должна соответствовать техническим требованиям PostgreSQL 18.4

Запуск:
    Виртуальное окружение Python:
        cd /папка/проекта
        python -m venv venv
        source venv/bin/activate
        pip install -r requirements.txt
        deactivate

    Создать файл "postgres_password.txt" в котором прописать пароль для суперпользователя postgres.

    Сборка образа в Docker:
        docker compose build --no-cache
        docker compose up
        docker compose down
