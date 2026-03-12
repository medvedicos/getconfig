#!/bin/bash
set -e  # остановить выполнение при любой ошибке

CRONTAB=/etc/crontabs/root
CRON_TIME="4 0 * * 1"

download_and_enable() {
    local name="$1"
    local url="$2"
    local dest="/etc/init.d/$name"

    echo "[*] Скачиваем $name..."
    curl -fsSL "$url" --output "$dest" || { echo "[!] Ошибка скачивания $name"; return 1; }
    chmod +x "$dest"
    "$dest" enable && "$dest" start && echo "[+] $name запущен"
}

download_and_enable getconfig \
    "https://raw.githubusercontent.com/medvedicos/getconfig/refs/heads/main/Megafon/getconfig"

download_and_enable getexclude \
    "https://raw.githubusercontent.com/medvedicos/getconfig/refs/heads/main/getexclude"

# Добавляем cron только если записи ещё нет
for service in getconfig getexclude; do
    CRON_ENTRY="$CRON_TIME  /etc/init.d/$service restart"
    if ! grep -qF "$CRON_ENTRY" "$CRONTAB" 2>/dev/null; then
        echo "$CRON_ENTRY" >> "$CRONTAB"
        echo "[+] Cron для $service добавлен"
    else
        echo "[-] Cron для $service уже существует, пропускаем"
    fi
done

echo "[*] Готово"
