#!/bin/bash
# ==============================================================================
# setup_dev_env.sh — Tự động hóa thiết lập môi trường làm việc nâng cao
# Module 08: Công Cụ Nâng Cao (Linux Basic)
# ==============================================================================

set -euo pipefail

# --- Màu sắc thông báo ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}======================================================${NC}"
echo -e "${BLUE}🚀 KHỞI TẠO & TỐI ƯU HÓA MÔI TRƯỜNG LÀM VIỆC LINUX${NC}"
echo -e "${BLUE}======================================================${NC}"

BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Kiểm tra các công cụ nâng cao cần thiết
echo -e "\n${YELLOW}[1/4] Kiểm tra các tiện ích hệ thống...${NC}"
TOOLS=("vim" "tmux" "curl" "jq" "tree" "find")
MISSING_TOOLS=()

for tool in "${TOOLS[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo -e "  ✅ $tool: $(command -v "$tool")"
    else
        echo -e "  ⚠️  $tool: ${RED}Chưa cài đặt${NC}"
        MISSING_TOOLS+=("$tool")
    fi
done

if [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
    echo -e "${YELLOW}💡 Gợi ý lệnh cài đặt các gói còn thiếu:${NC}"
    echo -e "   sudo apt update && sudo apt install -y ${MISSING_TOOLS[*]}"
fi

# 2. Tạo bản sao lưu cấu hình cũ nếu có
echo -e "\n${YELLOW}[2/4] Sao lưu các tệp cấu hình hiện tại...${NC}"
mkdir -p "$BACKUP_DIR"
for file in ".vimrc" ".bashrc" ".tmux.conf"; do
    if [ -f "$HOME/$file" ]; then
        cp "$HOME/$file" "$BACKUP_DIR/"
        echo -e "  📦 Đã sao lưu $HOME/$file -> $BACKUP_DIR/"
    fi
done

# 3. Áp dụng cấu hình Vim tối ưu từ vimrc_mau
echo -e "\n${YELLOW}[3/4] Cập nhật cấu hình Vim (~/.vimrc)...${NC}"
if [ -f "$SCRIPT_DIR/vimrc_mau" ]; then
    cp "$SCRIPT_DIR/vimrc_mau" "$HOME/.vimrc"
    echo -e "  ✅ Đã áp dụng $HOME/.vimrc thành công (Line numbers, Auto-indent, Search highlight)"
else
    echo -e "  ⚠️ Không tìm thấy vimrc_mau tại $SCRIPT_DIR"
fi

# 4. Bổ sung các Alias & Tiện ích chuyên nghiệp vào ~/.bashrc
echo -e "\n${YELLOW}[4/4] Bổ sung Aliases & Functions vào ~/.bashrc...${NC}"
ALIAS_MARKER="# === LINUX_BASIC_MODULE_08_ALIASES ==="

if ! grep -q "$ALIAS_MARKER" "$HOME/.bashrc" 2>/dev/null; then
    cat << 'EOF' >> "$HOME/.bashrc"

# === LINUX_BASIC_MODULE_08_ALIASES ===
# Phím tắt điều hướng & danh sách
alias ll='ls -la --color=auto'
alias ..='cd ..'
alias ...='cd ../..'

# Giám sát & Quản trị nhanh
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias path='echo $PATH | tr : "\n"'

# Hàm tiện ích: Tạo thư mục và cd ngay vào đó
mkcd() {
    mkdir -p "$1" && cd "$1" && echo "📁 Đã tạo và di chuyển vào: $(pwd)"
}

# Hàm tiện ích: Bóc tách file JSON nhanh bằng jq
json_view() {
    if [ -f "$1" ]; then
        jq '.' "$1" | less -R
    else
        echo "❌ File '$1' không tồn tại!"
    fi
}
# === END_MODULE_08_ALIASES ===
EOF
    echo -e "  ✅ Đã tích hợp bí danh (ll, .., path, mkcd, json_view) vào ~/.bashrc"
    echo -e "  💡 Hãy gõ: ${GREEN}source ~/.bashrc${NC} để nạp các alias mới ngay lập tức!"
else
    echo -e "  ℹ️ Cấu hình Module 08 đã tồn tại trong ~/.bashrc (bỏ qua)"
fi

echo -e "\n${GREEN}======================================================${NC}"
echo -e "${GREEN}🎉 HOÀN TẤT THIẾT LẬP MÔI TRƯỜNG LÀM VIỆC NÂNG CAO!${NC}"
echo -e "${GREEN}======================================================${NC}\n"
