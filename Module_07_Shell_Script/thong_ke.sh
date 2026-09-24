#!/bin/bash
# =============================================================
# thong_ke.sh — Script phân tích và thống kê file log
# Bài tập 3: Module 07 — Shell Script
# Cách chạy: ./thong_ke.sh <đường_dẫn_file_log>
# =============================================================

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
    echo -e "${RED}❌ Lỗi: Bạn chưa truyền đường dẫn file log!${NC}"
    echo -e "${YELLOW}👉 Cách dùng:${NC} $0 <file_log>"
    echo -e "   Ví dụ: $0 ~/linux_practice/module03/app.log"
    echo -e "          $0 Module_07_Shell_Script/sample_app.log"
    exit 1
fi

LOG_FILE="$1"

# 2. Kiểm tra file tồn tại và có quyền đọc
if [ ! -f "$LOG_FILE" ]; then
    echo -e "${RED}❌ Lỗi: File '$LOG_FILE' không tồn tại hoặc không phải là file thường!${NC}"
    exit 1
fi

if [ ! -r "$LOG_FILE" ]; then
    echo -e "${RED}❌ Lỗi: Bạn không có quyền đọc file '$LOG_FILE'!${NC}"
    exit 1
fi

# 3. Thu thập các chỉ số thống kê
TOTAL_LINES=$(wc -l < "$LOG_FILE" | tr -d ' ')
COUNT_ERROR=$(grep -c "ERROR" "$LOG_FILE" 2>/dev/null || true)
COUNT_WARN=$(grep -c "WARNING" "$LOG_FILE" 2>/dev/null || true)
COUNT_INFO=$(grep -c "INFO" "$LOG_FILE" 2>/dev/null || true)
COUNT_DEBUG=$(grep -c "DEBUG" "$LOG_FILE" 2>/dev/null || true)

# 4. Tìm ngày có nhiều lỗi ERROR nhất
# Giả sử ngày nằm ở cột 1 định dạng YYYY-MM-DD
TOP_ERROR_STAT=$(grep "ERROR" "$LOG_FILE" 2>/dev/null | awk '{print $1}' | sort | uniq -c | sort -nr | head -1 || true)

if [ -n "$TOP_ERROR_STAT" ]; then
    MOST_ERR_COUNT=$(echo "$TOP_ERROR_STAT" | awk '{print $1}')
    MOST_ERR_DATE=$(echo "$TOP_ERROR_STAT" | awk '{print $2}')
    MOST_ERR_STR="${MOST_ERR_DATE} (${MOST_ERR_COUNT} lỗi)"
else
    MOST_ERR_STR="Không có lỗi nào"
fi

# 5. In kết quả chuẩn format
echo "=== THỐNG KÊ FILE LOG ==="
echo "Tổng dòng: $TOTAL_LINES"
echo "ERROR: $COUNT_ERROR"
echo "WARNING: $COUNT_WARN"
echo "INFO: $COUNT_INFO"
echo "DEBUG: $COUNT_DEBUG"
echo "Ngày nhiều lỗi nhất: $MOST_ERR_STR"

exit 0
