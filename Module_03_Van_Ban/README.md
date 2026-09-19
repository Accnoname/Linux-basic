# Module 03 — Xem & Xử Lý Văn Bản

> **Mục tiêu**: Xem, tìm kiếm, lọc và xử lý nội dung văn bản trong Linux

---

## 📖 3.1 Lệnh grep — Tìm Kiếm Nội Dung

```bash
grep "từ_cần_tìm" file.txt          # Tìm trong file
grep -i "linux" file.txt             # Không phân biệt hoa thường (-i)
grep -n "error" log.txt              # Hiển thị số dòng (-n)
grep -r "TODO" ~/projects/           # Tìm đệ quy trong thư mục (-r)
grep -v "debug" log.txt              # Đảo ngược: dòng KHÔNG chứa (-v)
grep -c "error" log.txt              # Đếm số dòng khớp (-c)
grep -l "error" *.log                # Chỉ hiện tên file chứa (-l)
grep -w "log" file.txt               # Khớp đúng từ (-w = word)
grep -A 3 "error" log.txt            # In 3 dòng SAU kết quả (-A)
grep -B 3 "error" log.txt            # In 3 dòng TRƯỚC kết quả (-B)
grep -C 3 "error" log.txt            # In 3 dòng cả 2 phía (-C)
grep "^Start" file.txt               # Dòng bắt đầu bằng "Start" (regex)
grep "end$" file.txt                 # Dòng kết thúc bằng "end"
grep -E "error|warning" log.txt      # Regex mở rộng: OR
```

---

## 📖 3.2 Pipe ( | ) — Kết Nối Lệnh

```bash
# Pipe: đầu ra của lệnh trái → đầu vào của lệnh phải
ls -la | grep "txt"                  # Lọc file txt trong ls
cat file.txt | grep "error" | wc -l  # Đếm dòng có error
ps aux | grep "python"               # Tìm process python
history | grep "git"                 # Tìm lệnh git đã dùng
cat /etc/passwd | cut -d: -f1        # Lấy tên users
```

---

## 📖 3.3 Lệnh cut — Cắt Cột Dữ Liệu

```bash
cut -d: -f1 /etc/passwd              # Cắt theo dấu : lấy cột 1
cut -d, -f2 data.csv                 # Cắt CSV lấy cột 2
cut -d: -f1,3 /etc/passwd            # Lấy cột 1 và 3
cut -c1-10 file.txt                  # Lấy ký tự 1-10 mỗi dòng
cut -c5- file.txt                    # Từ ký tự thứ 5 trở đi
```

---

## 📖 3.4 Lệnh sort — Sắp Xếp

```bash
sort file.txt                        # Sắp xếp theo ABC
sort -r file.txt                     # Sắp xếp ngược
sort -n numbers.txt                  # Sắp xếp theo số
sort -k2 file.txt                    # Sắp xếp theo cột 2
sort -u file.txt                     # Xóa dòng trùng lặp khi sort
sort -t: -k3 -n /etc/passwd          # Sort /etc/passwd theo UID
```

---

## 📖 3.5 Lệnh uniq — Lọc Dòng Trùng

```bash
sort file.txt | uniq                 # Xóa dòng trùng (phải sort trước)
sort file.txt | uniq -c              # Đếm số lần xuất hiện
sort file.txt | uniq -d              # Chỉ hiện dòng trùng
sort file.txt | uniq -u              # Chỉ hiện dòng duy nhất
```

---

## 📖 3.6 Lệnh tr — Chuyển Đổi Ký Tự

```bash
echo "hello world" | tr 'a-z' 'A-Z'   # Chuyển thường → HOA
echo "hello world" | tr 'A-Z' 'a-z'   # Chuyển HOA → thường
echo "hello   world" | tr -s ' '      # Nén khoảng trắng liên tiếp
cat file.txt | tr -d '\n'              # Xóa ký tự xuống dòng
echo "abc123" | tr -d '0-9'           # Xóa số
```

---

## 📖 3.7 Redirect (Chuyển Hướng)

```bash
# Redirect output (>)
ls -la > output.txt                  # Ghi ra file (ghi đè)
ls -la >> output.txt                 # Thêm vào cuối file

# Redirect input (<)
sort < file.txt                      # Đọc đầu vào từ file

# Redirect lỗi (2>)
command 2> error.txt                 # Ghi lỗi ra file
command > output.txt 2> error.txt    # Ghi cả output và lỗi
command > output.txt 2>&1            # Gộp lỗi vào output
command &> all.txt                   # Gộp tất cả vào 1 file
command 2> /dev/null                 # Vứt lỗi vào sọt rác
```

---

## 📖 3.8 Lệnh awk — Xử Lý Cột Nâng Cao

```bash
awk '{print $1}' file.txt            # In cột 1
awk '{print $1, $3}' file.txt        # In cột 1 và 3
awk -F: '{print $1}' /etc/passwd     # Dùng : làm separator
awk '{print NR, $0}' file.txt        # In số dòng + nội dung
awk 'NR==3' file.txt                 # Chỉ in dòng thứ 3
awk '$3 > 1000' /etc/passwd          # Dòng có cột 3 > 1000
awk '{sum += $1} END {print sum}' nums.txt  # Tính tổng cột 1
awk '/error/ {print}' log.txt        # In dòng chứa "error"
```

---

## 📖 3.9 Lệnh sed — Stream Editor

```bash
sed 's/cũ/mới/' file.txt             # Thay thế lần đầu tiên mỗi dòng
sed 's/cũ/mới/g' file.txt            # Thay thế tất cả (g = global)
sed -i 's/cũ/mới/g' file.txt         # Thay trực tiếp trong file (-i)
sed '5d' file.txt                    # Xóa dòng 5
sed '/pattern/d' file.txt            # Xóa dòng chứa pattern
sed -n '5,10p' file.txt              # Chỉ in dòng 5-10
sed 's/^/  /' file.txt               # Thêm 2 khoảng trắng đầu mỗi dòng
```

---

## 📝 Tiếp Theo

👉 [bai_tap.md](./bai_tap.md) — Thực hành  
👉 [kiem_tra.md](./kiem_tra.md) — Kiểm tra
