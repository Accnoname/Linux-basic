# Module 07 — Bài Tập Shell Script (Tự Động Hóa Linux)

> 💡 **Mục tiêu**: Làm chủ cú pháp Bash Shell Scripting, tham số dòng lệnh, điều kiện rẽ nhánh, vòng lặp, hàm, xử lý chuỗi/file và phòng vệ lỗi để tự động hóa các tác vụ quản trị hệ thống.

---

## 🎯 Bài Tập 1: Script Chào Hỏi Thông Minh (`chao.sh`)

Viết script `chao.sh` nhận tên từ tham số dòng lệnh. Nếu không có tham số thì hỏi input người dùng. Script nhận diện buổi trong ngày và đưa ra cảnh báo bảo mật nếu người dùng là `root`.

### 💻 Mã nguồn hoàn chỉnh:
```bash
#!/bin/bash
# =============================================================
# chao.sh — Script chào hỏi thông minh
# Mục đích: Minh họa biến, tham số $1, if/elif/else, read, exit code
# Cách chạy: ./chao.sh [tên]
# =============================================================

# ─── Màu sắc giao diện ───
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'  # No Color

# ─── 1. Lấy tên người dùng từ $1 hoặc read ───
if [ $# -gt 0 ]; then
    # Có truyền tham số khi gọi script
    NAME="$1"
else
    # Không có tham số -> hỏi trực tiếp
    read -p "Xin chào! Bạn tên là gì? " NAME
fi

# ─── 2. Kiểm tra tính hợp lệ của chuỗi (-z: chuỗi rỗng) ───
if [ -z "$NAME" ]; then
    echo -e "${RED}❌ Lỗi: Tên không được để trống!${NC}"
    exit 1
fi

# ─── 3. Xác định buổi trong ngày theo giờ thực tế ───
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

# ─── 4. In thông điệp chào hỏi và thông tin môi trường ───
echo ""
echo -e "${GREEN}$EMOJI $GREETING, $NAME!${NC}"
echo "📅 Hôm nay là   : $(date '+%A, %d/%m/%Y')"
echo "⏰ Giờ hiện tại : $(date '+%H:%M:%S')"
echo "💻 Hệ điều hành : $(uname -s) $(uname -r | cut -d'-' -f1)"

# ─── 5. Cảnh báo an ninh nếu chạy bằng quyền root ───
if [ "$NAME" = "root" ] || [ "$USER" = "root" ]; then
    echo ""
    echo -e "${RED}⚠️  CẢNH BÁO: Bạn đang thao tác với quyền ROOT!${NC}"
    echo -e "${YELLOW}   Mọi thay đổi có thể ảnh hưởng trực tiếp đến toàn hệ thống.${NC}"
fi

echo ""
exit 0
```

### 🧪 Kiểm thử thực tế:
```bash
chmod +x chao.sh

# Test 1: Truyền tên qua tham số $1
./chao.sh Alice

# Test 2: Chạy với root để kích hoạt cảnh báo
./chao.sh root

# Test 3: Không truyền tham số (Script sẽ hiển thị lời nhắc nhập tên)
./chao.sh
```

---

## 🎯 Bài Tập 2: Thẩm Định File & Thư Mục (`kiem_tra.sh`)

Viết script `kiem_tra.sh` nhận đường dẫn từ tham số `$1` và phân loại đối tượng:
- Kiểm tra tính tồn tại.
- Nếu là file: đo dung lượng (`ls -lh`), đếm số dòng (`wc -l`), xác định định dạng (`file`).
- Nếu là thư mục: đếm số phần tử con bên trong (`ls -1A`), đo tổng dung lượng (`du -sh`).
- Hiển thị quyền truy cập (Permissions: rwx) và chủ sở hữu (Owner/Group).

