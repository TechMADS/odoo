import 'package:flutter/material.dart';


class card extends StatelessWidget {
  Widget columnrow;
  final double? height;
  Color? color;
  // final double padvalue;
  card({super.key, required this. columnrow, required this.height, required this.color, });


  @override
  Widget build(BuildContext context) {

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 5,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: color,
          ),
          height: height, // 150
          alignment: Alignment.center,
          child: columnrow
      ),
    );
  }
}