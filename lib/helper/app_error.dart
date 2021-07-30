class AppError {
  String error(String errorCode) {
    switch (errorCode) {
      case "10001":
        return "Lỗi server";
      case "10002":
        return "{0} không được trống";
      case "10003":
        return "{0} theo định dạng dd/MM/yyyy";
      case "10004":
        return "Số điện thoại không hợp lệ";
      case "10006":
        return "Vui lòng đăng nhập để thực hiện chức năng này";
      case "10007":
        return "Khách hàng không tồn tại";
      case "10008":
        return "Không tìm thấy";
      case "11001":
        return "Mã OTP không hợp lệ";
      case "11002":
        return "Sai thông tin đăng nhập";
      case "11005":
        return "Không hỗ trợ loại giao dịch {0}";
      case "12002":
        return "Số điện thoại đã tồn tại";
      case "14003":
        return "Câu trả lời không đúng";
      default:
        throw Exception("Unable to perform request!");
    }
  }
}

