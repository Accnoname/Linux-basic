# Module 07 — Shell Script

> **Mục tiêu**: Viết script tự động hóa công việc trên Linux

---

## 📖 7.1 Tạo Script Đầu Tiên

```bash
#!/bin/bash
# Dòng đầu tiên gọi là "shebang" — chỉ định trình thông dịch

echo "Xin chào, $(whoami)!"
echo "Hôm nay là $(date)"
echo "Bạn đang ở: $(pwd)"
```

### Cách tạo và chạy:
```bash
# 1. Tạo file
nano hello.sh         # hoặc vim, gedit...

# 2. Cấp quyền thực thi
chmod +x hello.sh

# 3. Chạy
./hello.sh
bash hello.sh
```

---

## 📖 7.2 Biến (Variables)

```bash
#!/bin/bash

# Khai báo biến (KHÔNG có khoảng trắng quanh =)
name="Alice"
age=25
path="/home/alice"

# Sử dụng biến
echo "Tên: $name"
echo "Tuổi: ${age}"         # {} để rõ ràng hơn
echo "Thư mục: $path"

# Biến môi trường
echo "Home: $HOME"
echo "User: $USER"
echo "Shell: $SHELL"
echo "Path: $PATH"

# Đọc input từ người dùng
read -p "Nhập tên của bạn: " username
echo "Xin chào, $username!"

# Tham số dòng lệnh
# $0 = tên script, $1 = tham số 1, $2 = tham số 2...
# $# = số tham số, $@ = tất cả tham số, $? = exit code lệnh trước
echo "Script: $0"
echo "Tham số 1: $1"
echo "Tổng số tham số: $#"
```

---

## 📖 7.3 Điều Kiện (if/else)

```bash
#!/bin/bash

age=20

# if cơ bản
if [ $age -ge 18 ]; then
    echo "Đã trưởng thành"
fi

# if-else
if [ $age -ge 18 ]; then
    echo "Đã trưởng thành"
else
    echo "Chưa trưởng thành"
fi

# if-elif-else
if [ $age -lt 13 ]; then
    echo "Trẻ em"
elif [ $age -lt 18 ]; then
    echo "Thiếu niên"
elif [ $age -lt 65 ]; then
    echo "Người lớn"
else
    echo "Người cao tuổi"
fi
```

### Toán tử so sánh:
```bash
# Số
[ $a -eq $b ]    # bằng (equal)
[ $a -ne $b ]    # khác (not equal)
[ $a -lt $b ]    # nhỏ hơn (less than)
[ $a -le $b ]    # nhỏ hơn hoặc bằng
[ $a -gt $b ]    # lớn hơn (greater than)
[ $a -ge $b ]    # lớn hơn hoặc bằng

# Chuỗi
[ "$a" = "$b" ]  # bằng
[ "$a" != "$b" ] # khác
[ -z "$a" ]      # chuỗi rỗng
[ -n "$a" ]      # chuỗi không rỗng

# File
[ -f file ]      # là file thường
[ -d dir ]       # là thư mục
[ -e path ]      # tồn tại
[ -r file ]      # có quyền đọc
[ -w file ]      # có quyền ghi
[ -x file ]      # có quyền thực thi

# Kết hợp
[ $a -gt 0 ] && [ $a -lt 10 ]    # AND
[ $a -lt 0 ] || [ $a -gt 100 ]   # OR
[[ $a -gt 0 && $a -lt 10 ]]      # Cú pháp mới hơn
```

---

## 📖 7.4 Vòng Lặp (Loops)

```bash
#!/bin/bash

# for loop — duyệt danh sách
for fruit in apple banana orange; do
    echo "Quả: $fruit"
done

# for loop — duyệt số
for i in {1..5}; do
    echo "Số: $i"
done

# for loop — C-style
for ((i=0; i<5; i++)); do
    echo "Lần $i"
done

# for loop — duyệt file
for file in *.txt; do
    echo "Xử lý: $file"
    wc -l "$file"
done

# while loop
count=1
while [ $count -le 5 ]; do
    echo "Đếm: $count"
    ((count++))
done

# until loop (ngược với while)
x=10
until [ $x -le 0 ]; do
    echo "Đếm ngược: $x"
    ((x--))
done

# break và continue
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        continue    # Bỏ qua i=5
    fi
    if [ $i -eq 8 ]; then
        break       # Dừng ở i=8
    fi
    echo "$i"
done
```

---

## 📖 7.5 Hàm (Functions)

```bash
#!/bin/bash

# Khai báo hàm
greet() {
    local name=$1           # local = biến cục bộ trong hàm
    echo "Xin chào, $name!"
}

# Gọi hàm
greet "Alice"
greet "Bob"

# Hàm có giá trị trả về
add() {
    local result=$(( $1 + $2 ))
    echo $result            # Trả về qua echo
}

sum=$(add 3 5)
echo "3 + 5 = $sum"

# Hàm kiểm tra file tồn tại
check_file() {
    if [ -f "$1" ]; then
        echo "✅ File '$1' tồn tại"
        return 0            # 0 = success
    else
        echo "❌ File '$1' không tồn tại"
        return 1            # 1 = failure
    fi
}

check_file "/etc/passwd"
check_file "/tmp/nonexistent.txt"
```

---

## 📖 7.6 Xử Lý Lỗi & Exit Codes

```bash
#!/bin/bash

# Exit code: 0 = thành công, khác 0 = lỗi
ls /tmp
echo "Exit code: $?"        # $? = exit code lệnh vừa chạy

ls /nonexistent
echo "Exit code: $?"

# Dừng script nếu có lỗi
set -e                      # Dừng ngay khi có lỗi
set -u                      # Báo lỗi nếu dùng biến chưa khai báo
set -o pipefail             # Bắt lỗi trong pipe

# Xử lý lỗi thủ công
if ! mkdir /tmp/test_dir 2>/dev/null; then
    echo "Không tạo được thư mục"
    exit 1
fi

# Trap — bắt tín hiệu
cleanup() {
    echo "Đang dọn dẹp..."
    rm -f /tmp/tempfile
}
trap cleanup EXIT           # Chạy cleanup khi script kết thúc
trap cleanup INT            # Chạy khi Ctrl+C
```

---

## 📖 7.7 Script Thực Tế Mẫu

```bash
#!/bin/bash
# backup.sh — Script backup thư mục

set -euo pipefail

SOURCE_DIR="$1"
BACKUP_DIR="$HOME/backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_${DATE}.tar.gz"

# Kiểm tra tham số
if [ $# -eq 0 ]; then
    echo "Dùng: $0 <thư_mục_cần_backup>"
    exit 1
fi

# Kiểm tra thư mục tồn tại
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Thư mục '$SOURCE_DIR' không tồn tại!"
    exit 1
fi

# Tạo thư mục backup nếu chưa có
mkdir -p "$BACKUP_DIR"

# Thực hiện backup
echo "📦 Đang backup '$SOURCE_DIR'..."
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR"

echo "✅ Backup thành công: $BACKUP_DIR/$BACKUP_NAME"
echo "📊 Kích thước: $(du -sh $BACKUP_DIR/$BACKUP_NAME | cut -f1)"
```

---

## 📝 Tiếp Theo

👉 [bai_tap.md](./bai_tap.md)  
👉 [kiem_tra.md](./kiem_tra.md)
