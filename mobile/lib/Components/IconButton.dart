import 'package:flutter/material.dart';

class iconButton extends StatelessWidget {
  const iconButton({
    super.key,
    required this.color,
    required this.icon,
    required this.route,
  });

  final String route;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed("/$route");
      },
      icon: Icon(icon, color: color),
    );
  }
}
