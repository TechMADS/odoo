import 'package:flutter/material.dart';
import 'package:mobile/Components/Colors.dart';

class Elevationbutton extends StatelessWidget {
  final String name, routePage;
  final double  fontsize, radius, padding;
  final int bgColor, textColor, iconcolor;
  final IconData icon;
  const Elevationbutton({super.key,
    required this.name,
    required this.bgColor,
    required this.textColor,
    required this.fontsize,
    required this.radius,
    required this.padding,
    required this.icon,
    required this.iconcolor,
    required this.routePage,
  });


  @override
  Widget build(BuildContext context) {
    final BgColor = Color(bgColor);
    final TextColor = Color(textColor);
    final IconColor = Color(iconcolor);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: (){Navigator.of(context).pushNamed('$routePage');},
        style: ElevatedButton.styleFrom(
            backgroundColor: BgColor,
            side: BorderSide(
                color: Colors.black,
                width: 1
            ),
            padding: EdgeInsets.all(radius),//15
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(padding),//15
            )
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon as IconData?,color: IconColor),
            SizedBox(width: 8,),
            Text("$name",style: TextStyle(fontSize: fontsize,color: TextColor ),),
          ],
        ),

      ),
    );
  }
}


class GradientElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final List<Color> gradientColors;

  const GradientElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.gradientColors = const [AppTheme.c1,AppTheme.c2],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradientColors),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
