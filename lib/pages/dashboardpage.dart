
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Dashbordpage extends StatefulWidget {
  const Dashbordpage({super.key});

  @override
  State<Dashbordpage> createState() => _DashbordpageState();
}

class _DashbordpageState extends State<Dashbordpage> {
  int availableExams = 0;
  int totalQuestions = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    // Fetch stats overview from Firestore
    var statsDoc = await FirebaseFirestore.instance.collection('students').doc('1').get();
    if (statsDoc.exists) {
      setState(() {
        availableExams = statsDoc.data()?['availableExams'] ?? 0;
        totalQuestions = statsDoc.data()?['totalQuestions'] ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            color: Colors.teal,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.list_alt, size: 50),
                  Text('Available Exams'),
                  Text('$availableExams', style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.red,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.help_outline, size: 50),
                  Text('Total Questions'),
                  Text('$totalQuestions', style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
          ),
          // Add more cards as needed
        ],
      ),
    );
  }
}
