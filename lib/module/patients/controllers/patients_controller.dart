import 'package:agora/utils/constants/app_id_token.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PatientController extends GetxController {
  late final AgoraClient agoraClient;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> initializeAgora(String doctorUid) async {
    await [Permission.microphone, Permission.camera].request();

    agoraClient = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AppIdToken.id,
        channelName: doctorUid, // Replace with doctorUid dynamically if needed
      ),
    );

    await agoraClient.initialize();
  }

  void startCall(String doctorUid) async {
    await agoraClient.engine.joinChannel(
      token: AppIdToken.token, // Provide token if required
      channelId: doctorUid,
      options: const ChannelMediaOptions(),
      uid: 0,
    );
  }

  @override
  void onClose() {
    agoraClient.engine.leaveChannel();
    super.onClose();
  }
}
