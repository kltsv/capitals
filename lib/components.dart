import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'models.dart';

class Headers extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const Headers({
    Key? key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    final subtitle = this.subtitle;
    return Column(
      children: [
        if (title != null)
          Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
        if (subtitle != null)
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyText2,
          ),
      ],
    );
  }
}

class Controls extends StatelessWidget {
  final ValueChanged<bool>? onAnswer;

  const Controls({Key? key, this.onAnswer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkResponse(
          onTap: () => onAnswer?.call(false),
          child: Text(
            'False',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        InkResponse(
          onTap: () => onAnswer?.call(true),
          child: Text(
            'True',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ],
    );
  }
}

class CapitalCard extends StatelessWidget {
  final GameItem item;

  const CapitalCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Image(
        frameBuilder: (
          BuildContext context,
          Widget child,
          int? frame,
          bool wasSynchronouslyLoaded,
        ) =>
            Stack(
          children: [
            Positioned.fill(
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: child,
                ),
              ),
            ),
          ],
        ),
        image: item.image,
        fit: BoxFit.cover,
      );
}

class GradientBackground extends StatelessWidget {
  final Color startColor;
  final Color endColor;
  final Widget? child;

  const GradientBackground({
    Key? key,
    required this.startColor,
    required this.endColor,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [startColor, endColor],
          ),
        ),
        child: child,
      );
}

class Wave extends StatelessWidget {
  final Color color;
  final Duration duration;

  const Wave({
    Key? key,
    required this.color,
    this.duration = const Duration(seconds: 10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [Colors.transparent, color],
        ],
        durations: [duration.inMilliseconds],
        heightPercentages: [0.0],
        blur: MaskFilter.blur(BlurStyle.solid, 10),
        gradientBegin: Alignment.bottomCenter,
        gradientEnd: Alignment.topCenter,
      ),
      waveAmplitude: 0,
      size: Size(
        double.infinity,
        double.infinity,
      ),
    );
  }
}

class ProgressWave extends StatelessWidget {
  final double progress;
  final Color color;
  final Duration duration;

  const ProgressWave({
    Key? key,
    required this.progress,
    required this.color,
    this.duration = const Duration(seconds: 10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * progress,
      child: Wave(
        color: color,
        duration: duration,
      ),
    );
  }
}
