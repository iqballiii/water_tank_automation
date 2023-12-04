import 'package:flutter/material.dart';
import 'package:water_tank_automation/painter/liquid_painter.dart';
import 'package:water_tank_automation/painter/water_tank_painter.dart';

class WaterTankLevelPage extends StatefulWidget {
  const WaterTankLevelPage({super.key});

  @override
  State<WaterTankLevelPage> createState() => _WaterTankLevelPageState();
}

class _WaterTankLevelPageState extends State<WaterTankLevelPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isPlaying = true;
  int maxDuration = 10;
  bool isParticlesReady = true;

  ValueNotifier<int> waterLevel = ValueNotifier(0);
  void waterLevelUpater(int val) {
    waterLevel.value = val;
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: maxDuration))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isPlaying = false;
        }
        if (status == AnimationStatus.forward) {
          isParticlesReady = true;
        }
      })
      ..addListener(() {
        waterLevelUpater((_controller.value * maxDuration).toInt());
      });

    _controller.forward().then((value) => _controller.reverse());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.sizeOf(context);
    double val = (_controller.value * maxDuration);
    waterLevelUpater(val.toInt());
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
                padding: const EdgeInsets.only(
                  top: 50.0,
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      height: mediaSize.height * 0.8,
                      width: mediaSize.width * 0.7,
                      child: CustomPaint(
                        painter: WaterTankPainter(),
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, _) {
                            return CustomPaint(
                              painter: LiquidPainter(
                                _controller.value * maxDuration,
                                maxDuration.toDouble(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ValueListenableBuilder(
                        valueListenable: waterLevel,
                        builder: (BuildContext context, dynamic value,
                            Widget? child) {
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
              )

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
