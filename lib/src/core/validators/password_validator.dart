mixin PasswordValidator {
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite uma senha válida';
    }
    if (value.length < 6) {
      return 'A senha deve ter no mínimo 6 caracteres';
    }

    return null;
  }

  String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Digite uma confirmação de senha válida';
    }

    if (value == password) {
      return null;
    }

    return 'Confirmação de senha não confere';
  }
}
