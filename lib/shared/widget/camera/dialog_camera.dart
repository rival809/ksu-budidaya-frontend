import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class CameraDialog extends StatefulWidget {
  final Function(XFile?) onImageCaptured;
  final bool isMobile;

  const CameraDialog({
    super.key,
    required this.onImageCaptured,
    required this.isMobile,
  });

  @override
  _CameraDialogState createState() => _CameraDialogState();
}

class _CameraDialogState extends State<CameraDialog> {
  final CameraService _cameraService = CameraService();
  bool _cameraInitialized = false;
  String _errorMessage = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    setState(() {
      isLoading = true;
    });
    bool initialized = await _cameraService.initialize();
    setState(() {
      isLoading = false;
    });
    if (!initialized) {
      setState(() {
        _errorMessage = 'Camera permission denied or no camera available.';
      });
    } else {
      setState(() {
        _cameraInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _cameraService.dispose();
    isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          width: widget.isMobile
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: _cameraInitialized
                    ? CameraPreview(_cameraService.controller!)
                    : Center(child: Text(_errorMessage)),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        text: "Kembali",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 24.0,
                    ),
                    Expanded(
                      child: PrimaryButton(
                        pathIcon: "assets/icons/misc/add_photo.svg",
                        onPressed: _cameraInitialized
                            ? () async {
                                XFile? file =
                                    await _cameraService.takePicture();
                                await widget.onImageCaptured(file);
                                Navigator.pop(context);
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
