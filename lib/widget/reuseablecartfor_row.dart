import 'package:fashion_ecommerce/widget/reuseable_text.dart';
import 'package:flutter/material.dart';

class ReUseableCartForRow extends StatelessWidget {
  final String text;
  final double price;
  const ReUseableCartForRow(
      {super.key, required this.text, required this.price});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: textTheme.displaySmall
              ?.copyWith(fontSize: 16, color: Colors.grey),
        ),
        ReUseableTextDetails(text: price.toString()),
      ],
    );
  }
}
