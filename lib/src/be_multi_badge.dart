// ignore_for_file: lines_longer_than_80_chars, library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Custom Flutter widget for rendering a badge on another widget </br>
/// [child] of Widget Type. badge widget respects child widget dimension
/// [rounded] will min(size.width, size.height) / 4 inside;
class BeMultiBadge extends MultiChildRenderObjectWidget {
  BeMultiBadge({required this.child, required this.labels, super.key, this.rounded = false})
    : super(children: [child, ...labels]);
  final Widget child;
  final bool rounded;
  final List<BeBadgeChild> labels;
  @override
  RenderObject createRenderObject(final BuildContext context) => _BeMultiLabelRenderObject(rounded: rounded);

  @override
  void updateRenderObject(final BuildContext context, final _BeMultiLabelRenderObject renderObject) {
    renderObject.rounded = rounded;
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('rounded', rounded));
  }
}

class _BeMultiLabelRenderObject extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _BeMultiBadgeParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _BeMultiBadgeParentData> {
  _BeMultiLabelRenderObject({required final bool rounded}) : _rounded = rounded;

  bool _rounded;
  set rounded(final bool value) {
    if (_rounded != value) {
      _rounded = value;
      markNeedsLayout();
    }
  }

  @override
  void setupParentData(covariant final RenderObject child) {
    child.parentData = _BeMultiBadgeParentData();
  }

  @override
  void performLayout() {
    final child = firstChild!;
    child.layout(constraints, parentUsesSize: true);
    size = child.size;

    // Layout all badge children
    final children = getChildrenAsList();
    for (final c in children) {
      if (c == firstChild) continue;

      final badge = c;
      badge.layout(const BoxConstraints(), parentUsesSize: true);

      final badgeParentData = badge.parentData! as _BeMultiBadgeParentData;
      final badgeRenderBox = badge as _BadgeRenderBox;
      final labelOffset = _getOffset(
        badgeRenderBox._position,
        badgeRenderBox._offset,
        badge.size.width,
        badge.size.height,
      );
      badgeParentData.offset = labelOffset;
    }
  }

  @override
  void paint(final PaintingContext context, final Offset offset) {
    defaultPaint(context, offset);
  }

  Offset _getOffset(
    final BeMultiBadgePosition badgePosition,
    final Offset childOffset,
    final double badgeWidth,
    final double badgeHeight,
  ) {
    final radius = min(size.width, size.height) / 2;
    final roundShift = radius / 2;

    final (double x, double y) = switch (badgePosition) {
      BeMultiBadgePosition.topLeft => (
        (-badgeWidth / 2) + (_rounded ? roundShift : 0),
        -badgeHeight / 2 + (_rounded ? roundShift / 3 : 0),
      ),
      BeMultiBadgePosition.topCenter => ((size.width - badgeWidth) / 2, -badgeHeight / 2),
      BeMultiBadgePosition.topRight => (
        (size.width - badgeWidth / 2) - (_rounded ? roundShift : 0),
        (-badgeHeight / 2) + (_rounded ? roundShift / 3 : 0),
      ),
      BeMultiBadgePosition.bottomRight => (
        (size.width - badgeWidth / 2) - (_rounded ? roundShift : 0),
        (size.height - badgeHeight / 2) - (_rounded ? roundShift / 3 : 0),
      ),
      BeMultiBadgePosition.bottomCenter => ((size.width - badgeWidth) / 2, size.height - badgeHeight / 2),
      BeMultiBadgePosition.bottomLeft => (
        (-badgeWidth / 2) + (_rounded ? roundShift : 0),
        (size.height - badgeHeight / 2) - (_rounded ? roundShift / 3 : 0),
      ),
      BeMultiBadgePosition.centerLeft => (-badgeWidth / 2, (size.height - badgeHeight) / 2),
      BeMultiBadgePosition.center => ((size.width - badgeWidth) / 2, (size.height - badgeHeight) / 2),
      BeMultiBadgePosition.centerRight => (size.width - badgeWidth / 2, (size.height - badgeHeight) / 2),
    };

    return Offset(x + childOffset.dx, y + childOffset.dy);
  }

  @override
  bool hitTest(final BoxHitTestResult result, {required final Offset position}) {
    // Test badges first (in reverse order since later ones are visually on top)
    final children = getChildrenAsList();

    // Test badges from last to first (visual z-order)
    for (var i = children.length - 1; i >= 0; i--) {
      final child = children[i];
      final childParentData = child.parentData! as _BeMultiBadgeParentData;

      if (child == firstChild) {
        // Main child - test with its offset
        final childLocalPosition = position - childParentData.offset;
        if (child.size.contains(childLocalPosition)) {
          if (child.hitTest(result, position: childLocalPosition)) {
            result.add(BoxHitTestEntry(this, position));
            return true;
          }
        }
      } else {
        // Badge children
        final badgeLocalPosition = position - childParentData.offset;
        if (child.size.contains(badgeLocalPosition)) {
          if (child.hitTest(result, position: badgeLocalPosition)) {
            result.add(BoxHitTestEntry(this, position));
            return true;
          }
        }
      }
    }

    return false;
  }
}

class _BeMultiBadgeParentData extends ContainerBoxParentData<RenderBox> with ContainerParentDataMixin<RenderBox> {}

// ==========================================================================

/// Custom Flutter widget for rendering a badge on another widget </br>
/// [child] of Widget Type. badge widget respects child widget dimension
/// [offset] translate widget to offset based on [Offset] default is [Offset.zero]
/// [position] set alignment position of badge
class BeBadgeChild extends SingleChildRenderObjectWidget {
  const BeBadgeChild({required this.position, required super.child, super.key, this.offset = Offset.zero});
  final BeMultiBadgePosition position;
  final Offset offset;

  @override
  RenderObject createRenderObject(final BuildContext context) => _BadgeRenderBox(offset: offset, position: position);

  @override
  void updateRenderObject(final BuildContext context, final _BadgeRenderBox renderObject) {
    renderObject
      ..position = position
      ..offset = offset;
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<BeMultiBadgePosition>('position', position))
      ..add(DiagnosticsProperty<Offset>('offset', offset));
  }
}

///
final class _BadgeRenderBox extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  _BadgeRenderBox({required final BeMultiBadgePosition position, required final Offset offset})
    : _position = position,
      _offset = offset;

  var _lastSize = Size.zero;

  BeMultiBadgePosition _position;
  set position(final BeMultiBadgePosition position) {
    if (_position != position) {
      _position = position;
      markNeedsLayout();
    }
  }

  Offset _offset;
  set offset(final Offset value) {
    if (_offset != value) {
      _offset = value;
      markNeedsLayout();
    }
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
    }
  }

  @override
  void paint(final PaintingContext context, final Offset offset) {
    final child = this.child;
    if (child != null) {
      context.paintChild(child, offset);
    }
  }

  @override
  bool hitTestChildren(final BoxHitTestResult result, {required final Offset position}) {
    return child?.hitTest(result, position: position) == true;
  }

  @override
  bool hitTest(final BoxHitTestResult result, {required final Offset position}) {
    if (size.contains(position)) {
      return hitTestChildren(result, position: position) || super.hitTest(result, position: position);
    }
    return false;
  }
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
