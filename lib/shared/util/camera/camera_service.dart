import 'package:camera/camera.dart';

class CameraService {
  CameraController? controller;

  Future<bool> initialize() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        return false;
      }
      controller = CameraController(
        cameras.first,
        ResolutionPreset.low,
        enableAudio: false,
      );
      await controller?.initialize();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<XFile?> takePicture() async {
    if (controller == null || !controller!.value.isInitialized) {
      return null;
    }
    if (controller!.value.isTakingPicture) {
      return null;
    }
    try {
      return await controller!.takePicture();
    } catch (e) {
      print(e);
      return null;
    }
  }

  void dispose() {
    controller?.dispose();
  }
}
