import 'package:flutter/material.dart';
import 'package:water_tank_automation/painter/liquid_painter.dart';
import 'package:water_tank_automation/painter/water_tank_painter.dart';
import 'package:firebase_database/firebase_database.dart';

class WaterTankLevelPage extends StatefulWidget {
  const WaterTankLevelPage({super.key});

  @override
  State<WaterTankLevelPage> createState() => _WaterTankLevelPageState();
}

class _WaterTankLevelPageState extends State<WaterTankLevelPage> {
  bool isPlaying = true;
  int maxDuration = 10;
  bool isParticlesReady = true;
  FirebaseDatabase database = FirebaseDatabase.instance;
  ValueNotifier<int> waterLevel = ValueNotifier(0);
  void waterLevelUpater(int val) {
    waterLevel.value = val;
  }

  @override
  void initState() {
    super.initState();
    database.ref('waterTank/water_level').onValue.listen((event) {
      final double data = double.parse(event.snapshot.value.toString());
      final levelOfWater = int.parse(((data / 50.0) * 100).toString());
      waterLevelUpater(levelOfWater);
    });
  }

  @override
  void dispose() {
    super.dispose();
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
                        child: ValueListenableBuilder<int>(
                          valueListenable: waterLevel,
                          builder: (context, waterLevelValue, _) {
                            return CustomPaint(
                              painter: LiquidPainter(
                                ((waterLevelValue / 100) * maxDuration)
                                    .toDouble(),
                                maxDuration.toDouble(),
                              ),
                            );
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
