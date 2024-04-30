// import 'package:flutter/material.dart';
//
//
//
// class SignupPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Course Navigator'),
//         // Add AppBar actions if needed
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: <Widget>[
//             Text(
//               'Student Signup Form',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Form(
//               child: Column(
//                 children: <Widget>[
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'First Name',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Last Name',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Contact Number',
//                       border: OutlineInputBorder(),
//                     ),
//                     keyboardType: TextInputType.phone,
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Address',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Username',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       border: OutlineInputBorder(),
//                     ),
//                     obscureText: true,
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Implement file picker for profile picture
//                     },
//                     child: Text('Choose File'),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Implement sign up logic
//                     },
//                     child: Text('Sign Up'),
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: Size.fromHeight(50), // specify the height of the button
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Use FirebaseAuth to create user credentials
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _usernameController.text, // Assuming the username is the email
          password: _passwordController.text,
        );

        // Add additional user details to Firestore under 'users' collection
        FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'contactNumber': _contactNumberController.text,
          'address': _addressController.text,
        });

        // Handle post sign up logic, like navigation
        Navigator.pushReplacementNamed(context, '/home'); // Adjust as needed
      } on FirebaseAuthException catch (e) {
        // Handle errors
        if (e.code == 'weak-password') {
          showDialog(context: context, builder: (context) => AlertDialog(content: Text('The password provided is too weak.')));
        } else if (e.code == 'email-already-in-use') {
          showDialog(context: context, builder: (context) => AlertDialog(content: Text('The account already exists for that email.')));
        }
      } catch (e) {
        print(e); // For debugging
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Navigator'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Student Signup Form',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                controller: _firstNameController,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                controller: _lastNameController,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                controller: _contactNumberController,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                controller: _addressController,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                controller: _usernameController,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(height: 16),

              // Add other form fields here...
              ElevatedButton(
                onPressed: signUp,
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50), // specify the height of the button
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
