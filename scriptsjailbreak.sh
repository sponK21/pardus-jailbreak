#!/bin/bash
# scripts/jailbreak.sh — Repo'nun Kontrol Merkezi

SRC="poc.sh"
VARIANT="${1:-local}"

case "$VARIANT" in
    local)
        USER=$(whoami)
        TARGET="/home/$USER/poc/$SRC"
        
        if [ -f "$TARGET" ]; then
            echo "Kullanıcı '$USER' için betik bulundu: $TARGET"
            sudo "$TARGET" autoupdate
            sleep 2
            sudo "$TARGET" B
        else
            echo "Not Found. Running Direct Mode:"
            cd "$(dirname "$0")"
            ./jailbreak.sh auto
        fi
        ;;
    auto)
        VICTIM=$(ls /home/ | grep -E 'victim|nobody|'$(whoami)'$' | head -1)
        if [ -n "$VICTIM" ]; then
            sudo chown "$VICTIM" /home/$VICTIM/poc/$SRC
            echo "Switched to $VICTIM"
            cd /home/$VICTIM/poc
            ./poc.sh B
        fi
        ;;
    *)
        echo "Kullanım: ./jailbreak.sh [local|auto|help]"
        ;;
esac
