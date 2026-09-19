# Module 05 — Bài Tự Kiểm Tra Kiến Thức

> ⏱️ **Thời gian gợi ý**: 15 phút.  
> ✍️ Hãy làm trước khi xem đáp án ở cuối bài!

---

## 📝 PHẦN 1: TRẢ LỜI NHANH

1. PID trong quản lý tiến trình Linux là viết tắt của từ gì?
2. Ký tự nào đặt ở cuối câu lệnh để yêu cầu hệ điều hành chạy câu lệnh đó ở chế độ nền (Background)?
3. Phím tắt nào gửi tín hiệu `SIGINT` để ngắt ngay lệnh đang chạy?
4. Phím tắt nào gửi tín hiệu `SIGTSTP` để tạm dừng lệnh và đưa vào hàng chờ?
5. Sự khác nhau giữa `kill <PID>` (mặc định gửi tín hiệu 15 - SIGTERM) và `kill -9 <PID>` (gửi tín hiệu 9 - SIGKILL) là gì?
6. Lệnh nào giúp xem dung lượng RAM còn trống dạng dễ đọc (GB, MB)?
7. Lệnh nào giúp đưa một tác vụ đang chạy ngầm trở lại màn hình tương tác chính?

---

## 📝 PHẦN 2: THỰC HÀNH VIẾT LỆNH

8. Một ứng dụng Python có PID là `4521` bị treo cứng và không phản hồi lệnh `kill 4521`. Viết lệnh để bắt buộc hệ điều hành dừng ngay lập tức tiến trình này:
```bash
# Câu trả lời:
```

9. Viết lệnh để tìm nhanh tất cả các tiến trình có tên chứa từ khóa `nginx`:
```bash
# Câu trả lời:
```

10. Bạn vừa cho chạy `python train_model.py &` và nó có mã Job là `[1]`. Viết lệnh để kéo tiến trình này ra lại màn hình phía trước:
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
1. **Process ID** (Định danh tiến trình duy nhất do nhân Linux cấp phát).
2. Dấu và `&` (Ví dụ: `sleep 100 &`).
3. `Ctrl + C`.
4. `Ctrl + Z`.
5. `kill <PID>` (SIGTERM) là yêu cầu tiến trình tự dọn dẹp bộ nhớ và tắt an toàn (tiến trình có thể từ chối hoặc mất thời gian xử lý). `kill -9 <PID>` (SIGKILL) là lệnh bắt buộc do nhân kernel lập tức thu hồi bộ nhớ và giết chết tiến trình ngay lập tức, tiến trình không thể can thiệp hay chặn lại.
6. `free -h`
7. Lệnh `fg` (*foreground*).

### Đáp án Phần 2:
8. `kill -9 4521`
9. `ps aux | grep nginx` (hoặc `pgrep -l nginx`)
10. `fg %1` (hoặc chỉ cần gõ `fg` nếu là job gần nhất).

</details>
