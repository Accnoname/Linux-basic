# Module 07 — Bài Tự Kiểm Tra Kiến Thức

> ⏱️ **Thời gian gợi ý**: 20 phút.  
> ✍️ Trả lời trước khi xem đáp án!

---

## 📝 PHẦN 1: TRẢ LỜI NHANH

1. Dòng đầu tiên `#!/bin/bash` trong một script được gọi là gì? Nó có tác dụng gì?
```bash
# Bạn đã trả lời:
câu 1 lên #! #!/bin/bash gióng như khai bao fra ng tôi dang sử dụng bash à ?
```

2. Biến `$1` trong script đại diện cho điều gì? Còn `$#` đại diện cho điều gì?
```bash
# Bạn đã trả lời:
2 $1 đại duẹn #1 có 1 tham số tryen bào # nhieu tham so ko giới han
```

3. Biến `$?` lưu trữ giá trị gì sau khi một lệnh chạy xong? Nếu lệnh chạy thành công thì `$?` bằng bao nhiêu?
```bash
# Bạn đã trả lời:
3 #? kiêm tra xem có lõi thưc thicac câu lên ko lêu cahyj thanh cong #? =0
```

4. Trong câu lệnh `if [ -f "$file" ]`, cờ `-f` dùng để kiểm tra điều gì? Cờ `-d` kiểm tra điều gì?
```bash
# Bạn đã trả lời:
câu 4 ciw f -f kielr tra xem có pahri giel thong thườngko -d là kiẻm tra đo cso ppahrithuw mục ko
```

5. Khi gán giá trị cho biến trong Bash (ví dụ: `NAME="Alice"`), có được phép để khoảng trắng quanh dấu `=` (như `NAME = "Alice"`) không?
```bash
# Bạn đã trả lời:
5 ko rõ vè th mtm
```

6. Phím tắt hoặc câu lệnh nào cấp quyền thực thi cho file script trước khi chạy?
```bash
# Bạn đã trả lời:
6 ./[ếncpr}
```

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
```bash
# Bạn đã trả lời:
câu 7 ; sai fi pahri la dỏn
```

8. Viết một script ngắn gọn (3-5 dòng) nhận vào tên một thư mục từ tham số `$1`. Nếu thư mục đó chưa tồn tại thì tự động tạo nó bằng `mkdir -p`:
```bash
# Bạn đã trả lời:
[[ ! -d "$1" ]] && mkdir -p "$1"
```

9. Viết một vòng lặp `for` in ra các số từ 1 đến 5:
```bash
# Bạn đã trả lời:
for i in {1..5}; do
    echo $i
done
```

---

## 🏆 KẾT QUẢ ĐÁNH GIÁ BÀI KIỂM TRA: 7.5 / 10 ĐIỂM (KHÁ GIỎI - ĐẠT CHUẨN) 🌟

### 📋 Bảng Tổng Hợp Câu Trả Lời & Chấm Điểm:

| Câu | Câu hỏi | Bạn đã trả lời | Điểm | Nhận xét chi tiết & Lời khuyên Mentor |
| :---: | :--- | :--- | :---: | :--- |
| **1** | `#!/bin/bash` gọi là gì? Tác dụng? | *gióng như khai bao fra ng tôi dang sử dụng bash* | **0.9/1.0** | **Chính xác bản chất!** Dòng này gọi là **Shebang** (hoặc hashbang), dùng để chỉ định trình thông dịch `bash` thực thi script này. |
| **2** | Biến `$1` và `$#` là gì? | *1 đại duẹn có 1 tham số tryen bào # nhieu tham so ko giới han* | **0.85/1.0** | **Rất tốt!** Bạn nhớ đúng: `$1` là tham số đầu tiên, còn `$#` là biến lưu **tổng số lượng** tham số được truyền vào (ví dụ truyền 3 từ thì `$# = 3`). |
| **3** | `$?` lưu gì? Thành công thì bằng mấy? | *kiêm tra xem có lõi thưc thicac câu lên ko lêu cahyj thanh cong #? =0* | **1.0/1.0** | **Tuyệt đối chính xác!** `$?` lưu mã thoát (*Exit Code*). Thành công thì luôn là số **`0`**, có lỗi thì khác `0`. |
| **4** | Cờ `-f` và `-d` trong `if` kiểm tra gì? | *-f kiểm tra file thông thường, -d là kiểm tra thư mục* | **1.0/1.0** | **Xuất sắc 100%!** Nắm rất chắc bộ cờ thẩm định đường dẫn (`-f` = File, `-d` = Directory). |
| **5** | Gán biến có được để khoảng trắng quanh dấu `=` không? | *ko rõ* | **0.0/1.0** | **TUYỆT ĐỐI KHÔNG ĐƯỢC CÓ KHOẢNG TRẮNG!** Viết `NAME="Alice"` là đúng, nếu viết `NAME = "Alice"` Bash sẽ hiểu nhầm `NAME` là một lệnh và báo lỗi `command not found`. |
| **6** | Lệnh nào cấp quyền thực thi cho script trước khi chạy? | *./[ếncpr}* | **0.3/1.0** | Câu lệnh cấp quyền thực thi là: **`chmod +x <tên_file>.sh`**! Còn cú pháp `./<tên_file>.sh` là lệnh để *kích hoạt chạy* sau khi đã cấp quyền `+x`. |
| **7** | Đoạn code so sánh `COUNT` có lỗi gì? | *sai fi pahri la dỏn* | **0.4/1.0** | Đoạn code có **2 lỗi chết người**: <br>1. `COUNT = 10` (sai vì có khoảng trắng quanh dấu `=`). <br>2. `[ $COUNT > 5 ]` (sai vì trong `[ ]` so sánh số phải dùng **`-gt`**, dùng `>` sẽ bị hiểu nhầm thành ghi file đè!). Sửa chuẩn: `COUNT=10` và `[ "$COUNT" -gt 5 ]`. |
| **8** | Viết script nhận `$1`, nếu chưa có thư mục thì tạo? | `[[ ! -d "$1" ]] && mkdir -p "$1"` | **1.0/1.0** | **ĐẲNG CẤP! 🔥** Bạn viết cú pháp *One-liner Short-circuit* của dân chuyên nghiệp cực kỳ ngắn gọn và chính xác 100%! |
| **9** | Viết vòng lặp `for` từ 1 đến 5? | `for i in {1..5}; do echo $i; done` | **1.0/1.0** | **Chính xác tuyệt đối 100%!** Sử dụng dải số `{1..5}` chuẩn Bash hiện đại rất gọn gàng. |

---

<br><br>
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
# Hoặc one-liner:
[[ ! -d "$1" ]] && mkdir -p "$1"
```
9. Vòng lặp `for`:
```bash
for i in {1..5}; do
    echo "Số: $i"
done
```

</details>
