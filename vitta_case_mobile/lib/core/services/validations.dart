extension StrUtils on String {
  static String validateName(String value) {
    if (value.isEmpty) {
      return 'Preencha este campo';
    } else if (!NameValidator().nameRegex.hasMatch(value)) {
      return 'Formato inválido';
    } else {
      return null;
    }
  }
}

class NameValidator {
  final RegExp nameRegex = RegExp(
      r'^[a-zA-ZáàâãäéèêëíìîïóòôõöúùûüçñÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇÑ ]{2,50}$');
}
