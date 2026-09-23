# Module 05 — Bài Tập Thực Hành: Tiến Trình & Tài Nguyên Hệ Thống

> 💡 **Mục tiêu**: Thực hành theo dõi CPU/RAM/Ổ đĩa, làm chủ tiến trình chạy ngầm (Background jobs), bền bỉ với `nohup`, dập tắt tiến trình treo an toàn (`kill`, `pkill`), và thiết lập tác vụ tự động với `cron`.

---

## 🎯 Phần 1: Chuẩn Bị Môi Trường & Giám Sát Tài Nguyên

### 1. Tạo thư mục thực hành
```bash
mkdir -p ~/linux_practice/module05
cd ~/linux_practice/module05
```

### 2. Giám sát bộ nhớ RAM (`free`)
```bash
# Xem RAM và bộ nhớ đệm (Cache/Buffer) theo định dạng dễ đọc (MB/GB)
free -h

# Quan sát 3 cột quan trọng:
# - total: Tổng lượng RAM vật lý
# - used: Lượng RAM đang bị chiếm dụng
# - available: Lượng RAM thực tế còn có thể cấp phát cho tiến trình mới
```

### 3. Giám sát không gian lưu trữ ổ đĩa (`df` & `du`)
```bash
# Xem dung lượng các phân vùng ổ đĩa
df -h

# Xem dung lượng thực tế của một thư mục cụ thể (Ví dụ thư mục Home)
du -sh ~

# Liệt kê các thư mục chiếm dung lượng lớn nhất trong thư mục hiện tại
du -sh * | sort -hr | head -5
```

### 4. Kiểm tra tải hệ thống (`uptime`)
```bash
uptime
# Ví dụ kết quả:
# 14:30:15 up 2 days, 3:12,  2 users,  load average: 0.15, 0.25, 0.18
# Ý nghĩa Load Average: Trung bình số tiến trình chờ xử lý trong 1 phút, 5 phút, 15 phút.
# Nếu Load Average vượt quá số Core CPU (kiểm tra bằng lệnh: nproc), hệ thống đang quá tải!
```

### 5. Khám phá trình giám sát realtime `top`
```bash
top
```
*Các phím tắt vàng trong `top`*:
- Phím `M` (viết hoa): Sắp xếp danh sách tiến trình theo **RAM** giảm dần.
- Phím `P` (viết hoa): Sắp xếp danh sách tiến trình theo **% CPU** giảm dần.
- Phím `k`: Nhập PID để trực tiếp gửi tín hiệu kill mà không cần thoát ra terminal.
- Phím `q`: Thoát khỏi giao diện `top`.

*(Khuyên dùng thêm `htop` nếu đã cài: `sudo apt install htop -y && htop`)*.

---

## 🎯 Phần 2: Soi Tiến Trình Chi Tiết (`ps` & Lọc Nâng Cao)

```bash
# 1. Xem các tiến trình của cửa sổ terminal hiện tại
ps

# 2. Xem TOÀN BỘ tiến trình đang chạy trên toàn hệ điều hành
ps aux | head -15

# 3. Lọc tiến trình của người dùng hiện tại
ps -u $USER

# 4. Tìm kiếm nhanh tiến trình đang chạy theo tên (Ví dụ: bash, python)
ps aux | grep bash

# 5. Xem cây tiến trình quan hệ Cha - Con (Parent-Child PPID/PID)
ps -ef --forest | head -20
# Hoặc nếu có lệnh pstree:
pstree

# 6. Top 5 tiến trình ngốn nhiều RAM nhất hệ thống
ps aux --sort=-%mem | head -6

# 7. Top 5 tiến trình ngốn nhiều CPU nhất hệ thống
ps aux --sort=-%cpu | head -6
```

---

## 🎯 Phần 3: Làm Chủ Tiến Trình Nền (Background Jobs)

### 1. Đưa tiến trình chạy ngầm ngay từ đầu với ký tự `&`
```bash
# Chạy lệnh giả lập tác vụ nặng 120 giây ở chế độ nền
sleep 120 &

# Chạy thêm một lệnh nền khác 240 giây
sleep 240 &

# Xem danh sách các job đang chạy ngầm của riêng terminal này
jobs -l
# Cột [1], [2] là Job ID. Cột số tiếp theo là PID hệ thống.
```

