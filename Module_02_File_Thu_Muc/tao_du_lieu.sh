#!/bin/bash
# tao_du_lieu.sh — Tạo dữ liệu mẫu cho Module 02
# Chạy: bash tao_du_lieu.sh

echo "🔧 Đang tạo dữ liệu mẫu cho Module 02..."

BASE="$HOME/linux_lab/module02"
mkdir -p "$BASE"

# ─────────────────────────────────────────────
# 1. Tạo cấu trúc thư mục dự án web mẫu
# ─────────────────────────────────────────────
mkdir -p "$BASE/du_an_web"/{frontend/{css,js,images},backend/{api,models,utils},database,docs,tests,logs}

echo "✅ Tạo cấu trúc thư mục dự án web"

# ─────────────────────────────────────────────
# 2. Tạo file HTML mẫu
# ─────────────────────────────────────────────
cat > "$BASE/du_an_web/frontend/index.html" << 'EOF'
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang Web Mẫu</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h1>Xin chào Linux!</h1>
    <p>Đây là trang web mẫu để thực hành.</p>
    <script src="js/main.js"></script>
</body>
</html>
EOF

# ─────────────────────────────────────────────
# 3. Tạo file CSS mẫu
# ─────────────────────────────────────────────
cat > "$BASE/du_an_web/frontend/css/style.css" << 'EOF'
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 20px;
    background-color: #f0f0f0;
}

h1 {
    color: #333;
    font-size: 2em;
}

p {
    color: #666;
    line-height: 1.6;
}
EOF

# ─────────────────────────────────────────────
# 4. Tạo file JavaScript mẫu
# ─────────────────────────────────────────────
cat > "$BASE/du_an_web/frontend/js/main.js" << 'EOF'
// File JavaScript mẫu
console.log("Trang đã tải xong!");

function chao(ten) {
    return "Xin chào, " + ten + "!";
}

document.addEventListener("DOMContentLoaded", function() {
    console.log(chao("người dùng"));
});
EOF

# ─────────────────────────────────────────────
# 5. Tạo file Python backend mẫu
# ─────────────────────────────────────────────
cat > "$BASE/du_an_web/backend/api/users.py" << 'EOF'
# API quản lý người dùng
def get_users():
    return [
        {"id": 1, "name": "Alice", "email": "alice@example.com"},
        {"id": 2, "name": "Bob", "email": "bob@example.com"},
        {"id": 3, "name": "Charlie", "email": "charlie@example.com"},
    ]

def get_user_by_id(user_id):
    users = get_users()
    return next((u for u in users if u["id"] == user_id), None)
EOF

cat > "$BASE/du_an_web/backend/models/user.py" << 'EOF'
# Model User
class User:
    def __init__(self, id, name, email):
        self.id = id
        self.name = name
        self.email = email

    def to_dict(self):
        return {"id": self.id, "name": self.name, "email": self.email}

    def __str__(self):
        return f"User({self.id}, {self.name})"
EOF

# ─────────────────────────────────────────────
# 6. Tạo file cấu hình
# ─────────────────────────────────────────────
cat > "$BASE/du_an_web/database/config.sql" << 'EOF'
-- Cấu hình database
CREATE DATABASE IF NOT EXISTS myapp;
USE myapp;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(200) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (name, email) VALUES
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com'),
('Charlie', 'charlie@example.com');
EOF

# ─────────────────────────────────────────────
# 7. Tạo file README cho dự án
# ─────────────────────────────────────────────
cat > "$BASE/du_an_web/docs/README.md" << 'EOF'
# Dự Án Web Mẫu

## Mô tả
Đây là dự án web mẫu để thực hành Linux.

## Cấu trúc
- frontend/   — HTML, CSS, JavaScript
- backend/    — Python API
- database/   — SQL scripts
- docs/       — Tài liệu
- tests/      — Unit tests
- logs/       — Log files

## Cách chạy
Xem hướng dẫn trong từng thư mục.
EOF

# ─────────────────────────────────────────────
# 8. Tạo file log mẫu
# ─────────────────────────────────────────────
for i in {1..20}; do
    echo "[$(date -d "$((RANDOM % 30)) days ago" '+%Y-%m-%d %H:%M:%S' 2>/dev/null || date '+%Y-%m-%d %H:%M:%S')] Request to /api/users - 200 OK - ${RANDOM}ms" >> "$BASE/du_an_web/logs/access.log"
done
echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Database connection timeout" >> "$BASE/du_an_web/logs/access.log"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] WARNING: High memory usage: 87%" >> "$BASE/du_an_web/logs/access.log"

# ─────────────────────────────────────────────
# 9. Tạo thêm file để thực hành tìm kiếm
# ─────────────────────────────────────────────
touch "$BASE/du_an_web/frontend/images/logo.png"
touch "$BASE/du_an_web/frontend/images/banner.jpg"
touch "$BASE/du_an_web/tests/test_users.py"
touch "$BASE/du_an_web/tests/test_api.py"
touch "$BASE/du_an_web/backend/utils/helpers.py"
touch "$BASE/du_an_web/backend/utils/validators.py"

# ─────────────────────────────────────────────
# 10. Tạo thư mục thứ 2 để luyện tập sao chép
# ─────────────────────────────────────────────
mkdir -p "$BASE/thu_muc_nguon"/{tai_lieu,hinh_anh,video,nhac}
for i in {1..5}; do
    echo "Tài liệu số $i" > "$BASE/thu_muc_nguon/tai_lieu/doc_$i.txt"
done
touch "$BASE/thu_muc_nguon/hinh_anh/photo_{1,2,3}.jpg"
touch "$BASE/thu_muc_nguon/video/video_{1,2}.mp4"
touch "$BASE/thu_muc_nguon/nhac/song_{1,2,3,4}.mp3"

echo ""
echo "✅ Tạo dữ liệu xong! Cấu trúc:"
find "$BASE" -type f | sort
echo ""
echo "📁 Tổng cộng:"
echo "   Thư mục: $(find $BASE -type d | wc -l)"
echo "   File:    $(find $BASE -type f | wc -l)"
echo ""
echo "🚀 Bắt đầu bài tập tại: $BASE"
