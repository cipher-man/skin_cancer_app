import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int _selectedTabIndex = 0;

  final List<Map<String, dynamic>> allAppointments = [
    {
      'name': 'William Andrew',
      'date': '22 Feb 2024',
      'time': '09:45 PM',
      'status': 'At Clinic',
      'appointmentId': '145875AB',
      'doctorImage': 'assests/black_doctor.jpg',
      'completed': false, // Pending
    },
    {
      'name': 'Saniya Lieders',
      'date': '20 Feb 2024',
      'time': '05:30 PM',
      'status': 'Completed',
      'appointmentId': '145876AB',
      'doctorImage': 'assests/black_doctor.jpg',
      'completed': true, // Completed
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Center(
            child: Text(
              'My Appointment',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            ),
          ),
          backgroundColor: Colors.blue[700], // Updated AppBar color
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade100, // Light blue at the top
              Colors.white, // White at the bottom
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            // Horizontal Scrolling Tabs
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _buildTabButton(0, 'Pending Appointment'),
                  SizedBox(width: 10),
                  _buildTabButton(1, 'Complete Appointment'),
                ],
              ),
            ),

            // Appointment List (Filtered Based on Selected Tab)
            Expanded(
              child: ListView.builder(
                itemCount: allAppointments.where((apt) => apt['completed'] == (_selectedTabIndex == 1)).length,
                itemBuilder: (context, index) {
                  final appointment = allAppointments
                      .where((apt) => apt['completed'] == (_selectedTabIndex == 1))
                      .toList()[index];

                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Doctor Name & Appointment ID in the same row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(appointment['name'],
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              Row(
                                children: [
                                  Icon(Icons.confirmation_number,
                                      color: Colors.blue[700], size: 20),
                                  SizedBox(width: 8),
                                  Text(appointment['appointmentId'],
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          // Doctor Image & Appointment Details
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  appointment['doctorImage'],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoRow(Icons.calendar_today,
                                        'Date: ${appointment['date']}'),
                                    SizedBox(height: 5),
                                    _buildInfoRow(Icons.access_time,
                                        'Time: ${appointment['time']}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          // Status (Gray Box for "At Clinic" / "Completed" Alignment)
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                appointment['status'],
                                style: TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          SizedBox(height: 10),

                          // Divider Between Buttons & Texts
                          Divider(thickness: 1.5, color: Colors.grey[400]),

                          // Action Buttons (Styled Like "Pending Appointment")
                          if (!appointment['completed']) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildStyledButton('Check In', Colors.blue),
                                SizedBox(width: 10),
                                _buildStyledButton('Check Out', Colors.green),
                                SizedBox(width: 10),
                                _buildStyledButton('Cancel', Colors.red),
                              ],
                            ),
                          ]
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Styled tab buttons (For Pending & Completed Tabs)
  Widget _buildTabButton(int index, String text) {
    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: _selectedTabIndex == index ? Colors.blue[700] : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue[700]!),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: _selectedTabIndex == index ? Colors.white : Colors.blue[700],
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Helper to build info row with an icon
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue[700], size: 20),
        SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 16)),
      ],
    );
  }

  // Helper to build styled buttons (Similar to Tab Buttons)
  Widget _buildStyledButton(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
        color: Colors.white,
      ),
      child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }
}