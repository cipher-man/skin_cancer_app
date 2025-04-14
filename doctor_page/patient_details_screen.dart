import 'package:flutter/material.dart';
import 'set_appointment_screen.dart';

class PatientDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> patient;

  PatientDetailsScreen({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Disease', style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue[700], size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Scan Image
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(patient['scanImage'] ?? 'assets/default_scan_image.jpg'), // Default image if none provided
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 20),

            // Results Section
            Text(
              'Results',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700]
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We think it\'s',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              patient['prediction'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red, // Highlight the prediction
              ),
            ),
            SizedBox(height: 20),

            // Medical History Section
            Text(
              'Medical History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700]
              ),
            ),
            SizedBox(height: 8),
            _buildMedicalHistorySection(patient['medicalHistory']),
            SizedBox(height: 20),

            // Date of Result
            Text(
              'Date of Result',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700]
              ),
            ),
            SizedBox(height: 8),
            Text(
              patient['dateOfResult'],
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(height: 40),

            // Action Buttons (Centered and Full Width)
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Confirm AI Results logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 120),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50), // Make button longer
                    ),
                    child: Center(
                      child: Text(
                        'Confirm AI Results',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SetAppointmentScreen()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.blue[700]!),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 108),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50), // Make button longer
                    ),
                    child: Center(
                      child: Text(
                        'Make an Appointment',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build the Medical History section
  Widget _buildMedicalHistorySection(Map<String, String> medicalHistory) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Current Conditions:', medicalHistory['currentMedicalConditions']),
        _buildDetailRow('Allergies:', medicalHistory['allergies']),
        _buildDetailRow('Past Surgeries/Hospitalizations:', medicalHistory['pastSurgeriesOrHospitalizations']),
        _buildDetailRow('Family Medical History:', medicalHistory['familyMedicalHistory']),
        _buildDetailRow('Current Medications:', medicalHistory['currentMedications']),
      ],
    );
  }

  // Helper method to build individual detail rows
  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 14, color: Colors.black),
          children: [
            TextSpan(text: '$label ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value ?? 'Not provided'),
          ],
        ),
      ),
    );
  }
}