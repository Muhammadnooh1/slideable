import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DismissibleContactsList(),
    );
  }
}

class DismissibleContactsList extends StatefulWidget {
  @override
  _DismissibleContactsListState createState() => _DismissibleContactsListState();
}

class _DismissibleContactsListState extends State<DismissibleContactsList> {
  final List<Contact> contacts = [
    Contact(name: 'John Doe', gender: 'Male'),
    Contact(name: 'Jane Smith', gender: 'Female'),
    Contact(name: 'Michael Brown', gender: 'Male'),
    Contact(name: 'Emily Davis', gender: 'Female'),
    Contact(name: 'James Wilson', gender: 'Male'),
    Contact(name: 'Sophia Martinez', gender: 'Female'),
    Contact(name: 'David Anderson', gender: 'Male'),
    Contact(name: 'Olivia Thomas', gender: 'Female'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slideable in Contacts List'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(contacts[index].name),
            background: slideLeftBackground(),
            secondaryBackground: slideRightBackground(),
            onDismissed: (direction) {
              String action;
              if (direction == DismissDirection.endToStart) {
                action = 'deleted';
              } else {
                action = 'archived';
              }
              String contactName = contacts[index].name;
              setState(() {
                contacts.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$action $contactName')),
              );
            },
            child: ListTile(
              title: Text(contacts[index].name),
              subtitle: Text(contacts[index].gender),
            ),
          );
        },
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.pink,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.blue,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(
            Icons.archive,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Contact {
  final String name;
  final String gender;

  Contact({required this.name, required this.gender});
}