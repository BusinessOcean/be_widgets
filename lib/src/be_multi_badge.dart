// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Custom Flutter widget for rendering a badge on another widget </br>
/// [child] of Widget Type. badge widget respects child widget dimention
/// [rounded] will min(size.width, size.height) / 4 inside;
class BeMultiBadge extends MultiChildRenderObjectWidget {
  BeMultiBadge({
    super.key,
    required this.child,
    required this.labels,
    this.rounded = false,
  }) : super(children: [child, ...labels]);
  final Widget child;
  final bool rounded;
  final List<BeBadgeChild> labels;
  @override
  RenderObject createRenderObject(BuildContext context) =>
      _BeMultiLabelRenderObject(rounded: rounded);

  @override
  void updateRenderObject(
    BuildContext context,
    _BeMultiLabelRenderObject renderObject,
  ) {
    renderObject.rounded = rounded;
  }
}

class _BeMultiLabelRenderObject extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _BeMultiBadgeParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _BeMultiBadgeParentData> {
  _BeMultiLabelRenderObject({required bool rounded}) : _rounded = rounded;

  bool _rounded;
  set rounded(bool value) {
    _rounded = value;
    markNeedsPaint();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    child.parentData = _BeMultiBadgeParentData();
  }

  @override
  void performLayout() {
    final child = firstChild;
    child!.layout(constraints, parentUsesSize: true);

    size = child.size;

    for (final c in getChildrenAsList()) {
      if (c == firstChild) continue;
      final badge = (c as _BadgeRenderBox)
        ..layout(
          const BoxConstraints(),
          parentUsesSize: true,
        );
      final badgeParentData = badge.parentData as _BeMultiBadgeParentData;
      final labelOffset = _getOffset(
        badge._position,
        badge._offset,
        badge.size.width,
        badge.size.height,
      );
      badgeParentData.offset = labelOffset;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  Offset _getOffset(
    BeMultiBadgePosition badgePosition,
    Offset childOffset,
    double badgeWidth,
    double badgeHeight,
  ) {
    var translateX = 0.0;
    var translateY = 0.0;
    final radius = min(size.width, size.height) / 2;
    final roundShift = radius / 2;

    final (double x, double y) = switch (badgePosition) {
      BeMultiBadgePosition.topLeft => (
          (-badgeWidth / 2) + (_rounded ? roundShift : 0),
          -badgeHeight / 2 + (_rounded ? roundShift / 3 : 0)
        ),
      BeMultiBadgePosition.topCenter => (
          ((size.width - badgeWidth) / 2),
          -badgeHeight / 2
        ),
      BeMultiBadgePosition.topRight => (
          (size.width - badgeWidth / 2) - (_rounded ? roundShift : 0),
          (-badgeHeight / 2) + (_rounded ? roundShift / 3 : 0)
        ),
      BeMultiBadgePosition.bottomRight => (
          (size.width - badgeWidth / 2) - (_rounded ? roundShift : 0),
          (size.height - badgeHeight / 2) - (_rounded ? roundShift / 3 : 0)
        ),
      BeMultiBadgePosition.bottomCenter => (
          (size.width - badgeWidth) / 2,
          (size.height - badgeHeight / 2)
        ),
      BeMultiBadgePosition.bottomLeft => (
          (-badgeWidth / 2) + (_rounded ? roundShift : 0),
          (size.height - badgeHeight / 2) - (_rounded ? roundShift / 3 : 0)
        ),
      BeMultiBadgePosition.centerLeft => (
          (-badgeWidth / 2),
          (size.height - badgeHeight) / 2
        ),
      BeMultiBadgePosition.center => (
          (size.width - badgeWidth) / 2,
          (size.height - badgeHeight) / 2
        ),
      BeMultiBadgePosition.centerRight => (
          (size.width - badgeWidth / 2),
          (size.height - badgeHeight) / 2
        ),
    };
    translateX = x + childOffset.dx;
    translateY = y + childOffset.dy;

    return Offset(translateX, translateY);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    for (final child in getChildrenAsList()) {
      final badgeParentData = child.parentData as _BeMultiBadgeParentData;
      // TODO(sourav): fix hitTest for bottom
      final badgePosition = Offset(
        position.dx - badgeParentData.offset.dx,
        position.dy - badgeParentData.offset.dy,
      );
      if (child.size.contains(badgePosition)) {
        if (hitTestChildren(result, position: position) ||
            hitTestSelf(position)) {
          result.add(BoxHitTestEntry(this, position));
          return true;
        }
      }

      if (size.contains(position)) {
        if (hitTestChildren(result, position: position) ||
            hitTestSelf(position)) {
          result.add(BoxHitTestEntry(this, position));
          return true;
        }
      }
    }
    return false;
  }
}

class _BeMultiBadgeParentData extends ContainerBoxParentData<RenderBox>
    with ContainerParentDataMixin<RenderBox> {}

// ==========================================================================

/// Custom Flutter widget for rendering a badge on another widget </br>
/// [child] of Widget Type. badge widget respects child widget dimention
/// [offset] translate widget to offset based on [Offset] default is [Offset.zero]
/// [position] set alignment position of badge
class BeBadgeChild extends SingleChildRenderObjectWidget {
  const BeBadgeChild({
    super.key,
    this.offset = Offset.zero,
    required this.position,
    required super.child,
  });
  final BeMultiBadgePosition position;
  final Offset offset;

  @override
  RenderObject createRenderObject(BuildContext context) => _BadgeRenderBox(
        offset: offset,
        position: position,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    _BadgeRenderBox renderObject,
  ) {
    renderObject
      ..position = position
      ..offset = offset;
  }
}

class _BadgeRenderBox extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  // Add any properties and constructor you need
  _BadgeRenderBox({
    required BeMultiBadgePosition position,
    required Offset offset,
  })  : _position = position,
        _offset = offset;

  var _lastSize = Size.zero;

  BeMultiBadgePosition _position;
  set position(BeMultiBadgePosition position) {
    _position = position;
    markNeedsPaint();
  }

  Offset _offset;
  set offset(Offset value) {
    _offset = value;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    final child = this.child;
    if (child != null) {
      child.layout(constraints, parentUsesSize: true);
      size = child.size;
    } else {
      size = constraints.smallest;
    }

    if (_lastSize != size) {
      _lastSize = size;
      // _widget.onChildSizeChanged?.call(_lastSize);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child != null) {
      context.paintChild(child, offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      child?.hitTest(result, position: position) == true;
}

enum BeMultiBadgePosition {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}
