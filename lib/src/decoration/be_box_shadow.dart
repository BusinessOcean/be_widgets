import 'dart:math' as math;
import 'dart:ui' as ui show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

class BeBoxShadow extends BoxShadow {
  const BeBoxShadow({
    super.color,
    super.offset,
    super.blurRadius,
    super.spreadRadius,
    super.blurStyle,
    this.inset = false,
  });

  /// Wether this shadow should be inset or not.
  final bool inset;

  /// Returns a new box shadow with its offset, blurRadius, and spreadRadius scaled by the given factor.
  @override
  BeBoxShadow scale(double factor) => BeBoxShadow(
        color: color,
        offset: offset * factor,
        blurRadius: blurRadius * factor,
        spreadRadius: spreadRadius * factor,
        blurStyle: blurStyle,
        inset: inset,
      );

  /// Linearly interpolate between two box shadows.
  ///
  /// If either box shadow is null, this function linearly interpolates from a
  /// a box shadow that matches the other box shadow in color but has a zero
  /// offset and a zero blurRadius.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static BeBoxShadow? lerp(BeBoxShadow? a, BeBoxShadow? b, double t) {
    if (a == null && b == null) {
      return null;
    }
    if (a == null) {
      return b!.scale(t);
    }
    if (b == null) {
      return a.scale(1.0 - t);
    }

    final blurStyle =
        a.blurStyle == BlurStyle.normal ? b.blurStyle : a.blurStyle;

    if (a.inset != b.inset) {
      return BeBoxShadow(
        color: lerpColorWithPivot(a.color, b.color, t),
        offset: lerpOffsetWithPivot(a.offset, b.offset, t),
        blurRadius: lerpDoubleWithPivot(a.blurRadius, b.blurRadius, t),
        spreadRadius: lerpDoubleWithPivot(a.spreadRadius, b.spreadRadius, t),
        blurStyle: blurStyle,
        inset: t >= 0.5 ? b.inset : a.inset,
      );
    }

    return BeBoxShadow(
      color: Color.lerp(a.color, b.color, t)!,
      offset: Offset.lerp(a.offset, b.offset, t)!,
      blurRadius: ui.lerpDouble(a.blurRadius, b.blurRadius, t)!,
      spreadRadius: ui.lerpDouble(a.spreadRadius, b.spreadRadius, t)!,
      blurStyle: blurStyle,
      inset: b.inset,
    );
  }

  /// Linearly interpolate between two lists of box shadows.
  ///
  /// If the lists differ in length, excess items are lerped with null.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static List<BeBoxShadow>? lerpList(
    List<BeBoxShadow>? a,
    List<BeBoxShadow>? b,
    double t,
  ) {
    if (a == null && b == null) {
      return null;
    }
    a ??= <BeBoxShadow>[];
    b ??= <BeBoxShadow>[];
    final int commonLength = math.min(a.length, b.length);
    return <BeBoxShadow>[
      for (int i = 0; i < commonLength; i += 1)
        BeBoxShadow.lerp(a[i], b[i], t)!,
      for (int i = commonLength; i < a.length; i += 1) a[i].scale(1.0 - t),
      for (int i = commonLength; i < b.length; i += 1) b[i].scale(t),
    ];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is BeBoxShadow &&
        other.color == color &&
        other.offset == offset &&
        other.blurRadius == blurRadius &&
        other.spreadRadius == spreadRadius &&
        other.blurStyle == blurStyle &&
        other.inset == inset;
  }

  @override
  int get hashCode =>
      Object.hash(color, offset, blurRadius, spreadRadius, blurStyle, inset);

  @override
  String toString() =>
      'BoxShadow($color, $offset, ${debugFormatDouble(blurRadius)}, ${debugFormatDouble(spreadRadius)}), $blurStyle, $inset)';
}

double lerpDoubleWithPivot(num? a, num? b, double t) {
  if (t < 0.5) {
    return ui.lerpDouble(a, 0, t * 2)!;
  }

  return ui.lerpDouble(0, b, (t - 0.5) * 2)!;
}

Offset lerpOffsetWithPivot(Offset? a, Offset? b, double t) {
  if (t < 0.5) {
    return Offset.lerp(a, Offset.zero, t * 2)!;
  }

  return Offset.lerp(Offset.zero, b, (t - 0.5) * 2)!;
}

Color lerpColorWithPivot(Color? a, Color? b, double t) {
  if (t < 0.5) {
    return Color.lerp(a, a?.withValues(alpha: 0), t * 2)!;
  }

  return Color.lerp(b?.withValues(alpha: 0), b, (t - 0.5) * 2)!;
}
