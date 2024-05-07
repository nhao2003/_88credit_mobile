import 'package:encrypt/encrypt.dart' as encrypt;

class HashUtils {
  static String encode(String text, {required String password}) {
    final key = encrypt.Key.fromUtf8(password);
    final iv = encrypt.IV.fromSecureRandom(16); // IV is generated randomly
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(text, iv: iv);
    return '${encrypted.base64}:${iv.base64}'; // Append IV to the encoded text
  }

  static String decode(String encodedText, {required String password}) {
    final List<String> parts = encodedText.split(':');
    final key = encrypt.Key.fromUtf8(password);
    final iv =
        encrypt.IV.fromBase64(parts[1]); // Extract IV from the encoded text
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encryptedText = parts[0];
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }
}
