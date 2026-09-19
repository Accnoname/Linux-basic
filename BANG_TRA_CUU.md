# 📋 Bảng Tra Cứu Lệnh Linux Nhanh

> Lưu file này để tra cứu nhanh khi cần!

---

## 🗂️ Điều Hướng

| Lệnh | Mô tả |
|------|-------|
| `pwd` | In thư mục hiện tại |
| `ls` | Liệt kê file |
| `ls -la` | Liệt kê chi tiết + file ẩn |
| `ls -lh` | Kích thước dạng đọc được |
| `cd /path` | Đổi thư mục |
| `cd ~` | Về thư mục home |
| `cd ..` | Lên thư mục cha |
| `cd -` | Thư mục vừa rồi |

---

## 📁 File & Thư Mục

| Lệnh | Mô tả |
|------|-------|
| `mkdir dir` | Tạo thư mục |
| `mkdir -p a/b/c` | Tạo thư mục lồng |
| `touch file` | Tạo file rỗng |
| `cp src dst` | Sao chép |
| `cp -r src/ dst/` | Sao chép thư mục |
| `mv src dst` | Di chuyển/Đổi tên |
| `rm file` | Xóa file |
| `rm -rf dir/` | Xóa thư mục ⚠️ |
| `find . -name "*.txt"` | Tìm file |
| `du -sh dir/` | Dung lượng thư mục |
| `df -h` | Dung lượng ổ đĩa |

---

## 📝 Xem & Xử Lý Văn Bản

| Lệnh | Mô tả |
|------|-------|
| `cat file` | In nội dung file |
| `less file` | Xem từng trang |
| `head -10 file` | 10 dòng đầu |
| `tail -10 file` | 10 dòng cuối |
| `tail -f file` | Xem realtime |
| `wc -l file` | Đếm dòng |
| `grep "pattern" file` | Tìm kiếm |
| `grep -r "pattern" dir/` | Tìm đệ quy |
| `grep -v "pattern"` | Loại trừ |
| `sort file` | Sắp xếp |
| `uniq` | Xóa trùng |
| `cut -d: -f1` | Cắt cột |
| `sed 's/old/new/g'` | Thay thế |
| `awk '{print $1}'` | Xử lý cột |

---

## 🔒 Quyền Truy Cập

| Lệnh | Mô tả |
|------|-------|
| `chmod 755 file` | Đặt quyền dạng số |
| `chmod u+x file` | Thêm quyền thực thi |
| `chmod -R 755 dir/` | Đệ quy |
| `chown user file` | Đổi chủ sở hữu |
| `chown user:group file` | Đổi cả owner & group |
| `ls -la` | Xem quyền |
| `id` | Xem UID/GID của bạn |
| `sudo lệnh` | Chạy với quyền root |

**Quyền phổ biến:**
- `644` → File thông thường (rw-r--r--)
- `755` → Script, thư mục (rwxr-xr-x)
- `600` → File riêng tư (rw-------)

---

## ⚙️ Tiến Trình

| Lệnh | Mô tả |
|------|-------|
| `ps aux` | Xem tất cả tiến trình |
| `top` | Tiến trình realtime |
| `htop` | top đẹp hơn |
| `kill PID` | Dừng tiến trình |
| `kill -9 PID` | Dừng ngay lập tức |
| `killall name` | Dừng theo tên |
| `lệnh &` | Chạy nền |
| `jobs` | Xem jobs nền |
| `fg` | Đưa về foreground |
| `free -h` | Xem RAM |
| `uptime` | Thời gian chạy |

---

## 🌐 Mạng

| Lệnh | Mô tả |
|------|-------|
| `ip addr` | Xem địa chỉ IP |
| `ping host` | Kiểm tra kết nối |
| `ping -c 4 host` | Ping 4 lần |
| `curl url` | Lấy nội dung URL |
| `wget url` | Tải file |
| `ss -tlnp` | Xem cổng đang mở |
| `ssh user@host` | Kết nối SSH |
| `scp file user@host:/path` | Copy qua SSH |

---

## 🔧 Hệ Thống

| Lệnh | Mô tả |
|------|-------|
| `uname -a` | Thông tin kernel |
| `lsb_release -a` | Thông tin distro |
| `whoami` | Tên user hiện tại |
| `date` | Ngày giờ |
| `cal` | Lịch |
| `history` | Lịch sử lệnh |
| `sudo apt update` | Cập nhật gói |
| `sudo apt install pkg` | Cài phần mềm |
| `sudo apt remove pkg` | Gỡ phần mềm |

---

## ⌨️ Phím Tắt

| Phím | Chức năng |
|------|-----------|
| `Ctrl+C` | Dừng lệnh |
| `Ctrl+D` | EOF / Thoát |
| `Ctrl+L` | Xóa màn hình |
| `Ctrl+Z` | Tạm dừng |
| `Ctrl+A` | Đầu dòng |
| `Ctrl+E` | Cuối dòng |
| `Ctrl+R` | Tìm trong lịch sử |
| `Tab` | Tự hoàn thành |
| `↑↓` | Lịch sử lệnh |

---

## 🔗 Ký Tự Đặc Biệt

| Ký tự | Ý nghĩa |
|-------|---------|
| `\|` | Pipe — kết nối lệnh |
| `>` | Redirect output (ghi đè) |
| `>>` | Redirect output (thêm vào) |
| `<` | Redirect input |
| `2>` | Redirect stderr |
| `&` | Chạy nền |
| `&&` | Chạy lệnh sau nếu lệnh trước thành công |
| `\|\|` | Chạy lệnh sau nếu lệnh trước thất bại |
| `;` | Chạy lệnh sau bất kể kết quả |
| `*` | Wildcard: mọi chuỗi |
| `?` | Wildcard: 1 ký tự |
| `~` | Thư mục home |
| `.` | Thư mục hiện tại |
| `..` | Thư mục cha |
| `#` | Comment trong script |
| `$` | Tham chiếu biến |

---

## 📦 Nén & Giải Nén

| Lệnh | Mô tả |
|------|-------|
| `tar -czf archive.tar.gz dir/` | Nén thư mục |
| `tar -xzf archive.tar.gz` | Giải nén |
| `tar -tzf archive.tar.gz` | Xem nội dung |
| `zip -r archive.zip dir/` | Nén zip |
| `unzip archive.zip` | Giải nén zip |
| `gzip file` | Nén file |
| `gunzip file.gz` | Giải nén gzip |
