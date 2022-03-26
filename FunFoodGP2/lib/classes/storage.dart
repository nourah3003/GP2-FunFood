import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  // الهيكل الاساسي لالتخزين المحلي
  FlutterSecureStorage storage = const FlutterSecureStorage();
  // قراءة البيانات من التخزين المحلي
  Future<Map<String, String>?> getInfo() async {
    return await storage.readAll();
  }

  // كتالة معلومات الي التخزين المحلي
  Future<void> setInfo(String email, String password) async {
    await storage.write(key: "email", value: email);
    await storage.write(key: "password", value: password);
  }
}
