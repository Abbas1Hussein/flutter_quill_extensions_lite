class ValidatorUtils {
  static bool isImageBase64(String imageUrl) {
    return !imageUrl.startsWith('http') && isBase64(imageUrl);
  }

  static bool isBase64(String str) => _base64.hasMatch(str);

  static final RegExp _base64 = RegExp(
    r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$',
  );
}
