# Module 06 — Bài Tự Kiểm Tra Kiến Thức

> ⏱️ **Thời gian gợi ý**: 15 phút.  
> ✍️ Làm bài trước khi xem đáp án!

---

## 📝 PHẦN 1: TRẢ LỜI NHANH

1. Trong lệnh `ping google.com`, nếu không chỉ định flag thì trên Linux lệnh này sẽ dừng lại hay chạy mãi mãi? Cần dùng flag nào để chỉ định số lần ping?
2. Cổng mặc định của giao thức HTTP là bao nhiêu? Cổng của HTTPS là bao nhiêu?
3. Cổng chuẩn của giao thức SSH để điều khiển server từ xa là bao nhiêu?
4. Lệnh nào hiện đại và nhanh hơn để xem các cổng đang lắng nghe (thay thế cho lệnh `netstat` cũ)?
5. File nào trong Linux đóng vai trò ánh xạ (mapping) trực tiếp giữa IP và tên miền trên máy cục bộ (tương tự file hosts trong Windows)?
6. Cờ `-O` (chữ O hoa) trong `wget` hoặc `-o` (o thường) trong `curl` có ý nghĩa gì?

---

## 📝 PHẦN 2: THỰC HÀNH VIẾT LỆNH

7. Viết lệnh ping đến địa chỉ `8.8.8.8` đúng 5 lần rồi tự động ngắt:
```bash
# Câu trả lời:
```

8. Viết lệnh dùng `curl` để tải một file ảnh từ đường link `https://example.com/logo.png` và lưu về máy với tên `my_logo.png`:
```bash
# Câu trả lời:
```

9. Viết lệnh kiểm tra xem cổng `3000` trên máy hiện tại có đang được ứng dụng nào sử dụng (listening) hay không:
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
1. Chạy mãi mãi không dừng (khác với Windows chỉ ping 4 lần). Cần dùng flag `-c <số_lần>` (*count*).
2. HTTP là cổng **80**, HTTPS là cổng **443**.
3. Cổng SSH mặc định là **22**.
4. Lệnh `ss` (Socket Statistics), thường dùng với cờ `ss -tlnp`.
5. File `/etc/hosts`.
6. Chỉ định tên file lưu về máy thay vì in thẳng ra màn hình hoặc dùng tên mặc định.

### Đáp án Phần 2:
7. `ping -c 5 8.8.8.8`
8. `curl -o my_logo.png https://example.com/logo.png`
9. `ss -tln | grep 3000` (hoặc `lsof -i :3000`)

</details>
