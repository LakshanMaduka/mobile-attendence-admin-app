import 'dart:math';

import 'package:attendence_admin_app/Screens/admin/subScreens/classesScreen.dart';
import 'package:attendence_admin_app/Screens/admin/subScreens/mark_attendence/markAttendenceScreen.dart';
import 'package:attendence_admin_app/Screens/admin/subScreens/register/registerSctreen.dart';
import 'package:attendence_admin_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum MenuItem {
  item1,
}

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  // openClassScreen(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const ClassesScreen()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Admin'),
          actions: [
            PopupMenuButton(
                onSelected: (value) {
                  if (value == MenuItem.item1) {
                    FirebaseAuth.instance.signOut();
                  }
                },
                itemBuilder: (context) => [
                      PopupMenuItem(
                          value: MenuItem.item1, child: Text('Sign Out'))
                    ])
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedCard(
                  icon: Icons.app_registration,
                  text: 'Register \na Student',
                  function: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StudentRegisterScreen()),
                    )
                  },
                ),
                RoundedCard(
                  icon: Icons.checklist,
                  text: 'Mark \n Attendence',
                  function: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScanScreen()),
                    )
                  },
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedCard(
                  icon: Icons.home_work,
                  text: 'Classes',
                  function: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ClassesScreen()),
                    )
                  },
                  // function: openClassScreen(context),
                ),
                RoundedCard(
                  icon: Icons.bar_chart,
                  text: 'Reports',
                ),
              ],
            ),
          ],
        ));
  }
}

class RoundedCard extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final Function()? function;
  const RoundedCard({
    this.icon,
    this.text,
    this.function,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        // margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: kPrimaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                offset: Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 1,
              )
            ]),
        height: 150,
        width: 150,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
