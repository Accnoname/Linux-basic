# Module 07 — Bài Tập Shell Script

---

## 🎯 Bài Tập 1: Script Chào Hỏi Thông Minh

Viết script `chao.sh` nhận tên từ tham số dòng lệnh. Nếu không có tham số thì hỏi input.

```bash
#!/bin/bash
# Yêu cầu:
# - Nếu có tham số ($1) thì chào tên đó
# - Nếu không có thì dùng read để hỏi
# - In ra: "Xin chào [tên]! Hôm nay là [ngày]"
# - Nếu tên là "root" thì in thêm cảnh báo

# Viết script của bạn ở đây:
```

**Test:**
```bash
chmod +x chao.sh
./chao.sh Alice      # → Xin chào Alice! Hôm nay là ...
./chao.sh            # → hỏi tên rồi chào
./chao.sh root       # → chào + cảnh báo
```

---

## 🎯 Bài Tập 2: Kiểm Tra File/Thư Mục

Viết script `kiem_tra.sh` nhận đường dẫn và cho biết đó là gì:

```bash
#!/bin/bash
# Yêu cầu:
# - Kiểm tra $1 có được truyền vào không
# - Nếu không tồn tại → thông báo
# - Nếu là file → hiện kích thước, số dòng
# - Nếu là thư mục → hiện số file bên trong
# - Hiện quyền truy cập của nó

# Viết script của bạn ở đây:
```

**Test:**
```bash
./kiem_tra.sh /etc/passwd
./kiem_tra.sh /etc
./kiem_tra.sh /tmp/khongtontai
```

---

## 🎯 Bài Tập 3: Script Đếm & Thống Kê

Viết script `thong_ke.sh` phân tích file log:

```bash
#!/bin/bash
# Input: đường dẫn file log (app.log từ Module 3)
# Output:
# - Tổng số dòng
# - Số dòng ERROR
# - Số dòng WARNING
# - Số dòng INFO
# - Ngày có nhiều lỗi nhất

# Viết script của bạn ở đây:
```

**Test:**
```bash
./thong_ke.sh ~/linux_practice/module03/app.log
```

**Đầu ra mong đợi:**
```
=== THỐNG KÊ FILE LOG ===
Tổng dòng: 10
ERROR: 4
WARNING: 2
INFO: 3
DEBUG: 1
Ngày nhiều lỗi nhất: 2024-01-01 (2 lỗi)
```

---

## 🎯 Bài Tập 4: Backup Script

Viết script `backup.sh` hoàn chỉnh:

```bash
#!/bin/bash
# Yêu cầu:
# 1. Nhận thư mục nguồn làm tham số
# 2. Kiểm tra thư mục tồn tại
# 3. Tạo backup với tên = tên_thư_mục_YYYYMMDD_HHMMSS.tar.gz
# 4. Lưu vào ~/backups/
# 5. Xóa backup cũ hơn 7 ngày
# 6. Hiện danh sách backup hiện có

# Viết script của bạn ở đây:
```

---

## 🎯 Bài Tập 5: Menu Tương Tác

Viết script `menu.sh` có menu lựa chọn:

```bash
#!/bin/bash
# Menu:
# 1) Xem thông tin hệ thống
# 2) Xem 10 process dùng CPU nhiều nhất
# 3) Xem dung lượng ổ đĩa
# 4) Tìm file (hỏi tên file)
# 5) Thoát
#
# Sau khi chọn xong → hiện kết quả → quay lại menu (dùng while loop)

# Gợi ý cấu trúc:
while true; do
    echo "=== MENU QUẢN LÝ HỆ THỐNG ==="
    echo "1) Thông tin hệ thống"
    echo "2) Top process CPU"
    echo "3) Dung lượng ổ đĩa"
    echo "4) Tìm file"
    echo "5) Thoát"
    read -p "Chọn: " choice
    
    case $choice in
        1) # ... ;;
        2) # ... ;;
        3) # ... ;;
        4) # ... ;;
        5) echo "Tạm biệt!"; exit 0 ;;
        *) echo "Lựa chọn không hợp lệ!" ;;
    esac
done
```

---

## 🏆 Thử Thách Cuối Module

Viết script `monitor.sh` theo dõi hệ thống:

```bash
#!/bin/bash
# Script chạy mỗi 10 giây, log ra file monitor.log:
# - Thời gian
# - % CPU đang dùng
# - RAM còn trống
# - Dung lượng disk còn
# - Cảnh báo nếu RAM < 20% hoặc disk < 10%
# Chạy 5 lần rồi thoát (hoặc Ctrl+C để dừng)
```

---

## ✅ Checklist

- [ ] Viết được script nhận tham số và input
- [ ] Dùng if/elif/else thành thạo
- [ ] Dùng for và while loop
- [ ] Viết và gọi được function
- [ ] Xử lý lỗi cơ bản ($?, exit code)
- [ ] Dùng được case statement
- [ ] Viết được script thực tế có ích

👉 Sang [kiem_tra.md](./kiem_tra.md)!
