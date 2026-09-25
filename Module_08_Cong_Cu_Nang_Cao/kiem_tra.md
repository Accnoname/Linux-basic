# Module 08 — Bài Tự Kiểm Tra Kiến Thức (Vim, Tmux, Môi Trường & Pipeline)

> ⏱️ **Thời gian gợi ý**: 20 phút.  
> ✍️ Hãy tự trả lời các câu hỏi dưới đây trước khi đối chiếu đáp án và nhận đánh giá từ Mentor!

---

## 📝 PHẦN 1: TRÌNH SOẠN THẢO VIM

1. Để chuyển từ chế độ Normal mode sang Insert mode để bắt đầu gõ văn bản trong Vim, bạn bấm phím nào?
```bash
# Bạn đã trả lời:

```

2. Để thoát khỏi chế độ Insert mode quay về Normal mode, bạn bấm phím nào?
```bash
# Bạn đã trả lời:

```

3. Trong Normal mode, tổ hợp phím nào giúp bạn sao chép (copy) cả dòng hiện tại, và phím nào để dán (paste) xuống dưới?
```bash
# Bạn đã trả lời:

```

4. Lệnh nào trong Command mode (`:`) để lưu file và thoát khỏi Vim cùng lúc? Còn nếu muốn thoát NGAY LẬP TỨC mà **KHÔNG lưu lại** những gì đã sửa, bạn gõ lệnh gì?
```bash
# Bạn đã trả lời:

```

5. Trong Vim, cú pháp Command mode nào cho phép tìm và thay thế tất cả các từ `staging` thành `production` trên toàn bộ file?
```bash
# Bạn đã trả lời:

```

---

## 📝 PHẦN 2: QUẢN LÝ TIẾN TRÌNH ĐA NHIỆM TMUX

6. Khi đang làm việc qua SSH trên máy chủ, tại sao kỹ sư DevOps thường tạo phiên làm việc trong `tmux` thay vì chạy trực tiếp trên terminal ngoài? Tổ hợp phím nào dùng để tách (Detach) khỏi session mà vẫn giữ tiến trình chạy ngầm?
```bash
# Bạn đã trả lời:

```

7. Trong Tmux, phím tắt tiền tố (prefix) mặc định là gì? Khi muốn chia đôi màn hình theo chiều dọc (trái/phải) và theo chiều ngang (trên/dưới), bạn bấm phím gì?
```bash
# Bạn đã trả lời:

```

---

## 📝 PHẦN 3: BIẾN MÔI TRƯỜNG, ALIAS & TỐI ƯU SHELL

8. Biến môi trường `$PATH` có vai trò gì khi bạn gõ một câu lệnh trong terminal? Điểm khác biệt giữa việc khai báo biến cục bộ `VAR="abc"` và biến môi trường `export VAR="abc"` là gì?
```bash
# Bạn đã trả lời:

```

9. Bạn gõ lệnh `alias ll='ls -la'` trực tiếp trên cửa sổ terminal. Khi tắt cửa sổ terminal đó đi và mở lại, lệnh `ll` còn hoạt động không? Muốn lệnh này tồn tại vĩnh viễn, bạn phải làm gì? Lệnh nào giúp nạp lại cấu hình ngay mà không cần khởi động lại máy?
```bash
# Bạn đã trả lời:

```

---

## 📝 PHẦN 4: PIPELINE & CÔNG CỤ NÂNG CAO (`find`, `jq`, `diff`, `xargs`)

10. Bạn hãy nêu ngắn gọn tác dụng của ít nhất 2 trong 4 công cụ sau trong công việc thực tế:
    - **`find`** kết hợp `-size +5M` và `-delete`
    - **`jq`** khi làm việc với API hoặc dữ liệu log microservices
    - **`diff -u`** khi so sánh file cấu hình trước và sau khi cập nhật
    - **`xargs`** khi kết hợp nhận dữ liệu từ pipe `|`
```bash
# Bạn đã trả lời:

```

---

<br><br><br>
<hr>

## 🔑 ĐÁP ÁN THAM KHẢO

<details>
<summary>👉 Bấm vào đây để xem đáp án chi tiết sau khi làm xong</summary>

### Đáp án Phần 1 (Vim):
1. Phím `i` (insert tại con trỏ), hoặc `a` (append sau con trỏ), `o` (mở dòng mới bên dưới), `O` (mở dòng mới bên trên).
2. Phím `Esc` (hoặc `Ctrl + [`).
3. Sao chép (copy) dòng: bấm `yy` (yank). Dán (paste) xuống dưới: bấm `p` (put).
4. Lưu và thoát: `:wq` (hoặc `ZZ`, `:x`). Thoát không lưu: `:q!`.
5. Cú pháp thay thế toàn file: `:%s/staging/production/g`.

### Đáp án Phần 2 (Tmux):
6. Dùng `tmux` để khi mạng bị chập chờn hoặc đứt kết nối SSH, các tiến trình (build, deploy, backup) bên trong tmux vẫn tiếp tục chạy độc lập trên server mà không bị OS tắt (kill). Tổ hợp phím để Detach: `Ctrl + B` rồi bấm `d`.
7. Phím prefix mặc định là `Ctrl + B`.
   - Chia đôi theo chiều dọc (trái/phải): `Ctrl + B` rồi bấm `%`.
   - Chia đôi theo chiều ngang (trên/dưới): `Ctrl + B` rồi bấm `"`.

### Đáp án Phần 3 (Môi trường & Shell):
8. `$PATH` chứa danh sách các đường dẫn thư mục (ngăn cách bằng dấu `:`). Khi gõ lệnh, hệ điều hành sẽ tìm kiếm file thực thi trong các thư mục này theo thứ tự.
   - `VAR="abc"` chỉ có giá trị trong shell hiện tại, tiến trình con (subshell) không thấy được.
   - `export VAR="abc"` biến nó thành biến môi trường, mọi subshell sinh ra đều kế thừa được giá trị này.
9. Khi tắt terminal, alias gõ trực tiếp sẽ **BỊ MẤT**. Muốn lưu vĩnh viễn, phải ghi vào file `~/.bashrc`. Để nạp lại cấu hình ngay lập tức: gõ `source ~/.bashrc` (hoặc `. ~/.bashrc`).

### Đáp án Phần 4 (Công cụ nâng cao):
10.
   - `find . -type f -size +5M -delete`: Tự động tìm và xóa sạch các file có dung lượng lớn hơn 5MB (dọn dẹp ổ đĩa).
   - `jq`: Tiện ích bóc tách, trích xuất thuộc tính, lọc dữ liệu định dạng JSON từ output của API hoặc log microservices một cách chuyên nghiệp.
   - `diff -u`: So sánh trực quan sự khác biệt giữa hai phiên bản file dưới định dạng Unified diff (hiện dấu `+` dòng thêm mới, `-` dòng bị xóa).
   - `xargs`: Nhận luồng dữ liệu từ pipe stdin và phân tách thành danh sách các tham số truyền cho lệnh tiếp theo (ví dụ: `find ... | xargs rm`).

</details>
