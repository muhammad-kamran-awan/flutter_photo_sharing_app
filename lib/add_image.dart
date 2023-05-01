import 'package:file_picker/file_picker.dart';
import 'package:firebase_crud/home_page.dart';
import 'package:firebase_crud/storage_service.dart';
import 'package:flutter/material.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Image'),
      ),
      body: Column(
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () async {
                    final results = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['png', 'jpg']);

                    if (results == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("No File Selected")));
                      return null;
                    }
                    final path = results.files.single.path!;
                    final fileName = results.files.single.name;

                    storage
                        .uploadFile(path, fileName)
                        .then((value) => print('Done'));
                  },
                  child: Text("Upload Image"))),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Go Back")),
        ],
      ),
    );
  }
}
