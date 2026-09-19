# Module 07 — Bài Tự Kiểm Tra Kiến Thức

> ⏱️ **Thời gian gợi ý**: 20 phút.  
> ✍️ Trả lời trước khi xem đáp án!

---

## 📝 PHẦN 1: TRẢ LỜI NHANH

1. Dòng đầu tiên `#!/bin/bash` trong một script được gọi là gì? Nó có tác dụng gì?
2. Biến `$1` trong script đại diện cho điều gì? Còn `$#` đại diện cho điều gì?
3. Biến `$?` lưu trữ giá trị gì sau khi một lệnh chạy xong? Nếu lệnh chạy thành công thì `$?` bằng bao nhiêu?
4. Trong câu lệnh `if [ -f "$file" ]`, cờ `-f` dùng để kiểm tra điều gì? Cờ `-d` kiểm tra điều gì?
5. Khi gán giá trị cho biến trong Bash (ví dụ: `NAME="Alice"`), có được phép để khoảng trắng quanh dấu `=` (như `NAME = "Alice"`) không?
6. Phím tắt hoặc câu lệnh nào cấp quyền thực thi cho file script trước khi chạy?

---

## 📝 PHẦN 2: ĐỌC VÀ VIẾT CODE

7. Đoạn code sau có lỗi gì?
```bash
#!/bin/bash
COUNT = 10
if [ $COUNT > 5 ]; then
    echo "Lon hon"
fi
```

8. Viết một script ngắn gọn (3-5 dòng) nhận vào tên một thư mục từ tham số `$1`. Nếu thư mục đó chưa tồn tại thì tự động tạo nó bằng `mkdir -p`:
```bash
# Câu trả lời:
```

9. Viết một vòng lặp `for` in ra các số từ 1 đến 5:
```bash
# Câu trả lời:
```

---

<br><br><br>
<hr>

## 🔑 ĐÁP ÁN THAM KHẢO

<details>
<summary>👉 Bấm vào đây để xem đáp án chi tiết</summary>

### Đáp án Phần 1:
1. Được gọi là **Shebang** (hoặc Hashbang). Nó báo cho hệ điều hành biết chương trình thông dịch nào (ở đây là `/bin/bash`) sẽ được dùng để thực thi script này.
2. `$1` là **tham số đầu tiên** truyền vào khi chạy script. `$#` là **tổng số lượng tham số** được truyền vào.
3. `$?` lưu **Exit Code (Mã thoát)** của lệnh vừa chạy. Nếu thành công thì `$? = 0`, nếu có lỗi thì `$? != 0` (thường từ 1 đến 255).
4. `-f` kiểm tra đường dẫn có tồn tại và là **file thông thường** (regular file) không. `-d` kiểm tra có là **thư mục** (directory) không.
5. **TUYỆT ĐỐI KHÔNG ĐƯỢC CÓ KHOẢNG TRẮNG**. `NAME="Alice"` là đúng, `NAME = "Alice"` sẽ bị Bash hiểu lầm `NAME` là một lệnh.
6. `chmod +x ten_script.sh`

### Đáp án Phần 2:
7. Các lỗi:
   - `COUNT = 10`: Không được có khoảng trắng quanh dấu `=`. Sửa thành `COUNT=10`.
   - `[ $COUNT > 5 ]`: Trong ngoặc vuông đơn `[ ]`, toán tử so sánh số nguyên phải dùng `-gt` (*greater than*), vì dấu `>` bị hiểu là chuyển hướng file! Sửa thành `[ "$COUNT" -gt 5 ]`.
8. Script chuẩn:
```bash
#!/bin/bash
DIR="$1"
if [ ! -d "$DIR" ]; then
    mkdir -p "$DIR"
    echo "Đã tạo thư mục: $DIR"
fi
```
9. Vòng lặp `for`:
```bash
for i in {1..5}; do
    echo "Số: $i"
done
```

</details>
