import 'package:course_navigator/pages/adminpage.dart';
import 'package:course_navigator/pages/singuppage.dart';
import 'package:course_navigator/pages/studentdashbord.dart';
import 'package:course_navigator/pages/techer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

 main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void initNotification() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification!.title}');
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Navigator System',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // useMaterial3: true
      ),

      home: HomePage(),
    );
  }
  MyApp() {
    initNotification();
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {

    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Navigator System'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Navigate to the Home page
            },
            child: Text('Home'),
            style: TextButton.styleFrom(
              // primary: Colors.white, //white Text color
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TecherScreen()),
              );
            },
            child: Text('Teacher'),
            style: TextButton.styleFrom(


            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  DashboardPage()),
              );
              // Navigate to the Student page
            },
            child: Text('Student'),
            style: TextButton.styleFrom(

            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>    AdminScreen()),
              );

              // Navigate to the Admin page
            },
            child: Text('Admin'),
            style: TextButton.styleFrom(

            ),
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Course Navigator System',
              style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Attend your examinations online!\nSign Up now to start your first online examination',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Handle sign up action
              },
              child: Text('Start Your Journey Here'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              icon: Icon(Icons.school),
              label: Text('Sign Up as Student'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.lightBlue, // Text color
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.facebook),
              onPressed: () {
                // Handle Facebook link action
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // Handle Twitter link action
              },
            ),
            IconButton(
              icon: Icon(Icons.email),
              onPressed: () {
                // Handle Email link action
              },
            ),
          ],
        ),
      ),
    );
  }
}


