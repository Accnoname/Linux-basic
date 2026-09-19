#!/bin/bash
# =============================================================
# menu.sh — Menu tương tác quản lý hệ thống
# Mục đích: Minh hoạ: vòng lặp while, case, function
# Cách chạy: ./menu.sh
# =============================================================

# ─── Màu sắc ───
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# ─── Hàm vẽ đường kẻ ───
draw_line() { printf '%*s\n' "${COLUMNS:-50}" '' | tr ' ' '─'; }

# ─── Hàm in tiêu đề ───
print_header() {
    clear
    echo -e "${BOLD}${BLUE}"
    draw_line
    echo "   🖥️  TRÌNH QUẢN LÝ HỆ THỐNG LINUX"
    echo "   $(date '+%A, %d/%m/%Y %H:%M:%S')"
    draw_line
    echo -e "${NC}"
}

# ─── Hàm "nhấn phím để tiếp tục" ───
press_enter() {
    echo ""
    read -p "$(echo -e "${YELLOW}Nhấn Enter để quay lại menu...${NC}")"
}

# ─── Menu 1: Thông tin hệ thống ───
show_system_info() {
    echo -e "${CYAN}📊 THÔNG TIN HỆ THỐNG${NC}"
    draw_line
    echo "Hostname     : $(hostname)"
    echo "OS           : $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
    echo "Kernel       : $(uname -r)"
    echo "Architecture : $(uname -m)"
    echo "Uptime       : $(uptime -p 2>/dev/null || uptime | awk '{print $3,$4}' | sed 's/,//')"
    echo "CPU          : $(grep "model name" /proc/cpuinfo | head -1 | cut -d':' -f2 | xargs)"
    echo "CPU Cores    : $(nproc)"
    echo ""
    echo -e "${CYAN}💾 BỘ NHỚ${NC}"
    free -h | grep -E "^(Mem|Swap)"
    press_enter
}

# ─── Menu 2: Top Process CPU ───
show_top_cpu() {
    echo -e "${CYAN}🔥 TOP 10 PROCESS DÙNG CPU NHIỀU NHẤT${NC}"
    draw_line
    printf "%-8s %-10s %-5s %-5s %-s\n" "PID" "USER" "%CPU" "%MEM" "COMMAND"
    draw_line
    ps aux --sort=-%cpu | awk 'NR>1 && NR<=11 {printf "%-8s %-10s %-5s %-5s %-s\n", $2, $1, $3, $4, $11}' | head -10
    press_enter
}

# ─── Menu 3: Dung lượng ổ đĩa ───
show_disk() {
    echo -e "${CYAN}💿 DUNG LƯỢNG Ổ ĐĨA${NC}"
    draw_line
    df -h | grep -v "tmpfs\|udev\|loop"
    echo ""
    echo -e "${CYAN}📁 10 THƯ MỤC LỚN NHẤT TRONG HOME${NC}"
    draw_line
    du -sh "$HOME"/*/ 2>/dev/null | sort -rh | head -10 || echo "(thư mục home trống)"
    press_enter
}

# ─── Menu 4: Tìm file ───
find_file() {
    echo -e "${CYAN}🔍 TÌM KIẾM FILE${NC}"
    draw_line
    read -p "Nhập tên file cần tìm (ví dụ: *.log hoặc config.txt): " pattern
    
    if [ -z "$pattern" ]; then
        echo -e "${RED}Tên file không được để trống!${NC}"
        press_enter
        return
    fi
    
    echo ""
    echo "Đang tìm '$pattern' trong hệ thống..."
    draw_line
    
    find / -name "$pattern" 2>/dev/null | head -20
    
    COUNT=$(find / -name "$pattern" 2>/dev/null | wc -l)
    echo ""
    echo -e "${GREEN}Tìm thấy $COUNT kết quả${NC}"
    press_enter
}

# ─── Menu 5: Xem log hệ thống ───
show_logs() {
    echo -e "${CYAN}📋 LOG HỆ THỐNG GẦN NHẤT${NC}"
    draw_line
    echo -e "${YELLOW}Chọn loại log:${NC}"
    echo "  1) Syslog (toàn hệ thống)"
    echo "  2) Auth log (đăng nhập, sudo)"
    echo "  3) Journal (systemd)"
    read -p "Chọn (1-3): " log_choice
    
    case $log_choice in
        1)  [ -f /var/log/syslog ] && tail -30 /var/log/syslog || echo "Không tìm thấy syslog" ;;
        2)  [ -f /var/log/auth.log ] && tail -30 /var/log/auth.log || echo "Không tìm thấy auth.log" ;;
        3)  journalctl -n 30 --no-pager 2>/dev/null || echo "journalctl không khả dụng" ;;
        *)  echo -e "${RED}Lựa chọn không hợp lệ${NC}" ;;
    esac
    press_enter
}

# ─── VÒNG LẶP CHÍNH ───
while true; do
    print_header
    
    echo -e "  ${GREEN}1${NC}) 📊 Thông tin hệ thống"
    echo -e "  ${GREEN}2${NC}) 🔥 Top process CPU"
    echo -e "  ${GREEN}3${NC}) 💿 Dung lượng ổ đĩa"
    echo -e "  ${GREEN}4${NC}) 🔍 Tìm kiếm file"
    echo -e "  ${GREEN}5${NC}) 📋 Xem log hệ thống"
    echo -e "  ${RED}0${NC}) 🚪 Thoát"
    echo ""
    draw_line
    read -p "$(echo -e "${BOLD}Nhập lựa chọn của bạn: ${NC}")" choice
    echo ""
    
    case $choice in
        1) show_system_info ;;
        2) show_top_cpu ;;
        3) show_disk ;;
        4) find_file ;;
        5) show_logs ;;
        0)
            echo -e "${GREEN}👋 Tạm biệt! Hẹn gặp lại.${NC}"
            echo ""
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Lựa chọn '$choice' không hợp lệ! Hãy chọn 0-5.${NC}"
            sleep 1
            ;;
    esac
done
