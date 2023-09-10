import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

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
  double? _confidence;

  File resizeImage(File imageFile) {
    // Citim imaginea din fișier
    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());

    // Redimensionăm imaginea la 456x456 pixeli
    img.Image resizedImage = img.copyResize(image!, width: 456, height: 456);

    // Salvăm imaginea redimensionată într-un nou fișier
    File resizedFile = File('${imageFile.path}_resized.jpg')
      ..writeAsBytesSync(img.encodeJpg(resizedImage));

    return resizedFile;
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _isLoading = true; // set loading to true
        _diagnosis = null; // reset the diagnosis
        _uploadImage(_image!).then((result) {
          setState(() {
            _isLoading = false;
            _diagnosis = result['prediction'];
            _confidence = result['confidence'];
          });
        });
      } else {
        print('Please select an image');
      }
    });
  }

  Future<Map<String, dynamic>> _uploadImage(File image) async {
    const url = 'https://abadescu-dermoskin-app.loca.lt/api/upload-image';
    final request = http.MultipartRequest('PUT', Uri.parse(url));
    var _myimage = resizeImage(image);
    request.files.add(http.MultipartFile(
      'image',
      _myimage.readAsBytes().asStream(),
      _myimage.lengthSync(),
      filename: _myimage.path.split('/').last,
    ));

    try {
      final response = await request.send();
      print(response);
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final Map<String, dynamic> data = json.decode(responseData);
        return data;
      } else {
        print('Failed to upload image: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
    return <String, dynamic>{};
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
                      ? Text("Diagnosis: $_diagnosis \nConfidence $_confidence")
                      : Container(),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _getImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4757E9),
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Open Camera",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
