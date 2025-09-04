import 'package:be_widgets/src/be_breakpoint.dart';
import 'package:be_widgets/src/be_column.dart';
import 'package:flutter/material.dart';

class BeContainer extends StatelessWidget {
  const BeContainer({
    super.key,
    required this.child,
    this.fluid = false,
    this.padding,
    this.maxWidth,
    this.alignment = Alignment.center,
  });

  final Widget child;
  final bool fluid;
  final EdgeInsets? padding;
  final double? maxWidth;
  final Alignment alignment;

  @override
  Widget build(final BuildContext context) {
    return LayoutBuilder(
      builder: (final context, final constraints) {
        final screenWidth = constraints.maxWidth;
        final effectivePadding = padding ?? _getResponsivePadding(screenWidth);
        final effectiveMaxWidth =
            fluid ? null : maxWidth ?? _getResponsiveMaxWidth(screenWidth);

        return Container(
          width: double.infinity,
          constraints: effectiveMaxWidth != null
              ? BoxConstraints(maxWidth: effectiveMaxWidth)
              : null,
          padding: effectivePadding,
          alignment: alignment,
          child: child,
        );
      },
    );
  }

  EdgeInsets _getResponsivePadding(final double screenWidth) {
    final breakpoint = calculateBreakpoint(screenWidth);

    return switch (breakpoint) {
      BeBreakpoint.xl2 ||
      BeBreakpoint.xl ||
      BeBreakpoint.lg =>
        const EdgeInsets.symmetric(horizontal: 24.0),
      BeBreakpoint.md => const EdgeInsets.symmetric(horizontal: 20.0),
      BeBreakpoint.sm ||
      BeBreakpoint.xs =>
        const EdgeInsets.symmetric(horizontal: 16.0),
    };
  }

  double _getResponsiveMaxWidth(final double screenWidth) {
    final breakpoint = calculateBreakpoint(screenWidth);

    return switch (breakpoint) {
      BeBreakpoint.xl2 => 1320,
      BeBreakpoint.xl => 1140,
      BeBreakpoint.lg => 960,
      BeBreakpoint.md => 720,
      BeBreakpoint.sm => 540,
      BeBreakpoint.xs => screenWidth,
    };
  }
}

class BeGap extends StatelessWidget {
  const BeGap({super.key, this.columns = 1});
  final int columns;

  @override
  Widget build(final BuildContext context) {
    return BeColumn(xs: columns, child: const SizedBox.shrink());
  }
}

// Utility extensions
extension BeGridUtilsExtension on List<Widget> {
  List<BeColumn> toEqualColumns({final int columns = 12}) {
    final colSize = columns ~/ length;
    return map((final child) => BeColumn(xs: colSize, child: child)).toList();
  }

  List<BeColumn> toResponsiveColumns({
    final int xs = 12,
    final int? sm,
    final int? md,
    final int? lg,
    final int? xl,
    final int? xl2,
  }) {
    return map((final child) => BeColumn(
        xs: xs,
        sm: sm,
        md: md,
        lg: lg,
        xl: xl,
        xl2: xl2,
        child: child)).toList();
  }
}

// Predefined layout templates
class BeLayoutTemplates {
  static List<BeColumn> twoColumn(final Widget left, final Widget right) {
    return [left.beColumn(xs: 12, md: 6), right.beColumn(xs: 12, md: 6)];
  }

  static List<BeColumn> threeColumn(
      final Widget left, final Widget center, final Widget right) {
    return [
      left.beColumn(xs: 12, md: 4),
      center.beColumn(xs: 12, md: 4),
      right.beColumn(xs: 12, md: 4)
    ];
  }

  static List<BeColumn> sidebarMain(
      final Widget sidebar, final Widget mainContent,
      {final int sidebarSize = 3}) {
    return [
      sidebar.beColumn(xs: 12, md: sidebarSize),
      mainContent.beColumn(xs: 12, md: 12 - sidebarSize)
    ];
  }
}
