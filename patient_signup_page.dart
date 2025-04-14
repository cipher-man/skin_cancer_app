import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientSignupPage extends StatefulWidget {
  const PatientSignupPage({super.key});

  @override
  State<PatientSignupPage> createState() => _PatientSignupPageState();
}

class _PatientSignupPageState extends State<PatientSignupPage> {
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final nationalIdController = TextEditingController();

  
  bool isPasswordVisible = false;

  
  bool isValidEmail(String email) {
    
    final allowedDomains = ['gmail.com', 'yahoo.com', 'outlook.com'];

    
    final emailParts = email.split('@');
    if (emailParts.length != 2) return false; 

    final domain = emailParts[1];

    
    return allowedDomains.contains(domain);
  }

  
  bool isValidPassword(String password) {
    
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    final hasMinLength = password.length >= 8;

    
    return hasUppercase && hasLowercase && hasNumber && hasSpecialChar && hasMinLength;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Text(
                  'Create Account',
                  style: GoogleFonts.dmSerifText(
                    color: Color.fromARGB(255, 20, 117, 181),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 9),
                Image.asset(
                  'assests/Mobile login-bro.png',
                  height: 122,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Email Field
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(30, 3, 20, 0),
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.black,
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.grey,
                            ),
                            hintText: 'Email Address',
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Password Field
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(30, 3, 20, 0),
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          obscureText: !isPasswordVisible,
                          cursorColor: Colors.black,
                          controller: passwordController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Phone Number Field
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(30, 3, 20, 0),
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          cursorColor: Colors.black,
                          controller: phoneController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.phone,
                              color: Colors.grey,
                            ),
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // National ID Field
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(30, 3, 20, 0),
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          controller: nationalIdController,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.credit_card,
                              color: Colors.grey,
                            ),
                            hintText: 'National ID',
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Signup Button
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            if (emailController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Email is required')),
                              );
                            } else if (!isValidEmail(emailController.text)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Email must end with gmail.com, yahoo.com, or outlook.com')),
                              );
                            } else if (passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Password is required')),
                              );
                            } else if (!isValidPassword(passwordController.text)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character')),
                              );
                            } else if (phoneController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Phone number is required')),
                              );
                            } else if (nationalIdController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('National ID is required')),
                              );
                            } else {

                              print('Email: ${emailController.text}');
                              print('Password: ${passwordController.text}');
                              print('Phone: ${phoneController.text}');
                              print('National ID: ${nationalIdController.text}');


                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Color.fromARGB(255, 20, 117, 181),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Signup',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Already have an account? Login',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
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