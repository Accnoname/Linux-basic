# Module 02 — Thao Tác File & Thư Mục

> **Mục tiêu**: Tạo, xóa, sao chép, di chuyển, tìm kiếm file và thư mục

---

## 📖 2.1 Tạo File & Thư Mục

```bash
# Tạo thư mục
mkdir ten_thu_muc              # Tạo 1 thư mục
mkdir -p a/b/c                 # Tạo thư mục lồng nhau (tạo cả cha)
mkdir thu_muc1 thu_muc2        # Tạo nhiều thư mục cùng lúc

# Tạo file
touch ten_file.txt             # Tạo file rỗng (hoặc cập nhật timestamp)
touch file1.txt file2.txt      # Tạo nhiều file

# Tạo file có nội dung
echo "Nội dung" > file.txt     # Ghi nội dung vào file (ghi đè)
echo "Thêm dòng" >> file.txt   # Thêm vào cuối file (không ghi đè)
```

---

## 📖 2.2 Sao Chép (cp)

```bash
cp file.txt copy.txt           # Sao chép file
cp file.txt /tmp/              # Sao chép vào thư mục khác
cp -r thu_muc/ backup/         # Sao chép thư mục (-r = recursive)
cp -i file.txt dest.txt        # Hỏi trước khi ghi đè (-i = interactive)
cp -v file.txt /tmp/           # Hiện thông báo quá trình (-v = verbose)
cp -p file.txt copy.txt        # Giữ nguyên thuộc tính (permissions, timestamp)
```

---

## 📖 2.3 Di Chuyển & Đổi Tên (mv)

```bash
mv file.txt /tmp/              # Di chuyển file
mv ten_cu.txt ten_moi.txt      # Đổi tên file
mv thu_muc_cu/ thu_muc_moi/    # Đổi tên thư mục
mv -i file.txt /tmp/           # Hỏi trước khi ghi đè
mv -v *.txt /tmp/              # Di chuyển tất cả .txt, hiện thông báo
```

---

## 📖 2.4 Xóa (rm & rmdir)

```bash
rm file.txt                    # Xóa file (KHÔNG vào thùng rác!)
rm -i file.txt                 # Hỏi trước khi xóa (an toàn)
rm -f file.txt                 # Xóa không hỏi (force)
rm *.txt                       # Xóa tất cả file .txt
rm -r thu_muc/                 # Xóa thư mục và nội dung bên trong
rm -rf thu_muc/                # Xóa mạnh (cẩn thận!!!)

rmdir thu_muc/                 # Xóa thư mục RỖNG
```

> ⚠️ **CẢNH BÁO**: `rm -rf` xóa vĩnh viễn, không khôi phục được!  
> Luôn kiểm tra đường dẫn trước khi dùng `rm -rf`

---

## 📖 2.5 Xem Nội Dung File

```bash
cat file.txt                   # In toàn bộ nội dung
cat -n file.txt                # In kèm số dòng
less file.txt                  # Xem từng trang (q để thoát)
more file.txt                  # Xem từng trang (đơn giản hơn less)
head file.txt                  # 10 dòng đầu
head -20 file.txt              # 20 dòng đầu
tail file.txt                  # 10 dòng cuối
tail -20 file.txt              # 20 dòng cuối
tail -f /var/log/syslog        # Xem log realtime (f = follow)
```

---

## 📖 2.6 Tìm Kiếm File (find)

```bash
find / -name "file.txt"              # Tìm file tên "file.txt" từ /
find . -name "*.txt"                 # Tìm tất cả .txt trong thư mục hiện tại
find /home -type f                   # Tìm file (f=file, d=directory)
find /home -type d                   # Tìm thư mục
find . -name "*.sh" -executable      # Tìm script có thể chạy
find . -mtime -7                     # File được sửa trong 7 ngày gần đây
find . -size +1M                     # File lớn hơn 1MB
find . -name "*.log" -delete         # Tìm và xóa (cẩn thận!)
find . -name "*.txt" -exec cat {} \; # Tìm rồi chạy lệnh với kết quả
```

---

## 📖 2.7 Liên Kết (Links)

```bash
# Hard link — cùng trỏ đến 1 inode
ln file.txt hardlink.txt

# Soft link (symbolic link) — như shortcut
ln -s /duong/dan/day/du alias.txt
ln -s /usr/bin/python3 python

ls -li                         # Xem inode của file
readlink -f alias.txt          # Xem file gốc của symlink
```

---

## 📖 2.8 Xem Thông Tin File & Thư Mục

```bash
ls -lh                         # Kích thước dạng đọc được
du -h file.txt                 # Dung lượng file
du -sh thu_muc/                # Dung lượng thư mục (tổng)
du -sh *                       # Tất cả file trong thư mục hiện tại
df -h                          # Dung lượng ổ đĩa
file ten_file                  # Loại file là gì (text, binary, image...)
stat file.txt                  # Thông tin chi tiết: size, inode, permissions...
wc file.txt                    # Đếm: dòng, từ, ký tự
wc -l file.txt                 # Chỉ đếm dòng
wc -w file.txt                 # Chỉ đếm từ
```

---

## 📖 2.9 Wildcard (Ký Tự Đại Diện)

```bash
*       # Khớp bất kỳ chuỗi nào
?       # Khớp 1 ký tự bất kỳ
[abc]   # Khớp a, b, hoặc c
[0-9]   # Khớp số 0 đến 9

# Ví dụ:
ls *.txt               # Tất cả file .txt
ls file?.txt           # file1.txt, file2.txt...
ls [A-Z]*.txt          # File .txt bắt đầu bằng chữ hoa
rm temp*               # Xóa tất cả file bắt đầu bằng "temp"
cp *.jpg ~/Pictures/   # Copy tất cả ảnh jpg
```

---

## 📝 Tiếp Theo

👉 [bai_tap.md](./bai_tap.md) — Thực hành  
👉 [kiem_tra.md](./kiem_tra.md) — Kiểm tra kiến thức
