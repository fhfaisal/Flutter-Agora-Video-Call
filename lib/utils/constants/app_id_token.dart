import 'package:permission_handler/permission_handler.dart';

class AppIdToken{
  static const id='c57f66b24eae464ba041634d990de9ed';
  static const token='007eJxTYGBYqrN5wbRJtgwsRV8u+4iGlYrWzI0XL5z1Y+f+n66OPZ8UGJJNzdPMzJKMTFITU03MTJISDUwMzYxNUiwtDVJSLVNTup7zpjcEMjIERZkyMEIhiM/BkJyRmJeXmmPIwAAAft0fxw==';
  static const channel='channel1';
  // Request camera and microphone permissions
  static Future<bool> requestPermissions() async {
    final statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();
    final allGranted = statuses.values.every((status) => status.isGranted);
    if (!allGranted) {
      print("Permissions not granted.");
    }
    return allGranted;
  }
}