import 'dart:io';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('Please select an image');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? const Text('Please select an image.')
                : Image.file(_image!),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: _getImage,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF4757E9), // Set the background color here
                minimumSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Set the border radius
                ),
              ),
              child: const Text("Open camera"),
            ),
            // Adăugați aici butonul de upload sau orice altă logică pe care o doriți
          ],
        ),
      ),
    );
  }
}
