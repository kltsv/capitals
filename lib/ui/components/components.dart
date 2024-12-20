import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../domain/models/game_item.dart';
import '../../keys.dart';

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeSizedText(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        if (subtitle != null)
          FadeSizedText(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
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
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        InkResponse(
          onTap: () => onAnswer?.call(true),
          child: Text(
            'True',
            style: Theme.of(context).textTheme.headlineSmall,
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
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: frame != null ? 1 : 0,
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
            ),
          ],
        ),
        image: item.image,
        fit: BoxFit.cover,
      );
}

class GradientBackground extends StatelessWidget {
  /// Если флаг включен, то вместо градиента
  /// будет использован один цвет.
  ///
  /// Включать только для golden-тестов.
  @visibleForTesting
  static var simplify = false;

  static const _updateDuration = Duration(milliseconds: 600);

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
  Widget build(BuildContext context) => AnimatedContainer(
        duration: _updateDuration,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [startColor, simplify ? startColor : endColor],
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
        blur: const MaskFilter.blur(BlurStyle.solid, 5),
        gradientBegin: Alignment.bottomCenter,
        gradientEnd: Alignment.topCenter,
      ),
      waveAmplitude: 0,
      size: const Size(
        double.infinity,
        double.infinity,
      ),
    );
  }
}

class ProgressWave extends StatelessWidget {
  /// Если флаг включен, то вместо волн
  /// будет использован обычный заполняющийся контейнер.
  ///
  /// Включать только для golden-тестов.
  @visibleForTesting
  static var simplify = false;

  static const _updateDuration = Duration(milliseconds: 600);

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
    return AnimatedContainer(
      curve: Curves.ease,
      height: MediaQuery.of(context).size.height * progress,
      duration: _updateDuration,
      child: simplify
          ? SizedBox.expand(child: ColoredBox(color: color))
          : Wave(
              color: color,
              duration: duration,
            ),
    );
  }
}

class FadeSizedText extends StatelessWidget {
  final String text;
  final Duration duration;
  final TextStyle? style;

  const FadeSizedText(
    this.text, {
    Key? key,
    this.duration = const Duration(milliseconds: 200),
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: AnimatedSwitcher(
        duration: duration,
        child: Text(
          text,
          key: ValueKey(text),
          style: style,
        ),
      ),
    );
  }
}

class CompleteWidget extends StatelessWidget {
  final int score;
  final int topScore;
  final VoidCallback? onTap;

  const CompleteWidget({
    Key? key,
    required this.score,
    required this.topScore,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your result',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            score.toString(),
            key: Keys.scoreResult,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            'out of $topScore',
            key: Keys.maxResult,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}

class CenterLandscape extends StatelessWidget {
  final Widget? child;

  const CenterLandscape({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = this.child;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Row(
      children: [
        if (isLandscape) const Spacer(flex: 1),
        if (child != null)
          Flexible(
            flex: 2,
            child: child,
          ),
        if (isLandscape) const Spacer(flex: 1),
      ],
    );
  }
}
