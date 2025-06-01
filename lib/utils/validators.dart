class AppValidator {
  static requiredField(String text, {String? errorMsg}) =>
      text.isEmpty ? errorMsg ?? "Kolom tidak boleh kosong" : null;

  static checkNumberPhone(String text) {
    const pattern = r'(^(?:[+]62)?([0-9]|[-]){10,16}$)';
    final regExp = RegExp(pattern);
    if (text.isEmpty) {
      return "Nomor handphone tidak boleh kosong";
    } else if (!regExp.hasMatch(text.trim())) {
      return "Masukkan format nomor HP yang valid";
    } else {
      return null;
    }
  }
}
