
# Архітектура системи (C4 Model та Deployment View)

Цей документ описує архітектуру системи планування покупок з використанням підходу **Architecture as Code**. Діаграми побудовані за допомогою синтаксису Mermaid.js.

## 1. C4 Level 1: System Context

Діаграма відображає взаємодію користувачів із системою та зовнішніми сервісами на найвищому рівні абстракції.

```mermaid
graph TD
    User([Користувач / Сім'я])

    subgraph Core ["Shopping List System Context"]
        SLS[Система управління списками покупок]
    end

    PushNotifications[External: Push/Email Notifications]
    Analytics[External: Analytics & Error Tracking]

    User -- "Створює списки, відмічає товари" --> SLS
    SLS -- "Надсилає сповіщення про оновлення" --> PushNotifications
    PushNotifications -- "Сповіщає Push/Email" --> User
    SLS -- "Надсилає логи та метрики" --> Analytics

    classDef person fill:#08427b,stroke:#052e56,color:#fff;
    classDef system fill:#1168bd,stroke:#0b4884,color:#fff;
    classDef extSystem fill:#999999,stroke:#6b6b6b,color:#fff;

    class User person;
    class SLS system;
    class PushNotifications,Analytics extSystem;
```

## 2. C4 Level 2: Container Diagram

Діаграма демонструє основні програмні компоненти системи, їхню відповідальність та взаємодію між собою.

```mermaid
graph TD
    User([Користувач])

    subgraph SLS ["Shopping List System"]
        WebApp["Web Application (React)"]
        MobileApp["Mobile App (Flutter/React Native)"]
        API["API Gateway & Core Service (Node.js/NestJS)"]
        DB[("Relational Database (PostgreSQL)")]
        Cache[("In-Memory Cache (Redis)")]
    end

    User -- "Використовує браузер" --> WebApp
    User -- "Використовує смартфон" --> MobileApp

    WebApp -- "REST API, WebSockets" --> API
    MobileApp -- "REST API, WebSockets" --> API

    API -- "Зчитує/Записує дані" --> DB
    API -- "Pub/Sub для оновлень у реальному часі" --> Cache

    classDef person fill:#08427b,stroke:#052e56,color:#fff;
    classDef container fill:#438dd5,stroke:#2e6295,color:#fff;
    classDef database fill:#2e6295,stroke:#113d6b,color:#fff;

    class User person;
    class WebApp,MobileApp,API container;
    class DB,Cache database;
```

## 3. Deployment View: Діаграма розгортання

Діаграма відображає передбачувану інфраструктуру розгортання застосунку у хмарному середовищі з використанням контейнеризації Docker та оркестрації Kubernetes.

```mermaid
graph TB
    subgraph Cloud ["Cloud Provider (AWS / GCP / Azure)"]
        LoadBalancer["Load Balancer"]

        subgraph KubernetesCluster ["Kubernetes Cluster"]
            subgraph Node1 ["Worker Node 1"]
                PodAPI1["API Pod 1 (Node.js/Docker)"]
                PodWeb["Web Frontend Pod (Nginx)"]
            end

            subgraph Node2 ["Worker Node 2"]
                PodAPI2["API Pod 2 (Node.js/Docker)"]
            end
        end

        subgraph ManagedServices ["Managed Stateful Services"]
            RDS[("Managed PostgreSQL (Primary)")]
            ElastiCache[("Managed Redis Cluster")]
        end
    end

    Internet((Internet)) --> LoadBalancer
    LoadBalancer --> PodAPI1
    LoadBalancer --> PodAPI2
    LoadBalancer --> PodWeb

    PodAPI1 --> RDS
    PodAPI2 --> RDS
    PodAPI1 --> ElastiCache
    PodAPI2 --> ElastiCache
```