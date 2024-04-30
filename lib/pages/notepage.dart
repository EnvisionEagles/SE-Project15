// import 'package:flutter/material.dart';
//
//
//
// class NotesPage extends StatefulWidget {
//   @override
//   _NotesPageState createState() => _NotesPageState();
// }
//
// class _NotesPageState extends State<NotesPage> {
//   final TextEditingController _controller = TextEditingController();
//   List<String> notes = []; // List to hold notes
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Write and View Notes'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 hintText: 'Enter your note here',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: null,
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 if (_controller.text.isNotEmpty) {
//                   notes.add(_controller.text); // Add note to the list
//                   _controller.clear(); // Clear the text field
//                 }
//               });
//             },
//             child: Text('Save Note'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: notes.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(notes[index]),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () {
//                       setState(() {
//                         notes.removeAt(index); // Remove note from the list
//                       });
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _controller = TextEditingController();
  final CollectionReference notesCollection = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write and View Notes'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter your note here',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_controller.text.isNotEmpty) {
                await notesCollection.add({'text': _controller.text});
                _controller.clear();
              }
            },
            child: Text('Save Note'),
          ),
          Expanded(
            child: StreamBuilder(
              stream: notesCollection.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    return ListView(
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        return ListTile(
                          title: Text(data['text']),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              document.reference.delete();
                            },
                          ),
                        );
                      }).toList(),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
