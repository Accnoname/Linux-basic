# Module 01 — Bài Tập Thực Hành (Làm Quen & Điều Hướng)

> 💡 **Nguyên tắc học**: Mở terminal WSL lên và **gõ tay từng lệnh một**. Không copy-paste để các ngón tay và não làm quen với cú pháp Linux. Làm từ từ từng phần.

---

## 🎯 Phần 1: Khám Phá Bản Thân & Hệ Thống

Hãy gõ các lệnh sau vào terminal và quan sát kết quả trả về:

### 1. Tôi là ai và đang ở đâu?
```bash
# Xem tên tài khoản người dùng của bạn
whoami

# Xem định danh người dùng (User ID) và các nhóm quyền (Groups)
id

# Xem đường dẫn thư mục bạn đang đứng
pwd
```
* **Nhật ký thực hành của bạn:**
  - `whoami`: Trả về `hieu` (tên tài khoản hiện tại).
  - `id`: Hiển thị `uid=1000(hieu)` (User ID định danh) và `groups` (nhóm quyền, đặc biệt có `sudo` nghĩa là có quyền quản trị máy).
  - `pwd`: Trả về `/mnt/d/Linux-basic` (thư mục hiện tại bạn đang đứng, trên ổ D của Windows gắn vào WSL).

### 2. Hệ điều hành và phiên bản Kernel
```bash
# Xem thông tin hệ điều hành và kernel đầy đủ
uname -a

# Chỉ xem phiên bản nhân Linux
uname -r

# Xem thông tin bản phân phối (Ubuntu / Debian / ...)
cat /etc/os-release
```

* **Nhật ký thực hành & Giải nghĩa chi tiết:**
  - `uname`: Viết tắt của **Unix Name**.
  - `uname -a` (cờ `-a` = `--all`): In **toàn bộ** thông tin nhân hệ thống (Tên OS `Linux`, tên máy `DESKTOP-330P1B1`, bản kernel, kiến trúc chip `x86_64`).
  - `uname -r` (cờ `-r` = `--kernel-release`): Chỉ lọc lấy đúng số phiên bản phát hành của Kernel (`6.6.87.2-microsoft-standard-WSL2`). *Dùng khi cài driver, Docker, hay phần mềm yêu cầu bản kernel tối thiểu*.
  - `cat /etc/os-release`: Lệnh `cat` (*concatenate*) in nội dung file ra màn hình. File này cho biết thông tin **Bản phân phối (Distro)** ở tầng ứng dụng: **Ubuntu 26.04.1 LTS (Resolute Raccoon)**.
  - **Sự khác biệt cốt lõi**: `uname` xem tầng **Nhân (Kernel - phần cứng & điều phối)**, còn `/etc/os-release` xem tầng **Bản phân phối (Distro/OS - phần mềm quản lý gói, giao diện)**.

---

## 🎯 Phần 2: Di Chuyển Thư Mục & Phân Biệt Đường Dẫn

### 1. Các kiểu di chuyển cơ bản
```bash
# 1. Đi về thư mục Home của bạn
cd ~
pwd

# 2. Đi vào thư mục tạm của hệ thống (đường dẫn tuyệt đối)
cd /tmp
pwd

# 3. Đi lên thư mục cha của /tmp (tức là thư mục gốc /)
cd ..
pwd

# 4. Quay trở lại thư mục vừa đứng lúc nãy
cd -
pwd

# 5. Về lại Home nhanh nhất (lệnh cd không cần đối số)
cd
pwd
```

### 2. Thử thách di chuyển tương đối (Không dùng dấu `/` ở đầu)
Từ thư mục `~` của bạn:
1. Lên thư mục `/home`: `cd ..`
2. Lên tiếp thư mục gốc `/`: `cd ..`
3. Đi vào `/usr/bin`: `cd usr/bin`
4. Kiểm tra xem có đúng là `/usr/bin` không: `pwd`
5. Về lại thư mục Home: `cd ~`

---

## 🎯 Phần 3: Liệt Kê & Hiểu Ý Nghĩa Các Flag của `ls`

### 1. Thử từng cờ tùy chọn
```bash
# Liệt kê thông thường
ls

# Liệt kê chi tiết (quyền, chủ sở hữu, dung lượng, ngày tạo)
ls -l

# Liệt kê toàn bộ file (kể cả file ẩn bắt đầu bằng dấu chấm .)
ls -a

# Kết hợp: Chi tiết + File ẩn + Dung lượng đọc được (KB, MB)
ls -lah
```

### 2. Phân tích kết quả `ls -lah`
Nhìn vào một dòng kết quả của `ls -lah ~`, ví dụ:
```
-rw-r--r--  1 ubuntu ubuntu 3.7K Jan 15 10:30 .bashrc
```
- Cột 1 (`-rw-r--r--`): Quyền truy cập (sẽ học sâu ở Module 04). Dấu `-` đầu tiên nghĩa là file thông thường, nếu là chữ `d` thì là thư mục (directory).
- Cột 3 & 4 (`ubuntu ubuntu`): Tên người sở hữu và nhóm.
- Cột 5 (`3.7K`): Kích thước file (nhờ có cờ `-h`).
- Cột 8 (`.bashrc`): Tên file (có dấu chấm là file ẩn cấu hình).

### 3. Sắp xếp file
```bash
# Sắp xếp theo kích thước từ lớn đến bé
ls -lhS /etc | head -10

# Sắp xếp theo thời gian mới nhất lên đầu
ls -lht /etc | head -10

# Đảo ngược thứ tự (r = reverse)
ls -lhrt /etc | head -10
```

---

## 🎯 Phần 4: Tự Đọc Hướng Dẫn Với `man` & `--help` (Kỹ Năng Cốt Lõi)

Đừng cố nhớ hết mọi cờ tùy chọn! Dân Linux giỏi là người biết cách tra cứu khi cần.

```bash
# Đọc hướng dẫn chi tiết của lệnh ls
man ls
```
**Cách điều khiển khi đang đọc `man`:**
- Phím cách (Space) hoặc `f`: Cuộn xuống 1 trang.
- Phím `b`: Cuộn lên 1 trang.
- Gõ `/` rồi gõ từ khóa cần tìm (ví dụ: `/-h`) -> nhấn `Enter`.
- Phím `n`: Đi tới kết quả tìm kiếm tiếp theo.
- Phím `q`: Thoát khỏi trang hướng dẫn.

```bash
# Thử xem tóm tắt trợ giúp nhanh bằng --help
cat --help
mkdir --help
```

---

## 🎯 Phần 5: Kết Nối Windows & WSL

```bash
# Liệt kê các ổ đĩa Windows đang được gắn vào WSL
ls /mnt/

# Xem nội dung thư mục học tập trên ổ D của Windows
ls -l /mnt/d/Linux-basic
```

✅ **Bạn đã hoàn thành bài thực hành Module 01! Hãy chuyển sang [kiem_tra.md](file:///d:/Linux%20basic/Module_01_Bat_Dau/kiem_tra.md) để tự đánh giá kiến thức.**