### 💻 Mã nguồn hoàn chỉnh:
```bash
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
NC='\033[0m'

# 1. Kiểm tra tham số $1 có được truyền vào không
if [ $# -lt 1 ] || [ -z "$1" ]; then
    echo -e "${RED}❌ Lỗi: Bạn chưa cung cấp đường dẫn cần kiểm tra!${NC}"
    echo -e "${YELLOW}👉 Cách dùng:${NC} $0 <đường_dẫn>"
    echo -e "   Ví dụ: $0 /etc/passwd"
    echo -e "          $0 /var/log"
    exit 1
fi

TARGET="$1"

# 2. Kiểm tra đường dẫn có tồn tại trên hệ thống không (-e)
if [ ! -e "$TARGET" ]; then
    echo -e "${RED}❌ Lỗi: Đường dẫn '${BOLD}$TARGET${NC}${RED}' không tồn tại trên hệ thống!${NC}"
    exit 1
fi

echo -e "\n${BLUE}==============================================${NC}"
echo -e "${BOLD}🔍 THÔNG TIN KIỂM TRA: ${CYAN}$TARGET${NC}"
echo -e "${BLUE}==============================================${NC}"

# Lấy thông tin quyền truy cập (Permissions) và Owner
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
```

### 🧪 Kiểm thử thực tế:
```bash
chmod +x kiem_tra.sh

# Kiểm tra 1 file hệ thống:
./kiem_tra.sh /etc/passwd

# Kiểm tra 1 thư mục:
./kiem_tra.sh Module_07_Shell_Script

# Kiểm tra đường dẫn không tồn tại (xử lý lỗi):
./kiem_tra.sh /tmp/khong_ton_tai
```

---

## 🎯 Bài Tập 3: Script Phân Tích & Thống Kê File Log (`thong_ke.sh`)

Viết script `thong_ke.sh` đọc file log ứng dụng, bóc tách dữ liệu theo các mức độ nghiêm trọng (`ERROR`, `WARNING`, `INFO`, `DEBUG`) và tự động tìm ra ngày phát sinh nhiều lỗi nhất.

### 💻 Mã nguồn hoàn chỉnh:
```bash
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
    echo -e "   Ví dụ: $0 sample_app.log"
    exit 1
fi

LOG_FILE="$1"

# 2. Kiểm tra file tồn tại (-f) và có quyền đọc (-r)
if [ ! -f "$LOG_FILE" ]; then
    echo -e "${RED}❌ Lỗi: File '$LOG_FILE' không tồn tại hoặc không phải là file thường!${NC}"
    exit 1
fi

if [ ! -r "$LOG_FILE" ]; then
    echo -e "${RED}❌ Lỗi: Bạn không có quyền đọc file '$LOG_FILE'!${NC}"
    exit 1
fi

# 3. Thu thập các chỉ số thống kê qua wc và grep -c
TOTAL_LINES=$(wc -l < "$LOG_FILE" | tr -d ' ')
COUNT_ERROR=$(grep -c "ERROR" "$LOG_FILE" 2>/dev/null || true)
COUNT_WARN=$(grep -c "WARNING" "$LOG_FILE" 2>/dev/null || true)
COUNT_INFO=$(grep -c "INFO" "$LOG_FILE" 2>/dev/null || true)
COUNT_DEBUG=$(grep -c "DEBUG" "$LOG_FILE" 2>/dev/null || true)

# 4. Tìm ngày có nhiều lỗi ERROR nhất bằng pipeline: grep -> awk -> sort -> uniq -> head
TOP_ERROR_STAT=$(grep "ERROR" "$LOG_FILE" 2>/dev/null | awk '{print $1}' | sort | uniq -c | sort -nr | head -1 || true)

if [ -n "$TOP_ERROR_STAT" ]; then
    MOST_ERR_COUNT=$(echo "$TOP_ERROR_STAT" | awk '{print $1}')
    MOST_ERR_DATE=$(echo "$TOP_ERROR_STAT" | awk '{print $2}')
    MOST_ERR_STR="${MOST_ERR_DATE} (${MOST_ERR_COUNT} lỗi)"
else
    MOST_ERR_STR="Không có lỗi nào"
fi

# 5. In kết quả chuẩn format đề bài yêu cầu
echo "=== THỐNG KÊ FILE LOG ==="
echo "Tổng dòng: $TOTAL_LINES"
echo "ERROR: $COUNT_ERROR"
echo "WARNING: $COUNT_WARN"
echo "INFO: $COUNT_INFO"
echo "DEBUG: $COUNT_DEBUG"
echo "Ngày nhiều lỗi nhất: $MOST_ERR_STR"

exit 0
```

