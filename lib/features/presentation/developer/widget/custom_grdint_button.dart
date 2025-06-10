import 'package:flutter/material.dart';

class GradientBorderButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const GradientBorderButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.blue], // আপনার পছন্দের রং
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: EdgeInsets.all(1.5), // বর্ডারের পুরুত্ব
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // বাটনের ব্যাকগ্রাউন্ড
          borderRadius: BorderRadius.circular(18),
        ),
        child: OutlinedButton(

          style: OutlinedButton.styleFrom(
            side: BorderSide.none, // বাইরে কোনো বর্ডার নয়
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
