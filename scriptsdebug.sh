#!/bin/bash
# scripts/debug.sh — "Neden çalışmıyor?" sorusunun cevabı

echo "=== 🔍 Pardus Debug Mode ==="
cd /home/$USER/poc || cd /home/root/poc || true
sudo lsof /home/$USER/poc/poc.sh 2>/dev/null || echo "Sadece file var"
sudo ls -la /home/$USER/poc/
sudo cat /var/log/apt/history.log | grep -A 5 "poc.sh"
sudo tail -f /tmp/pardus_log/*.log
