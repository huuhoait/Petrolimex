import 'package:intl/intl.dart';
class STConstant {
  static const String BASE_URL = 'https://plxapp.herokuapp.com';
  static const String channel = 'Mobile';
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'text/plain'
  };

  String eInternalServerError = "10001"; //Lỗi server
  String eNullOrEmptyValue = "10002"; //{0} không được trống
  String eInvalidDateFormat = "10003"; //{0} theo định dạng dd/MM/yyyy
  String eInvalidPhoneFormat = "10004"; //Số điện thoại không hợp lệ
  String success = "10005"; //Thành công
  String eUnauthorized = "10006"; //Vui lòng đăng nhập để thực hiện chức năng này
  String validationExist = "10007"; //Khách hàng không tồn tại
  String notFound = "10008"; //Không tìm thấy
  String authEInvalidOTP = "11001"; //Mã OTP không hợp lệ
  String authEWrongUserOrPassword = "11002"; //Sai thông tin đăng nhập
  String authValidOTP = "11003"; //Xác thực thành công
  String authSuccessLogin = "11004"; //Đăng nhập thành công
  String authUnsupportedOTPType = "11005"; //Không hỗ trợ loại giao dịch {0}
  String registerSuccess = "12001"; //Đăng ký thành công
  String registerError = "12002"; //Số điện thoại đã tồn tại
  String updateSuccess = "13001"; //Cập nhật thành công
  String changePasswordSuccess = "14001"; //Lấy lại mật khẩu thành công
  String wrongAnswer = "14003"; //Câu trả lời không đúng

  //TransactionType
  String register = "REGISTER";
  String update =  "UPDATE";
  String changePassword = "CHANGE_PASSWORD";

  //api
  String apiGenerateOTP = "/api/generateotp";
  String apiValidateotp = "/api/validateotp";
  String apiRegister = "/api/register";
  String apiLogin = "/api/authenticate";
  String apiStaticlist = "/api/staticlist";
  String apiGetcustomer = "/api/getcustomer";
  String apiUpdate = "/api/customer/update";
  String apiCusValidateotp = "/api/customer/validateotp";
  String apiChangePassword = "/api/customer/changepassword";
  String apiCustomerQuestions = "/api/customer/getcustomerquestions";
  String apiCustomerAnswer = "/api/customer/validateanswer";

  String resultCode = "resultCode";
  String resultMessage = "resultMessage";
  String errorCode = "errorCode";
  String errorMessage = "errorMessage";
  String questionsOne = "questionsOne";
  String questionsTwo = "questionsTwo";
  String genders = "genders";
  String provinces = "provinces";
  String districts = "districts";
  String wards = "wards";

}
