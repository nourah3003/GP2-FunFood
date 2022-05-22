String? isValid(String? email) {
  if (email != null) {
    if (email.contains("@") && email.contains(".com")) {
      return null;
    }
  }
  return "please insert a valid email";
}
