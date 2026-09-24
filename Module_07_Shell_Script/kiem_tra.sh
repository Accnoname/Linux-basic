#!/bin/bash
# =============================================================
# kiem_tra.sh — Script kiểm tra thuộc tính file hoặc thư mục
# Bài tập 2: Module 07 — Shell Script
# Cách chạy: ./kiem_tra.sh <đường_dẫn>
# =============================================================

# Màu sắc thông báo
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# 1. Kiểm tra tham số $1 có được truyền vào không
if [ $# -lt 1 ] || [ -z "$1" ]; then
    echo -e "${RED}❌ Lỗi: Bạn chưa cung cấp đường dẫn cần kiểm tra!${NC}"
    echo -e "${YELLOW}👉 Cách dùng:${NC} $0 <đường_dẫn>"
    echo -e "   Ví dụ: $0 /etc/passwd"
    echo -e "          $0 /var/log"
    exit 1
fi

TARGET="$1"

# 2. Kiểm tra đường dẫn có tồn tại trên hệ thống không
if [ ! -e "$TARGET" ]; then
    echo -e "${RED}❌ Lỗi: Đường dẫn '${BOLD}$TARGET${NC}${RED}' không tồn tại trên hệ thống!${NC}"
    exit 1
fi

echo -e "\n${BLUE}==============================================${NC}"
echo -e "${BOLD}🔍 THÔNG TIN KIỂM TRA: ${CYAN}$TARGET${NC}"
echo -e "${BLUE}==============================================${NC}"

# Lấy thông tin quyền truy cập (Permissions)
PERM_TEXT=$(ls -ld "$TARGET" | awk '{print $1}')
OWNER_GROUP=$(ls -ld "$TARGET" | awk '{print $3":"$4}')
echo -e "🔐 Quyền truy cập  : ${YELLOW}$PERM_TEXT${NC} (Chủ sở hữu: ${BOLD}$OWNER_GROUP${NC})"

# 3. Kiểm tra nếu là file thường (-f)
if [ -f "$TARGET" ]; then
    FILE_SIZE=$(ls -lh "$TARGET" | awk '{print $5}')
    LINE_COUNT=$(wc -l < "$TARGET" 2>/dev/null || echo "0")
    FILE_TYPE=$(file -b "$TARGET" 2>/dev/null || echo "Unknown")

    echo -e "📄 Phân loại       : ${GREEN}File thông thường (Regular File)${NC}"
    echo -e "📊 Kích thước      : ${BOLD}$FILE_SIZE${NC}"
    echo -e "🔢 Số dòng văn bản : ${BOLD}$LINE_COUNT dòng${NC}"
    echo -e "ℹ️  Loại định dạng  : $FILE_TYPE"

# 4. Kiểm tra nếu là thư mục (-d)
elif [ -d "$TARGET" ]; then
    SUB_COUNT=$(ls -1A "$TARGET" 2>/dev/null | wc -l)
    DIR_SIZE=$(du -sh "$TARGET" 2>/dev/null | cut -f1)

    echo -e "📁 Phân loại       : ${GREEN}Thư mục (Directory)${NC}"
    echo -e "📦 Tổng dung lượng : ${BOLD}$DIR_SIZE${NC}"
    echo -e "📂 Số phần tử con  : ${BOLD}$SUB_COUNT${NC} (bao gồm cả file và folder ẩn)"

# 5. Các dạng file đặc biệt khác (symlink, block device, socket...)
else
    echo -e "⚙️  Phân loại       : ${YELLOW}Loại file đặc biệt (Symlink, Socket hoặc Device)${NC}"
fi

echo -e "${BLUE}==============================================${NC}\n"
exit 0
