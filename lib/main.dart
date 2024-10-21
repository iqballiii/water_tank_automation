import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_tank_automation/blocs/app_bloc/app_bloc.dart';
import 'package:water_tank_automation/blocs/water_tracking_bloc/water_track_bloc.dart';
import 'package:water_tank_automation/routes/route_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AuthenticationBloc(),
    ),
    BlocProvider(
      create: (context) => WaterTrackBloc(),
    ),
  ], child: const WaterTankAutomationApp()));
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
