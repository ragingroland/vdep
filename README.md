# VDEP — Data Engineering Playground

Учебный проект для построения современного data engineering окружения.

Цель проекта — собрать локальное хранилище данных с использованием практик, применяемых в production-средах:

* разделение слоев хранения данных;
* контейнеризация инфраструктуры;
* оркестрация ETL/ELT процессов;
* подготовка данных для аналитики;
* использование современных инструментов Data Engineering.

Проект развивается постепенно: от простого DWH на PostgreSQL до полноценного аналитического стека.

---

## Architecture

Текущая архитектура:

```
                 +----------------+
                 |   Data Source  |
                 +-------+--------+
                         |
                         v
                 +---------------+
                 |      RAW      |
                 |  PostgreSQL   |
                 +---------------+
                         |
                         v
                 +---------------+
                 |      STG      |
                 |  PostgreSQL   |
                 +---------------+
                         |
                         v
                 +---------------+
                 |      DM       |
                 | Data Marts    |
                 +---------------+

                         ^
                         |
                    Apache Airflow
                    (orchestration)

                         ^
                         |
                       dbt
                    (transformations)
```

---

## Technology stack

### Database

**PostgreSQL**

Используется как основное хранилище данных.

Функции:

* хранение исходных данных;
* подготовка данных;
* построение витрин;
* хранение метаданных Airflow.

---

### Transformation

**dbt (data build tool)**

Используется для:

* SQL-трансформаций;
* построения моделей данных;
* документирования преобразований;
* управления зависимостями между слоями.

Текущая схема:

```
raw -> stg -> dm
```

---

### Orchestration

**Apache Airflow**

Используется для:

* запуска ETL/ELT процессов;
* управления зависимостями между задачами;
* планирования загрузок;
* мониторинга выполнения pipeline.

Airflow запускается в Docker-контейнере.

---

## Data layers

### RAW

Слой сырых данных.

Назначение:

* хранение данных максимально близко к источнику;
* сохранение истории загрузок;
* возможность повторной обработки.

Пример:

```
raw.customer
raw.product
raw.orders
```

---

### STG (staging)

Подготовленный слой.

Здесь выполняются:

* очистка данных;
* приведение типов;
* дедупликация;
* базовые преобразования.

Пример:

```
stg.customer
stg.product
stg.orders
```

---

### DM (Data Mart)

Аналитический слой.

Содержит подготовленные данные для пользователей:

* отчеты;
* аналитика;
* BI-системы.

Пример:

```
dm.sales
dm.customer_activity
dm.product_statistics
```

---

## Infrastructure

Проект запускается через Docker Compose.

Текущие сервисы:

```
services:

postgresql
    |
    +-- DWH database
    |
    +-- Airflow metadata database


airflow-apiserver
airflow-scheduler
airflow-dag-processor
airflow-triggerer
```

---

## Project structure

```
vdep/

├── airflow/
│   ├── config/
│   ├── logs/
│   └── plugins/
│
├── postgresql/
│   ├── Dockerfile
│   └── db_init.sql
│
├── scripts/
│   └── dags/
│
├── docker-compose.yml
├── requirements.txt
├── .env.example
└── README.md
```

---

## Running locally

### Requirements

Installed:

* Docker
* Docker Compose
* Python 3.x
* WSL2 (recommended)

---

### 1. Clone repository

```bash
git clone <repository_url>

cd vdep
```

---

### 2. Create environment file

Create `.env`:

```env
POSTGRES_USER=postgres
POSTGRES_DB=postgres

FERNET_KEY=<generate_key>

AIRFLOW_UID=50000

_AIRFLOW_WWW_USER_USERNAME=airflow
_AIRFLOW_WWW_USER_PASSWORD=airflow
```

---

### 3. Build and start containers

```bash
docker compose build

docker compose up
```

---

### 4. Access Airflow UI

Open:

```
http://localhost:8080
```

Default credentials:

```
login:
airflow

password:
airflow
```

---

## Database users

The project uses separated database users:

```
postgres
    |
    +-- administrative user

airflow
    |
    +-- Airflow metadata database

lydemere
    |
    +-- DWH development user
```

The principle:

* administrative operations are separated;
* application users have only required permissions;
* database ownership is explicitly managed.

---

## Future plans

Roadmap:

### Data ingestion

* [ ] REST API ingestion
* [ ] CSV ingestion
* [ ] JSON event ingestion
* [ ] incremental loading

### Data warehouse

* [ ] Slowly Changing Dimensions (SCD)
* [ ] Fact and dimension modeling
* [ ] Historical tracking
* [ ] Data quality checks

### Pipeline

* [ ] Complete Airflow DAGs
* [ ] dbt models
* [ ] Automated testing
* [ ] CI/CD

### Analytics

* [ ] Apache Superset
* [ ] ClickHouse integration
* [ ] Analytical dashboards

---

## Purpose

This repository is a personal Data Engineering laboratory.

The goal is to build practical skills required for a Middle Data Engineer role:

* SQL;
* data modeling;
* ETL/ELT pipelines;
* orchestration;
* cloud-ready architecture principles;
* production-oriented development practices.
