# Module 01 — Bài Tự Kiểm Tra Kiến Thức

> ⏱️ **Thời gian gợi ý**: 15 phút.  
> ✍️ Hãy tự trả lời trước ra giấy hoặc nháp trước khi cuộn xuống xem đáp án!

---

## 📝 PHẦN 1: TRẢ LỜI NHANH (10 CÂU)

1. Lệnh nào hiển thị đường dẫn thư mục bạn đang đứng hiện tại?
2. Ký tự `~` trong Linux đại diện cho đường dẫn nào?
3. Để hiển thị cả file ẩn và xem dung lượng dạng KB/MB trong `ls`, bạn dùng kết hợp những flag nào?
4. Ký tự đại diện cho thư mục cha (lên 1 cấp) là gì?
5. Đường dẫn bắt đầu bằng dấu `/` là đường dẫn **tuyệt đối** hay **tương đối**?
6. Khi xem chi tiết bằng `ls -l`, ký tự đầu tiên là `d` có nghĩa là gì?
7. Muốn quay lại thư mục bạn vừa đứng trước đó ngay lập tức, bạn gõ lệnh `cd` với tham số gì?
8. Muốn thoát khỏi màn hình xem hướng dẫn `man`, bạn bấm phím gì?
9. Thư mục `/etc` trong hệ thống Linux dùng để chứa nội dung gì?
10. Trong WSL, ổ đĩa `C:` của Windows được gắn (mount) ở đường dẫn nào?

---

## 📝 PHẦN 2: THỰC HÀNH VIẾT LỆNH

11. Viết một lệnh duy nhất để liệt kê chi tiết các file trong `/var/log`, hiển thị file ẩn và dung lượng dễ đọc:
```bash
# Câu trả lời của bạn:
```

12. Bạn đang ở `/tmp/test/abc`. Hãy viết 2 cách khác nhau để di chuyển về thư mục Home của bạn:
```bash
# Cách 1:
# Cách 2:
```

13. Phân tích cấu trúc của lệnh sau: `ls -la /home`
- Đâu là command (lệnh)?
- Đâu là flag (tùy chọn)?
- Đâu là argument (đối số)?

---

<br><br><br>
<hr>

## 🔑 ĐÁP ÁN THAM KHẢO

<details>
<summary>👉 Bấm vào đây để xem đáp án chi tiết</summary>

### Đáp án Phần 1:
1. `pwd` (Print Working Directory).
2. Thư mục Home của user hiện tại (`/home/tên_user/`).
3. `ls -lah` (hoặc `-lh -a`).
4. `..` (hai dấu chấm liên tiếp).
5. Đường dẫn **tuyệt đối** (bắt đầu từ gốc Root).
6. Đó là một **thư mục** (Directory). Nếu là file bình thường thì ký tự đầu là dấu gạch ngang `-`.
7. `cd -`
8. Phím `q` (viết tắt của Quit).
9. Chứa toàn bộ các file **cấu hình hệ thống** (configuration files).
10. `/mnt/c/`

### Đáp án Phần 2:
11. `ls -lah /var/log`
12. 
   - Cách 1: `cd ~`
   - Cách 2: `cd` (gõ `cd` không kèm đối số sẽ tự động về Home)
   - Cách 3: `cd /home/$USER`
13. Phân tích:
   - Command: `ls` (lệnh liệt kê)
   - Flag: `-la` (gồm 2 cờ: `-l` hiện chi tiết, `-a` hiện file ẩn)
   - Argument: `/home` (đối tượng chịu tác động của lệnh)

</details>
