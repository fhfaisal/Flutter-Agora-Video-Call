import 'package:permission_handler/permission_handler.dart';

class AppIdToken{
  static const id='c57f66b24eae464ba041634d990de9ed';
  static const token='007eJxTYHgjlnleMkPN9PGnbY4sl7omWJtGsN+O6BB0e2Iya73/aU4FhmRT8zQzsyQjk9TEVBMzk6REAxNDM2OTFEtLg5RUy9SULV840hsCGRmmr/RiYIRCEJ+RwZCBAQCP5hzr';
  static const channel='1';
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