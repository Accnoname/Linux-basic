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
# 1. Tìm tất cả dòng có "ERROR"
grep "ERROR" app.log

# 2. Đếm số lỗi ERROR
grep -c "ERROR" app.log

# 3. Hiện số dòng của các lỗi
grep -n "ERROR" app.log

# 4. Tìm dòng KHÔNG có ERROR
grep -v "ERROR" app.log

# 5. Tìm ERROR và WARNING (không phân biệt hoa thường)
grep -iE "error|warning" app.log
```

* **Nhật ký thực hành của bạn:**
  - `grep "ERROR" app.log`: Trả về đúng 4 dòng chứa chữ `ERROR`.
  - `grep -c "ERROR" app.log`: Đếm được tổng cộng `4` lỗi.
  - `grep -n "ERROR" app.log`: Định vị chính xác số dòng lỗi (`1`, `4`, `6`, `9`).
  - `grep -v "ERROR" app.log`: Đảo ngược bộ lọc (*inVert*), in ra 6 dòng bình thường (INFO, WARNING, DEBUG).
  - `grep -iE "error|warning" app.log`: 
    - `-i` (*ignore-case*): Không phân biệt chữ hoa/thường.
    - `-E` (*Extended Regex*): Cho phép dùng toán tử logic **`|`** mang ý nghĩa là **HOẶC** (*OR*). Lệnh này lọc ra cả dòng có `error` HOẶC `warning` (tổng 6 dòng).
    - *Lưu ý*: Ban đầu bạn gõ nhầm dấu gạch chéo `/` (`error/warning`) nên không ra kết quả vì grep tìm kiếm nguyên cụm chữ `error/warning`. Khi đổi sang thanh đứng `|` thì regex hiểu là phép chọn lựa một trong hai.


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
# 1. Lấy danh sách tên người dùng từ users.csv
cut -d',' -f1 users.csv

# 2. Đếm số lượng từng chức vụ
cut -d',' -f3 users.csv | sort | uniq -c

# 3. Sắp xếp người dùng theo lương (cột 4, giảm dần) và lấy người cao nhất
sort -t',' -k4 -rn users.csv | head -n 1
```

* **Nhật ký thực hành của bạn:**
  - `cut -d',' -f1 users.csv`: Rút trích đúng cột Tên (`Alice`, `Bob`, `Charlie`...).
  - `cut -d',' -f3 users.csv | sort | uniq -c`: Thống kê được: `1 Designer`, `1 Director`, `2 Engineer`, `1 Intern`, `2 Manager`.
  - `sort -t',' -k4 -rn users.csv | head -n 1`: Tìm được người lương cao nhất là `Eve,35,Director,90000`.

* **Mẹo giải mã cờ (Đừng học vẹt, hãy nhớ từ tiếng Anh):**
  - Trong `cut`:
    - `-d` = **D**elimiter (Dấu ngăn cách giữa các cột, ví dụ `-d','` hoặc `-d':'`).
    - `-f` = **F**ield (Cột số mấy, ví dụ `-f1` là cột 1, `-f3` là cột 3).
  - Trong `sort`:
    - `-t` = Separator / **T**ab (Dấu ngăn cách cột).
    - `-k` = **K**ey (Khóa / Cột dùng làm mốc so sánh, ví dụ `-k4` là cột lương).
    - `-n` = **N**umber (Sắp xếp theo giá trị Số học, nếu không có cờ này máy sẽ coi số 100 bé hơn số 2 vì bắt đầu bằng chữ số 1).
    - `-r` = **R**everse (Đảo ngược thứ tự, từ to đến nhỏ).
  - Trong `uniq`:
    - `-c` = **C**ount (Đếm số lần xuất hiện của dòng).


---

## 🎯 Bài Tập 4: awk Xử Lý CSV

```bash
# 1. In tên và lương
awk -F',' '{print $1, $4}' users.csv

# 2. Chỉ in người có lương > 60000
awk -F',' '$4 > 60000 {print $1, $3, $4}' users.csv

# 3. Tính tổng lương cả công ty
awk -F',' '{sum += $4} END {print "Tổng lương:", sum}' users.csv

# 4. Tính lương trung bình
awk -F',' '{sum += $4; count++} END {print "Lương TB:", sum/count}' users.csv
```

* **Nhật ký thực hành của bạn:**
  - `awk` coi mỗi dòng là một bảng ghi, tự động chia cột theo dấu phẩy nhờ `-F','`.
  - `$1`, `$2`, `$3`, `$4` lần lượt đại diện cho các cột: Tên, Tuổi, Chức vụ, Lương.
  - Lọc điều kiện `$4 > 60000` tìm ra 3 người: `Bob (75000)`, `Eve (90000)`, `Grace (78000)`.
  - Tính toán tổng quỹ lương: `430000` và lương trung bình: `61428.6`.
  - *Lưu ý quan trọng*: Lệnh `awk` luôn phải được bao bọc trong cặp dấu nháy đơn `'...'` để tránh Bash hiểu nhầm dấu `$` thành biến môi trường.


---

## 🎯 Bài Tập 5: sed Thay Thế

```bash
# 1. Thay "ERROR" thành "[LỖI]" khi xem (không sửa file gốc)
sed 's/ERROR/[LỖI]/g' app.log

# 2. Xóa dòng DEBUG (d = Delete)
sed '/DEBUG/d' app.log

# 3. Chỉ xem từ dòng 3 đến 7 (p = Print kết hợp cờ im lặng -n)
sed -n '3,7p' app.log

# 4. Thêm tiền tố "LOG: " vào đầu mỗi dòng (^ = đầu dòng)
sed 's/^/LOG: /' app.log
```

