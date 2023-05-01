import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';

Set<String> imageUrls = {};

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);
    try {
      await storage.ref('test/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  // Future<firebase_storage.ListResult> listFiles() async {
  //   firebase_storage.ListResult results = await storage.ref('test').listAll();
  //   final List<Reference> allImages = results.items;

  //   for (final imageRef in allImages) {
  //     final url = await imageRef.getDownloadURL();
  //     imageUrls.add(url);
  //   }
  //   return results;
  // }

  Future<Set> downloadURL() async {
    final ListResult result = await storage.ref().child('test/').listAll();
    final List<Reference> allImages = result.items;

    for (final imageRef in allImages) {
      final url = await imageRef.getDownloadURL();
      imageUrls.add(url);

      // String downloadURL = await storage.ref('test/').getDownloadURL();

      // return downloadURL;
    }

    return imageUrls;
  }
}
