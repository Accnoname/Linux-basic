# Module 08 — Bài Tập Thực Hành: Công Cụ Nâng Cao (Vim, Tmux, Môi Trường, Pipeline)

> 💡 **Mục tiêu**: Làm chủ bộ công cụ năng suất tối thượng của kỹ sư Linux/DevOps:
> 1. Trình soạn thảo **Vim** (sống sót, điều hướng tốc độ cao, tìm kiếm thay thế regex).
> 2. Quản lý phiên làm việc đa nhiệm **Tmux** (chia màn hình, giữ tiến trình nền khi đứt SSH).
> 3. Tinh chỉnh **Biến môi trường**, **$PATH**, **Alias** và **Bash Functions** trong `~/.bashrc`.
> 4. Tìm kiếm file chuyên sâu với **`find`**, **`which`**, **`whereis`**, **`tree`**.
> 5. Xử lý dữ liệu & pipeline nâng cao với **`jq`** (JSON), **`diff`** (so sánh file), **`xargs`**, **`tee`**.
> 6. Tự động hóa thiết lập môi trường với script **`setup_dev_env.sh`**.

---

## 🎯 Lab 1: Làm Chủ Trình Soạn Thảo Vim

Vim là trình soạn thảo mặc định trên hầu hết server Linux. Khi cứu hộ server hay chỉnh sửa cấu hình qua SSH, bạn bắt buộc phải thành thạo Vim.

### Bước 1: Chuẩn bị thư mục thực hành
```bash
mkdir -p ~/linux_practice/module08/vim_lab
cd ~/linux_practice/module08/vim_lab
```

### Bước 2: Tạo và chỉnh sửa file với các chế độ Vim
Mở file mới:
```bash
vim server_config.txt
```

#### Quy trình thao tác chuẩn:
1. **Chế độ INSERT (Gõ văn bản)**:
   - Khi vừa mở file, Vim đang ở chế độ **NORMAL**.
   - Nhấn phím `i` (bạn sẽ thấy chữ `-- INSERT --` ở góc dưới bên trái).
   - Nhập đoạn cấu hình sau:
     ```text
     SERVER_NAME=my-web-server
     PORT=8080
     ENVIRONMENT=staging
     LOG_LEVEL=debug
     DATABASE_URL=postgres://localhost:5432/testdb
     CACHE_ENABLED=false
     DEBUG=true
     ```

2. **Chế độ NORMAL (Điều hướng & Lệnh)**:
   - Nhấn phím `Esc` để thoát INSERT mode về NORMAL mode.
   - **Di chuyển con trỏ không dùng chuột**:
     - `h` (trái), `j` (xuống), `k` (lên), `l` (phải).
     - `w`: Nhảy tới đầu từ tiếp theo.
     - `b`: Lùi về đầu từ phía trước.
     - `0`: Nhảy về đầu dòng.
     - `$`: Nhảy về cuối dòng.
     - `gg`: Nhảy về dòng đầu tiên của file.
     - `G`: Nhảy về dòng cuối cùng của file.
     - `:3` + `Enter`: Nhảy trực tiếp đến dòng số 3.

3. **Thao tác sao chép, cắt, dán và hoàn tác (Normal Mode)**:
   - Di chuyển con trỏ đến dòng `LOG_LEVEL=debug`:
     - Nhấn `yy` (Copy dòng hiện tại).
     - Nhấn `p` (Dán dòng vừa copy xuống phía dưới).
   - Di chuyển đến dòng vừa dán:
     - Nhấn `dd` (Xóa/Cắt dòng hiện tại).
   - Nhấn `u` (Undo - hoàn tác lại hành động vừa xóa).
   - Nhấn `Ctrl + r` (Redo - làm lại).

4. **Tìm kiếm & Thay thế Regex (Command Mode)**:
   - Nhấn `/` rồi gõ `staging` rồi nhấn `Enter` để tìm kiếm từ này.
   - Nhấn `n` để nhảy đến kết quả tiếp theo, `N` để quay lại kết quả trước.
   - Thay thế toàn bộ từ `staging` thành `production`:
     ```text
     :%s/staging/production/g
     ```
   - Thay thế cổng `8080` thành `443`:
     ```text
     :%s/8080/443/g
     ```

5. **Lưu và thoát**:
   - Gõ `:w` và nhấn `Enter` để lưu file.
   - Gõ `:wq` (hoặc nhấn `ZZ`) để lưu và thoát ra terminal.
   - *(Mẹo an toàn: Nếu lỡ sửa sai muốn thoát mà KHÔNG lưu: bấm `Esc` rồi gõ `:q!` rồi `Enter`)*.

