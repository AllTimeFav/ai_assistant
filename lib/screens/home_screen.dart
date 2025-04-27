import 'package:aiassistant1/models/task.dart';
import 'package:aiassistant1/widgets/floatingbutton.dart';
import 'package:aiassistant1/widgets/mycalender.dart';
import 'package:aiassistant1/widgets/taskview.dart';
import 'package:flutter/material.dart';
import 'package:aiassistant1/widgets/bottombar.dart';
import 'package:aiassistant1/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late List<Widget> _pages;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildTaskStream(), // Replaced with Firestore stream
      const CalendarPage(),
      const Center(child: Text('Mood Page')),
      const Center(child: Text('Reminders Page')),
      const Center(child: Text('Summaries Page')),
    ];
  }

  Widget _buildTaskStream() {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore
              .collection('tasks')
              .orderBy('due_date') // Optional: Sort by due date
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No tasks found'));
        }

        return MyTaskListView(
          tasks:
              snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return Task(
                  id: doc.id,
                  title: data['task'] ?? 'No Title',
                  dueDate: _parseDate(data['due_date']),
                  category: data['category'] ?? 'other',
                  isCompleted: data['isCompleted'] ?? false,
                );
              }).toList(),
        );
      },
    );
  }

  DateTime _parseDate(dynamic date) {
    if (date is Timestamp) return date.toDate();
    if (date is String) {
      try {
        return DateFormat('dd-MM-yyyy').parse(date);
      } catch (e) {
        return DateTime.now().add(const Duration(days: 1));
      }
    }
    return DateTime.now().add(const Duration(days: 1));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(title: const Text("AI Personal Assistant")),
      body: _pages[_selectedIndex],
      bottomNavigationBar: MyBottomBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: const MyFloatingButton(),
    );
  }
}
