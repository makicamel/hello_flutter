import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ImageManager {
  static Future<String> uploadImage(File file) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String subDirectoryName = 'images';
    final StorageReference ref = FirebaseStorage()
        .ref()
        .child(subDirectoryName)
        .child('${timestamp}');
    final StorageUploadTask uploadTask = ref.putFile(
        file,
        StorageMetadata(
          contentType: "image/jpeg",
        ));
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    if (snapshot.error == null) {
      return await snapshot.ref.getDownloadURL();
    } else {
      return 'Something goes wrong';
    }
  }
}
