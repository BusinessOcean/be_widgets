// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BeRow extends MultiChildRenderObjectWidget {
  const BeRow({
    super.key,
    required super.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.padding = EdgeInsets.zero,
    this.debugGrid = false,
    this.debugGridColor = Colors.red,
  });

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final double spacing;
  final double runSpacing;
  final EdgeInsets padding;
  final bool debugGrid;
  final Color debugGridColor;

  @override
  RenderObject createRenderObject(final BuildContext context) {
    return _RenderBeRow(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      spacing: spacing,
      runSpacing: runSpacing,
      padding: padding,
      debugGrid: debugGrid,
      debugGridColor: debugGridColor,
    );
  }

  @override
  void updateRenderObject(final BuildContext context, final _RenderBeRow renderObject) {
    renderObject
      ..mainAxisAlignment = mainAxisAlignment
      ..crossAxisAlignment = crossAxisAlignment
      ..mainAxisSize = mainAxisSize
      ..spacing = spacing
      ..runSpacing = runSpacing
      ..padding = padding
      ..debugGrid = debugGrid
      ..debugGridColor = debugGridColor;
  }
}

class _RenderBeRow extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, BeRowParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, BeRowParentData> {
  _RenderBeRow({
    required final MainAxisAlignment mainAxisAlignment,
    required final CrossAxisAlignment crossAxisAlignment,
    required final MainAxisSize mainAxisSize,
    required final double spacing,
    required final double runSpacing,
    required final EdgeInsets padding,
    required final bool debugGrid,
    required final Color debugGridColor,
  }) : _mainAxisAlignment = mainAxisAlignment,
       _crossAxisAlignment = crossAxisAlignment,
       _mainAxisSize = mainAxisSize,
       _spacing = spacing,
       _runSpacing = runSpacing,
       _padding = padding,
       _debugGrid = debugGrid,
       _debugGridColor = debugGridColor;

  MainAxisAlignment _mainAxisAlignment;
  CrossAxisAlignment _crossAxisAlignment;
  MainAxisSize _mainAxisSize;
  double _spacing;
  double _runSpacing;
  EdgeInsets _padding;
  bool _debugGrid;
  Color _debugGridColor;

  MainAxisAlignment get mainAxisAlignment => _mainAxisAlignment;
  set mainAxisAlignment(final MainAxisAlignment value) {
    if (_mainAxisAlignment != value) {
      _mainAxisAlignment = value;
      markNeedsLayout();
    }
  }

  CrossAxisAlignment get crossAxisAlignment => _crossAxisAlignment;
  set crossAxisAlignment(final CrossAxisAlignment value) {
    if (_crossAxisAlignment != value) {
      _crossAxisAlignment = value;
      markNeedsLayout();
    }
  }

