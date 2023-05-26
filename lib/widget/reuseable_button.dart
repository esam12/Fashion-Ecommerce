import 'package:flutter/material.dart';

class ReUseableButton extends StatelessWidget {
  final String text;
  final Size size;
  final void Function()? onPressed;
  const ReUseableButton({
    super.key,
    required this.size,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: size.width * 0.9,
        height: size.height * 0.07,
        color: const Color(0xff141414),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
