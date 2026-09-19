# Module 01: Làm Quen Với Linux & WSL (Khởi Đầu Vững Chắc)

> 🎯 **Mục tiêu**: Nắm vững bản chất Linux, hiểu cách hoạt động của WSL, hiểu sâu cấu trúc thư mục và cú pháp lệnh (Command, Flag, Argument) để không phải học vẹt.

---

## 🧭 1. Bản Chất Linux & Cách Hoạt Động Trong WSL

### Linux là gì?
Linux về bản chất là một **Kernel (Nhân hệ điều hành)** do Linus Torvalds tạo ra năm 1991. Nhân chịu trách nhiệm điều phối phần cứng (CPU, RAM, ổ đĩa, card mạng) và cho phép các phần mềm người dùng giao tiếp với thiết bị.

```
+-------------------------------------------------------------+
|    Ứng dụng / Công cụ (bash, git, python, vim, ls, grep)    |  <-- Nơi bạn đang gõ lệnh
+-------------------------------------------------------------+
                              ↕
+-------------------------------------------------------------+
|                     Kernel Linux (Nhân)                     |  <-- Điều phối tài nguyên
+-------------------------------------------------------------+
                              ↕
+-------------------------------------------------------------+
|                     Phần cứng máy tính                      |  <-- CPU, RAM, Ổ cứng SSD
+-------------------------------------------------------------+
```

### WSL (Windows Subsystem for Linux) là gì?
WSL2 chạy một nhân Linux thực sự bên trong Windows. Bạn có đầy đủ sức mạnh của Ubuntu Linux mà không cần cài lại máy hay mở phần mềm ảo cồng kềnh:
- **Thư mục Linux cá nhân**: `~` (nằm ở `/home/tên_user/`). Hãy làm việc chủ yếu ở đây để đạt tốc độ cao nhất.
- **Truy cập ổ đĩa Windows**: Ổ đĩa `C:` của Windows được gắn (mount) tại `/mnt/c/`, ổ `D:` nằm tại `/mnt/d/`.

```bash
# Ví dụ truy cập file Windows từ WSL:
ls /mnt/d/Linux-basic
```

---

## 🌳 2. Cây Thư Mục Linux (Không Có Ổ C:\ hay D:\)

Trong Windows, mỗi ổ đĩa là một gốc riêng (`C:\`, `D:\`).  
Trong Linux, **mọi thứ bắt đầu từ một dấu gạch chéo `/` duy nhất (Root)**. Các ổ đĩa hay thiết bị đều chỉ là các thư mục gắn vào cây này.

```
/ (Root - Gốc của toàn bộ hệ thống)
├── bin/          -> Chứa các lệnh thực thi cơ bản nhất (ls, cp, mv, cat...)
├── etc/          -> Chứa toàn bộ file cấu hình hệ thống (dạng văn bản thuần)
├── home/         -> Thư mục chứa tài khoản người dùng
│   └── ubuntu/   -> Thư mục cá nhân của bạn (ký hiệu tắt là ~)
├── root/         -> Thư mục cá nhân của Superuser (quản trị viên tối cao)
├── var/          -> Dữ liệu biến đổi liên tục (log hệ thống, cache, database)
│   └── log/      -> Nơi kiểm tra khi hệ thống hay ứng dụng gặp lỗi
├── tmp/          -> Chứa file tạm thời (hệ thống tự dọn khi khởi động lại)
├── mnt/          -> Nơi Windows được gắn vào (/mnt/c, /mnt/d)
└── proc/ & sys/  -> Thư mục ảo biểu diễn RAM, CPU và tiến trình đang chạy
```

---

## 🔍 3. Giải Phẫu Cú Pháp Lệnh Linux (Hiểu Để Không Cần Học Vẹt)

Mọi câu lệnh trong Linux đều tuân theo công thức kinh điển:

```
command       [flags/options]              [arguments]
  ↑                  ↑                          ↑
Lệnh làm gì?    Làm theo cách nào?         Làm với đối tượng nào?
```

### Flag (Tùy chọn) là gì?
Flag là các công tắc bật/tắt hành vi của lệnh:
- **Flag ngắn (1 dấu gạch ngang `-`)**: Viết tắt bằng 1 chữ cái.
  - Ví dụ: `ls -l` (`l` = long format, hiển thị chi tiết).
  - Có thể gom nhiều flag ngắn lại với nhau: `ls -l -a -h` viết gọn thành **`ls -lah`**.
- **Flag dài (2 dấu gạch ngang `--`)**: Tên đầy đủ bằng tiếng Anh, dễ đọc và dễ nhớ.
  - Ví dụ: `ls --all --human-readable`.

### Ví dụ phân tích:
```bash
ls -lah /var/log
```
1. `ls`: Lệnh liệt kê danh sách (List).
2. `-lah`:
   - `-l`: Hiển thị chi tiết (quyền hạn, kích thước, ngày sửa).
   - `-a`: All, hiện cả file ẩn (bắt đầu bằng dấu chấm `.`).
   - `-h`: Human-readable, hiển thị dung lượng dễ đọc (KB, MB, GB thay vì số byte).
3. `/var/log`: Argument - đường dẫn thư mục muốn kiểm tra.

---

## 🧭 4. Đường Dẫn Tuyệt Đối vs Tương Đối

- **Đường dẫn tuyệt đối**: Bắt đầu bằng `/` (đi từ gốc), dù bạn đang ở đâu thì đường dẫn này vẫn trỏ đúng vị trí đó.
  - Ví dụ: `/etc/passwd`, `/var/log/syslog`.
- **Đường dẫn tương đối**: Tính từ thư mục bạn đang đứng hiện tại:
  - `.` (1 dấu chấm): Thư mục hiện tại.
  - `..` (2 dấu chấm): Thư mục cha (lên 1 cấp).
  - `~` (dấu ngã): Thư mục cá nhân của bạn (`/home/username`).
  - `-` (dấu gạch ngang): Quay lại thư mục vừa đứng trước đó (`cd -`).

---

## ⚡ 5. Bảng Lệnh Thiết Yếu Của Bài Này

| Lệnh | Ý nghĩa | Ví dụ thực tế |
| :--- | :--- | :--- |
| `whoami` | Xem bạn đang đăng nhập với tên người dùng nào | `whoami` |
| `pwd` | In đường dẫn thư mục hiện tại (*Print Working Directory*) | `pwd` |
| `ls` | Liệt kê file và thư mục | `ls -la` |
| `cd` | Di chuyển thư mục (*Change Directory*) | `cd ~`, `cd ..`, `cd /etc` |
| `man` | Xem tài liệu hướng dẫn chuẩn (*Manual*) của lệnh | `man ls` (nhấn `q` để thoát) |
| `which` | Xem vị trí file chạy của lệnh nằm ở đâu | `which ls`, `which python3` |
| `clear` | Xóa sạch màn hình terminal (phím tắt `Ctrl + L`) | `clear` |

---

## 🚀 Các Bước Học Bài Này:
1. Đọc kỹ phần lý thuyết và tư duy ở trên.
2. Mở terminal WSL và làm lần lượt các bài thực hành trong [bai_tap.md](file:///d:/Linux%20basic/Module_01_Bat_Dau/bai_tap.md).
3. Tự làm bài kiểm tra trong [kiem_tra.md](file:///d:/Linux%20basic/Module_01_Bat_Dau/kiem_tra.md) để đánh giá mức độ hiểu bài.
