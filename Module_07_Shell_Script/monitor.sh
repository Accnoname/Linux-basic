#!/bin/bash
# =============================================================
# monitor.sh — Script theo dõi tải tài nguyên hệ thống
# Thử thách cuối: Module 07 — Shell Script
# Cách chạy: ./monitor.sh [số_lần] [chu_kỳ_giây]
# Mặc định:  5 lần, mỗi lần cách nhau 10 giây
# =============================================================

# Màu sắc hiển thị
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

LOG_FILE="$(dirname "$0")/monitor.log"
MAX_RUNS=${1:-5}
INTERVAL=${2:-10}

# Trap để bắt tín hiệu Ctrl+C
cleanup() {
    echo -e "\n${YELLOW}⚠️  Đã nhận tín hiệu dừng từ người dùng. Thoát giám sát an toàn.${NC}"
    exit 0
}
trap cleanup SIGINT SIGTERM

echo -e "\n${BLUE}======================================================================${NC}"
echo -e "${BOLD}🖥️  BẮT ĐẦU GIÁM SÁT HỆ THỐNG LINUX (Ghi log vào: ${CYAN}monitor.log${NC}${BOLD})${NC}"
echo -e "⏱️  Cấu hình: Lặp lại ${BOLD}$MAX_RUNS${NC} lần | Chu kỳ: ${BOLD}${INTERVAL}s${NC}/lần"
echo -e "${BLUE}======================================================================${NC}"
printf "%-20s | %-10s | %-18s | %-16s | %-12s\n" "Thời gian" "CPU Dùng" "RAM Trống / Tổng" "Ổ đĩa Trống (/)" "Trạng thái"
echo "---------------------+------------+--------------------+------------------+-------------"

for ((count=1; count<=MAX_RUNS; count++)); do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    # 1. Tính toán % CPU sử dụng
    # Đọc CPU idle từ /proc/stat để tính toán chuẩn xác không phụ thuộc top
    CPU_LINE1=$(grep '^cpu ' /proc/stat)
    sleep 1
    CPU_LINE2=$(grep '^cpu ' /proc/stat)

    # Tính delta
    IDLE1=$(echo "$CPU_LINE1" | awk '{print $5}')
    TOTAL1=$(echo "$CPU_LINE1" | awk '{print $2+$3+$4+$5+$6+$7+$8}')
    IDLE2=$(echo "$CPU_LINE2" | awk '{print $5}')
    TOTAL2=$(echo "$CPU_LINE2" | awk '{print $2+$3+$4+$5+$6+$7+$8}')

    DIFF_IDLE=$(( IDLE2 - IDLE1 ))
    DIFF_TOTAL=$(( TOTAL2 - TOTAL1 ))
    if [ $DIFF_TOTAL -gt 0 ]; then
        CPU_USAGE=$(( (100 * (DIFF_TOTAL - DIFF_IDLE)) / DIFF_TOTAL ))
    else
        CPU_USAGE=0
    fi

    # 2. Tính toán RAM
    RAM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
    RAM_AVAIL=$(free -m | awk '/Mem:/ {print $7}')
    if [ $RAM_TOTAL -gt 0 ]; then
        RAM_PCT_FREE=$(( (RAM_AVAIL * 100) / RAM_TOTAL ))
    else
        RAM_PCT_FREE=0
    fi

    # 3. Tính toán Ổ đĩa phân vùng gốc (/)
    DISK_AVAIL_STR=$(df -h / | awk 'NR==2 {print $4}')
    DISK_PCT_USED=$(df / | awk 'NR==2 {sub(/%/, "", $5); print $5}')
    DISK_PCT_FREE=$(( 100 - DISK_PCT_USED ))

    # 4. Kiểm tra cảnh báo (Alert)
    ALERTS=""
    STATUS="${GREEN}OK${NC}"
    LOG_STATUS="OK"

    if [ "$RAM_PCT_FREE" -lt 20 ]; then
        ALERTS="${ALERTS} [RAM < 20%]"
        STATUS="${RED}CẢNH BÁO: RAM thấp${NC}"
        LOG_STATUS="WARNING: RAM_LOW"
    fi

    if [ "$DISK_PCT_FREE" -lt 10 ]; then
        ALERTS="${ALERTS} [DISK < 10%]"
        STATUS="${RED}CẢNH BÁO: Ổ đĩa đầy${NC}"
        LOG_STATUS="WARNING: DISK_FULL"
    fi

    # 5. Ghi log ra file
    echo "[$TIMESTAMP] CPU: ${CPU_USAGE}% | RAM: ${RAM_AVAIL}MB/${RAM_TOTAL}MB (${RAM_PCT_FREE}% free) | DISK: ${DISK_AVAIL_STR} free (${DISK_PCT_FREE}%) | STATUS: $LOG_STATUS $ALERTS" >> "$LOG_FILE"

    # 6. In ra màn hình console
    printf "%-20s | %-10s | %-18s | %-16s | " "$TIMESTAMP" "${CPU_USAGE}%" "${RAM_AVAIL}M (${RAM_PCT_FREE}%)" "${DISK_AVAIL_STR} (${DISK_PCT_FREE}%)"
    echo -e "$STATUS"

    # Nghỉ trước chu kỳ tiếp theo (trừ lần cuối cùng)
    if [ $count -lt $MAX_RUNS ]; then
        SLEEP_TIME=$(( INTERVAL - 1 )) # Bù 1s đã dùng khi đo CPU delta
        [ $SLEEP_TIME -gt 0 ] && sleep $SLEEP_TIME
    fi
done

echo -e "${BLUE}======================================================================${NC}"
echo -e "${GREEN}✅ Hoàn thành đủ $MAX_RUNS lần giám sát!${NC}"
echo -e "📄 Xem toàn bộ file log tại: ${BOLD}$LOG_FILE${NC}"
echo -e "🔍 3 dòng log gần nhất:"
tail -n 3 "$LOG_FILE"
echo -e "${BLUE}======================================================================${NC}\n"

exit 0
