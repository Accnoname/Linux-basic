# Module 04 — Bài Tự Kiểm Tra Kiến Thức

> ⏱️ **Thời gian gợi ý**: 15 phút.  
> ✍️ Tự trả lời trước khi cuộn xuống xem đáp án!

---

## 📝 PHẦN 1: TÍNH TOÁN QUYỀN TRUY CẬP

1. Hãy quy đổi các quyền dạng chuỗi sau sang mã số (octal):
   - `rwxr-xr-x` = `___`
   - `rw-r--r--` = `___`
   - `rw-------` = `___`
   - `rwxrwxrwx` = `___`

2. Hãy viết chuỗi ký tự tương ứng với các mã số sau:
   - `750` = `___________`
   - `600` = `___________`
   - `777` = `___________`

---

## 📝 PHẦN 2: CÂU HỎI HIỂU BẢN CHẤT

3. Tại sao trong môi trường sản xuất (Production Server), việc gán quyền `chmod 777` cho thư mục hoặc file mã nguồn web lại bị coi là điều cấm kỵ?
4. Đối với một thư mục, nếu người dùng chỉ có quyền `r` (Read) mà không có quyền `x` (Execute), điều gì sẽ xảy ra khi họ thực hiện lệnh `cd` vào thư mục đó?
5. Lệnh nào dùng để thay đổi **chủ sở hữu (owner)** của một file từ user `alice` sang `bob`?
6. Để cấp thêm quyền thực thi cho tất cả mọi người đối với file `run.sh` bằng ký tự, bạn gõ lệnh nào?
7. Sự khác biệt giữa tài khoản thường chạy lệnh với tiền tố `sudo` và việc đăng nhập hẳn vào tài khoản `root` là gì?

---

<br><br><br>
<hr>

## 🔑 ĐÁP ÁN THAM KHẢO

<details>
<summary>👉 Bấm vào đây để xem đáp án chi tiết</summary>

### Đáp án Phần 1:
1. Quy đổi sang số:
   - `rwxr-xr-x` = **755** (7: đọc+ghi+chạy, 5: đọc+chạy, 5: đọc+chạy)
   - `rw-r--r--` = **644** (6: đọc+ghi, 4: chỉ đọc, 4: chỉ đọc)
   - `rw-------` = **600** (6: đọc+ghi, 0: không quyền, 0: không quyền)
   - `rwxrwxrwx` = **777** (tất cả mọi người đều có toàn quyền)
2. Quy đổi sang ký tự:
   - `750` = `rwxr-x---`
   - `600` = `rw-------`
   - `777` = `rwxrwxrwx`

### Đáp án Phần 2:
3. `chmod 777` cho phép bất kỳ ai (kể cả kẻ tấn công qua mạng hoặc các tiến trình mã độc) đều có thể sửa đổi, chèn mã độc hại hoặc xóa file. Đây là lỗ hổng bảo mật cực kỳ nghiêm trọng.
4. Người dùng sẽ bị báo lỗi `Permission denied` và **không thể vào thư mục (`cd`)**, cũng không thể đọc nội dung các file bên trong thư mục đó. Quyền `x` trên thư mục là điều kiện bắt buộc để duyệt (traverse).
5. `sudo chown bob ten_file`
6. `chmod +x run.sh` (hoặc `chmod a+x run.sh`).
7. Dùng `sudo` giúp ghi lại nhật ký hành động (audit log) trong `/var/log/auth.log`, chỉ cấp quyền quản trị tạm thời cho lệnh đó rồi thôi, hạn chế việc gõ nhầm lệnh hủy diệt hệ thống khi liên tục đứng ở quyền `root`.

</details>
