import 'package:flutter/material.dart';
class TecherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COURSE NAVIGATOR'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Handle logout logic
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Vijaya (Teacher)'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Manage Courses'),
              onTap: () {
                // Update the state of the app
                // ...
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Manage Questions'),
              onTap: () {
                // Update the state of the app
                // ...
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Wrap(
          spacing: 20, // space between the tiles
          runSpacing: 20, // space between the rows
          children: <Widget>[
            DashboardTile(
              title: 'Registered Students',
              count: 1,
              iconData: Icons.person,
              color: Colors.teal,
            ),
            DashboardTile(
              title: 'Total Courses',
              count: 2,
              iconData: Icons.book,
              color: Colors.red,
            ),
            DashboardTile(
              title: 'Total Questions',
              count: 1,
              iconData: Icons.question_answer,
              color: Colors.cyan,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // IconButton(icon: Icon(Icons.facebook), onPressed: () {}),
            // IconButton(icon: Icon(Icons.twitter), onPressed: () {}),
            // IconButton(icon: Icon(Icons.), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class DashboardTile extends StatelessWidget {
  final String title;
  final int count;
  final IconData iconData;
  final Color color;

  const DashboardTile({

    required this.title,
    required this.count,
    required this.iconData,
    required this.color,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Container(
        width: 150.0,
        height: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(iconData, size: 30.0, color: Colors.white),
            Text(
              '$count',
              style: TextStyle(color: Colors.white, fontSize: 22.0),
            ),
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
