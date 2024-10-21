import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:water_tank_automation/widgets/slide_icon_widget.dart';
import 'package:water_tank_automation/widgets/wave_animation.dart';

class WaterWaveAnimationPage extends StatefulWidget {
  const WaterWaveAnimationPage({super.key});

  @override
  State<WaterWaveAnimationPage> createState() => _WaterWaveAnimationPageState();
}

class _WaterWaveAnimationPageState extends State<WaterWaveAnimationPage> {
  double height = 0.6;
  final double min = 0.6;
  final double max = 0.02;

  void _increaseHeight() {
    setState(() {
      height <= max ? max : height -= 0.003;
    });
  }

  void _decreaseHeight() {
    setState(() {
      height >= min ? min : height += 0.003;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'WATER LEVEL (0-100)',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                          height:
                              (MediaQuery.sizeOf(context).height * 0.5) * 0.9,
                          width: 5,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.yellow,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(50),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      WaveAnimationContainer(
                        width: MediaQuery.sizeOf(context).width / 2,
                        height: MediaQuery.sizeOf(context).height * height,
                        seconds: height <= (min / 2) ? 1000 : 1500,
                        colors: const [
                          Colors.blue,
                          Colors.blueAccent,
                          Color.fromARGB(255, 5, 39, 97),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    left: MediaQuery.sizeOf(context).width * 0.75,
                    top: (MediaQuery.sizeOf(context).height - 20) * height,
                    child: GestureDetector(
                      onTap: () {
                        Logger().i('do you work??');

                        Logger().f(height);
                      },
                      onVerticalDragUpdate: (details) {
                        Logger().f(details.toString());
                        if (details.delta.dy > 0) {
                          _decreaseHeight();
                        } else {
                          _increaseHeight();
                        }
                      },
                      child: const WaveSlideIcon(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
