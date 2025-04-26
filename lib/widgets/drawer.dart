import 'package:aiassistant1/Theme/Mytheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  final image =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQL5vOVk60fM-tCjEg1_R0OGtOp3dChyHSuew&s";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: MyTheme.primaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.orange),
                accountName: const Text("User Name"),
                accountEmail: const Text("user@gamil.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(image),
                  // backgroundImage: AssetImage(image),
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.home, color: Colors.white),
              title: Text("Home", style: TextStyle(color: Colors.white)),
            ),
            const ListTile(
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white,
              ),
              title: Text(
                "User Profile",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const ListTile(
              leading: Icon(CupertinoIcons.mail, color: Colors.white),
              title: Text("Gmail", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