* **Nhật ký thực hành & Cấu trúc cốt lõi của `sed`:**
  - Cấu trúc chung: `[Phạm vi/Điều kiện] + [Hành động]`.
  - `s` = **S**ubstitute (thay thế), `g` = **G**lobal (thay tất cả các lần xuất hiện trên cùng 1 dòng).
  - `/DEBUG/d`: Điều kiện `/DEBUG/`, hành động `d` = **D**elete (xóa cả dòng).
  - `-n '3,7p'`: Điều kiện dòng `3,7` (dấu phẩy `,` nghĩa là từ dòng 3 đến dòng 7), hành động `p` = **P**rint. Cờ `-n` tắt chế độ tự động in của sed.
  - Mặc định `sed` chỉ in kết quả ra màn hình chứ KHÔNG sửa file gốc (an toàn tuyệt đối).


---

## 🎯 Bài Tập 6: sort & uniq

```bash
# 1. Sắp xếp số theo thứ tự tăng dần
sort -n numbers.txt

# 2. Xóa các số trùng lặp
sort -n numbers.txt | uniq

# 3. Chỉ lấy các số DUY NHẤT (không bị trùng lặp)
sort -n numbers.txt | uniq -u

# 4. Chỉ lấy các số BỊ TRÙNG LẶP
sort -n numbers.txt | uniq -d

# 5. Số nào xuất hiện nhiều nhất?
sort -n numbers.txt | uniq -c | sort -rn | head -n 1
```

* **Nhật ký thực hành của bạn:**
  - `sort -n numbers.txt`: Sắp xếp dãy số đúng thứ tự `3, 17, 17, 23, 42, 42, 56, 89, 89, 100` (nhờ cờ `-n` nhận diện giá trị số học).
  - `sort -n | uniq`: Loại bỏ hoàn toàn số trùng lặp, chỉ còn danh sách rút gọn.
  - `uniq -u` (*Unique*): Tìm ra các số độc nhất: `3, 23, 56, 100`.
  - `uniq -d` (*Duplicate*): Tìm ra các số bị trùng lặp: `17, 42, 89`.
  - **Bài học cốt lõi**: `uniq` chỉ so sánh được các dòng kề nhau $\rightarrow$ Luôn phải `sort` trước khi qua `uniq`.


---

## 🏆 Thử Thách Cuối Module

```bash
# Câu 1: Dùng 1 pipeline, lấy danh sách tên tất cả Engineer, sắp xếp theo ABC và hiện ra
grep 'Engineer' users.csv | cut -d',' -f1 | sort
# Kết quả:
# Alice
# Frank

# Câu 2: Đếm có bao nhiêu dòng WARNING trong app.log mà liên quan đến số phần trăm (%)
grep "WARNING" app.log | grep "%" | wc -l
# Hoặc dùng Regex kết hợp:
grep -E "WARNING.*%" app.log | wc -l
# Kết quả: 2

# Câu 3: Tính tổng số ngày có lỗi ERROR (mỗi ngày tính 1 lần)
grep "ERROR" app.log | cut -c 1-10 | sort | uniq | wc -l
# Hoặc cut theo khoảng trắng:
grep "ERROR" app.log | cut -d' ' -f1 | sort | uniq | wc -l
# Kết quả: 4
```

* **Nhận xét & Phân tích giải pháp của bạn:**
  - **Câu 1**: Bạn đã lọc đúng `grep 'Engineer' users.csv`, chỉ cần nối thêm `| cut -d',' -f1 | sort` để rút gọn đúng cột tên và xếp A-Z.
  - **Câu 2**: Khi dùng `grep -E "WARNING| %"`, dấu `|` trong regex là phép **HOẶC** (tìm dòng có WARNING hoặc có %). Để tìm dòng có cả 2 điều kiện, cách chuẩn của pipeline là nối 2 lần grep: `grep "WARNING" | grep "%"` rồi đẩy qua `wc -l` để đếm.
  - **Câu 3**: Bạn có lời giải cực kỳ thông minh khi dùng `cut -c 1-10` (lấy đúng 10 ký tự ngày tháng `YYYY-MM-DD`), sau đó `| sort | uniq` để lọc ngày trùng và chỉ cần thêm `| wc -l` là ra đúng 4 ngày có lỗi!

---

## ✅ Checklist Hoàn Thành Module 03

- [x] Dùng được `grep` với các flag: `-i`, `-n`, `-v`, `-c`, `-r`, `-E`, `-C`
- [x] Biết dùng pipe `|` để kết nối nhiều lệnh thành pipeline xử lý dữ liệu
- [x] Dùng được `cut` để lấy cột dữ liệu (`-d`, `-f`, `-c`)
- [x] Dùng được `sort` (`-n`, `-r`, `-k`) và `uniq` (`-c`, `-u`, `-d`)
- [x] Dùng được `awk` để lọc theo điều kiện và tính toán số liệu
- [x] Dùng được `sed` để thay thế từ ngữ (`s/cũ/mới/g`) và lọc dòng (`d`, `p`)

👉 Hoàn thành bài tập thực hành Module 03! Sang [kiem_tra.md](./kiem_tra.md) để làm bài tự kiểm tra kiến thức!

