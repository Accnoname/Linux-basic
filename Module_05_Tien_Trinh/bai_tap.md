# Module 05 — Bài Tập Thực Hành: Tiến Trình & Tài Nguyên Hệ Thống

> 💡 **Mục tiêu**: Thực hành theo dõi CPU/RAM, chạy tác vụ ngầm (background jobs), tìm kiếm và tắt tiến trình bị treo (kill).

---

## 🎯 Phần 1: Giám Sát Tài Nguyên Máy Tính

```bash
# 1. Xem dung lượng RAM đang sử dụng (dạng đọc được MB/GB)
free -h

# 2. Xem dung lượng ổ đĩa còn trống
df -h

# 3. Xem thời gian máy đã bật (Uptime) và chỉ số tải (Load Average)
uptime

# 4. Mở trình giám sát tiến trình realtime
top
```
*Trong `top`*:
- Bấm phím `M` (viết hoa): Sắp xếp tiến trình theo dung lượng RAM sử dụng.
- Bấm phím `P` (viết hoa): Sắp xếp tiến trình theo % CPU.
- Bấm phím `q`: Thoát khỏi `top`.

---

## 🎯 Phần 2: Xem Danh Sách Tiến Trình & Lọc Theo Tên

```bash
# 1. Xem các tiến trình của cửa sổ terminal hiện tại
ps

# 2. Xem TOÀN BỘ tiến trình của toàn hệ điều hành
ps aux | head -20

# 3. Tìm tiến trình bash của bạn
ps aux | grep bash

# 4. Tìm tiến trình chiếm nhiều RAM nhất hệ thống
ps aux --sort=-%mem | head -10
```

---

## 🎯 Phần 3: Làm Chủ Tiến Trình Chạy Ngầm (Background Jobs)

### 1. Đưa tiến trình chạy ngầm ngay từ đầu với dấu `&`
```bash
# Chạy một lệnh giả lập mất thời gian 100 giây ở chế độ nền
sleep 100 &

# Chạy thêm một lệnh nữa
sleep 200 &

# Xem danh sách các job đang chạy ngầm của terminal này
jobs
```

### 2. Quản lý Foreground (`fg`) và Background (`bg`)
```bash
# Chạy lệnh bình thường
sleep 50
# Trong khi đang chạy, bấm tổ hợp phím Ctrl + Z để TẠM DỪNG (Suspend) tiến trình!

# Gõ lệnh kiểm tra trạng thái
jobs
# Bạn sẽ thấy lệnh sleep 50 đang ở trạng thái [Stopped]

# Cho phép nó tiếp tục chạy nhưng chạy ở BACKGROUND
bg %1

# Kéo nó trở lại FOREGROUND (màn hình chính)
fg %1
# Nhấn Ctrl + C để HỦY lệnh hoàn toàn
```

---

## 🎯 Phần 4: Tiêu Diệt Tiến Trình (kill & pkill)

```bash
# 1. Tạo một tiến trình giả lập chạy ngầm
sleep 999 &

# 2. Xem PID của nó bằng lệnh jobs -l hoặc ps
jobs -l

# 3. Dừng tiến trình một cách lịch sự bằng SIGTERM (kill PID)
# Thay <PID> bằng mã tiến trình bạn vừa thấy ở trên
kill <PID>

# 4. Kiểm tra lại
jobs

# 5. Thử nghiệm lệnh pkill theo tên
sleep 888 &
pkill sleep
jobs
```

✅ **Hoàn thành bài tập! Hãy chuyển sang [kiem_tra.md](file:///d:/Linux%20basic/Module_05_Tien_Trinh/kiem_tra.md) để đánh giá bản thân.**
