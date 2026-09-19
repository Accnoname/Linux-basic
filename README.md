<div align="center">

# 🐧 Khóa Học Linux Thực Chiến & Quản Trị Hệ Thống
### *Hands-on Linux for Developers, DevOps & System Administrators*

[![Linux](https://img.shields.io/badge/OS-Linux%20%2F%20Ubuntu-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://ubuntu.com/)
[![WSL2](https://img.shields.io/badge/Platform-WSL2-0078D6?style=for-the-badge&logo=windows&logoColor=white)](https://learn.microsoft.com/en-us/windows/wsl/)
[![Bash](https://img.shields.io/badge/Shell-Bash%205.0+-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](./LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=for-the-badge)](./CONTRIBUTING.md)

<p align="center">
  <b>Giáo trình học Linux tư duy - thực hành từng bước từ cơ bản đến tự động hóa hệ thống trên môi trường WSL (Windows Subsystem for Linux) & Server.</b>
</p>

[Lộ Trình Học](#-lộ-trình-học-tập-roadmap) • [5 Tư Duy Cốt Lõi](#-5-nguyên-lý-tư-duy-cốt-lõi) • [Giải Phẫu Lệnh](#-giải-phẫu-cú-pháp-lệnh-command--flags) • [Bảng Tra Cứu Lệnh](./BANG_TRA_CUU.md) • [Đóng Góp](./CONTRIBUTING.md)

</div>

---

## 🌟 Điểm Khác Biệt Của Khóa Học Này

Hầu hết các tài liệu trên mạng bắt đầu bằng việc liệt kê hàng trăm câu lệnh khô khan mà không giải thích nguyên nhân. Khóa học này áp dụng phương pháp **Hands-on Lab-driven** (tương tự giáo trình chuẩn của [KodeKloud](https://github.com/kodekloudhub/linux-basics-course)):

1. 🎯 **Hiểu bản chất trước, gõ lệnh sau**: Hiểu rõ Kernel, Shell, Process và File System hoạt động ra sao.
2. 🗂️ **Cấu trúc tối giản & thực tế**: Mỗi bài học nằm trọn vẹn trong **đúng 1 thư mục** duy nhất gồm: `Lý thuyết` $\rightarrow$ `Thực hành Lab` $\rightarrow$ `Bài kiểm tra`.
3. 💻 **Thực hành với dữ liệu thật**: File log server thực tế, file CSV nhân viên, kịch bản sự cố hệ thống thật.
4. ⚙️ **Dự án cuối khóa hoàn chỉnh**: Tự tay xây dựng hệ thống tự động giám sát server và sao lưu dữ liệu bằng Bash Script & Cron.

---

## 🗺️ Lộ Trình Học Tập (Roadmap)

| Module | Tên Bài Học | Trọng Tâm Kiến Thức | Lý Thuyết | Lab Thực Hành | Đánh Giá |
| :---: | :--- | :--- | :---: | :---: | :---: |
| **01** | **[Bắt Đầu Với WSL & Linux](./Module_01_Bat_Dau/)** | Kernel, WSL2, Cây thư mục `/`, `pwd`, `cd`, `ls`, `man` | [📖 Đọc](./Module_01_Bat_Dau/README.md) | [🎯 Thực hành](./Module_01_Bat_Dau/bai_tap.md) | [📝 Quiz](./Module_01_Bat_Dau/kiem_tra.md) |
| **02** | **[Thao Tác File & Thư Mục](./Module_02_File_Thu_Muc/)** | Tạo, sao chép, di chuyển, xóa, tìm kiếm (`touch`, `mkdir`, `cp`, `mv`, `rm`, `find`) | [📖 Đọc](./Module_02_File_Thu_Muc/README.md) | [🎯 Thực hành](./Module_02_File_Thu_Muc/bai_tap.md) | [📝 Quiz](./Module_02_File_Thu_Muc/kiem_tra.md) |
| **03** | **[Xử Lý Dữ Liệu & Văn Bản](./Module_03_Van_Ban/)** | Đọc log, lọc dữ liệu, pipeline (`cat`, `head`, `tail -f`, `grep`, `awk`, `pipe \|`) | [📖 Đọc](./Module_03_Van_Ban/README.md) | [🎯 Thực hành](./Module_03_Van_Ban/bai_tap.md) | [📝 Quiz](./Module_03_Van_Ban/kiem_tra.md) |
| **04** | **[Phân Quyền & Bảo Mật](./Module_04_Quyen_Truy_Cap/)** | Quyền `rwx`, mã số Octal (`chmod 755/644/600`), quản trị viên `sudo`, `chown` | [📖 Đọc](./Module_04_Quyen_Truy_Cap/README.md) | [🎯 Thực hành](./Module_04_Quyen_Truy_Cap/bai_tap.md) | [📝 Quiz](./Module_04_Quyen_Truy_Cap/kiem_tra.md) |
| **05** | **[Tiến Trình & Tài Nguyên](./Module_05_Tien_Trinh/)** | Giám sát CPU/RAM, tắt tiến trình treo, chạy nền (`top`, `ps aux`, `kill -9`, `jobs`, `fg`) | [📖 Đọc](./Module_05_Tien_Trinh/README.md) | [🎯 Thực hành](./Module_05_Tien_Trinh/bai_tap.md) | [📝 Quiz](./Module_05_Tien_Trinh/kiem_tra.md) |
| **06** | **[Mạng & Kết Nối Server](./Module_06_Mang/)** | Kiểm tra IP, port, gửi request web, SSH (`ip`, `ping`, `curl`, `wget`, `ss -tlnp`) | [📖 Đọc](./Module_06_Mang/README.md) | [🎯 Thực hành](./Module_06_Mang/bai_tap.md) | [📝 Quiz](./Module_06_Mang/kiem_tra.md) |
| **07** | **[Lập Trình Shell Script](./Module_07_Shell_Script/)** | Viết script tự động hóa, biến, điều kiện if/else, vòng lặp for, exit code | [📖 Đọc](./Module_07_Shell_Script/README.md) | [🎯 Thực hành](./Module_07_Shell_Script/bai_tap.md) | [📝 Quiz](./Module_07_Shell_Script/kiem_tra.md) |
| **08** | **[Công Cụ Chuyên Nghiệp](./Module_08_Cong_Cu_Nang_Cao/)** | Soạn thảo file cấu hình với `vim`, tạo phím tắt `alias`, biến môi trường `PATH` | [📖 Đọc](./Module_08_Cong_Cu_Nang_Cao/README.md) | [🎯 Thực hành](./Module_08_Cong_Cu_Nang_Cao/bai_tap.md) | [📝 Quiz](./Module_08_Cong_Cu_Nang_Cao/kiem_tra.md) |
| **09** | **[Dự Án Tổng Hợp Cuối Khóa](./Module_09_Du_An_Thuc_Te/)** | Hệ thống tự động giám sát server & tự động backup định kỳ với `Cron` | [📖 Thiết kế](./Module_09_Du_An_Thuc_Te/README.md) | [🎯 Checklist](./Module_09_Du_An_Thuc_Te/bai_tap.md) | 🏆 Tốt nghiệp |

---

## 🧠 5 Nguyên Lý Tư Duy Cốt Lõi

Trước khi gõ lệnh, hãy ghi nhớ 5 quy luật bất biến của hệ sinh thái Unix/Linux:

```
┌────────────────────────────────────────────────────────────────────────┐
│ 1. MỌI THỨ ĐỀU LÀ FILE                                                │
│    Ổ cứng, bàn phím, màn hình, socket mạng, tiến trình đều là file.  │
│                                                                        │
│ 2. CHƯƠNG TRÌNH ĐƠN NHIỆM (DO ONE THING WELL)                         │
│    Một công cụ chỉ làm tốt 1 việc. Ghép chúng lại bằng đường ống |    │
│                                                                        │
│ 3. VĂN BẢN THUẦN (PLAIN TEXT) LÀ GIAO THỨC CHUNG                       │
│    Mọi công cụ giao tiếp qua chuỗi ký tự chuẩn: stdin, stdout, stderr  │
│                                                                        │
│ 4. HỆ THỐNG TIN TƯỞNG NGƯỜI DÙNG                                      │
│    Không hỏi "Are you sure?". Lệnh chạy là thực thi ngay lập tức.     │
│                                                                        │
│ 5. PHÂN QUYỀN BẢO VỆ ĐA NGƯỜI DÙNG (MULTI-USER)                        │
│    Không có quyền hạn tương ứng thì không thể can thiệp hệ thống.      │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 🔍 Giải Phẫu Cú Pháp Lệnh (Command + Flags)

Đừng học vẹt cú pháp! Mọi lệnh trong Linux đều tuân theo công thức chuẩn:

```
command       [flags/options]              [arguments]
  ↑                  ↑                          ↑
Lệnh làm gì?    Làm theo cách nào?         Làm với đối tượng nào?
```

- **Ví dụ**:
  ```bash
  ls -lah /var/log
  ```
  - `ls`: Lệnh liệt kê (*List*).
  - `-lah`: Cờ tùy chọn gom lại (`-l` hiển thị chi tiết, `-a` hiển thị cả file ẩn, `-h` hiển thị dung lượng dạng KB/MB dễ đọc).
  - `/var/log`: Đường dẫn thư mục cần kiểm tra.

---

## 🚀 Hướng Dẫn Thực Hành Nhanh Trên WSL

### 1. Khởi động môi trường
Mở Windows Terminal hoặc PowerShell và gõ:
```bash
wsl
```

### 2. Kiểm tra thông số máy
```bash
uname -a
echo "User hiện tại: $USER | Thư mục Home: $HOME"
```

### 3. Truy cập thư mục khóa học từ WSL
Nếu bạn lưu thư mục này tại ổ `D:` của Windows:
```bash
cd /mnt/d/Linux-basic
ls -la
```

---

## 📑 Tài Liệu Tham Khảo Thêm
- ⚡ **[Bảng Tra Cứu Lệnh & Phím Tắt Tiện Lợi](./BANG_TRA_CUU.md)**: Tổng hợp các lệnh phổ biến nhất của Sysadmin.
- 🤝 **[Hướng Dẫn Đóng Góp](./CONTRIBUTING.md)**: Cách gửi Pull Request cải thiện giáo trình.
- 📜 **[Giấy Phép Mã Nguồn Mở MIT](./LICENSE)**: Tự do sử dụng, chỉnh sửa và chia sẻ.

---

<div align="center">
  <b>⭐ Nếu thấy khóa học hữu ích, hãy tặng 1 Star cho Repository này trên GitHub nhé! ⭐</b>
</div>
