import 'package:aiassistant1/models/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyTaskListView extends StatelessWidget {
  final List<Task> tasks;

  const MyTaskListView({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Text(
          'No tasks found\nTap the + button to add a new task',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Dismissible(
          key: Key(task.id),
          background: Container(color: Colors.red),
          secondaryBackground: Container(color: Colors.green),
          confirmDismiss: (direction) async {
            // Add your delete/complete logic here
            return true; // Return false to cancel dismissal
          },
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListTile(
                leading: _buildCategoryIcon(task.category),
                title: Text(
                  task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    decoration:
                        task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (task.description?.isNotEmpty ?? false)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(task.description ?? ''),
                      ),
                    Text(
                      'Due: ${DateFormat('MMM dd, yyyy').format(task.dueDate)}',
                      style: TextStyle(
                        color: _getDueDateColor(task.dueDate),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) {
                    // Add your task completion toggle logic here
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryIcon(String category) {
    final iconData = switch (category.toLowerCase()) {
      'study' => Icons.school,
      'work' => Icons.work,
      'personal' => Icons.person,
      'health' => Icons.favorite,
      _ => Icons.task,
    };

    return CircleAvatar(
      backgroundColor: _getCategoryColor(category),
      child: Icon(iconData, color: Colors.white),
    );
  }

  Color _getCategoryColor(String category) {
    return switch (category.toLowerCase()) {
      'study' => Colors.blue,
      'work' => Colors.purple,
      'personal' => Colors.green,
      'health' => Colors.red,
      _ => Colors.orange,
    };
  }

  Color _getDueDateColor(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;

    if (dueDate.isBefore(now)) {
      return Colors.red; // Overdue
    } else if (difference <= 1) {
      return Colors.orange; // Due soon (today or tomorrow)
    } else {
      return Colors.grey; // Not urgent
    }
  }
}
