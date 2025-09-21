import 'package:flutter/material.dart';

import 'Colors.dart';


class card extends StatelessWidget {
  Widget columnrow;
  final double? height;
  // final double padvalue;
  card({super.key, required this. columnrow, required this.height, });


  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 5,
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppTheme.c1,AppTheme.c2]),
            borderRadius: BorderRadius.circular(14),
          ),
          height: height, // 150
          alignment: Alignment.center,
          child: columnrow
      ),
    );
  }
}