  MainAxisSize get mainAxisSize => _mainAxisSize;
  set mainAxisSize(final MainAxisSize value) {
    if (_mainAxisSize != value) {
      _mainAxisSize = value;
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
    if (child.parentData is! BeRowParentData) {
      child.parentData = BeRowParentData();
    }
  }

  @override
  void performLayout() {
    final availableWidth = constraints.maxWidth - padding.horizontal;
    final availableHeight = constraints.maxHeight - padding.vertical;

    if (childCount == 0) {
      size = _computeEmptySize();
      return;
    }

    final visibleChildren = _getVisibleChildren();
    if (visibleChildren.isEmpty) {
      size = _computeEmptySize();
      return;
    }

    // Calculate column width considering spacing between 12 columns
    final totalSpacingWidth = _spacing * 11; // 11 gaps between 12 columns
    final columnWidth = (availableWidth - totalSpacingWidth) / 12;
    final rows = _calculateRowLayout(visibleChildren);

    double currentY = padding.top;
    double maxWidth = 0.0;

    for (final row in rows) {
      final rowLayout = _layoutRow(row, columnWidth, availableHeight - currentY + padding.top);
      _positionRow(row, rowLayout, currentY);

      currentY += rowLayout.height + _runSpacing;
      maxWidth = max(maxWidth, rowLayout.width);
    }

    if (rows.isNotEmpty) {
      currentY -= _runSpacing;
    }

    size = constraints.constrain(
      Size(_mainAxisSize == MainAxisSize.max ? constraints.maxWidth : maxWidth, currentY + padding.bottom),
    );
  }

  Size _computeEmptySize() {
    return constraints.constrain(
      Size(_mainAxisSize == MainAxisSize.max ? constraints.maxWidth : padding.horizontal, padding.vertical),
    );
  }

  List<RenderBox> _getVisibleChildren() {
    final visibleChildren = <RenderBox>[];
    var child = firstChild;

    while (child != null) {
      if (child is RenderBeColumn && !child.isHidden(constraints.maxWidth)) {
        visibleChildren.add(child);
      } else {
        child.layout(const BoxConstraints(), parentUsesSize: true);
      }

      final parentData = child.parentData! as BeRowParentData;
      child = parentData.nextSibling;
    }

    return visibleChildren;
  }

  List<List<RenderBox>> _calculateRowLayout(final List<RenderBox> children) {
    final rows = <List<RenderBox>>[];
    List<RenderBox> currentRow = [];
    int currentRowWidth = 0;

    for (final child in children) {
      final columns = (child as RenderBeColumn).getColumnCount(constraints.maxWidth);

      if (currentRowWidth + columns <= 12) {
        currentRow.add(child);
        currentRowWidth += columns;
      } else {
        rows.add(currentRow);
        currentRow = [child];
        currentRowWidth = columns;
      }
    }

    if (currentRow.isNotEmpty) {
      rows.add(currentRow);
    }

    return rows;
  }

  _RowLayout _layoutRow(final List<RenderBox> row, final double columnWidth, final double maxHeight) {
    double currentX = 0.0; // Start from 0, padding will be added in positioning
    double maxHeightInRow = 0.0;
    final offsets = <Offset>[];

    for (int i = 0; i < row.length; i++) {
      final child = row[i];
      final columns = (child as RenderBeColumn).getColumnCount(constraints.maxWidth);
      // For a child spanning multiple columns, include the spacing that would be between those columns
      // For example: 3 columns = 3 * columnWidth + 2 * spacing (gaps between the 3 columns)
      final childWidth = (columnWidth * columns) + (_spacing * (columns - 1));

      child.layout(
        BoxConstraints(minWidth: 0, maxWidth: childWidth, minHeight: 0, maxHeight: maxHeight),
        parentUsesSize: true,
      );

      offsets.add(Offset(currentX, 0));
      currentX += childWidth;

      // Add spacing between child elements (but not after the last child)
      if (i < row.length - 1) {
        currentX += _spacing;
      }

      maxHeightInRow = max(maxHeightInRow, child.size.height);
    }

    return _RowLayout(width: currentX + padding.horizontal, height: maxHeightInRow, offsets: offsets);
  }

  void _positionRow(final List<RenderBox> row, final _RowLayout layout, final double y) {
    for (int i = 0; i < row.length; i++) {
      final child = row[i];

      (child.parentData! as BeRowParentData).offset = Offset(layout.offsets[i].dx + padding.left, y);
    }
  }

  @override
  void paint(final PaintingContext context, final Offset offset) {
    defaultPaint(context, offset);

    if (_debugGrid) {
      _paintDebugGrid(context, offset);
    }
  }

  void _paintDebugGrid(final PaintingContext context, final Offset offset) {
    final totalSpacingWidth = _spacing * 11; // 11 gaps between 12 columns
    final columnWidth = (size.width - padding.horizontal - totalSpacingWidth) / 12;
    final paint =
        Paint()
          ..color = _debugGridColor.withValues(alpha: 0.3)
          ..strokeWidth = 1;

    for (int i = 0; i <= 12; i++) {
      final x = padding.left + (columnWidth * i) + (_spacing * i);
      context.canvas.drawLine(
        Offset(x + offset.dx, padding.top + offset.dy),
        Offset(x + offset.dx, size.height - padding.bottom + offset.dy),
        paint,
      );
    }
  }

  @override
  bool hitTestChildren(final BoxHitTestResult result, {required final Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  double computeMinIntrinsicWidth(final double height) => padding.horizontal;

  @override
  double computeMaxIntrinsicWidth(final double height) => constraints.maxWidth;

  @override
  double computeMinIntrinsicHeight(final double width) => padding.vertical;

  @override
  double computeMaxIntrinsicHeight(final double width) => constraints.maxHeight;
}

class _RowLayout {
  _RowLayout({required this.width, required this.height, required this.offsets});
  final double width;
  final double height;
  final List<Offset> offsets;
}

mixin RenderBeColumn on RenderBox {
  int getColumnCount(final double screenWidth);
  bool isHidden(final double screenWidth) => getColumnCount(screenWidth) == 0;
}

class BeRowParentData extends MultiChildLayoutParentData {
  // Additional parent data if needed
}