### 🧪 Kiểm thử với file log thực tế (`sample_app.log`):
```bash
chmod +x thong_ke.sh
./thong_ke.sh sample_app.log
```

**Kết quả đầu ra chính xác:**
```text
=== THỐNG KÊ FILE LOG ===
Tổng dòng: 10
ERROR: 4
WARNING: 2
INFO: 3
DEBUG: 1
Ngày nhiều lỗi nhất: 2024-01-01 (2 lỗi)
```

---

## 🎯 Bài Tập 4: Script Backup Tự Động & Xoay Vòng Lưu Trữ (`backup.sh`)

Viết script `backup.sh` đóng gói thư mục nguồn thành file nén `.tar.gz`, đặt tên theo timestamp, lưu vào thư mục `~/backups/`, tự động quét và xóa các bản backup cũ quá 7 ngày, và in danh sách hiện có.

### 💻 Mã nguồn hoàn chỉnh:
```bash
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
    exit 1
fi

SOURCE_DIR="$1"
BACKUP_DIR="$HOME/backups"

# 2. Kiểm tra thư mục nguồn có tồn tại không
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}❌ Lỗi: Thư mục nguồn '${BOLD}$SOURCE_DIR${NC}${RED}' không tồn tại!${NC}"
    exit 1
fi

# 3. Chuẩn bị đường dẫn và tên file nén theo timestamp
SOURCE_BASE=$(basename "$SOURCE_DIR")
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
BACKUP_FILE="${SOURCE_BASE}_${TIMESTAMP}.tar.gz"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_FILE"

mkdir -p "$BACKUP_DIR"

echo -e "\n${BLUE}==============================================${NC}"
echo -e "${BOLD}📦 BẮT ĐẦU QUÁ TRÌNH BACKUP${NC}"
echo -e "${BLUE}==============================================${NC}"
echo -e "📁 Nguồn        : ${CYAN}$SOURCE_DIR${NC}"
echo -e "💾 Nơi lưu trữ  : ${CYAN}$BACKUP_DIR${NC}"
echo -e "🗜️  Tên gói nén  : ${BOLD}$BACKUP_FILE${NC}"

# 4. Tiến hành nén dữ liệu bằng tar
echo -e "⏳ Đang nén dữ liệu..."
tar -czf "$BACKUP_PATH" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

BACKUP_SIZE=$(du -sh "$BACKUP_PATH" | cut -f1)
echo -e "${GREEN}✅ Nén hoàn tất! Dung lượng: ${BOLD}$BACKUP_SIZE${NC}"

# 5. Xóa các bản backup cũ hơn 7 ngày bằng find -mtime +7
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
    ls -lh "$BACKUP_DIR" | awk 'NR>1 {printf "  %-40s %8s  %s %s\n", $9, $5, $6, $7}'
    echo -e "──────────────────────────────────────────────"
    echo -e "💾 Tổng dung lượng thư mục backup: ${BOLD}$(du -sh "$BACKUP_DIR" | cut -f1)${NC}"
else
    echo "  (Chưa có bản backup nào trong $BACKUP_DIR)"
fi
echo -e "${BLUE}==============================================${NC}\n"

exit 0
```

### 🧪 Kiểm thử thực tế:
```bash
chmod +x backup.sh
./backup.sh Module_07_Shell_Script
```

---

## 🎯 Bài Tập 5: Menu Tương Tác Quản Lý Hệ Thống (`menu.sh`)