### Bước 3: Áp dụng file cấu hình `vimrc_mau`
Để Vim hiển thị số dòng, tô màu cú pháp và tự thụt lề thông minh:
```bash
cp /mnt/d/Linux-basic/Module_08_Cong_Cu_Nang_Cao/vimrc_mau ~/.vimrc
vim server_config.txt
# Bạn sẽ thấy số dòng, highlight con trỏ và màu sắc cực kỳ trực quan!
```

---

## 🎯 Lab 2: Quản Trị Terminal Đa Nhiệm Với Tmux

**Vấn đề thực tế**: Khi bạn SSH vào server và đang chạy một tác vụ dài 2 tiếng (như build docker, backup database), nếu mạng nhà bạn chập chờn bị ngắt kết nối SSH, tiến trình đó sẽ bị OS kill ngay lập tức!
**Giải pháp**: Sử dụng **Tmux** (Terminal Multiplexer) — tiến trình chạy độc lập trong session của Tmux, ngắt SSH thoải mái không bao giờ sợ mất việc.

### Bước 1: Kiểm tra hoặc cài đặt tmux
```bash
which tmux || sudo apt update && sudo apt install -y tmux
```

### Bước 2: Khởi tạo và đặt tên Session
```bash
# Tạo session có tên "dev_session"
tmux new -s dev_session
```

### Bước 3: Thao tác đa nhiệm trong Tmux (Phím dẫn mặc định là Ctrl + B)
> ⚠️ **Cách bấm**: Nhấn giữ `Ctrl` và bấm `B`, sau đó **thả cả hai phím ra**, rồi mới bấm phím chức năng tiếp theo.

1. **Chia màn hình (Split Panes)**:
   - Bấm `Ctrl + B`, sau đó bấm `%` : Chia đôi terminal theo **chiều dọc** (trái / phải).
   - Bấm `Ctrl + B`, sau đó bấm `"` : Chia đôi terminal theo **chiều ngang** (trên / dưới).
2. **Di chuyển giữa các Pane**:
   - Bấm `Ctrl + B` rồi bấm các phím **mũi tên** (←, →, ↑, ↓) để nhảy sang pane tương ứng.
   - Thử nghiệm:
     - Pane 1: Gõ `top` hoặc `htop` để theo dõi CPU/RAM.
     - Pane 2: Gõ `tail -f /var/log/syslog` hoặc xem file log.
     - Pane 3: Gõ lệnh terminal thông thường.
3. **Phóng to toàn màn hình một Pane (Zoom)**:
   - Đứng ở một pane, bấm `Ctrl + B`, sau đó bấm `z`. Pane đó sẽ bung toàn màn hình!
   - Bấm lại `Ctrl + B` rồi `z` để thu nhỏ về lưới ban đầu.
4. **Tách khỏi Session (Detach) — Phép màu của Tmux**:
   - Bấm `Ctrl + B`, sau đó bấm `d` (Detach).
   - Màn hình lập tức quay trở lại shell bên ngoài, nhưng session `dev_session` bên trong vẫn đang chạy bình thường!

### Bước 4: Kiểm tra và kết nối lại (Attach)
```bash
# Xem danh sách các session đang chạy ngầm
tmux ls

# Kết nối lại vào session "dev_session"
tmux attach -t dev_session

# Sau khi làm việc xong, muốn đóng hẳn session:
# Cách 1: Trong tmux, gõ exit ở tất cả các pane
# Cách 2: Từ bên ngoài gõ:
tmux kill-session -t dev_session
```

---

## 🎯 Lab 3: Biến Môi Trường, $PATH & Shell Tiện Ích

### 1. Hiểu sâu về $PATH và cơ chế tìm kiếm lệnh
Khi bạn gõ lệnh `ls` hay `python3`, Linux tìm file thực thi ở đâu?
```bash
# Xem toàn bộ danh sách thư mục trong PATH:
echo $PATH

# Hiển thị PATH dễ đọc hơn (mỗi thư mục trên một dòng):
echo $PATH | tr : "\n"

# Kiểm tra đường dẫn chính xác của lệnh:
which bash
which python3 2>/dev/null || which ls
```

### 2. Sự khác biệt giữa Biến Cục Bộ và Biến Môi Trường (Export)
```bash
# Tạo biến cục bộ (Local variable)
MY_APP_MODE="testing"
echo $MY_APP_MODE

# Mở một subshell mới (tiến trình con)
bash -c 'echo "Trong subshell: $MY_APP_MODE"'
# Kết quả: rỗng! Vì subshell không nhìn thấy biến local.

# Xuất thành biến môi trường với export:
export MY_APP_MODE="testing"
bash -c 'echo "Trong subshell sau khi export: $MY_APP_MODE"'
# Kết quả: In ra "testing"! Subshell đã kế thừa được biến.
```

