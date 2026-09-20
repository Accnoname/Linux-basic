# Module 01 — Bài Tự Kiểm Tra Kiến Thức

> ⏱️ **Thời gian gợi ý**: 15 phút.  
> ✍️ Hãy tự trả lời trước ra giấy hoặc nháp trước khi cuộn xuống xem đáp án!

---

## 📝 PHẦN 1: TRẢ LỜI NHANH (10 CÂU)

1. Lệnh nào hiển thị đường dẫn thư mục bạn đang đứng hiện tại?
   - **Trả lời của bạn**: `pwd`
   - **Đáp án & Ghi chú**: ✅ **Chính xác** (`pwd` = *Print Working Directory*).

2. Ký tự `~` trong Linux đại diện cho đường dẫn nào?
   - **Trả lời của bạn**: `đại diện cho đường ở vị trí trước`
   - **Đáp án & Ghi chú**: 💡 **Đáp án đúng là Thư mục Home** (`/home/hieu`). Đại diện cho vị trí vừa đứng trước đó là dấu gạch ngang `-` (`cd -`).

3. Để hiển thị cả file ẩn và xem dung lượng dạng KB/MB trong `ls`, bạn dùng kết hợp những flag nào?
   - **Trả lời của bạn**: `ls -lah`
   - **Đáp án & Ghi chú**: ✅ **Chính xác** (`-l`: chi tiết, `-a`: hiện file ẩn, `-h`: human-readable đọc dung lượng dạng KB, MB).

4. Ký tự đại diện cho thư mục cha (lên 1 cấp) là gì?
   - **Trả lời của bạn**: `..`
   - **Đáp án & Ghi chú**: ✅ **Chính xác** (hai dấu chấm liên tiếp).

5. Đường dẫn bắt đầu bằng dấu `/` là đường dẫn **tuyệt đối** hay **tương đối**?
   - **Trả lời của bạn**: `/ là tuyệt đối`
   - **Đáp án & Ghi chú**: ✅ **Chính xác** (đi từ gốc Root `/`).

6. Khi xem chi tiết bằng `ls -l`, ký tự đầu tiên là `d` có nghĩa là gì?
   - **Trả lời của bạn**: `d là directory - đây là thư mục`
   - **Đáp án & Ghi chú**: ✅ **Chính xác** (`d` = Directory. Nếu là file thông thường sẽ là dấu `-`).

7. Muốn quay lại thư mục bạn vừa đứng trước đó ngay lập tức, bạn gõ lệnh `cd` với tham số gì?
   - **Trả lời của bạn**: `cd ..`
   - **Đáp án & Ghi chú**: 💡 **Đáp án đúng là `cd -`** (`cd ..` là đi lên thư mục cha 1 cấp; còn `cd -` hoạt động như nút Back, đưa bạn về vị trí vừa đứng trước đó).

8. Muốn thoát khỏi màn hình xem hướng dẫn `man`, bạn bấm phím gì?
   - **Trả lời của bạn**: `q`
   - **Đáp án & Ghi chú**: ✅ **Chính xác** (`q` = Quit).

9. Thư mục `/etc` trong hệ thống Linux dùng để chứa nội dung gì?
   - **Trả lời của bạn**: `Chứa các file hệ thống (cần giải thích rõ)`
   - **Đáp án & Ghi chú**: 💡 **Chứa toàn bộ file cấu hình hệ thống (Configuration Files)** ở dạng văn bản thuần (*Editable Text Configuration*). Ví dụ: file thông tin user `/etc/passwd`, file tên hệ điều hành `/etc/os-release`, cấu hình mạng, SSH, web server... Khi cần chỉnh cấu hình máy Linux, bạn chỉ cần mở các file text trong `/etc` ra sửa.

10. Trong WSL, ổ đĩa `C:` của Windows được gắn (mount) ở đường dẫn nào?
    - **Trả lời của bạn**: `cd /mnt/c`
    - **Đáp án & Ghi chú**: ✅ **Chính xác** (`/mnt/c/`).

---

## 📝 PHẦN 2: THỰC HÀNH VIẾT LỆNH

11. Viết một lệnh duy nhất để liệt kê chi tiết các file trong `/var/log`, hiển thị file ẩn và dung lượng dễ đọc:
```bash
# Trả lời của bạn: cd /var/log rồi ls -lah
# Đáp án chuẩn 1 lệnh duy nhất (không cần cd):
ls -lah /var/log
```
> *Ghi chú*: Linux cho phép truyền trực tiếp đường dẫn thư mục làm đối số (argument) phía sau lệnh `ls`.

12. Bạn đang ở `/tmp/test/abc`. Hãy viết 2 cách khác nhau để di chuyển về thư mục Home của bạn:
```bash
# Cách 1 (dùng ký tự ~):
cd ~

# Cách 2 (lệnh cd trần không đối số):
cd

# Cách 3 (đường dẫn tuyệt đối):
cd /home/hieu
```

13. Phân tích cấu trúc của lệnh sau: `ls -la /home`
- **Command (Lệnh làm gì)**: `ls` (liệt kê danh sách file/thư mục)
- **Flag (Làm theo cách nào)**: `-la` (kết hợp của `-l`: hiển thị chi tiết và `-a`: hiển thị cả file ẩn)
- **Argument (Làm với đối tượng nào)**: `/home` (đường dẫn thư mục mục tiêu)

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