Viết script `menu.sh` xây dựng giao diện CLI tương tác điều hướng bằng số (`while true` kết hợp `case`), hỗ trợ xem cấu hình máy, top process ngốn CPU, dung lượng đĩa, và tìm kiếm file.

### 💻 Mã nguồn hoàn chỉnh:
```bash
#!/bin/bash
# =============================================================
# menu.sh — Menu tương tác quản lý hệ thống Linux
# Bài tập 5: Module 07 — Shell Script
# Cách chạy: ./menu.sh
# =============================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

draw_line() { printf '%*s\n' "${COLUMNS:-60}" '' | tr ' ' '─'; }

print_header() {
    clear
    echo -e "${BOLD}${BLUE}"
    draw_line
    echo "   🖥️  TRÌNH QUẢN LÝ HỆ THỐNG LINUX INTERACTIVE"
    echo "   $(date '+%A, %d/%m/%Y %H:%M:%S')"
    draw_line
    echo -e "${NC}"
}

press_enter() {
    echo ""
    read -p "$(echo -e "${YELLOW}Nhấn Enter để quay lại menu chính...${NC}")"
}

# 1) Thông tin hệ thống
show_system_info() {
    echo -e "${CYAN}📊 THÔNG TIN HỆ THỐNG${NC}"
    draw_line
    echo "Hostname     : $(hostname)"
    echo "OS           : $(cat /etc/os-release 2>/dev/null | grep PRETTY_NAME | cut -d'"' -f2 || uname -s)"
    echo "Kernel       : $(uname -r)"
    echo "Architecture : $(uname -m)"
    echo "Uptime       : $(uptime -p 2>/dev/null || uptime | awk '{print $3,$4}' | sed 's/,//')"
    echo "CPU Model    : $(grep "model name" /proc/cpuinfo 2>/dev/null | head -1 | cut -d':' -f2 | xargs || echo "Unknown")"
    echo "CPU Cores    : $(nproc)"
    echo ""
    echo -e "${CYAN}💾 BỘ NHỚ RAM & SWAP${NC}"
    free -h | grep -E "^(Mem|Swap)"
    press_enter
}

# 2) Top process CPU
show_top_cpu() {
    echo -e "${CYAN}🔥 TOP 10 TIẾN TRÌNH DÙNG CPU NHIỀU NHẤT${NC}"
    draw_line
    printf "%-8s %-10s %-6s %-6s %-s\n" "PID" "USER" "%CPU" "%MEM" "COMMAND"
    draw_line
    ps aux --sort=-%cpu | awk 'NR>1 && NR<=11 {printf "%-8s %-10s %-6s %-6s %-s\n", $2, $1, $3, $4, $11}'
    press_enter
}

# 3) Dung lượng ổ đĩa
show_disk() {
    echo -e "${CYAN}💿 DUNG LƯỢNG CÁC PHÂN VÙNG Ổ ĐĨA${NC}"
    draw_line
    df -h | grep -v "tmpfs\|udev\|loop"
    press_enter
}

# 4) Tìm file
find_file() {
    echo -e "${CYAN}🔍 TÌM KIẾM FILE TRÊN HỆ THỐNG${NC}"
    draw_line
    read -p "Nhập tên file cần tìm (ví dụ: *.sh hoặc app.log): " pattern

    if [ -z "$pattern" ]; then
        echo -e "${RED}Tên file không được để trống!${NC}"
        press_enter
        return
    fi

    echo "Đang tìm '$pattern' trong thư mục hiện tại..."
    draw_line
    find . -name "$pattern" 2>/dev/null | head -20
    press_enter
}

# ─── VÒNG LẶP MENU ĐIỀU KHIỂN CHÍNH ───
while true; do
    print_header
    echo -e "  ${GREEN}1${NC}) 📊 Xem thông tin hệ thống (OS, CPU, RAM)"
    echo -e "  ${GREEN}2${NC}) 🔥 Xem top 10 process dùng CPU nhiều nhất"
    echo -e "  ${GREEN}3${NC}) 💿 Xem dung lượng các phân vùng ổ đĩa"
    echo -e "  ${GREEN}4${NC}) 🔍 Tìm kiếm file theo tên/mẫu"
    echo -e "  ${RED}5${NC}) 🚪 Thoát chương trình"
    echo ""
    draw_line
    read -p "$(echo -e "${BOLD}Nhập lựa chọn của bạn (1-5): ${NC}")" choice
    echo ""

    case "$choice" in
        1) show_system_info ;;
        2) show_top_cpu ;;
        3) show_disk ;;
        4) find_file ;;
        5)
            echo -e "${GREEN}👋 Cảm ơn bạn đã sử dụng. Hẹn gặp lại!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Lựa chọn '$choice' không hợp lệ! Vui lòng chọn 1-5.${NC}"
            sleep 1
            ;;
    esac
done
```

