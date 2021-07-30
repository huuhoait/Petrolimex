class Validation {
  static validationPass(String pass) {
    if (pass.length < 6) return false;
    return true;
  }

  static validationPhone(String phone) {
    var isValid = RegExp(r"^[0-9]").hasMatch(phone);
    if (phone.length < 10 || !isValid)
      return false;
    return true;
  }

  static  validationEmail(String email) {
    var isValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (!isValid) return false;
    return true;
  }

  static String validationAnswer(String answer) {
    if (answer.length == 0) return "Vui lòng nhập câu trả lời";
    return null;
  }

  static String validationId(String id) {
    if (id.length == 0) return "Bắt buộc";
    return null;
  }

  static String validationAddress(String address) {
    if (address.length == 0) return "Bắt buộc";
    return null;
  }

  static String validationDate(String date) {
    if (date.length == 0) return "Bắt buộc";
    return null;
  }

  static String validationTax(String tax) {
    if (tax.length == 0) return "Bắt buộc";
    return null;
  }

  static bool confirmPass(String pass, String conPass) {
    if (pass.compareTo(conPass) == 0) return true;
    return false;
  }

  static bool checkNullValue(String value) {
    if (value == null) return true;
    return false;
  }

  static bool checkEmpty(String value) {
    if (value.length <= 0) return false;
    return true;
  }

  static bool compareValue(String value1, String value2) {
    if (value1.compareTo(value2) == 0) return true;
    return false;
  }
}
