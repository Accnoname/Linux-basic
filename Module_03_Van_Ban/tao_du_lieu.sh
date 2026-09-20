#!/bin/bash
# tao_du_lieu.sh — Tạo dữ liệu mẫu cho Module 03 (Xử Lý Văn Bản)
# Cách chạy:
#   bash tao_du_lieu.sh

echo "🔧 Đang khởi tạo dữ liệu mẫu cho Module 03..."

# Tạo file app.log
cat > app.log << 'EOF'
2024-01-01 ERROR Database connection failed
2024-01-01 INFO Server started successfully
2024-01-02 WARNING Disk space low: 85% used
2024-01-02 ERROR Null pointer exception in UserService
2024-01-03 INFO User admin logged in
2024-01-03 ERROR Failed to send email
2024-01-04 DEBUG Processing request id=1234
2024-01-04 INFO Request completed in 250ms
2024-01-05 ERROR Database connection failed
2024-01-05 WARNING Memory usage: 90%
EOF

# Tạo file users.csv
cat > users.csv << 'EOF'
Alice,25,Engineer,50000
Bob,30,Manager,75000
Charlie,22,Intern,30000
Diana,28,Designer,55000
Eve,35,Director,90000
Frank,27,Engineer,52000
Grace,31,Manager,78000
EOF

# Tạo file numbers.txt
cat > numbers.txt << 'EOF'
42
17
89
3
56
23
89
17
100
42
EOF

echo "✅ Đã tạo xong dữ liệu mẫu cho Module 03!"
echo "📁 Danh sách file hiện tại:"
ls -lh app.log users.csv numbers.txt
