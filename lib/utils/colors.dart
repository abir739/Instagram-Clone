import 'package:flutter/material.dart';

const mobileBackgroundColor = Color.fromRGBO(0, 0, 0, 1);
const webBackgroundColor = Color.fromRGBO(18, 18, 18, 1);
const backgroundColor = Color.fromARGB(0, 0, 0, 1);
const blueColor = Color.fromARGB(0, 149, 246, 1);
const primaryColor = Colors.white;
const secondaryColor = Colors.grey; 


  final List<Color> mixColors = [
    const Color.fromRGBO(251, 175, 69, 1), // Orange
    const Color.fromRGBO(197, 53, 132, 1), // Pink
    const Color.fromRGBO(64, 93, 230, 1), // Blue
    const Color(0xFF5B51D8),
    const Color(0xFF833AB4),
    const Color(0xFFF56040),
    const Color(0xFFFCAF45),
    const Color(0xFFFFDC80),
  ];

  Color generateMixedColor() {
    double red = 0;
    double green = 0;
    double blue = 0;

    for (Color color in mixColors) {
      red += color.red;
      green += color.green;
      blue += color.blue;
    }

    red /= mixColors.length;
    green /= mixColors.length;
    blue /= mixColors.length;

    return Color.fromRGBO(red.toInt(), green.toInt(), blue.toInt(), 1);
  }
