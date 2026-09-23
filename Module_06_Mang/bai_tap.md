# Module 06 — Bài Tập Thực Hành: Mạng & Kết Nối (Networking)

> 💡 **Mục tiêu**: Thực hành kiểm tra kết nối mạng (ping, curl, wget), tra cứu DNS, xem địa chỉ IP và các cổng (ports) đang lắng nghe trên máy.

---

## 🎯 Phần 1: Kiểm Tra Địa Chỉ IP & Kết Nối

```bash
# 1. Xem địa chỉ IP của máy trong mạng nội bộ
ip addr

# 2. Hoặc chỉ in các địa chỉ IP nhanh
hostname -I

# 3. Kiểm tra kết nối Internet đến máy chủ Google (ping 4 lần rồi tự dừng)
ping -c 4 google.com

# 4. Xem địa chỉ IP công khai (Public IP) ra ngoài Internet của bạn
curl ifconfig.me
echo ""
```

---

## 🎯 Phần 2: Tải File & Gửi Yêu Cầu Web Với `curl` và `wget`

```bash
mkdir -p ~/linux_practice/module06
cd ~/linux_practice/module06

# 1. Dùng curl để lấy nội dung một trang web / API đơn giản
curl -s https://api.github.com | head -15

# 2. Dùng curl tải file về và lưu với tên cụ thể (cờ -o)
curl -o sample_robots.txt https://www.google.com/robots.txt
head -10 sample_robots.txt

# 3. Dùng wget để tải file
wget -q https://raw.githubusercontent.com/git/git/master/README.md -O git_readme.md
head -15 git_readme.md
```

---

## 🎯 Phần 3: Kiểm Tra Cổng Đang Lắng Nghe (Ports)

```bash
# 1. Xem tất cả các cổng TCP đang lắng nghe trên máy (hiện đại, thay thế netstat)
# -t: TCP, -l: listening, -n: hiện số port (không dịch sang tên dịch vụ), -p: hiện tiến trình
ss -tln

# 2. Dùng Python tạo nhanh một máy chủ web mini để kiểm tra cổng
# (Mở tab terminal khác hoặc chạy ngầm)
python3 -m http.server 8080 &

# 3. Kiểm tra xem cổng 8080 đã mở chưa
ss -tln | grep 8080

# 4. Gửi thử request tới cổng vừa mở
curl http://localhost:8080 | head -10

# 5. Tắt web server mini vừa bật
pkill -f "http.server"
```

---

## 🎯 Phần 4: Tra Cứu DNS

```bash
# 1. Xem cấu hình DNS resolver của máy
cat /etc/resolv.conf

# 2. Tra cứu IP của một tên miền bằng nslookup hoặc host
host google.com
host github.com

# 3. Tra cứu chi tiết bản ghi DNS bằng dig (nếu có cài dnsutils)
dig google.com +short
```

---

## 🎯 Phần 5: Quản Lý SSH Key & Cấu Hình Kết Nối Server (`~/.ssh/`)

```bash
# 1. Tạo cặp SSH key hiện đại (chuẩn Ed25519) dùng cho GitHub/Server
ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/id_ed25519_demo -N ""

# 2. Xem public key (chìa khóa công khai mang đi gửi lên server / add vào GitHub)
cat ~/.ssh/id_ed25519_demo.pub

# 3. Kiểm tra phân quyền an toàn của thư mục .ssh và private key (bắt buộc chmod 600)
ls -la ~/.ssh/
chmod 600 ~/.ssh/id_ed25519_demo
chmod 700 ~/.ssh

# 4. Thử tạo file cấu hình SSH config (~/.ssh/config) để kết nối nhanh không cần nhớ IP/Port
cat << 'EOF' > ~/.ssh/config_demo
Host webserver
    HostName 192.168.1.100
    User ubuntu
    Port 2222
    IdentityFile ~/.ssh/id_ed25519_demo
EOF

cat ~/.ssh/config_demo
```

---

## 🎯 Phần 6: Đồng Bộ Dữ Liệu Thông Minh Với `rsync`

```bash
mkdir -p ~/linux_practice/module06/source_dir
mkdir -p ~/linux_practice/module06/backup_dir

# Tạo một số file mẫu
echo "Data 1" > ~/linux_practice/module06/source_dir/file1.txt
echo "Data 2" > ~/linux_practice/module06/source_dir/file2.txt

# 1. Dùng rsync để đồng bộ source sang backup (cờ -a: archive giữ nguyên thuộc tính, -v: verbose)
rsync -av ~/linux_practice/module06/source_dir/ ~/linux_practice/module06/backup_dir/

# 2. Kiểm tra xem file đã sang thư mục backup chưa
ls -l ~/linux_practice/module06/backup_dir/

# 3. Thử sửa 1 file và chạy lại rsync (rsync chỉ copy phần file thay đổi, cực nhanh và tiết kiệm băng thông!)
echo "Updated Data 1" >> ~/linux_practice/module06/source_dir/file1.txt
rsync -av ~/linux_practice/module06/source_dir/ ~/linux_practice/module06/backup_dir/
```

---

## 🎯 Phần 7: Kịch Bản Thực Chiến DevOps — Quy Trình 5 Bước Gỡ Rối Mạng (Network Troubleshooting)

### 🚨 Tình huống sự cố:
*Khách hàng phàn nàn không thể truy cập vào website `http://api.internal.company:8080/`.*

