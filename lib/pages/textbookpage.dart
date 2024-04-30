// import 'package:flutter/material.dart';
//
// class BookStoreHomePage extends StatelessWidget {
//   final List<Map<String, dynamic>> books = [
//     {
//       'title': 'Atomic Habits',
//       'author': 'James Clear',
//       'price': '\$25',
//       'tags': ['Non-fiction', 'Business', 'Self Improvement'],
//       'imageUrl': 'https://via.placeholder.com/150',
//     },
//     {
//       'title': 'Let My People Go Surfing',
//       'author': 'Yvon Chouinard',
//       'price': '\$22',
//       'tags': ['Non-fiction', 'Entrepreneurship', 'Autobiography'],
//       'imageUrl': 'https://via.placeholder.com/150',
//     },
//     // Add more books here
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         childAspectRatio: 0.6,
//       ),
//       itemCount: books.length,
//       itemBuilder: (context, index) {
//         return BookItem(books[index]);
//       },
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class BookItem extends StatelessWidget {
  final Map<String, dynamic> book;

  BookItem(this.book);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Image.network(
              book['imageUrl'] as String,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  book['title'] as String,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  book['author'] as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  book['price'] as String,
                  style: TextStyle(color: Colors.green),
                ),
                Wrap(
                  spacing: 4.0, // Spacing between chips
                  children: (book['tags'] as List<dynamic>).map<Widget>((tag) {
                    return Chip(
                      label: Text(tag as String),
                      backgroundColor: Colors.grey[200],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class BookStoreHomePage extends StatefulWidget {
  @override
  _BookStoreHomePageState createState() => _BookStoreHomePageState();
}

class _BookStoreHomePageState extends State<BookStoreHomePage> {
  List<Map<String, dynamic>> books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      var collection = FirebaseFirestore.instance.collection('students').doc('1').collection('books');
      var querySnapshot = await collection.get();
      for (var queryDocumentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = queryDocumentSnapshot.data() as Map<String, dynamic>;
        books.add({
          'title': data['title'],
          'author': data['author'],
          'price': data['price'],
          'tags': List<String>.from(data['tags']),
          'imageUrl': data['imageUrl'],
        });
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.6,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return BookItem(books[index]);
      },
    );
  }
}