---

## 🏆 Thử Thách Cuối Module: Giám Sát Tài Nguyên Tự Động (`monitor.sh`)

Viết script `monitor.sh` định kỳ ghi log thông số tải của máy (CPU, RAM, Ổ đĩa) ra file `monitor.log` và cảnh báo ngay lập tức nếu RAM trống dưới 20% hoặc ổ đĩa trống dưới 10%.

### 💻 Mã nguồn hoàn chỉnh:
```bash
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

# Trap để bắt tín hiệu Ctrl+C (SIGINT)
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

    # 1. Đo lường % CPU sử dụng thực tế từ /proc/stat
    CPU_LINE1=$(grep '^cpu ' /proc/stat)
    sleep 1
    CPU_LINE2=$(grep '^cpu ' /proc/stat)

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

    # 2. Đo lường RAM (Tính theo available RAM)
    RAM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
    RAM_AVAIL=$(free -m | awk '/Mem:/ {print $7}')
    if [ $RAM_TOTAL -gt 0 ]; then
        RAM_PCT_FREE=$(( (RAM_AVAIL * 100) / RAM_TOTAL ))
    else
        RAM_PCT_FREE=0
    fi

    # 3. Đo lường phân vùng ổ đĩa gốc (/)
    DISK_AVAIL_STR=$(df -h / | awk 'NR==2 {print $4}')
    DISK_PCT_USED=$(df / | awk 'NR==2 {sub(/%/, "", $5); print $5}')
    DISK_PCT_FREE=$(( 100 - DISK_PCT_USED ))

    # 4. Đánh giá ngưỡng cảnh báo
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

    # 5. Ghi dòng dữ liệu vào file monitor.log
    echo "[$TIMESTAMP] CPU: ${CPU_USAGE}% | RAM: ${RAM_AVAIL}MB/${RAM_TOTAL}MB (${RAM_PCT_FREE}% free) | DISK: ${DISK_AVAIL_STR} free (${DISK_PCT_FREE}%) | STATUS: $LOG_STATUS $ALERTS" >> "$LOG_FILE"

    # 6. In ra màn hình console theo định dạng bảng
    printf "%-20s | %-10s | %-18s | %-16s | " "$TIMESTAMP" "${CPU_USAGE}%" "${RAM_AVAIL}M (${RAM_PCT_FREE}%)" "${DISK_AVAIL_STR} (${DISK_PCT_FREE}%)"
    echo -e "$STATUS"

    # Nghỉ chờ chu kỳ tiếp theo
    if [ $count -lt $MAX_RUNS ]; then
        SLEEP_TIME=$(( INTERVAL - 1 ))
        [ $SLEEP_TIME -gt 0 ] && sleep $SLEEP_TIME
    fi
done

echo -e "${BLUE}======================================================================${NC}"
echo -e "${GREEN}✅ Hoàn thành đủ $MAX_RUNS lần giám sát!${NC}"
echo -e "📄 Xem toàn bộ file log tại: ${BOLD}$LOG_FILE${NC}"
echo -e "${BLUE}======================================================================${NC}\n"

exit 0
```

