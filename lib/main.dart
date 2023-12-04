import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_tank_automation/routes/route_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const WaterTankAutomationApp());
}

class WaterTankAutomationApp extends StatelessWidget {
  const WaterTankAutomationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: GoogleFonts.titanOneTextTheme()),
      debugShowCheckedModeBanner: false,
      routerConfig: MyAppRouter.router(),
      // routeInformationParser:
      //     MyAppRouter.returnRouter(false).routeInformationParser,
      // routerDelegate: MyAppRouter.returnRouter(false).routerDelegate,
    );
  }
}