### 2. Điều phối linh hoạt Foreground (`fg`) và Background (`bg`)
```bash
# Chạy một lệnh ở chế độ bình thường (chiếm quyền điều khiển terminal)
sleep 90

# 👉 Khi lệnh đang chạy, nhấn tổ hợp phím: Ctrl + Z
# Terminal sẽ hiển thị: [1]+ Stopped sleep 90 (Tiến trình bị tạm dừng!)

# Kiểm tra danh sách jobs:
jobs

# Cho phép tiến trình bị tạm dừng tiếp tục chạy nhưng ở chế độ BACKGROUND:
bg %1

# Kéo tiến trình trở lại màn hình chính FOREGROUND để tương tác:
fg %1

# 👉 Khi đang ở Foreground, nhấn tổ hợp phím: Ctrl + C
# Tín hiệu SIGINT sẽ được gửi để HỦY HOÀN TOÀN tiến trình!
```

---

## 🎯 Phần 4: Chạy Ứng Dụng Bền Bỉ Với `nohup`

Khi bạn tắt cửa sổ terminal hoặc mất kết nối SSH, Linux sẽ gửi tín hiệu `SIGHUP` để hủy toàn bộ tiến trình con của shell đó. Để ứng dụng tiếp tục chạy ngầm vĩnh viễn:

```bash
# Chạy một script/lệnh không lo bị ngắt kết nối (No Hangup)
nohup bash -c "while true; do date >> ~/linux_practice/module05/timer.log; sleep 2; done" > /dev/null 2>&1 &

# Kiểm tra tiến trình đang chạy:
ps aux | grep timer.log

# Theo dõi file log được ghi liên tục:
tail -f ~/linux_practice/module05/timer.log
# Nhấn Ctrl + C để ngừng xem log (tiến trình ghi log vẫn âm thầm chạy ngầm!)
```

---

## 🎯 Phần 5: Tiêu Diệt Tiến Trình Treo (`kill`, `pkill`, `killall`)

Hiểu rõ 2 tín hiệu sống còn:
- **Tín hiệu 15 (`SIGTERM`)**: Yêu cầu tắt lịch sự, cho phép app lưu file và đóng kết nối database sạch sẽ (`kill <PID>`).
- **Tín hiệu 9 (`SIGKILL`)**: Cưỡng chế thu hồi RAM/CPU ngay lập tức từ tầng Kernel, app không thể chối từ (`kill -9 <PID>`).

```bash
# 1. Tạo 2 tiến trình mẫu để thực hành tiêu diệt
sleep 500 &
PID_TEST=$!
echo "Đã tạo tiến trình PID: $PID_TEST"

# 2. Tiêu diệt lịch sự bằng SIGTERM
kill $PID_TEST
jobs

# 3. Tạo tiến trình giả lập cứng đầu và cưỡng chế dập tắt bằng SIGKILL (-9)
sleep 600 &
PID_STUBBORN=$!
kill -9 $PID_STUBBORN
jobs

# 4. Tiêu diệt theo tên với pkill
sleep 700 &
sleep 701 &
# Dập tắt tất cả tiến trình có tên chứa 'sleep'
pkill -f sleep
jobs

# 5. Dọn dẹp tiến trình nohup ghi log ở Phần 4
pkill -f timer.log
```

---

## 🎯 Phần 6: Lên Lịch Tác Vụ Tự Động Định Kỳ Với Cron

`cron` là trái tim tự động hóa của Linux Sysadmin và DevOps.

### 1. Cú pháp kinh điển của Cron (5 ngôi sao thời gian)
```
*   *   *   *   *   lệnh_cần_thực_thi
┬   ┬   ┬   ┬   ┬
│   │   │   │   └──── Thứ trong tuần (0-7, 0 và 7 đều là Chủ Nhật)
│   │   │   └──────── Tháng trong năm (1-12)
│   │   └──────────── Ngày trong tháng (1-31)
│   └──────────────── Giờ trong ngày (0-23)
└──────────────────── Phút trong giờ (0-59)
```

### 2. Thực hành xem và chỉnh sửa Cron Job
```bash
# Xem danh sách cron job hiện tại của bạn
crontab -l

# Mở trình soạn thảo crontab (lần đầu có thể chọn số 1: nano)
crontab -e
```

**Ví dụ thiết lập Cron Job mẫu:**
Thêm dòng sau vào cuối file crontab để tự động ghi thời gian vào file log mỗi phút một lần:
```text
* * * * * echo "Cron check at $(date)" >> ~/linux_practice/module05/cron_test.log
```
Lưu lại (Nếu dùng nano: `Ctrl + O` rồi `Enter` để lưu, `Ctrl + X` để thoát).
Sau 1 - 2 phút, gõ lệnh kiểm tra:
```bash
cat ~/linux_practice/module05/cron_test.log
```
*(Xóa crontab sau khi thử nghiệm xong: `crontab -r`)*.

