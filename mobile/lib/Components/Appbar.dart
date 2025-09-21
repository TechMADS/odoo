import 'package:flutter/material.dart';
import 'package:mobile/Components/IconButton.dart';
import 'Colors.dart';


class appbar extends StatelessWidget {
  const appbar({super.key, required this.appbar_title , required this.icbutton});
  final String appbar_title;
  final IconButton icbutton;

  double get myAppBarHeight => 60.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      toolbarHeight: 60,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.c1,AppTheme.c2 // Blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title:  Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icbutton,
            Text(appbar_title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
            Row(
              children: [
                iconButton(color: Colors.white, icon: Icons.person, route: "route")

              ],
            )
          ],
        ),
      ),
    );


  }
}