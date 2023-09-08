import 'dart:io';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image;
  bool _isLoading = false;
  String? _diagnosis;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _isLoading = true; // set loading to true
        _diagnosis = null; // reset the diagnosis

        // Call your API here and set _isLoading to false and _diagnosis
        // For demo, let's set diagnosis to "Test" after 2 seconds
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _isLoading = false;
            _diagnosis = "Test Disease"; // Replace with API response
          });
        });
      } else {
        print('Please select an image');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? const Text('No image selected.')
                  : Image.file(_image!),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : _diagnosis != null
                      ? Text("Diagnosis: $_diagnosis")
                      : Container(),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _getImage,
                child: const Text("Open Camera"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