---

## 🎯 Phần 7: Kịch Bản Xử Lý Sự Cố DevOps Thực Tế

### 🚨 Tình huống sự cố:
Server nhận cảnh báo: *"Một worker chạy ngầm đang chiếm dụng tài nguyên bất thường làm nghẽn hệ thống"*.

### Các bước điều tra và xử lý chuẩn Sysadmin:
1. **Bước 1 — Định vị thủ phạm:**
   ```bash
   # Tìm xem tiến trình nào đang ngốn nhiều tài nguyên nhất
   ps aux --sort=-%cpu | head -5
   ```
2. **Bước 2 — Tra cứu nguồn gốc:**
   ```bash
   # Lấy PID của thủ phạm (ví dụ PID là 12345), kiểm tra thông tin chi tiết:
   ls -l /proc/12345/exe
   # Lệnh này cho biết chính xác file thực thi nào đang chạy tại PID đó!
   ```
3. **Bước 3 — Dập tắt an toàn theo trình tự:**
   ```bash
   # Thử dừng lịch sự trước:
   kill 12345
   sleep 2
   # Kiểm tra xem đã tắt chưa:
   ps -p 12345
   # Nếu vẫn còn lì lợm chạy, cưỡng chế bằng -9:
   kill -9 12345
   ```

---

## 📋 BẢNG TỔNG HỢP KIẾN THỨC CẦN GHI NHỚ

| Thao tác | Câu lệnh chuẩn | Ý nghĩa thực tế |
| :--- | :--- | :--- |
| **Kiểm tra RAM** | `free -h` | Đọc cột `available` để biết RAM thực tế còn bao nhiêu |
| **Kiểm tra ổ đĩa** | `df -h` | Kiểm tra % Use của phân vùng `/` |
| **Tải hệ thống** | `uptime` | Xem 3 mốc Load Average (1m, 5m, 15m) so với số Core |
| **Giám sát động** | `top` / `htop` | `M` sort RAM, `P` sort CPU, `q` để thoát |
| **Tìm tiến trình** | `ps aux \| grep <tên>` | Tra cứu PID và người chạy tiến trình |
| **Chạy ngầm** | `<lệnh> &` | Giải phóng terminal ngay lập tức |
| **Chạy bền bỉ** | `nohup <lệnh> &` | Tiến trình không bị chết khi ngắt SSH/Terminal |
| **Tạm dừng / Tiếp tục** | `Ctrl + Z` rồi `bg %1` | Đẩy lệnh đang chạy vào background |
| **Kéo ra tương tác** | `fg %1` | Mang job nền ra lại giao diện chính |
| **Dừng lịch sự** | `kill <PID>` (hoặc `-15`) | Cho app dọn dẹp kết nối rồi mới thoát |
| **Cưỡng chế hủy** | `kill -9 <PID>` | Kernel trực tiếp thu hồi bộ nhớ, không thể kháng lệnh |
| **Hủy theo tên** | `pkill -f <tên>` | Dừng hàng loạt tiến trình trùng tên |
| **Lập lịch tự động** | `crontab -e` | Cấu hình tác vụ tự động lặp lại theo chu kỳ |

---

## ✅ CHECKLIST HOÀN THÀNH MODULE 05

- [x] Hiểu rõ khái niệm PID, Process States và vòng đời của tiến trình trong Linux.
- [x] Thành thạo các lệnh đọc thông số sức khỏe hệ thống: `free -h`, `df -h`, `uptime`.
- [x] Biết dùng `top` / `htop` để lọc tiến trình ngốn CPU và RAM.
- [x] Phân biệt và làm chủ linh hoạt: Foreground, Background (`&`), `jobs`, `fg`, `bg`.
- [x] Biết cách dùng `nohup` để duy trì tiến trình chạy xuyên suốt session.
- [x] Nắm vững sự khác biệt giữa `SIGTERM (15)` và `SIGKILL (9)`.
- [x] Biết đọc và thiết lập lịch định kỳ với 5 ngôi sao thời gian trong `crontab`.
- [x] Hoàn thành bài kiểm tra lý thuyết và tình huống đạt **6.0/10 điểm** trong [kiem_tra.md](./kiem_tra.md)!
