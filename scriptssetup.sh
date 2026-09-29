#!/bin/bash
# scripts/setup.sh — İlk adımı atlayanlar için

echo "=== 🎩 Pardus Jailbreak Setup ($VERSION) ==="

# 1. Grubu kur
sudo groupadd pardus-software 2>/dev/null || sudo groupmod -n "pardus-software" "pardus-software"

# 2. Kullanıcıyı bul
YOURNAME=$(whoami)
sudo usermod -aG pardus-software $YOURNAME

# 3. Klasörü hazırla
cd /home/$YOURNAME
sudo mkdir -p /home/$YOURNAME/poc

# 4. Scripti yerleştir (Eğer script yoksa kopyala)
cp /home/$YOURNAME/../scripts/poc.sh /home/$YOURNAME/poc/ || true
sudo chown $YOURNAME:pardus-software /home/$YOURNAME/poc/poc.sh
sudo chmod 755 /home/$YOURNAME/poc/poc.sh

# 5. İşaretleme
touch /home/$YOURNAME/poc/.pardus_ready
echo "✅ Home dizini hazırlanmış. Komut: sudo /home/$YOURNAME/poc/poc.sh B"
