# Module 05 — Tiến Trình & Quản Lý Hệ Thống

> **Mục tiêu**: Quản lý tiến trình, theo dõi tài nguyên, lên lịch tác vụ

---

## 📖 5.1 Xem Tiến Trình

```bash
ps                             # Tiến trình của terminal hiện tại
ps aux                         # Tất cả tiến trình (a=all, u=user, x=no-tty)
ps aux | grep firefox          # Tìm process firefox
ps -ef                         # Tất cả tiến trình dạng full-format
ps --sort=-%mem | head         # Sắp xếp theo RAM (giảm dần)
ps --sort=-%cpu | head         # Sắp xếp theo CPU

# Xem realtime
top                            # Xem tiến trình realtime (q để thoát)
htop                           # top đẹp hơn (cần cài: sudo apt install htop)
```

### Cột trong `ps aux`:
| Cột | Ý nghĩa |
|-----|---------|
| USER | Người dùng chạy process |
| PID | Process ID |
| %CPU | % CPU đang dùng |
| %MEM | % RAM đang dùng |
| STAT | Trạng thái (R=Running, S=Sleep, Z=Zombie) |
| COMMAND | Lệnh đang chạy |

---

## 📖 5.2 Dừng Tiến Trình (kill)

```bash
kill PID                       # Gửi SIGTERM (yêu cầu dừng lịch sự)
kill -9 PID                    # Gửi SIGKILL (dừng ngay lập tức)
kill -l                        # Xem tất cả signal

killall firefox                # Kill tất cả process tên firefox
pkill -9 firefox               # Kill process theo tên (dùng pattern)

# Phím tắt trong terminal:
# Ctrl+C → gửi SIGINT (dừng lệnh đang chạy)
# Ctrl+Z → gửi SIGTSTP (tạm dừng, đưa vào background)
```

---

## 📖 5.3 Chạy Nền (Background Jobs)

```bash
lệnh &                         # Chạy ngay ở background
sleep 100 &                    # Ví dụ: sleep 100 giây ở background
jobs                           # Xem danh sách jobs
fg                             # Đưa job cuối về foreground
fg %2                          # Đưa job số 2 về foreground
bg                             # Tiếp tục job bị pause ở background
bg %2                          # Tiếp tục job số 2 ở background

# Ctrl+Z sau đó bg để chuyển foreground → background
nohup lệnh &                   # Chạy nền, không bị dừng khi logout
disown PID                     # Tách process khỏi shell hiện tại
```

---

## 📖 5.4 Theo Dõi Tài Nguyên

```bash
# CPU & RAM
free -h                        # RAM trống/đang dùng
free -m                        # RAM theo MB
vmstat 1 5                     # Thống kê VM mỗi 1 giây, 5 lần

# Ổ đĩa
df -h                          # Dung lượng ổ đĩa (human-readable)
df -Th                         # Thêm loại filesystem
du -sh /home/*                 # Dung lượng từng thư mục home

# CPU
lscpu                          # Thông tin CPU
nproc                          # Số core CPU
cat /proc/cpuinfo | grep "model name" | head -1

# Hệ thống
uptime                         # Thời gian chạy + load average
uname -a                       # Thông tin kernel
lsb_release -a                 # Thông tin distro (Ubuntu)
cat /etc/os-release            # Thông tin OS
```

---

## 📖 5.5 Quản Lý Phần Mềm (apt)

```bash
# Ubuntu/Debian
sudo apt update                # Cập nhật danh sách gói
sudo apt upgrade               # Nâng cấp tất cả gói
sudo apt install tên_gói       # Cài phần mềm
sudo apt remove tên_gói        # Gỡ phần mềm
sudo apt purge tên_gói         # Gỡ + xóa cấu hình
sudo apt autoremove            # Xóa gói không cần thiết
sudo apt search từ_khóa        # Tìm kiếm gói
apt show tên_gói               # Thông tin chi tiết gói
dpkg -l                        # Danh sách tất cả gói đã cài
dpkg -l | grep python          # Tìm gói python
which python3                  # Tìm đường dẫn lệnh
```

---

## 📖 5.6 Lên Lịch Tác Vụ (cron)

```bash
crontab -e                     # Chỉnh sửa cron của user hiện tại
crontab -l                     # Xem cron hiện tại
crontab -r                     # Xóa toàn bộ cron

# Cú pháp cron:
# ┌──── Phút (0-59)
# │ ┌──── Giờ (0-23)
# │ │ ┌──── Ngày tháng (1-31)
# │ │ │ ┌──── Tháng (1-12)
# │ │ │ │ ┌──── Ngày tuần (0-7, 0&7=CN)
# │ │ │ │ │
# * * * * * lệnh_cần_chạy

# Ví dụ:
# 0 2 * * * /backup.sh          ← Chạy lúc 2:00 AM mỗi ngày
# */5 * * * * echo "ping"       ← Mỗi 5 phút
# 0 9 * * 1 /weekly_report.sh   ← 9:00 AM mỗi thứ Hai
# 0 0 1 * * /monthly.sh         ← 0:00 ngày 1 hàng tháng
```

---

## 📖 5.7 Xem Log Hệ Thống

```bash
journalctl                     # Xem journal log (systemd)
journalctl -f                  # Xem log realtime
journalctl -n 50               # 50 dòng gần nhất
journalctl -u nginx            # Log của service nginx
journalctl --since "1 hour ago"
journalctl --since "2024-01-01" --until "2024-01-02"

# Log truyền thống
cat /var/log/syslog            # Log hệ thống chung
tail -f /var/log/syslog        # Xem realtime
cat /var/log/auth.log          # Log xác thực (sudo, ssh...)
```

---

## 📖 5.8 Quản Lý Dịch Vụ (systemctl)

```bash
systemctl status nginx         # Trạng thái dịch vụ
systemctl start nginx          # Khởi động
systemctl stop nginx           # Dừng
systemctl restart nginx        # Khởi động lại
systemctl enable nginx         # Tự động khởi động khi boot
systemctl disable nginx        # Tắt tự động khởi động
systemctl list-units --type=service  # Tất cả dịch vụ
```

---

## 📝 Tiếp Theo

👉 [bai_tap.md](./bai_tap.md)  
👉 [kiem_tra.md](./kiem_tra.md)
