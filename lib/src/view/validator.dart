class Validator {
  static final Validator _instance = Validator._internal();

  factory Validator() => _instance;

  Validator._internal();

  final validatorMessage = 'Lütfen bir değer giriniz.';

  String? validateEmpty(String? value) {
    if (value!.isEmpty) {
      return validatorMessage;
    }
    return null;
  }
}
