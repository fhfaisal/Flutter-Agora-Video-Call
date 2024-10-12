import 'package:agora/utils/constants/app_id_token.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class DoctorController extends GetxController {
  late RtcEngine engine;
  var isInitialized = false.obs;
  var isMicOn = true.obs;
  var isCameraOn = true.obs;

  @override
  void onInit() {
    super.onInit();
    initializeAgora();
  }

  Future<void> initializeAgora() async {
    final hasPermissions = await AppIdToken.requestPermissions();
    if (!hasPermissions) return;

    engine = createAgoraRtcEngine();
    await engine.initialize(
      RtcEngineContext(appId: AppIdToken.id),
    );

    // Enable video and start the preview
    await engine.enableVideo();
    await engine.startPreview();

    // Join the channel
    try {
      await engine.joinChannel(
        token: AppIdToken.token,
        channelId: AppIdToken.channel,
        uid: 0, // Doctor's UID
        options: const ChannelMediaOptions(),
      );
      print("Joined channel successfully.");
      isInitialized.value = true;
    } catch (e) {
      print("Error joining channel: $e");
    }
  }

  void toggleMic() {
    isMicOn.value = !isMicOn.value;
    engine.muteLocalAudioStream(!isMicOn.value);
  }

  void toggleCamera() {
    isCameraOn.value = !isCameraOn.value;
    engine.muteLocalVideoStream(!isCameraOn.value);
  }

  void endCall() {
    engine.leaveChannel();
    Get.back();
  }
}