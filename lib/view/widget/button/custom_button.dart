import 'package:flutter/material.dart';
import 'package:interactive/utils/app_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.title});

  final VoidCallback onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment(-0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF232222), Color(0xFF252424), Colors.black],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
            title.toString(), textAlign: TextAlign.center, style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.white100
        )),
      ),
    );
  }
}