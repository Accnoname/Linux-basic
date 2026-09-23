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

10. Để kết nối SSH vào server từ xa không cần nhập mật khẩu, file chìa khóa công khai (*Public Key*) phải được đưa vào file nào trên server? Và file chìa khóa bí mật (*Private Key*) lưu trên máy bạn bắt buộc phải được phân quyền (chmod) là bao nhiêu để SSH client không từ chối kết nối?
```bash
# Câu trả lời:
```

---

## 🏆 KẾT QUẢ ĐÁNH GIÁ BÀI KIỂM TRA: 7.9 / 10 ĐIỂM (KHÁ GIỎI - ĐẠT CHUẨN) 🌟

### 📋 Bảng Tổng Hợp Câu Trả Lời & Chấm Điểm:

| Câu | Câu hỏi | Bạn đã trả lời | Điểm | Nhận xét chi tiết & Lời khuyên Mentor |
| :---: | :--- | :--- | :---: | :--- |
| **1** | Ping trên Linux chạy mãi hay dừng? Cần cờ nào để giới hạn? | *nếu ko dung flag thì wsl sẽ chỉ chạy 4 cái nhưng trong lunix ununtu sẽ chạy mãu dùn -c + số* | **0.9/1.0** | **Rất tốt!** Bạn nhớ chính xác cờ `-c + số`. *Ghi chú thêm*: Trên WSL (bản chất vẫn là Linux) nếu dùng lệnh `ping` của Linux thì vẫn chạy vô tận nhé, chỉ có `ping.exe` của Windows CMD mới dừng ở 4 gói! |
| **2** | Cổng mặc định của HTTP và HTTPS? | *công mặc đinh 127.0.0.1 https 443* | **0.5/1.0** | Bạn nhớ chuẩn cổng **HTTPS là 443**! Còn HTTP là cổng **80**. `127.0.0.1` là địa chỉ IP Localhost (nhà riêng) chứ không phải số cổng (cánh cửa). |
| **3** | Cổng chuẩn của giao thức SSH? | *TCP 22* | **1.0/1.0** | **Chính xác tuyệt đối!** Bạn nhớ cả giao thức tầng Transport là TCP port 22 rất chuyên nghiệp. |
| **4** | Lệnh hiện đại xem cổng lắng nghe thay `netstat`? | *ss -tlnp* | **1.0/1.0** | **Xuất sắc!** Lệnh `ss` (*Socket Statistics*) kèm bộ cờ kinh điển `-tlnp`. |
| **5** | File ánh xạ IP và domain local như file hosts của Windows? | *chịu* | **0.0/1.0** | Đó chính là file **`/etc/hosts`**! File này cực kỳ hay dùng khi làm web dev để map domain ảo `http://myproject.local` về IP máy mình. |
| **6** | Cờ `-O` / `-o` trong `wget` / `curl` có ý nghĩa gì? | *cơ hóa -0 đầu ra tin nhăsn cho FIle* | **1.0/1.0** | **Chính xác!** Đều là *Output File* (chỉ định tên file lưu về máy thay vì in thẳng ra màn hình terminal). |
| **7** | Viết lệnh ping đến 8.8.8.8 đúng 5 lần rồi tự ngắt? | `piing -c 5 8.8.8.8` | **1.0/1.0** | **Rất chuẩn!** `ping -c 5 8.8.8.8` (trừ lỗi gõ phím thừa 1 chữ i). |
| **8** | Dùng curl tải logo.png lưu thành my_logo.png? | `curl -0 my_logo.png https://example.com/logo.png` | **0.8/1.0** | **Đúng bản chất!** Chú ý cờ trong `curl` là chữ **`-o`** (*o thường*), bạn gõ nhầm số `0` (`-0` trong curl là ép dùng HTTP 1.0). Cú pháp chuẩn: `curl -o my_logo.png <URL>`. |
| **9** | Viết lệnh kiểm tra cổng 3000 đang listening? | `ss -tln \|grep 3000` | **1.0/1.0** | **Tuyệt đối chính xác 100%!** Kỹ năng lọc cổng bằng Pipe `| grep` cực kỳ mượt mà. |
| **10**| Đặt Public Key ở đâu trên server? Phân quyền Private Key trên máy là bao nhiêu? | *ssh + teen mieenf đc lư ~/.ssh/id_rsa.pub buoc pahr phn chomd 600* | **0.7/1.0** | **Rất giỏi!** Bạn nắm chắc quy tắc an ninh sống còn: Private Key bắt buộc phải **`chmod 600`**. Còn chiếc Public key mang sang server sẽ được gom vào file: **`~/.ssh/authorized_keys`**. |

---

<br><br>
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
10. Đưa Public Key vào file **`~/.ssh/authorized_keys`** trên server. Private Key trên máy cục bộ bắt buộc phải phân quyền **`600`** (`chmod 600 id_ed25519` - chỉ Owner được đọc/ghi).

</details>
