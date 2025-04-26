import 'package:flutter/material.dart';


class MyTaskListView extends StatelessWidget {
  final List<String> items;

  const MyTaskListView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListTile(
              title: Text(items[index], style: TextStyle(fontWeight:FontWeight.bold, fontSize:24  ),),
              subtitle: Text("${items[index]} This is subtitle"),
            ),
          ),
        );
      },
    );
  }
}