import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:water_tank_automation/blocs/authentication_bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tank_automation/routes/route_names.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
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
                          controller: emailController,
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
                BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationSuccessState) {
                      context.goNamed(RouteNames.homeRoute);
                    } else if (state is AuthenticationFailureState) {
                      var customState = state;
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Sign in Failed! :\'('),
                                content: Text(customState.errorMessage),
                              ));
                    } else {
                      // do nothing
                    }
                  },
                  builder: (context, state) {
                    bool isLoading = false;
                    if (state is AuthenticationLoadingState) {
                      isLoading = state.isLoading;
                    }
                    return SizedBox(
                        height: mediaSize.height * 0.1,
                        width: mediaSize.width * 0.34,
                        child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    Logger().f("entered the go zone!");
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(SignInUserEvent(
                                            emailController.text,
                                            passwordController.text));
                                  },
                            child: isLoading
                                ? const CircularProgressIndicator.adaptive()
                                : const Text('Let\'s Go!')));
                  },
                ),

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
