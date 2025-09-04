// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Version of Wrap widget with full feature parity, debug support, and
/// allowing negative spacing & runSpacing for overlapping.
class BeWrap extends MultiChildRenderObjectWidget {
  const BeWrap({
    super.key,
    required super.children,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.spacing = 0.0,
    this.runSpacing = 0.0,
    this.padding = EdgeInsets.zero,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.debugGrid = false,
    this.debugGridColor = Colors.blue,
  }) : assert(spacing != double.infinity),
       assert(runSpacing != double.infinity);

  final Axis direction;
  final WrapAlignment alignment;
  final double spacing;
  final double runSpacing;
  final EdgeInsets padding;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;

  final bool debugGrid;
  final Color debugGridColor;

  @override
  RenderObject createRenderObject(final BuildContext context) {
    return _RenderBeWrap(
      direction: direction,
      alignment: alignment,
      spacing: spacing,
      runSpacing: runSpacing,
      padding: padding,
      textDirection: textDirection ?? Directionality.maybeOf(context),
      verticalDirection: verticalDirection,
      debugGrid: debugGrid,
      debugGridColor: debugGridColor,
    );
  }

  @override
  void updateRenderObject(final BuildContext context, final _RenderBeWrap renderObject) {
    renderObject
      ..direction = direction
      ..alignment = alignment
      ..spacing = spacing
      ..runSpacing = runSpacing
      ..padding = padding
      ..textDirection = textDirection ?? Directionality.maybeOf(context)
      ..verticalDirection = verticalDirection
      ..debugGrid = debugGrid
      ..debugGridColor = debugGridColor;
  }
}

class BeWrapParentData extends ContainerBoxParentData<RenderBox> {}

class _RunMetrics {
  _RunMetrics({required this.mainAxisExtent, required this.crossAxisExtent, required this.children});

  final double mainAxisExtent;
  final double crossAxisExtent;
  final List<RenderBox> children;
}

class _RenderBeWrap extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, BeWrapParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, BeWrapParentData> {
  _RenderBeWrap({
    required final Axis direction,
    required final WrapAlignment alignment,
    required final double spacing,
    required final double runSpacing,
    required final EdgeInsets padding,
    required final TextDirection? textDirection,
    required final VerticalDirection verticalDirection,
    required final bool debugGrid,
    required final Color debugGridColor,
  }) : _direction = direction,
       _alignment = alignment,
       _spacing = spacing,
       _runSpacing = runSpacing,
       _padding = padding,
       _textDirection = textDirection,
       _verticalDirection = verticalDirection,
       _debugGrid = debugGrid,
       _debugGridColor = debugGridColor;

  Axis _direction;
  WrapAlignment _alignment;
  double _spacing;
  double _runSpacing;
  EdgeInsets _padding;
  TextDirection? _textDirection;
  VerticalDirection _verticalDirection;
  bool _debugGrid;
  Color _debugGridColor;

  Axis get direction => _direction;
  set direction(final Axis value) {
    if (_direction != value) {
      _direction = value;
      markNeedsLayout();
    }
  }

  WrapAlignment get alignment => _alignment;
  set alignment(final WrapAlignment value) {
    if (_alignment != value) {
      _alignment = value;
      markNeedsLayout();
    }
  }

  double get spacing => _spacing;
  set spacing(final double value) {
    if (_spacing != value) {
      _spacing = value;
      markNeedsLayout();
    }
  }

  double get runSpacing => _runSpacing;
  set runSpacing(final double value) {
    if (_runSpacing != value) {
      _runSpacing = value;
      markNeedsLayout();
    }
  }

  EdgeInsets get padding => _padding;
  set padding(final EdgeInsets value) {
    if (_padding != value) {
      _padding = value;
      markNeedsLayout();
    }
  }

  TextDirection? get textDirection => _textDirection;
  set textDirection(final TextDirection? value) {
    if (_textDirection != value) {
      _textDirection = value;
      markNeedsLayout();
    }
  }

  VerticalDirection get verticalDirection => _verticalDirection;
  set verticalDirection(final VerticalDirection value) {
    if (_verticalDirection != value) {
      _verticalDirection = value;
      markNeedsLayout();
    }
  }

  bool get debugGrid => _debugGrid;
  set debugGrid(final bool value) {
    if (_debugGrid != value) {
      _debugGrid = value;
      markNeedsPaint();
    }
  }

  Color get debugGridColor => _debugGridColor;
  set debugGridColor(final Color value) {
    if (_debugGridColor != value) {
      _debugGridColor = value;
      markNeedsPaint();
    }
  }

