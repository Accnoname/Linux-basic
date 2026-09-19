#!/bin/bash
# =============================================================
# chao.sh — Script chào hỏi thông minh
# Mục đích: Minh hoạ biến, tham số, if/else, read
# Cách chạy: ./chao.sh [tên]
# =============================================================

# ─── Màu sắc ───
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'  # No Color

# ─── Lấy tên người dùng ───
if [ $# -gt 0 ]; then
    # Nếu có tham số dòng lệnh → dùng luôn
    NAME="$1"
else
    # Không có tham số → hỏi người dùng
    read -p "Xin chào! Bạn tên là gì? " NAME
fi

# ─── Kiểm tra tên hợp lệ ───
if [ -z "$NAME" ]; then
    echo -e "${RED}❌ Lỗi: Tên không được để trống!${NC}"
    exit 1
fi

# ─── Xác định thời gian trong ngày ───
HOUR=$(date +%H)

if [ "$HOUR" -lt 12 ]; then
    GREETING="Chào buổi sáng"
    EMOJI="🌅"
elif [ "$HOUR" -lt 18 ]; then
    GREETING="Chào buổi chiều"
    EMOJI="☀️"
else
    GREETING="Chào buổi tối"
    EMOJI="🌙"
fi

# ─── In lời chào ───
echo ""
echo -e "${GREEN}$EMOJI $GREETING, $NAME!${NC}"
echo "📅 Hôm nay: $(date '+%A, %d/%m/%Y')"
echo "⏰ Giờ hiện tại: $(date '+%H:%M:%S')"
echo "💻 Bạn đang dùng: $(uname -s) $(uname -r | cut -d'-' -f1)"

# ─── Cảnh báo nếu là root ───
if [ "$NAME" = "root" ] || [ "$USER" = "root" ]; then
    echo ""
    echo -e "${RED}⚠️  CẢNH BÁO: Bạn đang đăng nhập với quyền ROOT!${NC}"
    echo -e "${YELLOW}   Hãy cẩn thận khi thực thi lệnh.${NC}"
fi

echo ""
