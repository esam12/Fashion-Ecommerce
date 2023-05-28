import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ReUseableTextDetails extends StatelessWidget {
  const ReUseableTextDetails({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return RichText(
      text: TextSpan(
          text: "€",
          style: theme.titleSmall?.copyWith(
            color: primaryColor,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: text,
              style: theme.titleSmall?.copyWith(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            )
          ]),
    );
  }
}
