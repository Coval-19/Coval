String emailValidator(String value) {
  final emailPattern = RegExp(r"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  if (value.isEmpty) return '*Required';
  return !emailPattern.hasMatch(value) ? '*Enter a valid email' : null;
}

String passwordValidator(String value) {
  final alphaLower = RegExp(r'[a-z]+');
  final alphaCaps = RegExp(r'[A-Z]+');
  final numeric = RegExp(r'[0-9]+');
  if (value.isEmpty) return '*Required';
  if (value.length < 8) return '*Password to short';
  return numeric.hasMatch(value) && alphaLower.hasMatch(value) &&
      alphaCaps.hasMatch(value)
      ? null
      : "*Password must containt atleast capital letters lower case letters and numbers";
}

