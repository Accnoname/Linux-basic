# Module 04 — Bài Tập Thực Hành: Quyền Truy Cập (Permissions)

> 💡 **Mục tiêu**: Thực hành phân quyền cho file và thư mục bằng cả số (755, 644, 600) và ký tự (u+x, g-w), hiểu ý nghĩa của `sudo` và quyền sở hữu `chown`.

---

## 🎯 Phần 1: Tạo Môi Trường Thực Hành

Chạy các lệnh sau để tạo một thư mục bài tập:
```bash
mkdir -p ~/linux_practice/module04
cd ~/linux_practice/module04

# Tạo các file mẫu
echo "echo 'Xin chao Linux!'" > script.sh
echo "Thong tin mat khau bi mat" > secret.txt
echo "Tai lieu chia se chung" > public.txt
mkdir -p du_an

ls -la
```

---

## 🎯 Phần 2: Phân Quyền Bằng Ký Tự (u, g, o, a)

### 1. Thử chạy script khi chưa có quyền thực thi
```bash
# Thử chạy file script.sh
./script.sh
# Quan sát thông báo: "Permission denied" vì file chưa có quyền thực thi (x)!
```

### 2. Cấp quyền thực thi cho Owner
```bash
# Thêm quyền thực thi (x) cho User/Owner (u)
chmod u+x script.sh

# Kiểm tra lại
ls -l script.sh

# Chạy lại file
./script.sh
```

### 3. Thu hồi quyền đọc/ghi
```bash
# Bỏ quyền đọc và ghi của người khác (Others) đối với file bí mật
chmod o-rw secret.txt

# Kiểm tra lại
ls -l secret.txt
```

---

## 🎯 Phần 3: Phân Quyền Bằng Số (Octal Notation)

Ghi nhớ bảng số: **r = 4, w = 2, x = 1**

### 1. Phân quyền chuẩn cho file bí mật cá nhân (600)
- Owner: `rw-` = 4 + 2 = 6
- Group: `---` = 0
- Others: `---` = 0
```bash
chmod 600 secret.txt
ls -l secret.txt
# Chỉ bạn mới đọc/ghi được file này (thường dùng cho SSH Key: ~/.ssh/id_rsa)
```

### 2. Phân quyền chuẩn cho file tài liệu thông thường (644)
- Owner: đọc + ghi (6)
- Group: chỉ đọc (4)
- Others: chỉ đọc (4)
```bash
chmod 644 public.txt
ls -l public.txt
```

### 3. Phân quyền chuẩn cho file thực thi/script (755)
- Owner: đọc + ghi + chạy (7)
- Group: đọc + chạy (5)
- Others: đọc + chạy (5)
```bash
chmod 755 script.sh
ls -l script.sh
```

---

## 🎯 Phần 4: Quyền Của Thư Mục (Khác gì với File?)

> ⚠️ **Lưu ý cực quan trọng**: Với thư mục:
> - Quyền `r`: Được liệt kê danh sách file (`ls`).
> - Quyền `x`: Được bước vào thư mục (`cd`) và truy cập file bên trong!
> - Nếu thư mục có `r` nhưng không có `x`, bạn thấy tên file nhưng KHÔNG mở hay đọc nội dung được!

```bash
# Thử bỏ quyền x của thư mục du_an
chmod 644 du_an
ls -ld du_an

# Thử cd vào du_an
cd du_an
# Báo lỗi: Permission denied!

# Khôi phục quyền cho thư mục (chuẩn là 755)
chmod 755 du_an
cd du_an
pwd
cd ..
```

---

## 🎯 Phần 5: Quyền Quản Trị Siêu Cấp (sudo)

```bash
# Xem quyền của file hệ thống /etc/shadow (chứa mật khẩu đã mã hóa)
ls -l /etc/shadow

# Thử đọc trực tiếp bằng user thường
cat /etc/shadow
# Báo lỗi: Permission denied!

# Dùng sudo (nhập mật khẩu của bạn khi được hỏi)
sudo cat /etc/shadow | head -5
```

✅ **Hoàn thành bài tập! Hãy chuyển sang [kiem_tra.md](file:///d:/Linux%20basic/Module_04_Quyen_Truy_Cap/kiem_tra.md) để đánh giá bản thân.**
