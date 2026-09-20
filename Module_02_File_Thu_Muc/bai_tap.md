# Module 02 — Bài Tập Thực Hành

---

## 🎯 Bài Tập 1: Tạo Cấu Trúc Thư Mục Dự Án

Tạo cấu trúc thư mục sau chỉ bằng lệnh Linux:

```
~/linux_project/
├── src/
│   ├── main/
│   └── tests/
├── docs/
├── data/
│   ├── raw/
│   └── processed/
└── logs/
```

```bash
cd ~
mkdir -p linux_project/src/main linux_project/src/tests
# Tự hoàn thiện phần còn lại...
```

Kiểm tra kết quả:
```bash
find ~/linux_project -type d
```

---

## 🎯 Bài Tập 2: Tạo & Chỉnh Sửa File

```bash
cd ~/linux_project

# Tạo file README
echo "# Dự án Linux của tôi" > README.md
echo "Ngày tạo: $(date)" >> README.md
echo "Tác giả: $(whoami)" >> README.md

# Xem nội dung
cat README.md

# Tạo nhiều file log mẫu
touch logs/app.log logs/error.log logs/debug.log

# Xem cấu trúc
ls -la logs/
```

---

## 🎯 Bài Tập 3: Sao Chép & Di Chuyển

```bash
cd ~/linux_project

# Tạo file để thực hành
echo "File gốc" > src/main/code.py
echo "File test" > src/tests/test_code.py

# Sao chép file
cp src/main/code.py docs/code_backup.py

# Di chuyển file
mv docs/code_backup.py data/raw/code_backup.py

# Đổi tên file
mv data/raw/code_backup.py data/raw/original_code.py

# Kiểm tra
find ~/linux_project -name "*.py"
```

---

## 🎯 Bài Tập 4: Xem Nội Dung & Thống Kê

```bash
# Tạo file nhiều dòng
for i in {1..50}; do echo "Đây là dòng số $i"; done > data/raw/sample.txt

# Xem nội dung
head -10 data/raw/sample.txt      # 10 dòng đầu
tail -10 data/raw/sample.txt      # 10 dòng cuối
cat -n data/raw/sample.txt | head -5  # Có số dòng

# Đếm dòng
wc -l data/raw/sample.txt

# Xem dung lượng
du -sh ~/linux_project/
du -sh ~/linux_project/*
```

---

## 🎯 Bài Tập 5: Tìm Kiếm File

```bash
cd ~

# Tìm tất cả file .txt trong linux_project
find ~/linux_project -name "*.txt"

# Tìm tất cả thư mục
find ~/linux_project -type d

# Tìm file lớn hơn 0 bytes
find ~/linux_project -type f -size +0c

# Tìm file được tạo hôm nay
find ~/linux_project -type f -mtime 0
```

---

## 🎯 Bài Tập 6: Wildcard

```bash
cd ~/linux_project/logs

# Tạo thêm log files
touch app_2024.log app_2025.log error_2024.log error_2025.log

ls *.log             # Tất cả log
ls app*.log          # Chỉ app log
ls *2024*            # Chỉ file 2024
ls ???_2024.log      # 3 ký tự + _2024.log

# Copy tất cả log vào data/processed
cp *.log ~/linux_project/data/processed/
ls ~/linux_project/data/processed/
```

---

## 🎯 Bài Tập 7: Xóa An Toàn

```bash
cd ~/linux_project

# Luôn kiểm tra trước khi xóa!
ls data/processed/

# Xóa từng file một cách an toàn
rm -i data/processed/app_2024.log

# Xóa nhiều file với xác nhận
rm -i data/processed/*.log
```

---

## 🏆 Thử Thách Cuối Module

Viết lệnh để thực hiện tất cả trong 1 lần:
1. Tạo thư mục `/tmp/challenge`
2. Tạo 5 file txt trong đó (file1.txt đến file5.txt)
3. Sao chép chúng vào `/tmp/challenge/backup/`
4. Đổi tên `file1.txt` trong backup thành `important.txt`
5. Xóa `file3.txt` khỏi thư mục gốc
6. Đếm số file còn lại trong `/tmp/challenge`

```bash
# Lời giải One-Liner (1 dòng duy nhất dùng && và |):
mkdir -p /tmp/challenge/backup && touch /tmp/challenge/file{1..5}.txt && cp /tmp/challenge/file*.txt /tmp/challenge/backup/ && mv /tmp/challenge/backup/file1.txt /tmp/challenge/backup/important.txt && rm /tmp/challenge/file3.txt && ls /tmp/challenge/*.txt | wc -l
```

* **Ghi nhớ từ thực hành:**
  - `mkdir -p /tmp/challenge/backup`: Tạo tự động cả thư mục cha và thư mục con.
  - `{1..5}`: Kỹ thuật *Brace Expansion* giúp sinh dãy file tự động không cần gõ thủ công.
  - `>` vs `>>`: `>` là ghi đè (tạo mới), `>>` là ghi nối đuôi vào cuối file.
  - `cp` vs `mv`: `cp` là nhân bản giữ file gốc; `mv` là di chuyển và đồng thời dùng để đổi tên file.
  - `*` vs `?`: `*` khớp bất kỳ chuỗi ký tự nào; `?` khớp đúng 1 ký tự (`???_2024.log` chỉ khớp `app_2024.log`, loại `error_2024.log` vì có 5 ký tự).
  - `rm -i`: Hỏi xác nhận trước khi xóa file để tránh xóa nhầm (vì Linux xóa là mất vĩnh viễn).
  - `wc -l` là đếm số dòng trong file (với file rỗng sẽ in ra 0). Muốn đếm số lượng file phải kết hợp đường ống Pipe: `ls *.txt | wc -l`.
  - `du -sh`: Xem tổng dung lượng thư mục dạng KB, MB dễ đọc (*Disk Usage - Summary Human-readable*).

---

## ✅ Checklist

- [x] Tạo được thư mục lồng nhau với `mkdir -p`
- [x] Dùng được `cp`, `mv`, `rm` thành thạo
- [x] Biết dùng `head`, `tail`, `cat`, `wc`
- [x] Biết dùng `find` để tìm file
- [x] Hiểu và dùng được wildcard `*`, `?`, `[]`
- [x] Biết cách xóa an toàn với `-i`

👉 Hoàn thành Module 02! Sang [kiem_tra.md](./kiem_tra.md) để kiểm tra kiến thức!
