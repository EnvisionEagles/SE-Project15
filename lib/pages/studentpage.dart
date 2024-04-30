// import 'package:flutter/material.dart';
//
//
// class ExaminationPage extends StatefulWidget {
//   @override
//   State<ExaminationPage> createState() => _ExaminationPageState();
// }
//
// class _ExaminationPageState extends State<ExaminationPage> {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               color: Colors.blue.shade300,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text('Exam Name', style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text('Available Courses', style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text('Action', style: TextStyle(fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 10, // Replace with your dynamic data
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text('STA 120'),
//
//                     trailing: ElevatedButton(
//                       onPressed: () {
//                         // Handle exam entry logic
//                       },
//                       child: Text('Attend Exam'),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_navigator/pages/testQues.dart';
import 'package:flutter/material.dart';

class ExaminationPage extends StatefulWidget {
  @override
  State<ExaminationPage> createState() => _ExaminationPageState();
}

class _ExaminationPageState extends State<ExaminationPage> {
  List<dynamic> exams = [];

  @override
  void initState() {
    super.initState();
    fetchExams();
  }

  void fetchExams() async {
    // Assuming the document ID is known and the array is stored under the key 'exams'
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('students').doc('1').collection('more').doc('exames').get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      setState(() {
        exams = data['exams'] ?? [];  // Assuming 'exams' is the key for the array
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              color: Colors.blue.shade300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Exam Name', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Action', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: exams.length,
                itemBuilder: (context, index) {
                  var exam = exams[index];
                  return ListTile(
                    title: Text(exam['name']),  // Assuming each exam has a 'name'
                    trailing: ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Quezz()),
                        );
                      },
                      child: Text('Attend Exam'),
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

  void attendExam(BuildContext context, Map exam) {
    TextEditingController markController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter your mark"),
          content: TextField(
            controller: markController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Mark",
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                storeMark(exam, markController.text);
                Navigator.of(context).pop();
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  void storeMark(Map exam, String mark) async {
    // Assuming you have a way to update the exam's mark within the array in the document
    // This could be complex depending on your Firestore schema and needs Firestore array handling
    // You would likely need to use a transaction or a batched write to ensure atomic updates
    // Below is just a pseudo code and may not directly work
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference docRef = FirebaseFirestore.instance.collection('students').doc('1').collection('more').doc('exames');
      DocumentSnapshot snapshot = await transaction.get(docRef);
      List<dynamic> updatedExams = List.from(snapshot.get('exams'));
      int index = updatedExams.indexWhere((e) => e['id'] == exam['id']); // Assuming each exam has a unique 'id'
      updatedExams[index]['mark'] = mark; // Update the mark
      transaction.update(docRef, {'exams': updatedExams});
    });
  }
}
