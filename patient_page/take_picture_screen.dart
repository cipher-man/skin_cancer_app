// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'preview_edit_Screen.dart';
import 'package:google_fonts/google_fonts.dart';

class TakePictureScreen extends StatefulWidget {
  final List<String> tickets;

  const TakePictureScreen({super.key, required this.tickets});

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen>
    with SingleTickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  late AnimationController _animationController;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller for the camera icon
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _iconAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      final XFile? image =
          await _picker.pickImage(source: ImageSource.camera);
      if (image != null && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreviewEditScreen(
              imagePath: image.path,
              tickets: widget.tickets,
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to capture image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Take Picture',
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
        ),
        automaticallyImplyLeading: false,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade100,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Camera Icon
                ScaleTransition(
                  scale: _iconAnimation,
                  child: Icon(
                    Icons.camera_alt,
                    size: 120,
                    color: Colors.blue[700],
                  ),
                ),
                const SizedBox(height: 20),
                // Instruction Text
                Text(
                  'Take a clear picture of your affected skin area',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    color: Colors.blue[700],
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 30),
                // Submit Button
                ElevatedButton(
                  onPressed: _takePicture,
                  child: Text(
                    'Submit Ticket',
                    style: GoogleFonts.dmSans(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: Colors.blue.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 20),
                // Guidance Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        'Tips:',
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '- Ensure good lighting.\n'
                        '- Focus closely on the affected area.\n'
                        '- Avoid obstructions.',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}