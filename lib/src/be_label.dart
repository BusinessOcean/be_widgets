// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Custom Flutter widget for rendering a label on another widget </br>
/// [child] of Widget Type. badge widget respects child widget dimension
/// [label] of Widget Type. badge widget respects child
/// [childSized] make with of label full of hight or width size;
/// [offset] translate widget to offset based on [Offset] default is [Offset.zero]
/// [position] set alignment position of badge
class BeLabel extends MultiChildRenderObjectWidget {
  BeLabel({
    super.key,
    required this.child,
    this.label,
    this.offset = Offset.zero,
    this.childSized = false,
    this.innerLabel = false,
    this.position = BeLabelPosition.topLeft,
  }) : super(children: [child, label ?? const SizedBox.shrink()]);
  final Widget child;
  final Widget? label;
  final BeLabelPosition position;
  final Offset offset;
  final bool childSized;
  final bool innerLabel;
  @override
  RenderObject createRenderObject(BuildContext context) => _BeLabelRenderObject(
        position: position,
        offset: offset,
        childSized: childSized,
        innerLabel: innerLabel,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    _BeLabelRenderObject renderObject,
  ) {
    renderObject
      ..position = position
      ..offset = offset
      ..innerLabel = innerLabel
      ..childSized = childSized;
  }
}

class _BeLabelRenderObject extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _BeLabelChildParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _BeLabelChildParentData> {
  _BeLabelRenderObject({
    required BeLabelPosition position,
    required Offset offset,
    required bool childSized,
    required bool innerLabel,
  })  : _position = position,
        _childSized = childSized,
        _offset = offset,
        _innerLabel = innerLabel;

  BeLabelPosition _position;
  set position(BeLabelPosition position) {
    _position = position;
    markNeedsPaint();
  }

  Offset _offset;
  set offset(Offset value) {
    _offset = value;
    markNeedsPaint();
  }

  bool _childSized;
  set childSized(bool value) {
    _childSized = value;
    markNeedsLayout();
    markNeedsPaint();
  }

  bool _innerLabel;
  set innerLabel(bool value) {
    _innerLabel = value;
    markNeedsLayout();
    markNeedsPaint();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    child.parentData = _BeLabelChildParentData();
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final labelParentData = lastChild!.parentData as _BeLabelChildParentData;
    final labelPosition = Offset(
      position.dx - labelParentData.offset.dx,
      position.dy - labelParentData.offset.dy,
    );
    if (lastChild!.size.contains(labelPosition)) {
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
    return false;
  }

  @override
  void performLayout() {
    final child = firstChild;
    final badge = lastChild;
    child!.layout(constraints, parentUsesSize: true);

    size = child.size;

    badge!.layout(
      _childSized ? BoxConstraints.loose(size) : const BoxConstraints(),
      parentUsesSize: true,
    );

    final badgeParentData = badge.parentData as _BeLabelChildParentData;
    final labelOffset = _innerLabel
        ? _getInnerLabelOffset(
            badge.size.width,
            badge.size.height,
          )
        : _getOffset(
            badge.size.width,
            badge.size.height,
          );
    badgeParentData.offset = labelOffset;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  Offset _getOffset(
    double labelWidth,
    double labelHeight,
  ) {
    final (double x, double y) = switch (_position) {
      BeLabelPosition.topLeft => (0, -labelHeight),
      BeLabelPosition.leftTop => (-labelWidth, 0),
      BeLabelPosition.topCenter => (
          ((size.width - labelWidth) / 2),
          -labelHeight
        ),
      BeLabelPosition.topRight => ((size.width - labelWidth), (-labelHeight)),
      BeLabelPosition.rightTop => ((size.width), 0),
      BeLabelPosition.bottomRight => ((size.width - labelWidth), (size.height)),
      BeLabelPosition.rightBottom => (
          (size.width),
          (size.height - labelHeight)
        ),
      BeLabelPosition.rightCenter => (
          size.width,
          (size.height - labelHeight) / 2
        ),
      BeLabelPosition.bottomCenter => (
          (size.width - labelWidth) / 2,
          size.height
        ),
      BeLabelPosition.bottomLeft => (0, (size.height)),
      BeLabelPosition.leftBottom => (-labelWidth, size.height - labelHeight),
      BeLabelPosition.leftCenter => (
          (-labelWidth),
          (size.height - labelHeight) / 2
        ),
      BeLabelPosition.center => (
          (size.width - labelWidth) / 2,
          (size.height - labelHeight) / 2
        ),
    };

    return Offset(x + _offset.dx, y + _offset.dy);
  }

  Offset _getInnerLabelOffset(
    double labelWidth,
    double labelHeight,
  ) {
    final (double x, double y) = switch (_position) {
      BeLabelPosition.topLeft => (0, 0),
      BeLabelPosition.leftTop => (0, 0),
      BeLabelPosition.topCenter => (size.width / 2, -0),
      BeLabelPosition.topRight => (size.width - labelWidth, 0),
      BeLabelPosition.rightTop => ((size.width - labelWidth), 0),
      BeLabelPosition.bottomRight => (
          (size.width - labelWidth),
          (size.height - labelHeight)
        ),
      BeLabelPosition.rightBottom => (
          (size.width - labelWidth),
          (size.height - labelHeight)
        ),
      BeLabelPosition.rightCenter => (
          size.width - labelWidth,
          (size.height - labelHeight) / 2
        ),
      BeLabelPosition.bottomCenter => (
          (size.width - labelWidth) / 2,
          size.height - labelHeight
        ),
      BeLabelPosition.bottomLeft => (0, (size.height - labelHeight)),
      BeLabelPosition.leftBottom => (-0, size.height - labelHeight),
      BeLabelPosition.leftCenter => ((-0), (size.height - labelHeight) / 2),
      BeLabelPosition.center => (
          (size.width - labelWidth) / 2,
          (size.height - labelHeight) / 2
        ),
    };

    return Offset(x + _offset.dx, y + _offset.dy);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(
        result,
        position: position,
      );
}

class _BeLabelChildParentData extends ContainerBoxParentData<RenderBox>
    with ContainerParentDataMixin<RenderBox> {}

/// Enumeration for different badge positions [BeLabelPosition]
enum BeLabelPosition {
  topLeft,
  topCenter,
  topRight,
  rightTop,
  rightCenter,
  rightBottom,
  bottomRight,
  bottomCenter,
  bottomLeft,
  leftBottom,
  leftCenter,
  leftTop,
  center,
}
