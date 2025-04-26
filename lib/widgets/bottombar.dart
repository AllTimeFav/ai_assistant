// import 'package:budget_app/Theme/Mytheme.dart';
// import 'package:flutter/material.dart';

// class MyBottomBar extends StatelessWidget {
//   const MyBottomBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: MyTheme.primaryColor,  // Customize colors
//       unselectedItemColor: MyTheme.greyColor,
//       showUnselectedLabels: true,
//       items: const [
//         BottomNavigationBarItem(

//           icon: Icon(Icons.check_circle_outline),
//           label: "Tasks",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.schedule),
//           label: "Schedule",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.mood),
//           label: "Mood",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.notifications_active),
//           label: "Reminders",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.summarize),
//           label: "Summaries",
//         ),
//       ],
//     );
//   }
// }

import 'package:aiassistant1/Theme/Mytheme.dart';
import 'package:flutter/material.dart';

class MyBottomBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const MyBottomBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int _selectedIndex = 0;

  // List of pages to navigate
  // final List<Widget> _pages = [
  //   TasksPage(),
  //   SchedulePage(),
  //   MoodPage(),
  //   RemindersPage(),
  //   SummariesPage(),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
    });

    // Navigate to the selected page
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => _pages[index]),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: MyTheme.primaryColor,
      unselectedItemColor: MyTheme.greyColor,
      currentIndex: widget.currentIndex, // use HomePage's index
      onTap: (index) {
        widget.onItemTapped(index); // tell HomePage what was tapped
      },
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle_outline),
          label: "Tasks",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.schedule), label: "Schedule"),
        BottomNavigationBarItem(icon: Icon(Icons.mood), label: "Mood"),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_active),
          label: "Reminders",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.summarize),
          label: "Summaries",
        ),
      ],
    );
  }
}
