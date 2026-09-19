# Module 08 — Bài Tự Kiểm Tra Kiến Thức

> ⏱️ **Thời gian gợi ý**: 15 phút.  
> ✍️ Làm bài trước khi xem đáp án!

---

## 📝 PHẦN 1: TRẢ LỜI NHANH VỀ VIM

1. Để chuyển từ chế độ Normal mode sang Insert mode để bắt đầu gõ văn bản trong Vim, bạn bấm phím nào?
2. Để thoát khỏi chế độ Insert mode quay về Normal mode, bạn bấm phím nào?
3. Trong Normal mode, tổ hợp phím nào giúp xóa toàn bộ dòng hiện tại?
4. Lệnh nào trong Command mode (`:`) để lưu file và thoát khỏi Vim cùng lúc?
5. Nếu bạn chỉnh sửa nhầm và muốn thoát ngay lập tức mà **KHÔNG lưu lại** những thay đổi đó, bạn gõ lệnh gì?

---

## 📝 PHẦN 2: BIẾN MÔI TRƯỜNG & ALIAS

6. Biến môi trường `$PATH` có vai trò gì khi bạn gõ một câu lệnh trong terminal?
7. Lệnh `alias la='ls -A'` nếu chỉ gõ trực tiếp trên terminal thì có tồn tại sau khi bạn tắt cửa sổ terminal đó không?
8. Muốn các alias hoặc biến môi trường luôn có hiệu lực mỗi khi mở terminal mới, bạn phải lưu chúng vào file nào trong thư mục cá nhân?
9. Lệnh nào giúp nạp lại cấu hình file `.bashrc` ngay lập tức mà không cần tắt mở lại cửa sổ terminal?

---

<br><br><br>
<hr>

## 🔑 ĐÁP ÁN THAM KHẢO

<details>
<summary>👉 Bấm vào đây để xem đáp án chi tiết</summary>

### Đáp án Phần 1:
1. Phím `i` (insert) hoặc `a` (append), `o` (open newline).
2. Phím `Esc`.
3. Phím `dd`.
4. `:wq` (hoặc phím tắt `ZZ`).
5. `:q!` (Quit kèm dấu chấm than bắt buộc).

### Đáp án Phần 2:
6. `$PATH` chứa danh sách các thư mục ngăn cách bởi dấu hai chấm `:`. Khi bạn gõ một lệnh (như `git` hay `python`), hệ điều hành sẽ lần lượt tìm kiếm file thực thi của lệnh đó trong các thư mục được khai báo trong `$PATH`.
7. **KHÔNG**. Nó chỉ có hiệu lực tạm thời trong phiên làm việc (session) đó.
8. File `~/.bashrc` (hoặc `~/.bash_profile`).
9. `source ~/.bashrc` (hoặc `. ~/.bashrc`).

</details>
