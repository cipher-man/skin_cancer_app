import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

class PreviewEditScreen extends StatefulWidget {
  final String imagePath;
  final List<String> tickets; // List to store submitted tickets

  const PreviewEditScreen({
    required this.imagePath,
    required this.tickets,
  });

  @override
  _PreviewEditScreenState createState() => _PreviewEditScreenState();
}

class _PreviewEditScreenState extends State<PreviewEditScreen> {
  late String _currentImagePath;

  @override
  void initState() {
    super.initState();
    _currentImagePath = widget.imagePath; // Initialize with original image path
  }

  Future<void> _cropImage() async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: _currentImagePath,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: Colors.blue,
          lockAspectRatio: false, // Freeform cropping
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _currentImagePath = croppedFile.path; // Update with cropped file path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
            colors: [Colors.blue.shade100, // Light blue at the top
              Colors.white, ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Custom IconButton at the top-left corner
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context), // Navigate back
                  icon: Icon(
                    Icons.arrow_back, // AppBar back icon
                    color: Colors.white, // Match the AppBar icon color
                    size: 24, // Match the AppBar icon size
                  ),
                  splashRadius: 24, // Add some splash effect consistency
                ),
              ),
            ),
            Expanded(
              child: PhotoView(
                imageProvider: FileImage(File(_currentImagePath)),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                backgroundDecoration: BoxDecoration(
                  color: Colors.transparent, // Remove black frame
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _cropImage,
                  child: Text('Crop' , style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 20, 117, 181),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Add the image to the ticket list
                    widget.tickets.add(_currentImagePath);
                    // Navigate back to TakePictureScreen
                    Navigator.pop(context);
                  },
                  child: Text('Submit Ticket', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 20, 117, 181),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}