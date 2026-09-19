# Module 09 — Checklist & Bài Tập Dự Án Cuối Khóa

> 🎯 **Mục tiêu**: Tự tay triển khai từng thành phần của hệ thống Giám Sát & Quản Trị Server theo hướng dẫn trong [README.md](file:///d:/Linux%20basic/Module_09_Du_An_Thuc_Te/README.md).

---

## 📋 BẢNG THEO DÕI TIẾN ĐỘ THỰC HIỆN

Hãy đánh dấu `[x]` khi bạn hoàn thành từng giai đoạn:

- [ ] **Giai đoạn 1: Khởi tạo cấu trúc**
  - [ ] Tạo thư mục `~/server_manager` với đầy đủ các thư mục con.
  - [ ] Tạo file cấu hình `settings.conf`.

- [ ] **Giai đoạn 2: Script Giám sát (`monitor.sh`)**
  - [ ] Lấy được % CPU đang sử dụng.
  - [ ] Lấy được % RAM đang sử dụng.
  - [ ] Lấy được % Ổ cứng (`df -h`).
  - [ ] Ghi nhận vào file log kèm timestamp `YYYY-MM-DD HH:MM:SS`.
  - [ ] Đổi quyền thực thi `chmod +x monitor.sh`.

- [ ] **Giai đoạn 3: Script Tự động sao lưu (`backup.sh`)**
  - [ ] Nén dữ liệu nguồn thành file `.tar.gz`.
  - [ ] Đặt tên file backup có chứa ngày giờ tạo.
  - [ ] Tự động xóa các bản sao lưu cũ quá 7 ngày.

- [ ] **Giai đoạn 4: Lập lịch tác vụ tự động với Cron**
  - [ ] Đặt lịch chạy `monitor.sh` mỗi 5 phút một lần.
  - [ ] Đặt lịch chạy `backup.sh` vào lúc 2:00 sáng hàng ngày.
  - [ ] Kiểm tra lịch bằng lệnh `crontab -l`.

---

## 🏆 TỰ ĐÁNH GIÁ KẾT QUẢ DỰ ÁN

| Tiêu chí | Đạt yêu cầu | Cần cải thiện |
| :--- | :---: | :---: |
| Script chạy mượt mà, không báo lỗi cú pháp | [ ] | [ ] |
| Cấu trúc code sạch sẽ, có comment giải thích rõ ràng | [ ] | [ ] |
| Xử lý tốt các trường hợp lỗi (ví dụ: thư mục không tồn tại) | [ ] | [ ] |
| Định dạng log chuyên nghiệp, dễ đọc | [ ] | [ ] |

🎉 **Khi hoàn thành checklist này, bạn đã hoàn toàn tốt nghiệp khóa học Linux cơ bản và sẵn sàng làm việc thực tế!**
