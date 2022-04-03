mixin NameValidator {
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite um nome válido';
    }
    return null;
  }
}
