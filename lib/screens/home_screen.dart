import 'package:aiassistant1/widgets/floatingbutton.dart';
import 'package:aiassistant1/widgets/mycalender.dart';
import 'package:aiassistant1/widgets/taskview.dart';
import 'package:flutter/material.dart';
import 'package:aiassistant1/widgets/bottombar.dart';
import 'package:aiassistant1/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<String> _items = List.generate(20, (index) => "Item ${index + 1}");

  late List<Widget> _pages; // Use late!

  @override
  void initState() {
    super.initState();

    _pages = [
      MyTaskListView(items: _items), // Now _items is ready
      const CalendarPage(),
      const Center(child: Text('Mood Page')),
      const Center(child: Text('Reminders Page')),
      const Center(child: Text('Summaries Page')),
    ];
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
