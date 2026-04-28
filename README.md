# 🚀 Proxy Stack (Xray + Hysteria + Dante + MTProto + Alerts)

Готовый стек прокси-сервисов для VPS:

* **Xray (VLESS + REALITY)**
* **Hysteria 2**
* **Dante (SOCKS5)**
* **MTProto (Telegram proxy)**
* **Telegram Alerts (уведомления о падении контейнеров)**

---

## 📦 Что делает этот проект

Поднимает полный набор прокси-сервисов в Docker одной командой:

* защищённый VPN (VLESS REALITY)
* быстрый UDP-туннель (Hysteria)
* SOCKS5 прокси (Dante)
* MTProto прокси для Telegram
* мониторинг контейнеров + алерты в Telegram

---

## ⚙️ Требования

* VPS (Debian 11/12)
* root доступ
* открытые порты (443, 8888, 2095 и др.)

---

## 🚀 Быстрый запуск

### 1. Клонируем репозиторий

```bash
git clone git@github.com:evgeniy167/vpn.git
cd vpn
```

---

### 2. Запускаем установку

```bash
chmod +x install.sh
./install.sh
```

---

## 🔐 Настройка Telegram уведомлений

### 1. Создай бота через BotFather

Получи:

* BOT_TOKEN

---

### 2. Узнай свой chat_id

Напиши боту любое сообщение и выполни:

```bash
curl https://api.telegram.org/bot<BOT_TOKEN>/getUpdates
```

---

### 3. Создай файл `.env`

```bash
nano /opt/proxy-stack/.env
```

Пример:

```
BOT_TOKEN=ТВОЙ_ТОКЕН
CHAT_ID=ТВОЙ_CHAT_ID
```

---

### 4. Применить настройки

```bash
source /opt/proxy-stack/.env
systemctl restart docker-alerts
```

---

## 🔔 Проверка алертов

```bash
docker stop dante
```

👉 должно прийти сообщение в Telegram

---

## 📡 Сервисы

| Сервис   | Описание       |
| -------- | -------------- |
| Xray     | основной VPN   |
| Hysteria | быстрый UDP    |
| Dante    | SOCKS5         |
| MTProto  | Telegram proxy |
| Alerts   | уведомления    |

---

## 🛠 Полезные команды

Проверка контейнеров:

```bash
docker ps
```

Логи:

```bash
docker logs -f dante
```

Перезапуск:

```bash
docker restart dante
```

---

## ⚠️ Важно

* НЕ коммить `.env`
* НЕ публикуй BOT_TOKEN
* если токен утёк → `/revoke` в BotFather

---

## 📁 Структура

```
configs/        конфиги сервисов  
dante/          Dockerfile SOCKS5  
install.sh      установка  
generate.sh     генерация конфигов  
alert.sh        алерты Docker  
port-alert.sh   проверка портов  
```

---

## 💡 Идея

Проект для быстрого развёртывания прокси-стека с нуля на любом VPS.

---

## 🧠 Автор

evgeniy167
