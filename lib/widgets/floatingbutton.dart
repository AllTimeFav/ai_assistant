import 'package:aiassistant1/screens/task_creation_screen.dart';
import 'package:flutter/material.dart';

class MyFloatingButton extends StatelessWidget {
  const MyFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateTaskScreen()),
        );
      },
      child: const Icon(Icons.mic, color: Colors.white),
      backgroundColor: Colors.blueAccent,
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      tooltip: 'Add Task', // Updated tooltip
    );
  }
}
