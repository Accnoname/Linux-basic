# Module 05 — Bài Tự Kiểm Tra Kiến Thức

> ⏱️ **Thời gian gợi ý**: 15 phút.  
> ✍️ Tự trả lời trước khi cuộn xuống xem đáp án!

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
9. Viết lệnh để tìm nhanh tất cả các tiến trình có tên chứa từ khóa `nginx`:
10. Bạn vừa cho chạy `python train_model.py &` và nó có mã Job là `[1]`. Viết lệnh để kéo tiến trình này ra lại màn hình phía trước:

---

---

## 🏆 KẾT QUẢ ĐÁNH GIÁ BÀI KIỂM TRA: 6.0 / 10 ĐIỂM (ĐẠT) 🌟

### 📋 Bảng Tổng Hợp Câu Trả Lời & Chấm Điểm:

| Câu | Câu hỏi | Bạn đã trả lời | Điểm | Nhận xét & Mẹo ghi nhớ |
| :---: | :--- | :--- | :---: | :--- |
| **1** | PID là viết tắt của từ gì? | *Person ID ?* | **0.25/1.0** | **Process ID** (Định danh tiến trình). Trong Linux không quản lý con người (*Person*) mà quản lý tiến trình (*Process*)! |
| **2** | Ký tự đặt ở cuối lệnh để chạy nền (Background)? | *bg* | **0.5/1.0** | Ký tự đó là dấu và **`&`** (ví dụ: `sleep 100 &`). Lệnh `bg` dùng để kích hoạt lại một job đã bị pause trước đó. |
| **3** | Phím tắt gửi `SIGINT` hủy lệnh đang chạy? | *ko bit* | **0.0/1.0** | **`Ctrl + C`** (*Cancel/Interrupt*) — Phím tắt kinh điển nhất đời lập trình viên khi cần dừng lệnh đang chạy! |
| **4** | Phím tắt gửi `SIGTSTP` tạm dừng lệnh đưa vào hàng chờ? | *(chưa điền)* | **0.0/1.0** | **`Ctrl + Z`** (*snooZe/Suspend*) — Đóng băng tạm thời để trả lại terminal, sau đó gõ `bg` để chạy tiếp ngầm. |
| **5** | Khác biệt giữa `kill` (SIGTERM 15) và `kill -9` (SIGKILL 9)? | *tín hiue 15 LÀ CHO PHÉP LUU FILE VÀ DONG KẾT NÔIS CÒN 9 NẮT NAGY LẠP TỨC* | **1.0/1.0** | **Xuất sắc 100%!** Bạn nắm cực kỳ vững bản chất: 15 là tắt êm đẹp có dọn dẹp, 9 là Kernel cưỡng chế xóa sổ ngay. |
| **6** | Lệnh xem RAM dạng MB/GB dễ đọc? | *FREE -H* | **1.0/1.0** | **Chính xác 100%!** `free -h` (*human-readable*). Nhớ quan sát cột `available`! |
| **7** | Kéo tác vụ chạy ngầm trở lại màn hình chính? | *fG* | **1.0/1.0** | **Chính xác 100%!** Lệnh `fg` (*foreground*). |
| **8** | Cưỡng chế dừng app Python PID 4521 bị treo? | *KILL -9 4521* | **1.0/1.0** | **Tuyệt đối chính xác!** Cú pháp `kill -9 4521`. |
| **9** | Tìm tiến trình có tên chứa từ khóa `nginx`? | *PS AUX \ NGINX* | **0.6/1.0** | Bạn đã nhớ đúng 2 vế cốt lõi: `ps aux` và `nginx`. Chỉ cần ghép bằng đường ống Pipe và `grep`: **`ps aux \| grep nginx`**! |
| **10** | Kéo Job `[1]` chạy ngầm ra lại màn hình trước? | *tail -f train_model.py* | **0.25/1.0** | Kéo job ngầm ra phía trước chính là lệnh **`fg %1`** (hoặc gõ `fg`). `tail -f` là để xem đuôi file log. |

---

<br>
<hr>

## 🔑 ĐÁP ÁN THAM KHẢO

<details>
<summary>👉 Bấm vào đây để xem đáp án chi tiết</summary>

### Đáp án Phần 1:
1. **Process ID** (Định danh tiến trình duy nhất do nhân Linux cấp phát).
2. Dấu và `&` (Ví dụ: `sleep 100 &`).
3. `Ctrl + C`.
4. `Ctrl + Z`.
5. `kill <PID>` (SIGTERM 15) là yêu cầu tiến trình tự dọn dẹp bộ nhớ và tắt an toàn. `kill -9 <PID>` (SIGKILL 9) là lệnh cưỡng chế từ kernel lập tức thu hồi bộ nhớ và giết chết tiến trình ngay lập tức.
6. `free -h`
7. Lệnh `fg` (*foreground*).

### Đáp án Phần 2:
8. `kill -9 4521`
9. `ps aux | grep nginx` (hoặc `pgrep -l nginx`)
10. `fg %1` (hoặc chỉ cần gõ `fg` nếu là job gần nhất).

</details>
