#!/bin/bash
# tao_tien_trinh_mau.sh — Tạo tiến trình chạy ngầm giả lập phục vụ thực hành Module 05
# Hướng dẫn sử dụng:
#   bash tao_tien_trinh_mau.sh start   : Khởi chạy các tiến trình mẫu
#   bash tao_tien_trinh_mau.sh status  : Kiểm tra các tiến trình mẫu đang chạy
#   bash tao_tien_trinh_mau.sh stop    : Dừng và dọn dẹp toàn bộ tiến trình mẫu

ACTION=${1:-start}
WORK_DIR=$(pwd)
LOG_FILE="$WORK_DIR/gia_lap_app.log"
PID_FILE="$WORK_DIR/gia_lap_app.pid"

case "$ACTION" in
  start)
    echo "🚀 Đang khởi tạo các tiến trình giả lập cho Module 05..."
    
    # Tạo worker 1: Giả lập app backend ghi log mỗi 3 giây
    (
      while true; do
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] Backend Worker: Đang đồng bộ dữ liệu..." >> "$LOG_FILE"
        sleep 3
      done
    ) >/dev/null 2>&1 &
    PID1=$!
    
    # Tạo worker 2: Giả lập background task xử lý ảnh
    (
      while true; do
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [DEBUG] Image Processor: Đang nén ảnh và lưu cache..." >> "$LOG_FILE"
        sleep 5
      done
    ) >/dev/null 2>&1 &
    PID2=$!
    
    # Tạo dummy service có tên dễ nhận biết
    sleep 3600 &
    PID3=$!

    echo "$PID1" > "$PID_FILE"
    echo "$PID2" >> "$PID_FILE"
    echo "$PID3" >> "$PID_FILE"

    echo "✅ Đã tạo thành công 3 tiến trình mẫu!"
    echo "  - Worker 1 PID : $PID1 (Ghi log vào gia_lap_app.log)"
    echo "  - Worker 2 PID : $PID2 (Ghi log vào gia_lap_app.log)"
    echo "  - Worker 3 PID : $PID3 (Lệnh sleep 3600 ngầm)"
    echo ""
    echo "💡 Gợi ý thực hành ngay:"
    echo "  1. Xem file log realtime : tail -f gia_lap_app.log"
    echo "  2. Tìm tiến trình mẫu     : ps aux | grep sleep"
    echo "  3. Thử tắt Worker 3      : kill $PID3"
    echo "  4. Dọn dẹp tất cả khi xong: bash tao_tien_trinh_mau.sh stop"
    ;;

  status)
    if [ ! -f "$PID_FILE" ]; then
      echo "ℹ️ Không tìm thấy file lưu PID. Có thể chưa chạy 'start'."
      exit 0
    fi
    echo "📋 Trạng thái các tiến trình mẫu:"
    while read -r pid; do
      if ps -p "$pid" > /dev/null 2>&1; then
        echo "  - PID $pid: Đang chạy [RUNNING]"
      else
        echo "  - PID $pid: Đã dừng [STOPPED]"
      fi
    done < "$PID_FILE"
    ;;

  stop)
    echo "🛑 Đang dọn dẹp các tiến trình mẫu..."
    if [ -f "$PID_FILE" ]; then
      while read -r pid; do
        if ps -p "$pid" > /dev/null 2>&1; then
          kill -9 "$pid" >/dev/null 2>&1
          echo "  - Đã dừng PID $pid"
        fi
      done < "$PID_FILE"
      rm -f "$PID_FILE"
    fi
    pkill -f "sleep 3600" >/dev/null 2>&1
    echo "🧹 Đã dọn dẹp sạch sẽ môi trường!"
    ;;

  *)
    echo "Cách dùng: bash tao_tien_trinh_mau.sh {start|status|stop}"
    exit 1
    ;;
esac
