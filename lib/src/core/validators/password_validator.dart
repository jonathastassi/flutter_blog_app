mixin PasswordValidator {
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite uma senha válida';
    }
    if (value.length <= 6) {
      return 'A senha deve ter no mínimo 6 caracteres';
    }

    return null;
  }
}
