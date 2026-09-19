#!/bin/bash
# =============================================================
# backup_don_gian.sh — Script backup thư mục với rotation
# Mục đích: Minh hoạ: biến, điều kiện, function, exit code
# Cách chạy: ./backup_don_gian.sh <thư_mục_nguồn> [thư_mục_đích]
# Ví dụ:     ./backup_don_gian.sh ~/projects ~/backups
# =============================================================

set -euo pipefail   # Dừng nếu có lỗi, biến chưa khai báo, lỗi pipe

# ─── Cấu hình mặc định ───
DEFAULT_BACKUP_DIR="$HOME/backups"
KEEP_LAST=5     # Giữ 5 backup gần nhất

# ─── Màu sắc ───
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# ─── Hàm in thông báo ───
log_info()    { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $1"; }
log_step()    { echo -e "${BLUE}[STEP]${NC} $1"; }

# ─── Hàm dọn dẹp khi có lỗi ───
cleanup() {
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        log_error "Script kết thúc với lỗi (exit code: $exit_code)"
        # Xóa file backup tạm nếu có
        [ -f "${TEMP_BACKUP:-}" ] && rm -f "$TEMP_BACKUP"
    fi
}
trap cleanup EXIT

# ─── Kiểm tra tham số ───
if [ $# -lt 1 ]; then
    log_error "Thiếu tham số!"
    echo ""
    echo "Cách dùng: $0 <thư_mục_nguồn> [thư_mục_đích]"
    echo "Ví dụ:     $0 ~/projects"
    echo "           $0 ~/projects ~/my_backups"
    exit 1
fi

SOURCE_DIR="$1"
BACKUP_DIR="${2:-$DEFAULT_BACKUP_DIR}"

# ─── Kiểm tra thư mục nguồn ───
log_step "Kiểm tra thư mục nguồn..."
if [ ! -d "$SOURCE_DIR" ]; then
    log_error "Thư mục '$SOURCE_DIR' không tồn tại!"
    exit 1
fi
log_info "Nguồn: $SOURCE_DIR ($(du -sh "$SOURCE_DIR" 2>/dev/null | cut -f1) dữ liệu)"

# ─── Tạo thư mục backup nếu chưa có ───
log_step "Chuẩn bị thư mục backup..."
mkdir -p "$BACKUP_DIR"
log_info "Đích: $BACKUP_DIR"

# ─── Tạo tên backup ───
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
SOURCE_NAME=$(basename "$SOURCE_DIR")
BACKUP_NAME="${SOURCE_NAME}_${TIMESTAMP}.tar.gz"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"
TEMP_BACKUP="$BACKUP_PATH.tmp"

# ─── Thực hiện backup ───
log_step "Đang tạo backup..."
tar -czf "$TEMP_BACKUP" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"
mv "$TEMP_BACKUP" "$BACKUP_PATH"

BACKUP_SIZE=$(du -sh "$BACKUP_PATH" | cut -f1)
log_info "✅ Backup thành công: $BACKUP_NAME ($BACKUP_SIZE)"

# ─── Xóa backup cũ (giữ $KEEP_LAST cái gần nhất) ───
log_step "Kiểm tra backup cũ..."
BACKUP_COUNT=$(ls -1 "$BACKUP_DIR/${SOURCE_NAME}_"*.tar.gz 2>/dev/null | wc -l)

if [ "$BACKUP_COUNT" -gt "$KEEP_LAST" ]; then
    DELETE_COUNT=$(( BACKUP_COUNT - KEEP_LAST ))
    log_warn "Tìm thấy $BACKUP_COUNT backup, sẽ xóa $DELETE_COUNT cái cũ nhất..."
    ls -1t "$BACKUP_DIR/${SOURCE_NAME}_"*.tar.gz | tail -"$DELETE_COUNT" | while read -r old_backup; do
        rm -f "$old_backup"
        log_info "Đã xóa: $(basename "$old_backup")"
    done
fi

# ─── Hiện danh sách backup hiện có ───
echo ""
echo "📦 Danh sách backup hiện có:"
echo "────────────────────────────"
ls -lht "$BACKUP_DIR/${SOURCE_NAME}_"*.tar.gz 2>/dev/null \
    | awk '{printf "  %-45s %5s  %s %s\n", $9, $5, $6, $7}' \
    | sed "s|$BACKUP_DIR/||g" \
    || echo "  (không có backup nào)"
echo ""
echo "💾 Tổng dung lượng backup: $(du -sh $BACKUP_DIR 2>/dev/null | cut -f1)"