### 3. Thêm thư mục cá nhân vào $PATH
```bash
mkdir -p ~/my_tools
echo 'echo "Xin chao tu my_tools!"' > ~/my_tools/hello_tool
chmod +x ~/my_tools/hello_tool

# Thử gõ trực tiếp:
hello_tool
# Báo lỗi: command not found!

# Thêm thư mục ~/my_tools vào $PATH:
export PATH="$HOME/my_tools:$PATH"

# Thử lại:
hello_tool
# Thành công! Lệnh chạy từ bất kỳ đâu.
```

### 4. Tinh chỉnh Aliases & Functions trong `~/.bashrc`
Thay vì gõ lệnh dài, hãy định nghĩa các phím tắt siêu tốc:
```bash
# Xem các alias hiện có
alias

# Đưa các alias và function tiện ích vào ~/.bashrc
cat << 'EOF' >> ~/.bashrc

# Custom Aliases cho hiệu năng cao
alias ll='ls -la --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias df='df -h'
alias du='du -h -d 1'
alias free='free -h'
alias ports='ss -tlnp'

# Function: Tạo thư mục và cd ngay vào đó
mkcd() {
    mkdir -p "$1" && cd "$1" && echo "📁 Đã vào: $(pwd)"
}
EOF

# Nạp lại cấu hình ngay lập tức:
source ~/.bashrc

# Thử nghiệm tính năng mới:
mkcd ~/linux_practice/module08/test_mkcd
pwd
..
```

---

## 🎯 Lab 4: Tìm Kiếm Chuyên Sâu (`find`, `which`, `whereis`, `tree`)

### 1. Chuẩn bị dữ liệu mẫu để tìm kiếm
```bash
mkdir -p ~/linux_practice/module08/find_lab/logs
mkdir -p ~/linux_practice/module08/find_lab/backup
mkdir -p ~/linux_practice/module08/find_lab/src

# Tạo file với các mốc thời gian và kích thước khác nhau
touch ~/linux_practice/module08/find_lab/logs/app.log
touch ~/linux_practice/module08/find_lab/logs/error.log
touch ~/linux_practice/module08/find_lab/backup/data.tar.gz
touch ~/linux_practice/module08/find_lab/src/main.py
touch ~/linux_practice/module08/find_lab/temp_cache.tmp

# Tạo một file có dung lượng giả lập 5MB
dd if=/dev/zero of=~/linux_practice/module08/find_lab/backup/large_archive.bin bs=1M count=5 2>/dev/null
```

### 2. Thực hành tìm kiếm nâng cao với `find`
```bash
cd ~/linux_practice/module08/find_lab

# 1. Tìm tất cả các file có đuôi .log
find . -type f -name "*.log"

# 2. Tìm tất cả các file có dung lượng lớn hơn 2 Megabytes (+2M)
find . -type f -size +2M -exec ls -lh {} \;

# 3. Tìm tất cả file được chỉnh sửa trong vòng 1 ngày qua (-mtime -1)
find . -type f -mtime -1

# 4. Tìm kiếm không phân biệt hoa thường (-iname)
find . -type f -iname "*.PY"

# 5. Tìm và xóa tự động các file rác .tmp
find . -type f -name "*.tmp" -delete
ls -la temp_cache.tmp 2>/dev/null || echo "✅ Đã tự động xóa sạch file rác .tmp!"
```

### 3. Trực quan hóa cấu trúc thư mục với `tree`
```bash
which tree || sudo apt update && sudo apt install -y tree

# Xem cây thư mục với độ sâu 2 cấp:
tree -L 2 ~/linux_practice/module08/find_lab
```

---

## 🎯 Lab 5: Xử Lý Dữ Liệu & Pipeline Nâng Cao (`jq`, `diff`, `xargs`, `tee`)

Trong thư mục `Module_08_Cong_Cu_Nang_Cao` đã có sẵn các file mẫu:
- `sample_api.json` (dữ liệu JSON)
- `config_v1.conf` và `config_v2.conf` (hai phiên bản cấu hình)

### 1. Bóc tách dữ liệu JSON cực đỉnh với `jq`
`jq` là công cụ tiêu chuẩn công nghiệp trong DevOps khi làm việc với Docker, Kubernetes, AWS CLI hay REST APIs.

