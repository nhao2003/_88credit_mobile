import 'dart:convert';

class HashUtils {
  static String encodeStringToBase64(String input) {
    // Sử dụng utf8 để encode chuỗi thành byte
    List<int> bytes = utf8.encode(input);
    // Encode byte thành Base64
    String base64Str = base64.encode(bytes);
    return base64Str;
  }

  // Hàm giải mã Base64 thành chuỗi
  static String decodeBase64ToString(String input) {
    // Decode Base64 thành byte
    List<int> bytes = base64.decode(input);
    // Decode byte thành chuỗi utf8
    String decodedString = utf8.decode(bytes);
    return decodedString;
  }
}
