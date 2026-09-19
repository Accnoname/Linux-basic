# Module 03 — Bài Tập Thực Hành Văn Bản

---

## 🎯 Chuẩn Bị Dữ Liệu

Chạy script này trước để tạo dữ liệu mẫu:

```bash
mkdir -p ~/linux_practice/module03
cd ~/linux_practice/module03

# Tạo file log mẫu
cat > app.log << 'EOF'
2024-01-01 ERROR Database connection failed
2024-01-01 INFO Server started successfully
2024-01-02 WARNING Disk space low: 85% used
2024-01-02 ERROR Null pointer exception in UserService
2024-01-03 INFO User admin logged in
2024-01-03 ERROR Failed to send email
2024-01-04 DEBUG Processing request id=1234
2024-01-04 INFO Request completed in 250ms
2024-01-05 ERROR Database connection failed
2024-01-05 WARNING Memory usage: 90%
EOF

# Tạo file dữ liệu người dùng
cat > users.csv << 'EOF'
Alice,25,Engineer,50000
Bob,30,Manager,75000
Charlie,22,Intern,30000
Diana,28,Designer,55000
Eve,35,Director,90000
Frank,27,Engineer,52000
Grace,31,Manager,78000
EOF

# Tạo file số
cat > numbers.txt << 'EOF'
42
17
89
3
56
23
89
17
100
42
EOF

echo "✅ Dữ liệu mẫu đã tạo xong!"
ls -la
```

---

## 🎯 Bài Tập 1: grep Cơ Bản

```bash
cd ~/linux_practice/module03

# 1. Tìm tất cả dòng có "ERROR"
grep "ERROR" app.log

# 2. Đếm số lỗi ERROR
grep -c "ERROR" app.log

# 3. Tìm ERROR và WARNING (không phân biệt hoa thường)
grep -iE "error|warning" app.log

# 4. Hiện số dòng của các lỗi
grep -n "ERROR" app.log

# 5. Tìm dòng KHÔNG có ERROR
grep -v "ERROR" app.log
```

---

## 🎯 Bài Tập 2: grep Nâng Cao

```bash
# 1. Tìm lỗi Database và hiện 2 dòng xung quanh
grep -C 2 "Database" app.log

# 2. Đếm tổng số lần "ERROR" xuất hiện theo ngày
grep "2024-01-01" app.log
grep "2024-01-02" app.log

# 3. Tìm dòng bắt đầu bằng "2024-01-03"
grep "^2024-01-03" app.log

# 4. Tìm các dòng chứa số (dùng regex)
grep -E "[0-9]+" app.log
```

---

## 🎯 Bài Tập 3: Pipe Kết Hợp

```bash
# 1. Đếm số lỗi unique
grep "ERROR" app.log | cut -d' ' -f4- | sort | uniq -c

# 2. Xem top 3 lỗi phổ biến nhất
grep "ERROR" app.log | awk '{print $NF}' | sort | uniq -c | sort -rn | head -3

# 3. Lấy danh sách tên người dùng từ users.csv
cat users.csv | cut -d, -f1

# 4. Sắp xếp người dùng theo lương (cột 4)
sort -t, -k4 -n users.csv

# 5. Ai có lương cao nhất?
sort -t, -k4 -rn users.csv | head -1
```

---

## 🎯 Bài Tập 4: awk Xử Lý CSV

```bash
# 1. In tên và lương
awk -F, '{print $1, $4}' users.csv

# 2. Chỉ in người có lương > 60000
awk -F, '$4 > 60000 {print $1, $4}' users.csv

# 3. Tính tổng lương
awk -F, '{sum += $4} END {print "Tổng lương:", sum}' users.csv

# 4. Tính lương trung bình
awk -F, '{sum += $4; count++} END {print "Lương TB:", sum/count}' users.csv

# 5. Đếm số người mỗi chức vụ
awk -F, '{print $3}' users.csv | sort | uniq -c
```

---

## 🎯 Bài Tập 5: sed Thay Thế

```bash
# 1. Thay "ERROR" thành "[LỖI]" khi xem (không sửa file)
sed 's/ERROR/[LỖI]/g' app.log

# 2. Xóa dòng DEBUG
sed '/DEBUG/d' app.log

# 3. Chỉ xem dòng 3-7
sed -n '3,7p' app.log

# 4. Thêm "LOG: " vào đầu mỗi dòng
sed 's/^/LOG: /' app.log

# 5. Tạo file mới, thay tất cả "2024" thành "2025"
sed 's/2024/2025/g' app.log > app_2025.log
cat app_2025.log | head -3
```

---

## 🎯 Bài Tập 6: sort & uniq

```bash
# 1. Sắp xếp số
sort -n numbers.txt

# 2. Số nào xuất hiện nhiều nhất?
sort -n numbers.txt | uniq -c | sort -rn | head -1

# 3. Số unique (không trùng)
sort -n numbers.txt | uniq -u

# 4. Xóa trùng và sắp xếp
sort -n numbers.txt | uniq
```

---

## 🏆 Thử Thách Cuối Module

```bash
# Câu 1: Dùng 1 pipeline, lấy danh sách tên tất cả Engineer,
#         sắp xếp theo ABC và hiện ra
# Gợi ý: grep + cut + sort

# Câu 2: Đếm có bao nhiêu dòng WARNING trong app.log
#         mà liên quan đến số phần trăm (%)
# Gợi ý: grep + grep

# Câu 3: Tính tổng số ngày có lỗi ERROR
#         (mỗi ngày tính 1 lần dù có nhiều lỗi)
# Gợi ý: grep + cut + sort + uniq + wc

# Viết câu trả lời của bạn:
```

---

## ✅ Checklist

- [ ] Dùng được `grep` với các flag: `-i`, `-n`, `-v`, `-c`, `-r`, `-E`
- [ ] Biết dùng pipe `|` để kết hợp lệnh
- [ ] Dùng được `cut` để lấy cột
- [ ] Dùng được `sort` và `uniq`
- [ ] Dùng được `awk` để xử lý cột và tính toán
- [ ] Dùng được `sed` để thay thế và lọc dòng

👉 Sang [kiem_tra.md](./kiem_tra.md)!
