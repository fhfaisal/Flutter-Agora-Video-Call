import 'package:permission_handler/permission_handler.dart';

class AppIdToken{
  static const id='c57f66b24eae464ba041634d990de9ed';
  static const token=
      "007eJxTYGi5mPyvUlpt8bpEwaU/bcUEEvKmbRQ9IR3Ct6pMSz1JWVeBIdnUPM3MLMnIJDUx1cTMJCnRwMTQzNgkxdLSICXVMjUlVZovvSGQkUH0/FomRgYIBPE5GJIzEvPyUnMMGRgA314dQQ==";
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