```bash
which jq || sudo apt update && sudo apt install -y jq

DATA_FILE="/mnt/d/Linux-basic/Module_08_Cong_Cu_Nang_Cao/sample_api.json"

# 1. Format dữ liệu JSON đẹp mắt (Pretty-print)
cat "$DATA_FILE" | jq '.'

# 2. Lấy thông tin server (nested object)
jq '.server' "$DATA_FILE"

# 3. Lấy IP của server
jq -r '.server.ip' "$DATA_FILE"

# 4. Trích xuất danh sách tất cả username trong mảng users
jq '.users[].username' "$DATA_FILE"

# 5. Lọc những user có vai trò là "developer"
jq '.users[] | select(.role == "developer") | {username: .username, email: .email}' "$DATA_FILE"
```

### 2. So sánh cấu hình dịch vụ với `diff`
Khi deploy ứng dụng, bạn cần biết chính xác giữa bản cũ và bản mới đã thay đổi những dòng nào:
```bash
CONF1="/mnt/d/Linux-basic/Module_08_Cong_Cu_Nang_Cao/config_v1.conf"
CONF2="/mnt/d/Linux-basic/Module_08_Cong_Cu_Nang_Cao/config_v2.conf"

# So sánh 2 file với định dạng thông thường:
diff "$CONF1" "$CONF2"

# So sánh theo định dạng Unified format (dễ đọc nhất, chuẩn Git Diff):
diff -u "$CONF1" "$CONF2"
# Dấu - màu đỏ/kí hiệu - là dòng bị xóa ở file cũ
# Dấu + màu xanh/kí hiệu + là dòng được thêm ở file mới

# Xuất ra file patch bản vá:
diff -u "$CONF1" "$CONF2" > config_update.patch
cat config_update.patch
```

### 3. Phân luồng dữ liệu với `tee`
Lệnh `tee` nhận dữ liệu từ stdin và vừa in ra màn hình console, vừa ghi đồng thời vào file:
```bash
cd ~/linux_practice/module08

# Vừa xem thông tin kernel/hệ điều hành vừa lưu vào audit.log
uname -a | tee audit.log

# Ghi nối tiếp (append) với cờ -a
date | tee -a audit.log
uptime | tee -a audit.log

cat audit.log
```

### 4. Xử lý hàng loạt đối số với `xargs`
`xargs` chuyển đổi đầu ra chuẩn (stdout) của lệnh trước thành danh sách tham số cho lệnh tiếp theo:
```bash
cd ~/linux_practice/module08

# Tạo danh sách các file cần tạo
echo "file_A.txt file_B.txt file_C.txt" | xargs touch
ls -l file_*.txt

# Đếm tổng số dòng của tất cả các file cấu hình trong thư mục
find /mnt/d/Linux-basic/Module_08_Cong_Cu_Nang_Cao -name "*.conf" | xargs wc -l

# Dọn dẹp các file vừa tạo
echo "file_A.txt file_B.txt file_C.txt" | xargs rm -v
```

---

## 🎯 Lab 6: Thử Thách Thực Chiến (Capstone Project)

Tự động hóa hoàn toàn việc cấu hình môi trường máy chủ Linux cá nhân bằng script:
Thực thi script thiết lập đã được viết sẵn tại thư mục:
```bash
chmod +x /mnt/d/Linux-basic/Module_08_Cong_Cu_Nang_Cao/setup_dev_env.sh
/mnt/d/Linux-basic/Module_08_Cong_Cu_Nang_Cao/setup_dev_env.sh
```

### Kiểm tra kết quả sau khi chạy script:
1. Kiểm tra xem file `~/.vimrc` đã có cấu hình số dòng và indent chưa:
   ```bash
   head -15 ~/.vimrc
   ```
2. Nạp lại shell và thử nghiệm các alias mới:
   ```bash
   source ~/.bashrc
   path
   ```

---

## 🏆 Checklist Tự Đánh Giá
- [ ] Tôi biết cách mở, gõ text (`i`), lưu (`:w`), thoát (`:wq`, `:q!`) và tìm thay thế (`:%s/a/b/g`) trong Vim.
- [ ] Tôi hiểu cách tạo session Tmux, chia Pane (`Ctrl+B %` và `"`), Zoom (`Ctrl+B z`) và Detach (`Ctrl+B d`).
- [ ] Tôi nắm vững biến `$PATH`, cách `export` biến môi trường và tạo Alias trong `~/.bashrc`.
- [ ] Tôi biết dùng `find` với `-size`, `-mtime`, `-delete` để tìm và lọc file chính xác.
- [ ] Tôi biết dùng `jq` để lọc dữ liệu JSON và `diff -u` để so sánh các file cấu hình.

👉 **Tiếp theo**: Hãy mở file **[kiem_tra.md](file:///d:/Linux-basic/Module_08_Cong_Cu_Nang_Cao/kiem_tra.md)** để thực hiện bài tự kiểm tra kiến thức và ghi nhận kết quả đánh giá cùng Mentor!
