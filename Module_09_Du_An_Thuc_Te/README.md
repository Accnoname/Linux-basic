# Module 09 — Dự Án Tổng Hợp Cuối Khóa

> **Mục tiêu**: Ứng dụng TẤT CẢ kiến thức đã học vào một dự án thực tế hoàn chỉnh

---

## 🎯 Dự Án: Hệ Thống Quản Lý & Giám Sát Server

Bạn sẽ xây dựng một hệ thống **tự động hóa và giám sát** hoàn chỉnh gồm nhiều script liên kết nhau.

---

## 📋 Cấu Trúc Dự Án

```
~/server_manager/
├── config/
│   └── settings.conf          ← Cấu hình chung
├── scripts/
│   ├── setup.sh               ← Thiết lập ban đầu
│   ├── monitor.sh             ← Giám sát hệ thống
│   ├── backup.sh              ← Backup tự động
│   ├── log_analyzer.sh        ← Phân tích log
│   └── report.sh              ← Tạo báo cáo
├── logs/
│   └── monitor.log            ← Log giám sát
├── backups/                   ← Lưu backup
├── reports/                   ← Báo cáo
└── README.md                  ← Hướng dẫn dự án
```

---

## 🔨 Nhiệm Vụ 1: Thiết Lập Dự Án

```bash
# Tạo cấu trúc dự án
mkdir -p ~/server_manager/{config,scripts,logs,backups,reports}
cd ~/server_manager

# Tạo file cấu hình
cat > config/settings.conf << 'EOF'
# Cấu hình hệ thống giám sát
PROJECT_DIR="$HOME/server_manager"
LOG_FILE="$PROJECT_DIR/logs/monitor.log"
BACKUP_DIR="$PROJECT_DIR/backups"
REPORT_DIR="$PROJECT_DIR/reports"

# Ngưỡng cảnh báo
CPU_THRESHOLD=80
MEM_THRESHOLD=85
DISK_THRESHOLD=90

# Backup
BACKUP_SOURCE="$HOME/linux_project"
BACKUP_RETENTION_DAYS=7
EOF

echo "✅ Cấu hình đã tạo!"
cat config/settings.conf
```

---

## 🔨 Nhiệm Vụ 2: Script Giám Sát (monitor.sh)

Viết script `scripts/monitor.sh` thực hiện:

```bash
#!/bin/bash
# monitor.sh — Giám sát hệ thống
# 
# YÊU CẦU:
# 1. Load cấu hình từ config/settings.conf
# 2. Thu thập thông tin:
#    - % CPU đang dùng
#    - % RAM đang dùng  
#    - % Disk đang dùng
#    - Số process đang chạy
#    - Load average (from uptime)
# 3. Ghi vào log với định dạng:
#    [2024-01-01 12:00:00] CPU:45% MEM:60% DISK:70% PROC:150 LOAD:0.5
# 4. Nếu vượt ngưỡng → ghi WARNING vào log
# 5. Nhận tham số -n để chạy n lần (mặc định = 1)
#    Ví dụ: ./monitor.sh -n 5 (giám sát 5 lần, mỗi 10 giây)

# Gợi ý lấy % CPU:
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)

# Gợi ý lấy % RAM:
MEM=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')

# Gợi ý lấy % Disk:
DISK=$(df / | tail -1 | awk '{print $5}' | cut -d'%' -f1)

# Viết phần còn lại...
```

---

## 🔨 Nhiệm Vụ 3: Script Backup (backup.sh)

```bash
#!/bin/bash
# backup.sh — Backup tự động với rotation
#
# YÊU CẦU:
# 1. Load cấu hình
# 2. Backup thư mục BACKUP_SOURCE → BACKUP_DIR
# 3. Tên backup: backup_YYYYMMDD_HHMMSS.tar.gz
# 4. Xóa backup cũ hơn BACKUP_RETENTION_DAYS ngày
# 5. Ghi log sau mỗi backup
# 6. Hiện danh sách backup còn lại và tổng dung lượng
# 7. Tham số: --dry-run (chỉ hiện sẽ làm gì, không thực thi)
```

---

## 🔨 Nhiệm Vụ 4: Script Phân Tích Log (log_analyzer.sh)

