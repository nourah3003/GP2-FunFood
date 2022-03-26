
//التاكد من صلاحية الايميل المدخل
String? validateEmail(String? value) {
  if (value != null) {
    if (value.length > 5 && value.contains('@') && value.endsWith('.com')) {
      return null;
    }
    return 'Enter a Valid Email Address';
  }
}
