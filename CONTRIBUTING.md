# Hướng Dẫn Đóng Góp (Contributing Guide)

Chào mừng bạn đến với dự án học Linux Cơ Bản Thực Chiến! Mọi đóng góp về nội dung bài giảng, sửa lỗi chính tả, bổ sung ví dụ thực tế hoặc thêm bài tập mới đều rất được trân trọng.

---

## 🛠️ Quy Trình Đóng Góp

1. **Fork** repository này về tài khoản GitHub của bạn.
2. Tạo một nhánh (branch) mới cho tính năng hoặc sửa lỗi của bạn:
   ```bash
   git checkout -b feature/them-vi-du-moi
   ```
3. Thực hiện các chỉnh sửa, bổ sung nội dung.
4. Kiểm tra format markdown và tính chính xác của các câu lệnh.
5. Commit thay đổi với thông điệp rõ ràng theo chuẩn Conventional Commits:
   ```bash
   git commit -m "docs(module-03): bổ sung ví dụ awk thực tế"
   ```
6. Push nhánh của bạn lên GitHub:
   ```bash
   git push origin feature/them-vi-du-moi
   ```
7. Mở một **Pull Request (PR)** và mô tả ngắn gọn nội dung bạn vừa cải tiến.

---

## 💡 Tiêu Chuẩn Nội Dung
- **Giải thích vì sao trước khi giải thích như thế nào**: Tập trung vào bản chất và tư duy Linux.
- **Có ví dụ và ngữ cảnh thực tế**: Tránh các ví dụ mang tính hình thức, ưu tiên bài toán thực tế của Sysadmin/DevOps.
- **Giữ cấu trúc phẳng**: Mỗi bài học nằm gọn trong đúng 1 thư mục riêng biệt (`README.md`, `bai_tap.md`, `kiem_tra.md`).
