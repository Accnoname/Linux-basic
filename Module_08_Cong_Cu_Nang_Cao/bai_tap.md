# Module 08 — Bài Tập Thực Hành: Công Cụ Nâng Cao (Vim, Alias, Môi Trường)

> 💡 **Mục tiêu**: Làm quen với trình soạn thảo huyền thoại `vim` (sống sót và chỉnh sửa được cấu hình trên server), tạo các phím tắt lệnh `alias`, và quản lý biến môi trường `PATH`.

---

## 🎯 Phần 1: Sống Sót & Thành Thạo Cơ Bản Trong Vim

Vim là trình soạn thảo có sẵn trên 99% server Linux. Bạn bắt buộc phải biết cách mở, sửa và thoát!

```bash
mkdir -p ~/linux_practice/module08
cd ~/linux_practice/module08

# Mở một file mới bằng Vim
vim hello.txt
```

### Làm theo từng bước chuẩn:
1. **Gõ chữ**: Bấm phím `i` (để vào chế độ **INSERT** - bạn sẽ thấy chữ `-- INSERT --` ở góc dưới màn hình).
2. Gõ dòng chữ: `Xin chao! Day la file dau tien soan bang Vim.`
3. Bấm phím `Enter`, gõ tiếp: `Hoc Linux rat thu vi va khong he kho!`
4. **Về chế độ điều khiển**: Bấm phím `Esc` để thoát Insert mode về **NORMAL mode**.
5. **Thao tác nhanh ở Normal mode**:
   - Bấm `yy` để sao chép dòng hiện tại.
   - Bấm `p` để dán dòng vừa copy xuống dưới.
   - Bấm `dd` để xóa dòng đang đứng.
   - Bấm `u` để Undo (hoàn tác).
6. **Lưu và thoát**:
   - Gõ `:w` rồi nhấn Enter (để Lưu - Write).
   - Gõ `:wq` rồi nhấn Enter (Lưu và Thoát - Write & Quit).
   - *(Nếu lỡ gõ lung tung và muốn thoát KHÔNG lưu: bấm `Esc` rồi gõ `:q!` rồi Enter)*.

---

## 🎯 Phần 2: Biến Môi Trường & File Cấu Hình Shell (~/.bashrc)

### 1. Xem và xuất biến môi trường
```bash
# Xem thư mục Home của user hiện tại từ biến môi trường
echo $HOME

# Xem user hiện tại
echo $USER

# Xem biến PATH (danh sách các thư mục chứa lệnh thực thi)
echo $PATH

# Tạo một biến môi trường tạm thời cho phiên làm việc hiện tại
export APP_ENV="development"
echo $APP_ENV
```

### 2. Tạo Alias (Lệnh Viết Tắt) Tiện Lợi
Thay vì phải gõ những lệnh dài ngoằng, hãy biến chúng thành các phím tắt ngắn:

```bash
# Tạo alias tạm thời
alias ll='ls -lah'
alias update='sudo apt update && sudo apt upgrade -y'

# Thử gõ:
ll
```

### 3. Lưu Vĩnh Viễn Vào File `~/.bashrc`
Mọi cấu hình bạn gõ trực tiếp trong terminal sẽ mất khi bạn tắt terminal đi. Để lưu vĩnh viễn:

```bash
# Mở file .bashrc
# (Hoặc dùng nano nếu chưa quen vim: nano ~/.bashrc)
# Thêm các dòng sau vào cuối file ~/.bashrc:
echo "alias ll='ls -lah'" >> ~/.bashrc
echo "alias c='clear'" >> ~/.bashrc

# Nạp lại cấu hình ngay lập tức mà không cần khởi động lại máy
source ~/.bashrc

# Thử phím tắt mới:
c
ll
```

---

## 🎯 Phần 3: Thử Nghiệm Config Mẫu
Trong thư mục này đã có sẵn file mẫu `bashrc_mau` và `vimrc_mau`. Bạn có thể tham khảo:

```bash
cat /mnt/d/"Linux basic"/Module_08_Cong_Cu_Nang_Cao/vimrc_mau
```

✅ **Hoàn thành bài tập! Hãy chuyển sang [kiem_tra.md](file:///d:/Linux%20basic/Module_08_Cong_Cu_Nang_Cao/kiem_tra.md) để tự đánh giá bản thân.**
