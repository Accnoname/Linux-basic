# Module 06 — Mạng & Kết Nối

> **Mục tiêu**: Kiểm tra mạng, kết nối SSH, tải file, và hiểu các công cụ mạng

---

## 📖 6.1 Thông Tin Mạng

```bash
# Địa chỉ IP
ip addr                        # Xem tất cả interface và IP
ip addr show eth0              # Xem interface cụ thể
ifconfig                       # Lệnh cũ hơn (cần net-tools)
hostname -I                    # Chỉ hiện IP
curl ifconfig.me               # IP public của bạn

# Bảng định tuyến
ip route                       # Xem routing table
route -n                       # Cách cũ

# DNS
cat /etc/resolv.conf           # DNS server đang dùng
cat /etc/hosts                 # File hosts local
```

---

## 📖 6.2 Kiểm Tra Kết Nối

```bash
# Ping
ping google.com                # Ping vô hạn (Ctrl+C để dừng)
ping -c 4 google.com           # Ping 4 lần
ping -c 4 8.8.8.8              # Ping Google DNS

# Traceroute — xem đường đi gói tin
traceroute google.com
mtr google.com                 # Kết hợp ping + traceroute (realtime)

# Kiểm tra DNS
nslookup google.com            # Tra DNS
dig google.com                 # Tra DNS chi tiết
dig @8.8.8.8 google.com        # Dùng DNS server cụ thể
host google.com                # Đơn giản hơn dig
```

---

## 📖 6.3 Cổng & Kết Nối Đang Mở

```bash
# Xem cổng đang lắng nghe
ss -tlnp                       # TCP listening ports (hiện đại)
netstat -tlnp                  # Cách cũ (cần net-tools)
ss -a                          # Tất cả kết nối

# Kiểm tra cổng cụ thể
ss -tlnp | grep 80             # Có gì đang dùng cổng 80?
lsof -i :80                    # Chi tiết hơn

# Kiểm tra kết nối đến host:port
nc -zv google.com 443          # Netcat kiểm tra port
telnet google.com 80           # Telnet (cũ hơn)
```

---

## 📖 6.4 Tải File Từ Internet

```bash
# wget — tải file
wget https://example.com/file.zip
wget -O ten_moi.zip https://example.com/file.zip   # Đổi tên khi tải
wget -c https://example.com/large.zip              # Tiếp tục tải nếu bị gián đoạn
wget -P ~/downloads/ https://example.com/file.txt  # Tải vào thư mục cụ thể
wget -r -np https://example.com/                   # Tải đệ quy (mirror site)

# curl — linh hoạt hơn
curl https://example.com                           # Xem nội dung
curl -O https://example.com/file.zip              # Tải file
curl -L https://bit.ly/link                        # Theo redirect
curl -I https://google.com                         # Chỉ xem headers
curl -X POST -d "data=value" https://api.example  # POST request
curl -H "Authorization: Bearer token" https://api  # Với header
```

---

## 📖 6.5 SSH — Kết Nối Từ Xa

```bash
# Kết nối SSH
ssh username@server.com              # Kết nối cơ bản
ssh -p 2222 username@server.com      # Cổng khác (mặc định 22)
ssh -i ~/.ssh/key.pem user@server    # Dùng private key

# Tạo SSH key
ssh-keygen -t rsa -b 4096            # Tạo cặp key RSA 4096-bit
ssh-keygen -t ed25519               # Dùng Ed25519 (hiện đại hơn)
cat ~/.ssh/id_rsa.pub                # Xem public key

# Copy public key lên server
ssh-copy-id username@server.com
# Hoặc thủ công: thêm nội dung id_rsa.pub vào ~/.ssh/authorized_keys trên server

# Cấu hình SSH (~/.ssh/config)
# Host myserver
#     HostName server.com
#     User alice
#     IdentityFile ~/.ssh/alice_key
#     Port 22
# Sau đó dùng: ssh myserver
```

---

## 📖 6.6 SCP & rsync — Truyền File

```bash
# scp — Sao chép qua SSH
scp file.txt user@server:/home/user/    # Upload file
scp user@server:/path/file.txt ./       # Download file
scp -r thu_muc/ user@server:/path/     # Copy thư mục

# rsync — Đồng bộ thông minh hơn (chỉ copy phần thay đổi)
rsync -av thu_muc/ user@server:/path/  # Sync lên server
rsync -av user@server:/path/ ./        # Sync về local
rsync -av --delete src/ dest/           # Xóa file ở dest không có ở src
rsync -avz --progress big_file user@server:/path/  # Nén + hiện tiến độ
```

---

## 📖 6.7 Firewall Cơ Bản (ufw)

```bash
sudo ufw status                        # Xem trạng thái
sudo ufw enable                        # Bật firewall
sudo ufw disable                       # Tắt firewall
sudo ufw allow 22                      # Cho phép SSH
sudo ufw allow 80/tcp                  # Cho phép HTTP
sudo ufw deny 3306                     # Chặn MySQL từ ngoài
sudo ufw allow from 192.168.1.0/24    # Cho phép từ subnet
sudo ufw status numbered               # Xem rules theo số
sudo ufw delete 2                      # Xóa rule số 2
```

---

## 📝 Tiếp Theo

👉 [bai_tap.md](./bai_tap.md)  
👉 [kiem_tra.md](./kiem_tra.md)
