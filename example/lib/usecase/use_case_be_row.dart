import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'BeRow', path: '/', type: BeRow)
Widget renderBeRowWidget(final BuildContext context) {
  final spacing = context.knobs.double
      .slider(label: 'Spacing', initialValue: 12, min: 0, max: 32);
  final avatarCount = context.knobs.int
      .slider(label: 'Avatar Count', initialValue: 4, min: 2, max: 8);
  final avatarSize = context.knobs.double
      .slider(label: 'Avatar Size', initialValue: 40, min: 24, max: 64);

  final avatarUrls = [
    'https://randomuser.me/api/portraits/men/32.jpg',
    'https://randomuser.me/api/portraits/women/44.jpg',
    'https://randomuser.me/api/portraits/men/65.jpg',
    'https://randomuser.me/api/portraits/women/12.jpg',
    'https://randomuser.me/api/portraits/men/23.jpg',
    'https://randomuser.me/api/portraits/women/56.jpg',
    'https://randomuser.me/api/portraits/men/78.jpg',
    'https://randomuser.me/api/portraits/women/34.jpg',
  ];

  return Center(
    child: BeRow(
      spacing: spacing,
      children: List.generate(
        avatarCount,
        (i) => CircleAvatar(
          radius: avatarSize / 2,
          backgroundImage: NetworkImage(avatarUrls[i % avatarUrls.length]),
        ),
      ),
    ),
  );
}
