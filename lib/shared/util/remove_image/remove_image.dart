import 'dart:io';

void removeImageLocal(String filePath) async {
  try {
    File file = File(filePath);

    if (await file.exists()) {
      await file.delete();
      file.deleteSync();
    }
  } catch (e) {
    print('Error while deleting file: $e');
  }
}
