import 'package:flutter/material.dart';
import 'take_picture_screen.dart';
import 'tickets_list.dart';
import 'patinet_info.dart';
import 'appointment_screen.dart';

class PatientPage extends StatefulWidget {
  final String patientImage; // Profile image URL
  final String patientName; // Patient's name

  const PatientPage({super.key, required this.patientName, required this.patientImage});

  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  int _selectedIndex = 0; // Index for the bottom navigation bar
  List<String> _tickets = []; // List to store ticket image paths

  // Screens for each navigation item
  List<Widget> get _screens => [
        TakePictureScreen(tickets: _tickets), // Pass the tickets list
        TicketListScreen(tickets: _tickets), // Pass the list of tickets
        PatientProfileSettingsScreen(),
        AppointmentScreen(), // Added appointment section
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 231, 239, 250)),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.blue, // Changed background to blue
          borderRadius: BorderRadius.vertical(top: Radius.circular(0)), // Rounded edges
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
          child: BottomNavigationBar(
            backgroundColor: Colors.blue[700], // Ensure consistent blue background
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.white, // Icons & text are now white
            unselectedItemColor: Colors.white.withOpacity(0.7), // Slight fade effect for inactive items
            showSelectedLabels: true, // Shows labels correctly
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed, // Ensures consistent styling
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt),
                label: 'Take Picture',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Tickets',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Appointments',
              ),
            ],
          ),
        ),
      ),
    );
  }
}