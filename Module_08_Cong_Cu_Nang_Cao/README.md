# Module 08 — Công Cụ Nâng Cao

> **Mục tiêu**: Thành thạo các công cụ nâng cao: vim, tmux, git, biến môi trường, alias

---

## 📖 8.1 Vim — Trình Soạn Thảo Văn Bản

```bash
vim file.txt               # Mở file bằng vim
```

### Các chế độ Vim:
| Chế độ | Cách vào | Dùng để |
|--------|----------|---------|
| Normal | Mặc định / `Esc` | Di chuyển, lệnh |
| Insert | `i`, `a`, `o` | Gõ văn bản |
| Visual | `v`, `V`, `Ctrl+V` | Chọn vùng văn bản |
| Command | `:` | Lưu, thoát, tìm kiếm |

### Di chuyển (Normal mode):
```
h j k l    ← ↓ ↑ →
w          → Đầu từ tiếp theo
b          → Đầu từ trước
0          → Đầu dòng
$          → Cuối dòng
gg         → Đầu file
G          → Cuối file
:10        → Nhảy đến dòng 10
Ctrl+f     → Trang sau
Ctrl+b     → Trang trước
```

### Chỉnh sửa (Normal mode):
```
i          → Insert trước con trỏ
a          → Insert sau con trỏ
o          → Dòng mới phía dưới
O          → Dòng mới phía trên
dd         → Xóa dòng
yy         → Copy dòng
p          → Paste
u          → Undo
Ctrl+r     → Redo
x          → Xóa ký tự
r          → Thay ký tự
```

### Lệnh Command mode:
```
:w         → Lưu
:q         → Thoát
:wq        → Lưu và thoát
:q!        → Thoát không lưu
:w file2   → Lưu thành tên khác
/từ_khóa  → Tìm kiếm (n = next, N = previous)
:%s/cũ/mới/g → Thay thế toàn file
:set number → Hiện số dòng
```

---

## 📖 8.2 Tmux — Quản Lý Terminal

```bash
# Cài đặt
sudo apt install tmux

# Khởi động
tmux                           # Mở session mới
tmux new -s ten_session        # Đặt tên session
tmux ls                        # Xem danh sách sessions
tmux attach -t ten_session     # Kết nối lại session
tmux kill-session -t ten_session  # Xóa session
```

### Phím tắt Tmux (prefix = Ctrl+B):
```
Ctrl+B, c       → Tạo window mới
Ctrl+B, n       → Window tiếp theo
Ctrl+B, p       → Window trước
Ctrl+B, 0-9     → Chuyển window theo số
Ctrl+B, %       → Chia đôi theo chiều dọc (pane)
Ctrl+B, "       → Chia đôi theo chiều ngang (pane)
Ctrl+B, mũi tên → Di chuyển giữa panes
Ctrl+B, z       → Phóng to/thu nhỏ pane hiện tại
Ctrl+B, d       → Detach session (session vẫn chạy nền)
Ctrl+B, ?       → Xem tất cả phím tắt
```

---

## 📖 8.3 Alias & Hàm Tiện Ích

```bash
# Tạo alias tạm thời (chỉ trong session hiện tại)
alias ll='ls -la'
alias la='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias cls='clear'
alias please='sudo'

# Xem tất cả alias
alias

# Xóa alias
unalias ll

# Thêm vào ~/.bashrc để lưu vĩnh viễn
echo "alias ll='ls -la'" >> ~/.bashrc
source ~/.bashrc               # Reload bashrc
```

---

## 📖 8.4 Biến Môi Trường

```bash
# Xem biến môi trường
env                            # Tất cả biến môi trường
printenv PATH                  # Biến PATH
echo $HOME                     # Xem biến cụ thể

# Đặt biến
MY_VAR="hello"                 # Biến local (chỉ shell hiện tại)
export MY_VAR="hello"          # Export → có trong subshell
export PATH="$PATH:/new/path"  # Thêm vào PATH

# Xóa biến
unset MY_VAR

# Thêm vào ~/.bashrc để lưu vĩnh viễn
echo 'export MY_VAR="hello"' >> ~/.bashrc
echo 'export PATH="$PATH:/new/path"' >> ~/.bashrc
```

---

## 📖 8.5 Tìm Kiếm Nâng Cao

```bash
# locate — tìm nhanh qua database
sudo updatedb                  # Cập nhật database
locate file.txt                # Tìm nhanh
locate -i "*.txt"              # Không phân biệt hoa thường

# which & whereis
which python3                  # Đường dẫn lệnh trong PATH
whereis python3                # Tìm binary, source, man page

# find nâng cao
find . -name "*.log" -mtime -7 -size +1M    # Log lớn hơn 1MB, 7 ngày gần đây
find . -type f -newer reference.txt          # File mới hơn reference.txt
find . -name "*.tmp" -delete                 # Xóa tất cả .tmp
find /home -maxdepth 2 -type d               # Thư mục, tối đa 2 cấp
```

---

## 📖 8.6 Quản Lý Gói Nâng Cao

```bash
# Tìm gói chứa lệnh cụ thể
apt-file search which_command  # (cần apt install apt-file)
dpkg -S /usr/bin/python3       # Gói nào cung cấp file này?

# Cài nhiều gói
sudo apt install git curl wget vim tmux htop tree jq -y

# tree — xem cây thư mục đẹp
tree                           # Cây thư mục hiện tại
tree -L 2                      # Chỉ 2 cấp
tree -a                        # Kể cả file ẩn
tree -d                        # Chỉ thư mục
```

---

## 📖 8.7 Xử Lý Văn Bản Nâng Cao

```bash
# jq — xử lý JSON
echo '{"name":"Alice","age":25}' | jq '.'          # Format đẹp
echo '{"name":"Alice","age":25}' | jq '.name'       # Lấy field
curl -s https://api.github.com/users/torvalds | jq '.name, .company'

# diff — so sánh file
diff file1.txt file2.txt                            # So sánh 2 file
diff -u file1.txt file2.txt                         # Unified format (đẹp hơn)
diff -r dir1/ dir2/                                 # So sánh thư mục

# xargs — biến stdin thành tham số
find . -name "*.txt" | xargs wc -l                  # Đếm dòng tất cả txt
find . -name "*.log" | xargs rm                     # Xóa tất cả log
echo "file1 file2 file3" | xargs -n1 touch          # Tạo từng file
cat urls.txt | xargs -I{} curl -O {}                # Tải nhiều URL

# tee — ghi vừa ra màn hình vừa vào file
ls -la | tee output.txt                             # Vừa xem vừa lưu
command | tee -a log.txt                            # Thêm vào cuối file
```

---

## 📖 8.8 Tối Ưu Shell (Bashrc)

Thêm vào `~/.bashrc`:
```bash
# === Custom Aliases ===
alias ll='ls -la --color=auto'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps aux'

# === Prompt đẹp hơn ===
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# === Hàm tiện ích ===
mkcd() { mkdir -p "$1" && cd "$1"; }          # Tạo và vào thư mục
extract() {                                    # Giải nén mọi định dạng
    case "$1" in
        *.tar.gz)  tar -xzf "$1" ;;
        *.tar.bz2) tar -xjf "$1" ;;
        *.zip)     unzip "$1" ;;
        *.gz)      gunzip "$1" ;;
        *)         echo "Không biết giải nén $1" ;;
    esac
}

# === History tốt hơn ===
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
```

---

## 📝 Tiếp Theo

👉 [bai_tap.md](./bai_tap.md)  
👉 Hoàn thành xong? Vào **Module 09** để làm dự án tổng hợp!
