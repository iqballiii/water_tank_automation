import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:water_tank_automation/blocs/app_bloc/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tank_automation/routes/route_names.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(children: [
        Lottie.asset("assets/login-water-lottie.json",
            fit: BoxFit.cover,
            height: mediaSize.height,
            width: mediaSize.width),
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
                          autofillHints: const [AutofillHints.email],
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
                        child: ValueListenableBuilder<bool>(
                          valueListenable: _obscureText,
                          builder: (context, value, child) => TextFormField(
                            textInputAction: TextInputAction.go,
                            onFieldSubmitted: (value) {
                              Logger().f("entered the go zone!");
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                  SignInUserEvent(emailController.text,
                                      passwordController.text));
                            },
                            controller: passwordController,
                            obscureText: value,
                            decoration: InputDecoration(
                              labelText: "Password",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _obscureText.value = !_obscureText.value;
                                },
                                child: value
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                              ),
                            ),
                          ),
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
                    if (state.status == AuthStatus.success) {
                      context.goNamed(RouteNames.homeRoute);
                    } else if (state.status == AuthStatus.failed) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Sign in Failed! :\'('),
                                content: Text(state.errorMessage!),
                              ));
                    } else {
                      // do nothing
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                        height: mediaSize.height * 0.1,
                        width: mediaSize.width * 0.34,
                        child: ElevatedButton(
                            onPressed: state.status == AuthStatus.loading
                                ? null
                                : () {
                                    Logger().f("entered the go zone!");
                                    context.read<AuthenticationBloc>().add(
                                        SignInUserEvent(emailController.text,
                                            passwordController.text));
                                  },
                            child: state.status == AuthStatus.loading
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
