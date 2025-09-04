// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/foundation.dart';

///
///| **Breakpoint**  | **Device Category** | **Button Size** | **Input Size** | **Text Size** |
///|---------------|----------------|-------------|------------|------------|
///| xs, sm        | Mobile         | Small       | Compact    | Small      |
///| md            | Tablet         | Medium      | Regular    | Medium     |
///| lg, xl, xl2   | Desktop        | Large       | Big        | Large      |

enum BeBreakpoint {
  xs, // Extra small
  sm, // Small
  md, // Medium
  lg, // Large
  xl, // Extra large
  xl2, // Extra extra large
}

final class BeResponsivePoints with Diagnosticable {
  /// Creates a [BeResponsivePoints].
  const BeResponsivePoints(
      {this.sm = 640,
      this.md = 768,
      this.lg = 1024,
      this.xl = 1280,
      this.xl2 = 1536});

  /// The minimum width of the small breakpoint, inclusive. Defaults to 640.
  ///
  /// Mobile devices are typically smaller than [sm].
  final double sm;

  /// The minimum width of the medium breakpoint, inclusive. Defaults to 768.
  ///
  /// Tablet decides are typically larger than [md].
  final double md;

  /// The minimum width of the large breakpoint, inclusive. Defaults to 1024.
  final double lg;

  /// The minimum width of the extra large breakpoint, inclusive. Defaults to 1280.
  final double xl;

  /// The minimum width of the extra extra large breakpoint, inclusive. Defaults to 1536.
  final double xl2;

  /// Returns the numeric value for a given [BeBreakpoint] enum.
  double valueForBreakpoint(final BeBreakpoint breakpoint) =>
      switch (breakpoint) {
        BeBreakpoint.xs => 0, // xs has no minimum width
        BeBreakpoint.sm => sm,
        BeBreakpoint.md => md,
        BeBreakpoint.lg => lg,
        BeBreakpoint.xl => xl,
        BeBreakpoint.xl2 => xl2,
      };

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is BeResponsivePoints &&
          runtimeType == other.runtimeType &&
          sm == other.sm &&
          md == other.md &&
          lg == other.lg &&
          xl == other.xl &&
          xl2 == other.xl2;

  @override
  int get hashCode =>
      sm.hashCode ^ md.hashCode ^ lg.hashCode ^ xl.hashCode ^ xl2.hashCode;

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('sm', sm, defaultValue: 640))
      ..add(DoubleProperty('md', md, defaultValue: 768))
      ..add(DoubleProperty('lg', lg, defaultValue: 1024))
      ..add(DoubleProperty('xl', xl, defaultValue: 1280))
      ..add(DoubleProperty('xl2', xl2, defaultValue: 1536));
  }
}

BeBreakpoint calculateBreakpoint(
  final double screenWidth, [
  final BeResponsivePoints breakpoints = const BeResponsivePoints(),
]) =>
    switch (screenWidth) {
      _ when screenWidth < breakpoints.sm => BeBreakpoint.xs,
      _ when screenWidth < breakpoints.md => BeBreakpoint.sm,
      _ when screenWidth < breakpoints.lg => BeBreakpoint.md,
      _ when screenWidth < breakpoints.xl => BeBreakpoint.lg,
      _ when screenWidth < breakpoints.xl2 => BeBreakpoint.xl,
      _ => BeBreakpoint.xl2,
    };

extension BeBreakpointDevice on BeBreakpoint {
  bool get isMobile => this == BeBreakpoint.xs || this == BeBreakpoint.sm;
  bool get isTablet => this == BeBreakpoint.md;
  bool get isDesktop =>
      this == BeBreakpoint.lg ||
      this == BeBreakpoint.xl ||
      this == BeBreakpoint.xl2;
}
