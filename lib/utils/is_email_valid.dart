bool isEmailValid(String email) {
  // Use uma expressão regular para verificar o formato do email.
  final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    caseSensitive: false,
  );

  return emailRegex.hasMatch(email);
}