import 'package:dictionary/config/configs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dictionary extends StatelessWidget {
  const Dictionary({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppConfigs.router,
      title: 'Dictionary',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
