import 'package:flutter/material.dart';

class MyFloatingButton extends StatelessWidget {
  const MyFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        print('Customized FAB pressed!');
      },
      child: Icon(Icons.mic, color: Colors.white),
      backgroundColor: Colors.blueAccent,
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      tooltip: 'Open Camera',
    );
  }
}