```bash
#!/bin/bash
# log_analyzer.sh — Phân tích file monitor.log
#
# YÊU CẦU:
# 1. Đọc file log
# 2. Thống kê:
#    - Số lần giám sát
#    - CPU trung bình, cao nhất, thấp nhất
#    - RAM trung bình, cao nhất, thấp nhất
#    - Số lần vượt ngưỡng WARNING
# 3. Tìm các khoảng thời gian có vấn đề
# 4. Tham số: --last N (chỉ phân tích N dòng cuối)
```

---

## 🔨 Nhiệm Vụ 5: Script Báo Cáo (report.sh)

```bash
#!/bin/bash
# report.sh — Tạo báo cáo HTML và text
#
# YÊU CẦU:
# 1. Gọi log_analyzer.sh để lấy số liệu
# 2. Tạo báo cáo text: reports/report_YYYYMMDD.txt
# 3. Nội dung báo cáo:
#    - Header: Tên, ngày tạo, hostname
#    - Thông tin hệ thống: OS, kernel, uptime
#    - Thống kê giám sát
#    - Danh sách backup hiện có
#    - Cảnh báo nổi bật
# 4. Tham số: --mail (in ra format phù hợp gửi email)
```

---

## 🔨 Nhiệm Vụ 6: Script Thiết Lập (setup.sh)

```bash
#!/bin/bash
# setup.sh — Script cài đặt ban đầu
#
# YÊU CẦU:
# 1. Tạo toàn bộ cấu trúc thư mục
# 2. Kiểm tra các công cụ cần thiết (awk, grep, tar...)
# 3. Cài nếu thiếu (apt install)
# 4. Cấp quyền thực thi cho tất cả script
# 5. Hỏi người dùng có muốn thêm vào crontab không
#    - Nếu có: thêm monitor.sh chạy mỗi 5 phút
#             thêm backup.sh chạy lúc 2:00 AM hàng ngày
#             thêm report.sh chạy lúc 8:00 AM hàng ngày
# 6. In hướng dẫn sử dụng sau khi setup xong
```

---

## 🔨 Nhiệm Vụ 7: README Dự Án

Viết file `README.md` hoàn chỉnh cho dự án:
```markdown
# Server Manager

## Mô tả
## Yêu cầu
## Cài đặt
## Cách sử dụng
## Cấu hình
## Ví dụ đầu ra
## Cấu trúc thư mục
```

---

## 🏆 Thử Thách Bonus

Nếu bạn hoàn thành tất cả, hãy thêm:

1. **Script kiểm tra kết nối mạng** — ping 3 địa chỉ, log kết quả
2. **Script tự phục hồi** — nếu một process dừng thì tự khởi động lại
3. **Script gửi thông báo** — dùng `mail` hoặc webhook để thông báo khi có cảnh báo
4. **Dashboard** — hiện tất cả thông tin hệ thống trên 1 màn hình (dùng tmux)

---

## 📊 Tiêu Chí Đánh Giá

| Tiêu chí | Điểm |
|----------|------|
| Tất cả script chạy không lỗi | 30đ |
| Xử lý lỗi đúng cách (kiểm tra tham số, file tồn tại...) | 20đ |
| Code có comment rõ ràng | 15đ |
| Cấu trúc thư mục gọn gàng | 10đ |
| Script setup.sh hoạt động hoàn toàn | 15đ |
| README đầy đủ | 10đ |
| **Tổng** | **100đ** |

---

## 🎓 Chúc Mừng Hoàn Thành Khóa Học!

Nếu bạn đã đến đây và làm được dự án này, bạn đã:
- ✅ Thành thạo các lệnh Linux cơ bản và nâng cao
- ✅ Biết quản lý file, quyền truy cập, tiến trình
- ✅ Biết viết Shell Script tự động hóa
- ✅ Biết xử lý văn bản với grep, awk, sed
- ✅ Biết dùng các công cụ chuyên nghiệp (vim, tmux)

### 🚀 Bước Tiếp Theo

Sau khi hoàn thành khóa học này, bạn có thể học:
- **Git** — Quản lý phiên bản code
- **Docker** — Container hóa ứng dụng
- **Nginx/Apache** — Web server
- **Python trên Linux** — Scripting nâng cao
- **Linux Administration** — Quản trị server thực tế
- **DevOps/SRE** — Tự động hóa hạ tầng
