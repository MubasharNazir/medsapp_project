import 'package:flutter/material.dart';

class CircularBox extends StatelessWidget {
  final Color color;
  final double boxWidth;
  final double boxHeight;
  final String boxText;
  final IconData icon;
  final VoidCallback onTap;

  const CircularBox({
    required this.color,
    required this.boxWidth,
    required this.boxHeight,
    required this.boxText,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: boxWidth,
          height: boxHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(height: 10),
              Text(
                boxText,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
