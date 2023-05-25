import 'package:fashion_ecommerce/utils/app_theme.dart';
import 'package:flutter/material.dart';

import 'main_wrappar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: const MainWrappar(),
    );
  }
}
