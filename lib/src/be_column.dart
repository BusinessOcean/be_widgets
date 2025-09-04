import 'package:be_widgets/src/be_breakpoint.dart'
    show BeResponsivePoints, calculateBreakpoint, BeBreakpoint;
import 'package:be_widgets/src/be_row.dart' show RenderBeColumn;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A Bootstrap-inspired column widget that works within a BeRow to create responsive layouts.
class BeColumn extends SingleChildRenderObjectWidget {
  const BeColumn({
    super.key,
    required super.child,
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xl2,
    this.offset = 0,
    this.order,
  });

  final int? xs;
  final int? sm;
  final int? md;
  final int? lg;
  final int? xl;
  final int? xl2;
  final int offset;
  final int? order;

  // Builder pattern for fluent API
  BeColumn copyWith({
    final int? xs,
    final int? sm,
    final int? md,
    final int? lg,
    final int? xl,
    final int? xl2,
    final int? offset,
    final int? order,
    final Widget? child,
  }) {
    return BeColumn(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xl2: xl2 ?? this.xl2,
      offset: offset ?? this.offset,
      order: order ?? this.order,
      child: child ?? this.child!,
    );
  }

  @override
  RenderObject createRenderObject(final BuildContext context) {
    return _RenderBeColumn(
        xs: xs,
        sm: sm,
        md: md,
        lg: lg,
        xl: xl,
        xl2: xl2,
        offset: offset,
        order: order);
  }

  @override
  void updateRenderObject(
      final BuildContext context, final _RenderBeColumn renderObject) {
    renderObject
      ..xs = xs
      ..sm = sm
      ..md = md
      ..lg = lg
      ..xl = xl
      ..xl2 = xl2
      ..offset = offset
      ..order = order;
  }
}

class _RenderBeColumn extends RenderProxyBox with RenderBeColumn {
  _RenderBeColumn({
    final int? xs,
    final int? sm,
    final int? md,
    final int? lg,
    final int? xl,
    final int? xl2,
    final int offset = 0,
    final int? order,
  })  : _xs = xs,
        _sm = sm,
        _md = md,
        _lg = lg,
        _xl = xl,
        _xl2 = xl2,
        _offset = offset,
        _order = order;

  int? _xs;
  int? _sm;
  int? _md;
  int? _lg;
  int? _xl;
  int? _xl2;
  int _offset;
  int? _order;

  int? get xs => _xs;
  set xs(final int? value) {
    if (_xs != value) {
      _xs = value;
      markNeedsLayout();
    }
  }

  int? get sm => _sm;
  set sm(final int? value) {
    if (_sm != value) {
      _sm = value;
      markNeedsLayout();
    }
  }

  int? get md => _md;
  set md(final int? value) {
    if (_md != value) {
      _md = value;
      markNeedsLayout();
    }
  }

  int? get lg => _lg;
  set lg(final int? value) {
    if (_lg != value) {
      _lg = value;
      markNeedsLayout();
    }
  }

  int? get xl => _xl;
  set xl(final int? value) {
    if (_xl != value) {
      _xl = value;
      markNeedsLayout();
    }
  }

  int? get xl2 => _xl2;
  set xl2(final int? value) {
    if (_xl2 != value) {
      _xl2 = value;
      markNeedsLayout();
    }
  }

  int get offset => _offset;
  set offset(final int value) {
    if (_offset != value) {
      _offset = value;
      markNeedsLayout();
    }
  }

  int? get order => _order;
  set order(final int? value) {
    if (_order != value) {
      _order = value;
      markNeedsLayout();
    }
  }

  @override
  int getColumnCount(final double screenWidth) {
    return _getColumnCountForScreenWidth(screenWidth);
  }

  @override
  bool isHidden(final double screenWidth) {
    return _getColumnCountForScreenWidth(screenWidth) == 0;
  }

  int _getColumnCountForScreenWidth(final double screenWidth) {
    const breakpoints = BeResponsivePoints();
    final breakpoint = calculateBreakpoint(screenWidth, breakpoints);

    return switch (breakpoint) {
      BeBreakpoint.xs => xs ?? 12,
      BeBreakpoint.sm => sm ?? xs ?? 12,
      BeBreakpoint.md => md ?? sm ?? xs ?? 12,
      BeBreakpoint.lg => lg ?? md ?? sm ?? xs ?? 12,
      BeBreakpoint.xl => xl ?? lg ?? md ?? sm ?? xs ?? 12,
      BeBreakpoint.xl2 => xl2 ?? xl ?? lg ?? md ?? sm ?? xs ?? 12,
    };
  }

  @override
  void performLayout() {
    if (isHidden(constraints.maxWidth)) {
      size = Size.zero;
      child?.layout(const BoxConstraints.tightFor(width: 0, height: 0));
      return;
    }
    super.performLayout();
  }

  @override
  void paint(final PaintingContext context, final Offset offset) {
    if (!isHidden(constraints.maxWidth)) {
      super.paint(context, offset);
    }
  }

  @override
  bool hitTestSelf(final Offset position) {
    return !isHidden(constraints.maxWidth) && super.hitTestSelf(position);
  }
}

// Extension for fluent API
extension BeColumnExtension on Widget {
  BeColumn beColumn({
    final int? xs,
    final int? sm,
    final int? md,
    final int? lg,
    final int? xl,
    final int? xl2,
    final int offset = 0,
    final int? order,
  }) {
    return BeColumn(
        xs: xs,
        sm: sm,
        md: md,
        lg: lg,
        xl: xl,
        xl2: xl2,
        offset: offset,
        order: order,
        child: this);
  }
}
