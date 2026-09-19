# Module 04 — Quyền Truy Cập (Permissions)

> **Mục tiêu**: Hiểu và quản lý quyền truy cập file/thư mục trong Linux

---

## 📖 4.1 Hệ Thống Quyền Linux

Mỗi file/thư mục có 3 nhóm quyền:

```
-rwxrw-r--  1  alice  staff  4096  Jan 1  file.txt
│├──┤├──┤├──┤
││  │ │  │  └─ Quyền Others (người khác)
││  │ │  └──── Quyền Group (nhóm)
││  │ └─────── Quyền Owner (chủ sở hữu)
││  └───────── Loại file (- = file, d = dir, l = link)
│└──────────── Bit thực thi đặc biệt
```

### Ý nghĩa từng ký tự:
| Ký tự | Quyền | Giá trị số |
|-------|-------|-----------|
| `r`   | Read (đọc) | 4 |
| `w`   | Write (ghi) | 2 |
| `x`   | Execute (thực thi) | 1 |
| `-`   | Không có quyền | 0 |

### Ví dụ:
```
rwxrw-r--
│ │ │ └── Others: r-- = 4 (chỉ đọc)
│ │ └──── Group:  rw- = 6 (đọc + ghi)
│ └────── Owner:  rwx = 7 (đọc + ghi + chạy)
→ Số: 764
```

---

## 📖 4.2 Lệnh chmod — Thay Đổi Quyền

### Cách dùng số (Octal):
```bash
chmod 755 file.sh          # Owner: rwx, Group: r-x, Others: r-x
chmod 644 file.txt         # Owner: rw-, Group: r--, Others: r--
chmod 600 secret.key       # Chỉ owner đọc/ghi, người khác không làm gì
chmod 777 file             # Tất cả đọc/ghi/chạy (NGUY HIỂM!)
chmod -R 755 thu_muc/      # Áp dụng đệ quy cho thư mục (-R)
```

### Cách dùng ký tự:
```bash
chmod u+x script.sh        # Thêm quyền thực thi cho user (owner)
chmod g-w file.txt         # Bỏ quyền ghi của group
chmod o+r file.txt         # Thêm quyền đọc cho others
chmod a+x script.sh        # Thêm quyền thực thi cho TẤT CẢ
chmod u=rwx,g=rx,o=r file  # Đặt quyền cụ thể

# u = user(owner), g = group, o = others, a = all
# + thêm, - bỏ, = đặt chính xác
```

### Quyền phổ biến:
| Số | Ký hiệu | Dùng cho |
|----|---------|---------|
| 755 | rwxr-xr-x | Script, thư mục public |
| 644 | rw-r--r-- | File thông thường |
| 600 | rw------- | File riêng tư (SSH key) |
| 700 | rwx------ | Script riêng tư |
| 777 | rwxrwxrwx | Tránh dùng! |

---

## 📖 4.3 Lệnh chown — Đổi Chủ Sở Hữu

```bash
chown alice file.txt           # Đổi owner thành alice
chown alice:staff file.txt     # Đổi owner và group
chown :staff file.txt          # Chỉ đổi group
chown -R alice:staff thư_mục/  # Đệ quy cho thư mục
```

---

## 📖 4.4 Lệnh chgrp — Đổi Group

```bash
chgrp staff file.txt           # Đổi group thành staff
chgrp -R developers project/   # Đệ quy
```

---

## 📖 4.5 Xem Thông Tin Quyền

```bash
ls -la                         # Xem quyền tất cả file
ls -la file.txt                # Xem quyền file cụ thể
stat file.txt                  # Thông tin chi tiết (cả octal)
```

---

## 📖 4.6 Người Dùng & Nhóm

```bash
# Thông tin người dùng
whoami                         # Tên user hiện tại
id                             # UID, GID và các nhóm
id alice                       # Thông tin user alice
groups                         # Các nhóm bạn thuộc
groups alice                   # Nhóm của alice

# Xem danh sách users
cat /etc/passwd                # Tất cả users
cut -d: -f1 /etc/passwd        # Chỉ tên users
cat /etc/group                 # Tất cả nhóm

# Chuyển sang user khác
su alice                       # Chuyển sang user alice (cần mật khẩu)
su -                           # Chuyển sang root
sudo lệnh                      # Chạy lệnh với quyền root
sudo su                        # Trở thành root
```

---

## 📖 4.7 Sudo — Quyền Đặc Biệt

```bash
sudo apt update                # Chạy với quyền root
sudo -l                        # Xem mình được sudo lệnh nào
sudo -u alice lệnh             # Chạy lệnh với tư cách alice
visudo                         # Chỉnh sửa /etc/sudoers (cẩn thận!)
```

---

## 📖 4.8 Quyền Đặc Biệt

```bash
# SUID (Set User ID) — chạy với quyền owner
chmod u+s script.sh
chmod 4755 script.sh           # 4 = SUID

# SGID (Set Group ID) — chạy với quyền group / kế thừa group
chmod g+s thu_muc/
chmod 2755 thu_muc/            # 2 = SGID

# Sticky bit — chỉ owner mới xóa được file của mình
chmod +t /tmp
chmod 1777 /tmp                # 1 = Sticky bit

# Xem
ls -la /tmp                    # Thư mục có sticky bit hiện là t
```

---

## 📖 4.9 umask — Quyền Mặc Định

```bash
umask                          # Xem umask hiện tại (thường 022)
umask 027                      # Đặt umask mới

# Quyền tạo mới = 666 - umask (cho file) / 777 - umask (cho dir)
# umask 022: file = 644, dir = 755
# umask 027: file = 640, dir = 750
```

---

## 📝 Tiếp Theo

👉 [bai_tap.md](./bai_tap.md)  
👉 [kiem_tra.md](./kiem_tra.md)
