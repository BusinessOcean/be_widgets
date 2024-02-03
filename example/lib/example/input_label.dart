import 'package:be_widgets/be_widgets.dart';
import 'package:example/example/component.dart';
import 'package:flutter/material.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return BeLabel(
      childSized: true,
      // innerLabel: true,
      position: BeLabelPosition.rightCenter,
      label: Container(
        color: Colors.pink,
        padding: const EdgeInsets.all(16),
        child: const Icon(
          Icons.person_3,
          color: Colors.white,
        ),
      ),
      child: const TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: Colors.pink,
            ),
          ),
        ),
      ),
    );
  }
}

class InputLabelRight extends StatelessWidget {
  const InputLabelRight({super.key});

  @override
  Widget build(BuildContext context) {
    return BeLabel(
        childSized: true,
        // innerLabel: true,
        position: BeLabelPosition.rightCenter,
        label: Container(
          color: Colors.pink,
          padding: const EdgeInsets.all(16),
          child: const Icon(
            Icons.lock_clock_sharp,
            color: Colors.white,
          ),
        ),
        child: const InputTextRectangle());
  }
}

class InputLabelInnerRight extends StatelessWidget {
  const InputLabelInnerRight({super.key});

  @override
  Widget build(BuildContext context) {
    return BeLabel(
        innerLabel: true,
        position: BeLabelPosition.rightCenter,
        label: Container(
          color: Colors.pink,
          padding: const EdgeInsets.all(16),
          child: const Icon(
            Icons.alarm,
            color: Colors.white,
          ),
        ),
        child: const InputTextRectangle());
  }
}

class InputLabelRounded extends StatelessWidget {
  const InputLabelRounded({super.key});

  @override
  Widget build(BuildContext context) {
    return BeLabel(
        innerLabel: false,
        position: BeLabelPosition.rightCenter,
        label: Container(
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16))),
          padding: const EdgeInsets.all(16),
          child: const Icon(
            Icons.ads_click_sharp,
            color: Colors.white,
          ),
        ),
        child: const InputTextRounded());
  }
}

class InputLabelRoundedRegular extends StatelessWidget {
  const InputLabelRoundedRegular({super.key});

  @override
  Widget build(BuildContext context) {
    return BeLabel(
        innerLabel: true,
        position: BeLabelPosition.rightCenter,
        label: Container(
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16))),
          padding: const EdgeInsets.all(16),
          child: const Icon(
            Icons.bar_chart_rounded,
            color: Colors.white,
          ),
        ),
        child: const InputTextRounded());
  }
}
