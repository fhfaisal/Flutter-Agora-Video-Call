import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:get/get.dart';

class VideoCallController extends GetxController {
  late AgoraClient agoraClient;
  var isInitialized = false.obs; // Observable to track initialization
  final appId = 'c57f66b24eae464ba041634d990de9ed';
  final channelName = '1';
  final tempToken =
      '007eJxTYHgjlnleMkPN9PGnbY4sl7omWJtGsN+O6BB0e2Iya73/aU4FhmRT8zQzsyQjk9TEVBMzk6REAxNDM2OTFEtLg5RUy9SULV840hsCGRmmr/RiYIRCEJ+RwZCBAQCP5hzr';

  @override
  void onInit() {
    super.onInit();
    initAgora();
  }

  Future<void> initAgora() async {
    try {
      // Ensure that permissions are requested sequentially
      var cameraStatus = await Permission.camera.request();
      var micStatus = await Permission.microphone.request();

      // Check if both permissions are granted before proceeding
      if (cameraStatus.isGranted && micStatus.isGranted) {
        // Agora client initialization with AgoraConnectionData
        agoraClient = AgoraClient(
          agoraConnectionData: AgoraConnectionData(
            appId: appId, // Replace with your Agora App ID
            channelName: channelName, // Replace with your channel name
            tempToken: tempToken, // Replace with your token
          ),
        );

        await agoraClient.initialize();

        // Mark Agora as initialized
        isInitialized.value = true;
      } else {
        Get.snackbar(
          "Permissions Denied",
          "Camera and Microphone permissions are required for video calling.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to initialize Agora: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void startCall() {
    agoraClient.engine.joinChannel(
      token: tempToken, // Replace with your actual token
      channelId: channelName, // Replace with your actual channel name
      options: const ChannelMediaOptions(), // Required parameter now
      uid: 0,
    );
  }

  void endCall() {
    agoraClient.engine.leaveChannel();
  }

  void toggleCamera() {
    agoraClient.engine.switchCamera();
  }

  void toggleMic() {
    agoraClient.engine.muteLocalAudioStream(true);
  }
}
