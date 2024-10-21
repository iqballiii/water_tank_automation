import 'package:flutter/material.dart';
import 'package:one_clock/one_clock.dart';
import 'package:water_tank_automation/models/weather_model.dart';
import 'package:water_tank_automation/routes/route_names.dart';
import 'package:water_tank_automation/services/repository.dart';
import 'package:water_tank_automation/views/home/home_card_widget.dart';
import 'package:water_tank_automation/views/home/home_controller.dart';

/// The Home page is the central page from where the user can navigate
/// to the all the other pages.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  HomeController homePageController = HomeController();
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              FutureBuilder<CurrentWeather?>(
                  future: NetworkRepository().getWeather(),
                  builder: (context, snapshot) {
                    debugPrint(snapshot.connectionState.toString());
                    debugPrint(snapshot.data.toString());
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Row(
                        children: [
                          Image.network(
                            snapshot.data!.condition.icon,
                            scale: 0.8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${snapshot.data!.temp.toStringAsFixed(0)}°C",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                snapshot.data!.condition.text,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                'Hyderbad, India',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          )
                        ],
                      );
                    } else {
                      return const Text('Errro');
                    }
                  })
            ],
          ),
          const SizedBox(height: 25.0),
          const CustomClock(),
          // DigitalClock(
          //     showSeconds: true,
          //     isLive: true,
          //     digitalClockTextColor: Colors.black,
          //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          //     decoration: const BoxDecoration(
          //         color: Colors.black12,
          //         shape: BoxShape.rectangle,
          //         borderRadius: BorderRadius.all(Radius.circular(5))),
          //     datetime: DateTime.now()),
          const SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 10,
              runAlignment: WrapAlignment.center,
              runSpacing: 10,
              children: List.generate(
                  homePageController.cardNames.length,
                  (index) => Builder(builder: (context) {
                        return HomeCardWidget(
                          index: index,
                          height: 200,
                          width: index == 0
                              ? double.infinity
                              : MediaQuery.sizeOf(context).width / 2.1,
                          title: homePageController.cardNames[index],
                          controller: _animationController,
                          iconName: index == 0
                              ? Icons.water
                              : index == 1
                                  ? Icons.admin_panel_settings
                                  : Icons.logout_rounded,
                          navigationUrl: index == 0
                              ? RouteNames.waterLevelRoute
                              : index == 1
                                  ? ''
                                  : '',
                        );
                      })),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClock extends StatelessWidget {
  const CustomClock({super.key});

  DateTime get dateTimee => DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DigitalClock(
          showSeconds: true,
          isLive: true,
          digitalClockTextColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: const BoxDecoration(
              color: Colors.black12,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          datetime: dateTimee,
        ),
        const SizedBox(width: 25),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: DigitalClock(
            format: 'yMMMEd',
            datetime: dateTimee,
            textScaleFactor: 1,
            showSeconds: false,
            isLive: true,
            // decoration: const BoxDecoration(color: Colors.cyan, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
        ),
      ],
    );
  }
}
