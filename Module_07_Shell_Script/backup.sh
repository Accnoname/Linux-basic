#!/bin/bash
# =============================================================
# backup.sh — Script backup thư mục tự động và xoay vòng lưu trữ
# Bài tập 4: Module 07 — Shell Script
# Cách chạy: ./backup.sh <thư_mục_nguồn>
# =============================================================

# Chế độ nghiêm ngặt: dừng ngay khi có lỗi, biến chưa khai báo, pipe lỗi
set -euo pipefail

# Màu sắc hiển thị
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# 1. Kiểm tra tham số đầu vào
if [ $# -lt 1 ] || [ -z "$1" ]; then
    echo -e "${RED}❌ Lỗi: Bạn chưa chỉ định thư mục cần backup!${NC}"
    echo -e "${YELLOW}👉 Cách dùng:${NC} $0 <thư_mục_nguồn>"
    echo -e "   Ví dụ: $0 ~/projects"
    echo -e "          $0 /var/www/myweb"
    exit 1
fi

SOURCE_DIR="$1"
BACKUP_DIR="$HOME/backups"

# 2. Kiểm tra thư mục nguồn có tồn tại không
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}❌ Lỗi: Thư mục nguồn '${BOLD}$SOURCE_DIR${NC}${RED}' không tồn tại!${NC}"
    exit 1
fi

# Chuẩn bị tên file backup
# Lấy tên thư mục gốc (không có dấu gạch chéo cuối)
SOURCE_BASE=$(basename "$SOURCE_DIR")
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
BACKUP_FILE="${SOURCE_BASE}_${TIMESTAMP}.tar.gz"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_FILE"

# 3. Tạo thư mục đích nếu chưa có
mkdir -p "$BACKUP_DIR"

echo -e "\n${BLUE}==============================================${NC}"
echo -e "${BOLD}📦 BẮT ĐẦU QUÁ TRÌNH BACKUP${NC}"
echo -e "${BLUE}==============================================${NC}"
echo -e "📁 Nguồn        : ${CYAN}$SOURCE_DIR${NC}"
echo -e "💾 Nơi lưu trữ  : ${CYAN}$BACKUP_DIR${NC}"
echo -e "🗜️  Tên gói nén  : ${BOLD}$BACKUP_FILE${NC}"

# 4. Tiến hành nén dữ liệu (.tar.gz)
echo -e "⏳ Đang nén dữ liệu..."
tar -czf "$BACKUP_PATH" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

BACKUP_SIZE=$(du -sh "$BACKUP_PATH" | cut -f1)
echo -e "${GREEN}✅ Nén hoàn tất! Dung lượng: ${BOLD}$BACKUP_SIZE${NC}"

# 5. Xóa các bản backup cũ hơn 7 ngày
echo -e "\n🧹 Kiểm tra và dọn dẹp các bản backup cũ hơn 7 ngày..."
OLD_BACKUPS=$(find "$BACKUP_DIR" -name "${SOURCE_BASE}_*.tar.gz" -type f -mtime +7)
if [ -n "$OLD_BACKUPS" ]; then
    find "$BACKUP_DIR" -name "${SOURCE_BASE}_*.tar.gz" -type f -mtime +7 -exec rm -f {} +
    echo -e "${YELLOW}⚠️  Đã xóa các bản backup cũ hơn 7 ngày:${NC}"
    echo "$OLD_BACKUPS"
else
    echo -e "ℹ️  Không có bản backup nào cũ hơn 7 ngày cần xóa."
fi

# 6. Hiện danh sách backup hiện có
echo -e "\n${BLUE}==============================================${NC}"
echo -e "${BOLD}📋 DANH SÁCH CÁC BẢN BACKUP HIỆN CÓ:${NC}"
echo -e "${BLUE}==============================================${NC}"
if ls "$BACKUP_DIR"/*.tar.gz 1> /dev/null 2>&1; then
    ls -lh "$BACKUP_DIR" | awk 'NR>1 {printf "  %-35s %8s  %s %s\n", $9, $5, $6, $7}'
    echo -e "──────────────────────────────────────────────"
    echo -e "💾 Tổng dung lượng thư mục backup: ${BOLD}$(du -sh "$BACKUP_DIR" | cut -f1)${NC}"
else
    echo "  (Chưa có bản backup nào trong $BACKUP_DIR)"
fi
echo -e "${BLUE}==============================================${NC}\n"

exit 0