### Quy trình 5 bước điều tra chuẩn kỹ sư DevOps:
1. **Bước 1 — Phân giải tên miền (DNS Resolution):**
   ```bash
   # Kiểm tra xem máy có dịch được tên miền ra địa chỉ IP hay không:
   host api.internal.company
   # Hoặc kiểm tra file ánh xạ local:
   cat /etc/hosts
   ```
2. **Bước 2 — Kiểm tra thông tuyến hạ tầng (Connectivity - Layer 3/4):**
   ```bash
   # Ping xem máy chủ mục tiêu có phản hồi không (hoặc ping IP nếu DNS chưa thông):
   ping -c 3 192.168.1.50
   ```
3. **Bước 3 — Kiểm tra Port ứng dụng có đang mở và lắng nghe không (Port Listening):**
   ```bash
   # Nếu bạn đang đứng trên server đó, kiểm tra xem ứng dụng có thực sự bind vào port 8080 không:
   ss -tlnp | grep 8080
   # Nếu bạn đứng từ máy client từ xa, dùng netcat hoặc curl kiểm tra:
   nc -zv 192.168.1.50 8080
   ```
4. **Bước 4 — Kiểm tra tường lửa (Firewall):**
   ```bash
   # Kiểm tra xem UFW có chặn port 8080 không:
   sudo ufw status
   # Nếu bị chặn, mở port cho phép truy cập:
   # sudo ufw allow 8080/tcp
   ```
5. **Bước 5 — Kiểm tra tầng ứng dụng HTTP (Application Layer - Layer 7):**
   ```bash
   # Gửi HTTP request và xem mã phản hồi (HTTP Status Code, Headers):
   curl -I http://localhost:8080
   ```

---

## 📋 BẢNG TỔNG HỢP KIẾN THỨC CẦN GHI NHỚ

### 🌐 1. Các Cổng Mạng Chuẩn Phổ Biến (Well-known Ports)
| Cổng (Port) | Giao thức | Ý nghĩa & Dịch vụ |
| :---: | :---: | :--- |
| **22** | SSH / SFTP | Kết nối điều khiển và quản trị server từ xa an toàn |
| **53** | DNS | Phân giải tên miền (Domain Name Resolution) |
| **80** | HTTP | Giao thức truyền tải web văn bản không mã hóa |
| **443** | HTTPS | Giao thức web bảo mật có chứng chỉ SSL/TLS |
| **3306** | MySQL / MariaDB | Cổng kết nối cơ sở dữ liệu MySQL |
| **5432** | PostgreSQL | Cổng kết nối cơ sở dữ liệu PostgreSQL |
| **6379** | Redis | Cổng dịch vụ lưu trữ In-memory Cache |
| **8080 / 3000** | Web App / Dev | Cổng thử nghiệm phổ biến của Node.js, Spring Boot, Python |

### 🛠️ 2. Bộ Lệnh Mạng Cốt Lõi (Core Networking Commands)
| Thao tác | Câu lệnh | Ý nghĩa thực tế |
| :--- | :--- | :--- |
| **Xem IP nội bộ** | `ip addr` / `hostname -I` | Biết IP card mạng (eth0, wlan0...) |
| **Xem IP Public** | `curl ifconfig.me` | Biết IP của mạng ra Internet |
| **Kiểm tra ping** | `ping -c 4 <host>` | Kiểm tra độ trễ (latency) và mất gói (packet loss) |
| **Xem bảng định tuyến**| `ip route` | Xem Gateway mặc định (default gateway) |
| **Kiểm tra DNS** | `cat /etc/resolv.conf` | Xem địa chỉ DNS Server đang định tuyến |
| **Ánh xạ IP cục bộ** | `cat /etc/hosts` | File map domain tự chế không cần qua DNS |
| **Tra cứu DNS** | `host <domain>` / `dig <domain>` | Kiểm tra bản ghi IP của tên miền |
| **Xem cổng đang mở** | `ss -tlnp` | Hiển thị tất cả port TCP đang lắng nghe kèm PID |
| **Kiểm tra 1 cổng** | `ss -tlnp \| grep <port>` | Xác minh dịch vụ đã khởi động trên port chưa |
| **Tải file cơ bản** | `wget <url>` | Tải trực tiếp file về thư mục hiện tại |
| **Gọi API / Tải file**| `curl -o <tên> <url>` | Công cụ test HTTP/API và tải file vạn năng |
| **Tạo SSH Key** | `ssh-keygen -t ed25519` | Sinh cặp khóa chứng thực hiện đại, an toàn |
| **Đồng bộ file** | `rsync -av src/ dest/` | Đồng bộ file thông minh, chỉ copy phần thay đổi |

---

## ✅ CHECKLIST HOÀN THÀNH MODULE 06

- [x] Xem được địa chỉ IP private (`ip addr`) và public IP (`curl ifconfig.me`).
- [x] Thành thạo lệnh `ping -c <số_lần>` để kiểm tra kết nối mạng.
- [x] Hiểu vai trò của `/etc/resolv.conf` (DNS) và `/etc/hosts` (Local DNS override).
- [x] Nắm vững cách dùng `ss -tlnp` để kiểm tra cổng listening và bắt bệnh port conflict.
- [x] Phân biệt được `curl` và `wget`, biết dùng `curl -o` hoặc `curl -I`.
- [x] Hiểu nguyên lý cặp khóa SSH (Public Key để trên server, Private Key giữ bí mật và quyền `600`).
- [x] Biết dùng `rsync -av` để đồng bộ dữ liệu nhanh gấp nhiều lần `cp`.
- [x] Hoàn thành bài kiểm tra lý thuyết và thực hành đạt **7.9/10 điểm** trong [kiem_tra.md](./kiem_tra.md)!
