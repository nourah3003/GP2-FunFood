import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static FlutterSecureStorage flutterSecureStorage =
      const FlutterSecureStorage();
  //insert email and password into local database
  //state : 1 is logged in.
  //state : 0  is logged out
  static Future<void> setInfo(
      String email, String password, String state) async {
    await flutterSecureStorage.write(key: "email", value: email);
    await flutterSecureStorage.write(key: "password", value: password);
    await flutterSecureStorage.write(key: "state", value: state);
  }

  static Future<void> setState(String state) async {
    await flutterSecureStorage.write(key: "state", value: state);
  }

  static Future<void> setEmail(String email) async {
    await flutterSecureStorage.write(key: "email", value: email);
  }

  static Future<void> setPassword(String password) async {
    await flutterSecureStorage.write(key: "password", value: password);
  }

  static Future<void> setPIN(String pin) async {
    await flutterSecureStorage.write(key: "pin", value: pin);
  }
  //get info from local database

  static Future<String?> getEmail() async {
    return await flutterSecureStorage.read(key: "email");
  }

  static Future<String?> getPIN() async {
    return await flutterSecureStorage.read(key: "pin");
  }

  static Future<String?> getPassword() async {
    return await flutterSecureStorage.read(key: "password");
  }

  static Future<String?> getState() async {
    return await flutterSecureStorage.read(key: "state");
  }

  static Future<Map<String, String>> isEmpty() async {
    return await flutterSecureStorage.readAll();
  }
}
