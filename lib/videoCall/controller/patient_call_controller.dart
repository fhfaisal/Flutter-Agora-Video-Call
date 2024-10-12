import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import '../../utils/constants/app_id_token.dart';

class PatientController extends GetxController {
  late RtcEngine engine;
  var isInitialized = false.obs;
  var isMicOn = true.obs;
  var isCameraOn = true.obs;
  late int doctorUserId; // This should be set properly

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
    await engine.joinChannel(
      token: AppIdToken.token,
      channelId: AppIdToken.channel,
      uid: 0, // Patient's UID
      options: ChannelMediaOptions(),
    );

    // Set doctorUserId to the actual doctor's UID who is in the call
    doctorUserId = 1; // Replace with actual doctor's UID
    isInitialized.value = true;
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

