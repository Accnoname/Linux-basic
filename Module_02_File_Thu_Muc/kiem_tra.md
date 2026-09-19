# Module 02 — Bài Tự Kiểm Tra Kiến Thức

> ⏱️ **Thời gian gợi ý**: 15 phút.  
> ✍️ Hãy tự làm trước khi xem đáp án ở cuối bài!

---

## 📝 PHẦN 1: TRẢ LỜI NHANH

1. Lệnh nào tạo thư mục lồng nhau nhiều cấp cùng lúc (ví dụ: `du_an/src/components`)? Flag nào được dùng?
2. Sự khác biệt cơ bản giữa toán tử `>` và `>>` khi ghi file bằng `echo` là gì?
3. Khi sao chép một thư mục bằng lệnh `cp`, bạn bắt buộc phải thêm cờ (flag) nào?
4. Trong Linux, lệnh `rm` xóa file thì file đó có vào Thùng rác (Recycle Bin) không?
5. Ký tự đại diện (wildcard) `*` đại diện cho điều gì? Ví dụ `rm *.log` sẽ làm gì?
6. Để đổi tên file `old.txt` thành `new.txt`, bạn dùng lệnh nào?
7. Khi dùng `rm -rf`, chữ `r` và chữ `f` viết tắt của từ gì?
8. Lệnh nào giúp tìm kiếm tất cả các file có đuôi `.txt` trong toàn bộ thư mục hiện tại và các thư mục con?

---

## 📝 PHẦN 2: VIẾT LỆNH THỰC HÀNH

9. Viết một lệnh để tạo 3 file rỗng cùng một lúc: `app.js`, `style.css`, `index.html`.
```bash
# Câu trả lời:
```

10. Viết lệnh sao chép toàn bộ thư mục `du_lieu/` sang một bản sao lưu tên là `du_lieu_backup/`.
```bash
# Câu trả lời:
```

11. Viết lệnh tìm tất cả các file có đuôi `.log` được sửa đổi trong vòng 7 ngày qua trong thư mục `/var/log`.
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
1. `mkdir -p du_an/src/components` (cờ `-p` là *parents*).
2. `>` ghi đè toàn bộ nội dung file (nếu file chưa có thì tạo mới). `>>` ghi nối tiếp vào cuối file mà không làm mất nội dung cũ.
3. Cờ `-r` hoặc `-R` (*recursive* - đệ quy). Nếu không có cờ này, lệnh `cp` sẽ báo lỗi bỏ qua thư mục.
4. **KHÔNG**. Lệnh `rm` trong Linux xóa vĩnh viễn khỏi filesystem, không thể khôi phục từ thùng rác.
5. Ký tự `*` đại diện cho 0 hoặc nhiều ký tự bất kỳ. `rm *.log` sẽ xóa tất cả các file kết thúc bằng `.log`.
6. Lệnh `mv old.txt new.txt` (Move vừa dùng để di chuyển, vừa dùng để đổi tên).
7. `r` = *recursive* (đệ quy toàn bộ thư mục con), `f` = *force* (bắt buộc xóa, không hỏi xác nhận, bỏ qua lỗi).
8. `find . -name "*.txt"`

### Đáp án Phần 2:
9. `touch app.js style.css index.html`
10. `cp -r du_lieu/ du_lieu_backup/`
11. `find /var/log -name "*.log" -mtime -7`

</details>