### 🧪 Kiểm thử:
```bash
chmod +x monitor.sh

# Chạy giám sát mặc định (5 lần, mỗi lần 10s):
./monitor.sh

# Chạy test nhanh (3 lần, mỗi lần 2s):
./monitor.sh 3 2
```

---

## 📋 BẢNG TRA CỨU NHANH BASH SCRIPTING

### 📌 1. Các Biến Đặc Biệt Trong Bash
| Ký hiệu | Ý nghĩa | Ví dụ |
| :---: | :--- | :--- |
| **`$0`** | Tên file script đang chạy | `echo "Đang chạy $0"` |
| **`$1`, `$2`...** | Tham số vị trí truyền vào khi chạy | `./script.sh Alice Bob` (`$1=Alice`, `$2=Bob`) |
| **`$#`** | Tổng số lượng tham số truyền vào | `if [ $# -lt 1 ]; then echo "Thiếu tham số"; fi` |
| **`$@`** / **`$*`** | Danh sách tất cả tham số | `for arg in "$@"; do ... done` |
| **`$?`** | Mã thoát (Exit Code) của lệnh vừa chạy | `0` = thành công, khác `0` = có lỗi |
| **`$$`** | PID của chính tiến trình script này | `echo "Script PID: $$"` |

### 🔍 2. Toán Tử So Sánh Điều Kiện `[ ... ]`
| Mục đích | Cú pháp kiểm tra | Ý nghĩa |
| :--- | :--- | :--- |
| **Số nguyên** | `[ $a -eq $b ]` / `-ne` | Bằng nhau (equal) / Khác nhau (not equal) |
| | `[ $a -lt $b ]` / `-le` | Nhỏ hơn (less than) / Nhỏ hơn hoặc bằng |
| | `[ $a -gt $b ]` / `-ge` | Lớn hơn (greater than) / Lớn hơn hoặc bằng |
| **Chuỗi** | `[ "$str1" = "$str2" ]` | Hai chuỗi giống nhau |
| | `[ -z "$str" ]` | Chuỗi rỗng (độ dài bằng 0) |
| | `[ -n "$str" ]` | Chuỗi không rỗng |
| **File & Thư mục**| `[ -f "$path" ]` | Tồn tại và là file thông thường |
| | `[ -d "$path" ]` | Tồn tại và là thư mục |
| | `[ -e "$path" ]` | Tồn tại (bất kể file hay thư mục) |
| | `[ -r "$path" ]` / `[ -w "$path" ]` / `[ -x "$path" ]` | Có quyền Đọc (r), Ghi (w), Thực thi (x) |

### 🛡️ 3. Quy Tắc Phòng Vệ (Defensive Scripting)
- `set -e`: Dừng script ngay khi có bất kỳ dòng lệnh nào bị lỗi (exit code != 0).
- `set -u`: Báo lỗi và dừng ngay nếu vô tình dùng một biến chưa từng được khai báo.
- `set -o pipefail`: Bắt lỗi trong chuỗi pipeline `cmd1 | cmd2` nếu `cmd1` chết.
- Luôn bọc biến trong ngoặc kép `"$VAR"` để chống hiện tượng Word Splitting khi chuỗi có dấu cách.

---

## ✅ Checklist Hoàn Thành Module 07

- [x] Viết được script nhận tham số và input (`$1`, `read`)
- [x] Dùng `if/elif/else` thành thạo với đầy đủ cờ kiểm tra file và số nguyên
- [x] Dùng `for` và `while` loop thành thạo
- [x] Viết và gọi được function modular có biến cục bộ `local`
- [x] Xử lý lỗi chuyên nghiệp (`$?`, exit code, `set -euo pipefail`, `trap`)
- [x] Dùng được `case ... in` để dựng menu tương tác
- [x] Viết được các script thực tế phục vụ DevOps: thẩm định file, phân tích log, backup xoay vòng, và monitor hệ thống

👉 Chuyển sang làm bài tự kiểm tra: [kiem_tra.md](./kiem_tra.md)!
