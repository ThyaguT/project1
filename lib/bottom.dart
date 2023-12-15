import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweet_nav_bar/sweet_nav_bar.dart';

import 'homepg.dart';
import 'menu_screen.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int mainindex = 0;
  List pages = [Home(),Menu()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.more_vert),
        ),
        body: pages[mainindex],
        bottomNavigationBar: SweetNavBar(
          currentIndex: mainindex,
          paddingBackgroundColor: const Color(0xFF232227),
          items: [
            SweetNavBarItem(
                sweetActive: const Icon(Icons.home),
                sweetIcon: const Icon(
                  Icons.home_outlined,
                ),
                sweetLabel: 'Home',
                sweetBackground: Colors.blue),
            SweetNavBarItem(
                sweetIcon: const Icon(Icons.menu_book,),sweetLabel: 'Menu' ),
            SweetNavBarItem(
                sweetIcon: const Icon(Icons.person,), sweetLabel: 'Profile'),
          ],
          onTap: (index) {
            setState(() {
              mainindex=index;
            });
          },

        )
    );
  }
}