import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:water_tank_automation/blocs/water_tracking_bloc/water_track_bloc.dart';
import 'package:water_tank_automation/painter/liquid_painter.dart';
import 'package:water_tank_automation/painter/water_tank_painter.dart';
import 'package:water_tank_automation/routes/route_names.dart';
import 'package:water_tank_automation/services/firebase_service.dart';

class WaterTankLevelPage extends StatefulWidget {
  const WaterTankLevelPage({super.key});

  @override
  State<WaterTankLevelPage> createState() => _WaterTankLevelPageState();
}

class _WaterTankLevelPageState extends State<WaterTankLevelPage> {
  bool isPlaying = true;
  int maxDuration = 10;
  bool isParticlesReady = true;
  ValueNotifier<int> waterLevel = ValueNotifier(0);
  void waterLevelUpater(int val) {
    waterLevel.value = val;
  }

  @override
  void initState() {
    FirebaseAppService().readWaterLevel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: mediaSize.height * 0.12,
        title: Text(
          "Water Tank Level",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(RouteNames.newWaterLevelRoute);

                Logger().f('Calling 101');
              },
              icon: const Icon(Icons.forward))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // AnimatedBuilder(
              //     animation: _controller,
              //     builder: (context, _) {
              //       return Stack(
              //         fit: StackFit.expand,
              //         children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Stack(
                  children: [
                    SizedBox(
                      height: mediaSize.height * 0.8,
                      width: mediaSize.width * 0.7,
                      child: CustomPaint(
                        painter: WaterTankPainter(),
                        child: BlocBuilder<WaterTrackBloc, WaterTrackState>(
                          builder: (context, state) {
                            if (state.status == WaterTrackStatus.success) {
                              return CustomPaint(
                                painter: LiquidPainter(
                                  ((state.waterLevel! / 100) * maxDuration)
                                      .toDouble(),
                                  maxDuration.toDouble(),
                                ),
                              );
                            } else {
                              return CustomPaint(
                                painter: LiquidPainter(
                                  ((50 / 100) * maxDuration).toDouble(),
                                  maxDuration.toDouble(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ValueListenableBuilder<int>(
                        valueListenable: waterLevel,
                        builder: (BuildContext context, value, Widget? child) {
                          return Text(
                            "$value %",
                            style: Theme.of(context).textTheme.displayMedium,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: mediaSize.height * 0.2,
              ),
              //           Padding(
              //             padding: const EdgeInsets.all(5.0),
              //             child: CustomPaint(
              //               painter: LiquidPainter(
              //                 _controller.value * maxDuration,
              //                 maxDuration.toDouble(),
              //               ),
              //             ),
              //           ),
              //           CustomPaint(
              //               painter: RadialProgressPainter(
              //             value: _controller.value * maxDuration,
              //             backgroundGradientColors: [Colors.blue],
              //             minValue: 0,
              //             maxValue: maxDuration.toDouble(),
              //           )),
              //         ],
              //       );
              //     }),
            ]),
      ),
    );
  }
}
