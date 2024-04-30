import 'package:flutter/material.dart';



class AdminScreen extends StatelessWidget {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school, size: 52.0, color: Colors.white),
                  Text('Admin', style: TextStyle(color: Colors.white, fontSize: 24.0)),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                // Handle Dashboard tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Teacher Section'),
              onTap: () {
                // Handle Teacher Section tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Student Section'),
              onTap: () {
                // Handle Student Section tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Manage Courses'),
              onTap: () {
                // Handle Manage Courses tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Manage Questions'),
              onTap: () {
                // Handle Manage Questions tap
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
              color: Colors.red,
            ),
            DashboardTile(
              title: 'Total Teachers',
              count: 1,
              iconData: Icons.person_outline,
              color: Colors.green,
            ),
            DashboardTile(
              title: 'Total Courses',
              count: 2,
              iconData: Icons.library_books,
              color: Colors.blue,
            ),
            DashboardTile(
              title: 'Available Questions',
              count: 1,
              iconData: Icons.question_answer,
              color: Colors.amber,
            ),
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
