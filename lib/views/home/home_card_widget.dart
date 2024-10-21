import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:water_tank_automation/blocs/app_bloc/app_bloc.dart';
import 'package:water_tank_automation/routes/route_names.dart';

class HomeCardWidget extends StatelessWidget {
  HomeCardWidget({
    this.title,
    this.iconName = Icons.water_drop,
    // "https://images.pexels.com/photos/327090/pexels-photo-327090.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    this.navigationUrl,
    this.height = 200.0,
    this.width = 200.0,
    this.index,
    required this.controller,
    super.key,
  }) : opacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: index == 0
                ? const Interval(0.0, 0.4, curve: Curves.easeIn)
                : index == 1
                    ? const Interval(
                        0.35,
                        0.8,
                        curve: Curves.easeIn,
                      )
                    : const Interval(0.75, 1.0, curve: Curves.easeIn)));

  final Animation<double> controller;
  final Animation<double> opacity;
  final int? index;
  final IconData? iconName;
  final String? title;
  final String? navigationUrl;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Opacity(
            opacity: opacity.value,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: title == "Logout"
                  ? () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(SignOutEvent());
                      context.canPop()
                          ? Navigator.popAndPushNamed(
                              context, RouteNames.loginRoute)
                          : context.goNamed(RouteNames.loginRoute);
                    }
                  : () {
                      context.goNamed(navigationUrl!);
                    },
              child: Container(
                height: height,
                width: width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        offset: const Offset(0.2, 0.1),
                        blurStyle: BlurStyle.outer,
                        blurRadius: 2.0,
                        spreadRadius: 1.0),
                    BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        offset: const Offset(-0.1, -0.2),
                        blurStyle: BlurStyle.outer,
                        blurRadius: 2.0,
                        spreadRadius: 1.0),
                  ],
                  borderRadius: BorderRadius.circular(12.0),
                  // image: DecorationImage(
                  //     image: NetworkImage(
                  //       imageUrl!,
                  //     ),
                  //     fit: BoxFit.contain),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Icon(
                      iconName,
                      color: Colors.blue,
                      size: MediaQuery.sizeOf(context).height * 0.15,
                    ),
                    // Container(
                    //   height: MediaQuery.sizeOf(context).height * 0.25,
                    //   width: MediaQuery.sizeOf(context).height * 0.25,
                    //   decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //       image: NetworkImage(imageUrl!),
                    //     ),
                    //     borderRadius: BorderRadius.circular(12.0),
                    //   ),
                    //   child: Image.network(
                    //     imageUrl!,
                    //     scale: 0.5,
                    //     fit: BoxFit.cover,
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
