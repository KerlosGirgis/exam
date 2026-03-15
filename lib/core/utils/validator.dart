class FormValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w.-]+@[\w.-]+.\w{2,4}$').hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) return 'Password is required';

    // final regex = RegExp(r'^(?=.[A-Za-z])(?=.\d)(?=.*[^A-Za-z\d]).{8,}$');

    // if (!regex.hasMatch(password)) {
    //   return 'Password must be at least 8 characters, include a number, a letter, and a special character';
    // }

    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) return 'Name is required';
    if (name.length < 3) return 'Name must be at least 3 characters';

    final regex = RegExp(r'^[A-Za-z]+$');
    if (!regex.hasMatch(name)) {
      return 'Name must contain only letters (no spaces or symbols)';
    }

    return null;
  }
}
