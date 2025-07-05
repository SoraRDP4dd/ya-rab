#!/bin/bash

# =======================================
#     Wick Studio | discord.gg/wicks
# =======================================

TARGET_DIR="${1:-$(pwd)}"

LOG_FILE="./permission.log"

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

if [ ! -d "$TARGET_DIR" ]; then
    log "❌ ERROR: Target directory '$TARGET_DIR' does not exist."
    exit 1
fi

log "🔍 Scanning all files and directories inside: $TARGET_DIR (excluding node_modules)"

log "⚙️ Setting permissions for all directories (755)..."
find "$TARGET_DIR" -type d -not -path "*/node_modules/*" -exec chmod 755 {} \; 2>/dev/null || log "⚠️ Warning: Some directories couldn't be modified. Try running with sudo if needed."

log "⚙️ Setting permissions for all files (644)..."
find "$TARGET_DIR" -type f -not -path "*/node_modules/*" -exec chmod 644 {} \; 2>/dev/null || log "⚠️ Warning: Some files couldn't be modified. Try running with sudo if needed."

log "✅ Permissions have been successfully updated for all files and directories!"
exit 0