  @override
  void setupParentData(final RenderBox child) {
    if (child.parentData is! BeWrapParentData) {
      child.parentData = BeWrapParentData();
    }
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    assert(
      constraints.hasBoundedWidth || constraints.hasBoundedHeight,
      'BeWrap needs bounded constraints in the main axis to layout.',
    );

    final double maxMainExtent =
        direction == Axis.horizontal
            ? constraints.maxWidth - padding.horizontal
            : constraints.maxHeight - padding.vertical;

    final double maxCrossExtent =
        direction == Axis.horizontal
            ? constraints.maxHeight - padding.vertical
            : constraints.maxWidth - padding.horizontal;

    final List<_RunMetrics> runs = [];

    List<RenderBox> currentRunChildren = [];

    double runMainExtent = 0.0; // sum width for horizontal, height for vertical
    double runCrossExtent = 0.0;

    var child = firstChild;
    while (child != null) {
      // Let children lay out with no max main constraint, but constrained cross axis, so they can measure their natural size
      child.layout(
        BoxConstraints(
          maxWidth: direction == Axis.horizontal ? double.infinity : maxCrossExtent,
          maxHeight: direction == Axis.horizontal ? maxCrossExtent : double.infinity,
          minWidth: 0,
          minHeight: 0,
        ),
        parentUsesSize: true,
      );

      final Size childSize = child.size;
      final double childMainAxisExtent = direction == Axis.horizontal ? childSize.width : childSize.height;
      final double childCrossAxisExtent = direction == Axis.horizontal ? childSize.height : childSize.width;

      final double spacingToAdd = currentRunChildren.isNotEmpty ? spacing : 0.0;
      // Check if fits in current run or need new run
      if (currentRunChildren.isNotEmpty && runMainExtent + spacingToAdd + childMainAxisExtent > maxMainExtent) {
        // Save current run metrics
        runs.add(
          _RunMetrics(mainAxisExtent: runMainExtent, crossAxisExtent: runCrossExtent, children: currentRunChildren),
        );
        currentRunChildren = [];
        runMainExtent = 0.0;
        runCrossExtent = 0.0;
      }

      if (currentRunChildren.isNotEmpty) {
        runMainExtent += spacing;
      }
      currentRunChildren.add(child);
      runMainExtent += childMainAxisExtent;
      runCrossExtent = max(runCrossExtent, childCrossAxisExtent);

      final BeWrapParentData childParentData = child.parentData! as BeWrapParentData;
      child = childParentData.nextSibling;
    }

    // Add last run
    if (currentRunChildren.isNotEmpty) {
      runs.add(
        _RunMetrics(mainAxisExtent: runMainExtent, crossAxisExtent: runCrossExtent, children: currentRunChildren),
      );
    }

    // Calculate container size along cross axis, accounting for run spacing
    double containerCrossExtent = 0;
    if (runs.isNotEmpty) {
      final double sumRunsCrossExtent = runs.fold(
        0.0,
        (final double sum, final _RunMetrics run) => sum + run.crossAxisExtent,
      );
      final double totalRunSpacing = runs.length > 1 ? (runs.length - 1) * runSpacing : 0.0;
      containerCrossExtent = sumRunsCrossExtent + totalRunSpacing;
    }

    final double containerMainExtent =
        direction == Axis.horizontal
            ? constraints.maxWidth
            : constraints.constrainWidth(
              padding.horizontal +
                  runs.fold<double>(0.0, (final double prev, final _RunMetrics run) => max(prev, run.mainAxisExtent)),
            );

    final double containerCrossExtentConstrained =
        direction == Axis.horizontal
            ? constraints.constrainHeight(padding.vertical + containerCrossExtent)
            : constraints.maxHeight;

    size = constraints.constrain(
      Size(
        direction == Axis.horizontal ? containerMainExtent : containerCrossExtentConstrained,
        direction == Axis.horizontal ? containerCrossExtentConstrained : containerMainExtent,
      ),
    );

    // Position Runs
    double crossAxisOffset = direction == Axis.horizontal ? padding.top : padding.left;

    for (final _RunMetrics run in runs) {
      double mainAxisOffset = direction == Axis.horizontal ? padding.left : padding.top;

      for (final RenderBox child in run.children) {
        final BeWrapParentData childParentData = child.parentData! as BeWrapParentData;
        childParentData.offset = Offset(mainAxisOffset, crossAxisOffset);
        mainAxisOffset += direction == Axis.horizontal ? child.size.width + spacing : child.size.height + spacing;
      }

      crossAxisOffset += run.crossAxisExtent + runSpacing;
    }
  }

