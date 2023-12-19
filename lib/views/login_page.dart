import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../routes/route_names.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(children: [
        Expanded(
          child: Lottie.asset("assets/login-water-lottie.json",
              fit: BoxFit.cover,
              height: mediaSize.height,
              width: mediaSize.width),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: [
                const Spacer(
                  flex: 1,
                ),
                Text(
                  'Log In',
                  style: Theme.of(context).textTheme.displayMedium,
                ).animate().shake(
                    delay: 300.ms, duration: 850.ms, curve: Curves.bounceInOut),
                const Spacer(
                  flex: 1,
                ),
                SizedBox(
                        width: mediaSize.width * 0.35,
                        child: TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                              hintText: "yourname@example.com",
                              labelText: "Email"),
                        ))
                    .animate()
                    .slideX(
                        duration: 600.ms,
                        delay: 300.ms,
                        curve: Curves.easeIn), // username text-field
                const Spacer(
                  flex: 1,
                ),
                SizedBox(
                        width: mediaSize.width * 0.35,
                        child: TextFormField(
                          controller: passwordController,
                          decoration:
                              const InputDecoration(labelText: "Password"),
                        ))
                    .animate()
                    .slideX(
                        duration: 600.ms,
                        delay: 300.ms,
                        curve: Curves.easeIn), // password text-field
                const Spacer(
                  flex: 2,
                ),
                SizedBox(
                    height: mediaSize.height * 0.1,
                    width: mediaSize.width * 0.34,
                    child: ElevatedButton(
                        onPressed: () {
                          context.goNamed(RouteNames.homeRoute);
                        },
                        child: const Text('Let\'s Go!'))),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
