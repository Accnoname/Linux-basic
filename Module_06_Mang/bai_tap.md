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
```

✅ **Hoàn thành bài tập! Hãy chuyển sang [kiem_tra.md](file:///d:/Linux%20basic/Module_06_Mang/kiem_tra.md) để đánh giá bản thân.**
