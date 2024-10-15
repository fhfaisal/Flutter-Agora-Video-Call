import 'package:agora/utils/constants/app_id_token.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class DoctorController extends GetxController {
  late final AgoraClient agoraClient;

  Future<void> initializeAgora(String channelId) async {
    await [Permission.microphone, Permission.camera].request();

    agoraClient = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AppIdToken.id,
        channelName: channelId, // Use the same channel ID as the patient
      ),
    );

    await agoraClient.initialize();
  }

  Future<void> joinCall(String channelId) async {
    try {
      await agoraClient.engine.joinChannel(
        token: AppIdToken.token, // Use a token if needed, otherwise leave it empty for testing
        channelId: channelId,
        uid: 1, // Assign a unique ID for the doctor
        options: const ChannelMediaOptions(),
      );
    } catch (e) {
      print('Error joining call: $e');
      rethrow;
    }
  }

  @override
  void onClose() {
    agoraClient.engine.leaveChannel();
    super.onClose();
  }
}
