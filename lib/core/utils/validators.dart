class Validators {
  static String? validateEmail(
      String? value, String requiredMessage, String invalidMessage) {
    if (value == null || value.isEmpty) {
      return requiredMessage;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return invalidMessage;
    }
    return null;
  }

  static String? validatePassword(
      String? value, String requiredMessage, String tooShortMessage) {
    if (value == null || value.isEmpty) {
      return requiredMessage;
    }
    if (value.length < 6) {
      return tooShortMessage;
    }
    return null;
  }

  static String? validateName(String? value, String requiredMessage) {
    if (value == null || value.isEmpty) {
      return requiredMessage;
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String password,
    String requiredMessage,
    String mismatchMessage,
  ) {
    if (value == null || value.isEmpty) {
      return requiredMessage;
    }
    if (value != password) {
      return mismatchMessage;
    }
    return null;
  }
}
