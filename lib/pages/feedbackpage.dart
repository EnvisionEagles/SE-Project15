// import 'package:flutter/material.dart';
//
//
// class MarksFeedbackPage extends StatelessWidget {
//   final List<SubjectMark> marks = [
//     SubjectMark(subject: 'Mathematics', mark: 85, feedback: 'Great work on algebra!'),
//     SubjectMark(subject: 'History', mark: 76, feedback: 'Good understanding of events.'),
//     // Add more subjects and marks here...
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Marks and Feedback'),
//       ),
//       body: SingleChildScrollView(
//         child: DataTable(
//           columns: [
//             DataColumn(label: Text('Subject')),
//             DataColumn(label: Text('Mark'), numeric: true),
//             DataColumn(label: Text('Feedback')),
//           ],
//           rows: marks.map((subjectMark) {
//             return DataRow(cells: [
//               DataCell(Text(subjectMark.subject)),
//               DataCell(Text(subjectMark.mark.toString())),
//               DataCell(Text(subjectMark.feedback)),
//             ]);
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
//
// class SubjectMark {
//   final String subject;
//   final int mark;
//   final String feedback;
//
//   SubjectMark({required this.subject, required this.mark, required this.feedback});
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarksFeedbackPage extends StatefulWidget {
  @override
  _MarksFeedbackPageState createState() => _MarksFeedbackPageState();
}

class _MarksFeedbackPageState extends State<MarksFeedbackPage> {
  final List<SubjectMark> marks = [];

  @override
  void initState() {
    super.initState();
    fetchMarksFromFirestore();
  }

  Future<void> fetchMarksFromFirestore() async {
    FirebaseFirestore.instance..collection('students').doc('1').collection('marks').snapshots().listen((snapshot) {
      setState(() {
        marks.clear();
        for (var doc in snapshot.docs) {
          marks.add(SubjectMark(
            subject: doc.data()['subject'] as String,
            mark: doc.data()['mark'] as int,
            feedback: doc.data()['feedback'] as String,
          ));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marks and Feedback'),
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text('Subject')),
            DataColumn(label: Text('Mark'), numeric: true),
            DataColumn(label: Text('Feedback')),
          ],
          rows: marks.map((subjectMark) {
            return DataRow(cells: [
              DataCell(Text(subjectMark.subject)),
              DataCell(Text(subjectMark.mark.toString())),
              DataCell(Text(subjectMark.feedback)),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}

class SubjectMark {
  final String subject;
  final int mark;
  final String feedback;

  SubjectMark({required this.subject, required this.mark, required this.feedback});
}
