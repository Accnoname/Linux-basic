# Module 03 — Bài Tự Kiểm Tra Kiến Thức

> ⏱️ **Thời gian gợi ý**: 20 phút.  
> ✍️ Trả lời trước khi xem đáp án ở phía dưới!

---

## 📝 PHẦN 1: TRẢ LỜI NHANH (10 CÂU)

1. Dấu gạch đứng `|` (Pipe) trong Linux có chức năng cơ bản là gì?
2. Sự khác biệt giữa `head -n 5 file.txt` và `tail -n 5 file.txt` là gì?
3. Muốn theo dõi file log đang được ghi liên tục theo thời gian thực (realtime), bạn dùng flag nào của lệnh `tail`?
4. Lệnh nào đếm số dòng, số từ và số byte của một file?
5. Trong lệnh `grep`, flag nào dùng để tìm kiếm **không phân biệt chữ hoa chữ thường**?
6. Flag `-v` trong lệnh `grep` dùng để làm gì?
7. Lệnh `uniq` chỉ hoạt động chính xác khi các dòng trùng lặp đứng cạnh nhau. Do đó, trước khi dùng `uniq`, ta luôn phải kết hợp với lệnh nào qua pipe?
8. Ký tự nào đại diện cho luồng đầu ra tiêu chuẩn (Standard Output - stdout) và chuyển hướng nó vào file?
9. Lệnh nào dùng để trích xuất cột thứ 2 trong một file CSV ngăn cách bằng dấu phẩy: `cut` hay `awk`? (Viết lệnh tương ứng).
10. Phím tắt nào giúp thoát khỏi lệnh đang theo dõi log bằng `tail -f`?

---

## 📝 PHẦN 2: THỬ THÁCH VIẾT LỆNH PIPELINE

11. Viết một lệnh pipeline để tìm tất cả các dòng chứa chữ `ERROR` trong file `server.log`, sau đó đếm xem có bao nhiêu dòng như vậy:
```bash
# Câu trả lời:
```

12. Viết một lệnh pipeline để lấy 10 địa chỉ IP xuất hiện nhiều nhất trong file `access.log` và sắp xếp từ nhiều đến ít nhất:
```bash
# Câu trả lời:
```

13. Viết lệnh dùng `sed` để thay thế tất cả chữ `http://` thành `https://` trong file `config.env`:
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
1. Lấy đầu ra (stdout) của lệnh phía trước làm đầu vào (stdin) cho lệnh phía sau.
2. `head -n 5` lấy 5 dòng **đầu tiên**, `tail -n 5` lấy 5 dòng **cuối cùng** của file.
3. `tail -f` (*follow*).
4. `wc` (Word Count). Dùng `wc -l` để đếm riêng số dòng.
5. Flag `-i` (*ignore case*).
6. In ra các dòng **KHÔNG chứa** từ khóa tìm kiếm (*invert match*).
7. Lệnh `sort` (Ví dụ: `sort file.txt | uniq`).
8. Ký tự `>` (ghi đè) hoặc `>>` (ghi nối tiếp).
9. Cả hai đều được:
   - Dùng `cut`: `cut -d',' -f2 file.csv`
   - Dùng `awk`: `awk -F',' '{print $2}' file.csv`
10. Tổ hợp phím `Ctrl + C`.

### Đáp án Phần 2:
11. `grep "ERROR" server.log | wc -l` (hoặc `grep -c "ERROR" server.log`).
12. `awk '{print $1}' access.log | sort | uniq -c | sort -nr | head -10`
13. `sed -i 's/http:\/\//https:\/\//g' config.env`

</details>