  @override
  void paint(final PaintingContext context, final Offset offset) {
    defaultPaint(context, offset);

    if (debugGrid) {
      _paintDebugGrid(context, offset);
    }
  }

  void _paintDebugGrid(final PaintingContext context, final Offset offset) {
    final Paint paint =
        Paint()
          ..color = debugGridColor.withValues(alpha: 0.25)
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke;

    // vertical lines about each 50 pixels - grid overlay
    for (double x = offset.dx + padding.left; x < offset.dx + size.width - padding.right; x += 50) {
      context.canvas.drawLine(
        Offset(x, offset.dy + padding.top),
        Offset(x, offset.dy + size.height - padding.bottom),
        paint,
      );
    }

    // horizontal lines at runs boundaries and about each 50 pixels horizontally
    for (double y = offset.dy + padding.top; y < offset.dy + size.height - padding.bottom; y += 50) {
      context.canvas.drawLine(
        Offset(offset.dx + padding.left, y),
        Offset(offset.dx + size.width - padding.right, y),
        paint,
      );
    }
  }

  @override
  bool hitTestChildren(final BoxHitTestResult result, {required final Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  double computeMinIntrinsicWidth(final double height) {
    if (direction == Axis.horizontal) {
      final double totalChildWidths = _sumChildrenSizes((final child) => child.getMinIntrinsicWidth(height));
      return padding.horizontal + totalChildWidths + max(0, childCount - 1) * spacing;
    } else {
      return padding.horizontal + _maxChildSizeMain((final child) => child.getMinIntrinsicWidth(height));
    }
  }

  @override
  double computeMaxIntrinsicWidth(final double height) {
    if (direction == Axis.horizontal) {
      final double totalChildWidths = _sumChildrenSizes((final child) => child.getMaxIntrinsicWidth(height));
      return padding.horizontal + totalChildWidths + max(0, childCount - 1) * spacing;
    } else {
      return padding.horizontal + _maxChildSizeMain((final child) => child.getMaxIntrinsicWidth(height));
    }
  }

  @override
  double computeMinIntrinsicHeight(final double width) {
    if (direction == Axis.vertical) {
      final double totalChildHeights = _sumChildrenSizes((final child) => child.getMinIntrinsicHeight(width));
      return padding.vertical + totalChildHeights + max(0, childCount - 1) * spacing;
    } else {
      return padding.vertical + _maxChildSizeCross((final child) => child.getMinIntrinsicHeight(width));
    }
  }

  @override
  double computeMaxIntrinsicHeight(final double width) {
    if (direction == Axis.vertical) {
      final double totalChildHeights = _sumChildrenSizes((final child) => child.getMaxIntrinsicHeight(width));
      return padding.vertical + totalChildHeights + max(0, childCount - 1) * spacing;
    } else {
      return padding.vertical + _maxChildSizeCross((final child) => child.getMaxIntrinsicHeight(width));
    }
  }

  @override
  @override
  int get childCount {
    int count = 0;
    var child = firstChild;
    while (child != null) {
      count++;
      final BeWrapParentData childParentData = child.parentData! as BeWrapParentData;
      child = childParentData.nextSibling;
    }
    return count;
  }

  double _sumChildrenSizes(final double Function(RenderBox child) sizeGetter) {
    double sum = 0;
    var child = firstChild;
    bool first = true;
    while (child != null) {
      if (!first) sum += spacing; // spacing applies between children
      sum += sizeGetter(child);
      first = false;

      final BeWrapParentData childParentData = child.parentData! as BeWrapParentData;
      child = childParentData.nextSibling;
    }
    return sum;
  }

  double _maxChildSizeMain(final double Function(RenderBox child) sizeGetter) {
    double maxSize = 0;
    var child = firstChild;
    while (child != null) {
      maxSize = max(maxSize, sizeGetter(child));
      final BeWrapParentData childParentData = child.parentData! as BeWrapParentData;
      child = childParentData.nextSibling;
    }
    return maxSize;
  }

  double _maxChildSizeCross(final double Function(RenderBox child) sizeGetter) {
    double maxSize = 0;
    var child = firstChild;
    while (child != null) {
      maxSize = max(maxSize, sizeGetter(child));
      final BeWrapParentData childParentData = child.parentData! as BeWrapParentData;
      child = childParentData.nextSibling;
    }
    return maxSize;
  }
}
