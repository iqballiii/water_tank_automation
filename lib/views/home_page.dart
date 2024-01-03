import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:water_tank_automation/routes/route_names.dart';

/// The Home page is the central page from where the user can navigate
/// to the all the other pages.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Iqbal', // This will be replaced by the user from the firebase auth.
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(
              height: 25.0,
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: HomeCardWidget(
                  title: 'Water Tank Level',
                  width: double.infinity,
                  iconName: Icons.water_drop,
                  // "https://images.unsplash.com/photo-1549372691-289fcc650e4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80",
                  navigationUrl: RouteNames.waterLevelRoute,
                  index: 0,
                ),
              ),
            )
                .animate()
                .fadeIn() // uses `Animate.defaultDuration`
                .scale() // inherits duration from fadeIn
                .move(
                    curve: Curves.elasticInOut,
                    delay: 300.ms,
                    duration: 600.ms), // runs after the above w/new duration
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  const Expanded(
                          child: HomeCardWidget(
                    iconName: Icons.admin_panel_settings,
                    title: 'User & more',
                    index: 1,
                  ))
                      .animate()
                      .fadeIn(
                        curve: Curves.elasticInOut,
                        delay: 1000.ms,
                      )
                      .scaleXY(
                          curve: Curves.elasticInOut,
                          delay: 1500.ms,
                          duration: 600
                              .ms), // uses `Animate.defaultDuration`// inherits duration from fadeIn

                  const SizedBox(
                    width: 25.0,
                  ),
                  const Expanded(
                          child: HomeCardWidget(
                    iconName: Icons.logout,
                    title: "Logout",
                    index: 2,
                  ))
                      .animate()
                      .fadeIn(
                        curve: Curves.elasticInOut,
                        delay: 1000.ms,
                      )
                      .scaleXY(
                          curve: Curves.bounceOut,
                          delay: 1500.ms,
                          duration: 600.ms)
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ]),
    );
  }
}

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({
    this.title,
    this.iconName = Icons.water_drop,
    // "https://images.pexels.com/photos/327090/pexels-photo-327090.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    this.navigationUrl,
    this.height = 200.0,
    this.width = 200.0,
    this.index,
    super.key,
  });
  final int? index;
  final IconData? iconName;
  final String? title;
  final String? navigationUrl;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: () {
        title == "Logout" ? null : context.goNamed(navigationUrl!);
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
    );
  }
}
