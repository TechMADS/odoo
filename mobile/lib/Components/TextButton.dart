import 'package:flutter/material.dart';

class textbutton extends StatelessWidget {
  textbutton({super.key , required this.iconsize, required this.iconcolor, required this.icon, required this.text, required this.textcolor, required this.textsize, required this.routepage});
  final String text;
  IconData icon;
  Color textcolor;
  Color iconcolor;
  final double iconsize;
  final double textsize;
  final String? routepage;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed("/$routepage");
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: iconsize, color: iconcolor),
              SizedBox(width: 6,),
              Text(
                "$text",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: textsize,
                  color: textcolor,
                ),
              ),
            ],

          ),
          const Divider(color: Colors.white, thickness: 1, height: 10),
        ],
      ),
    );
  }
}