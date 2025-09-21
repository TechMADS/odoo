import 'package:flutter/material.dart';

import '../Components/ElevationButton.dart';
import 'Home_Screen.dart';

class button extends StatelessWidget {
  const button({super.key, required this.onNewPressed});

  final VoidCallback onNewPressed;

  @override
  Widget build(BuildContext context) {
    return GradientElevatedButton(
      text: "New",
      onPressed: () {
        onNewPressed;
      },
    );
  }
}
