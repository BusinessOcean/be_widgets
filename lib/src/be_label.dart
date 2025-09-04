// ignore_for_file: library_private_types_in_public_api, avoid_setters_without_getters, lines_longer_than_80_chars

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
    required this.child,
    super.key,
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
  RenderObject createRenderObject(final BuildContext context) =>
      _BeLabelRenderObject(position: position, offset: offset, childSized: childSized, innerLabel: innerLabel);

  @override
  void updateRenderObject(final BuildContext context, final _BeLabelRenderObject renderObject) {
    renderObject
      ..position = position
      ..offset = offset
      ..innerLabel = innerLabel
      ..childSized = childSized;
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<BeLabelPosition>('position', position))
      ..add(DiagnosticsProperty<Offset>('offset', offset))
      ..add(DiagnosticsProperty<bool>('childSized', childSized))
      ..add(DiagnosticsProperty<bool>('innerLabel', innerLabel));
  }
}

class _BeLabelRenderObject extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _BeLabelChildParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _BeLabelChildParentData> {
  _BeLabelRenderObject({
    required final BeLabelPosition position,
    required final Offset offset,
    required final bool childSized,
    required final bool innerLabel,
  }) : _position = position,
       _childSized = childSized,
       _offset = offset,
       _innerLabel = innerLabel;

  BeLabelPosition _position;
  set position(final BeLabelPosition position) {
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

  bool _childSized;
  set childSized(final bool value) {
    if (_childSized != value) {
      _childSized = value;
      markNeedsLayout();
    }
  }

  bool _innerLabel;
  set innerLabel(final bool value) {
    if (_innerLabel != value) {
      _innerLabel = value;
      markNeedsLayout();
    }
  }

  @override
  void setupParentData(covariant final RenderObject child) {
    child.parentData = _BeLabelChildParentData();
  }

  @override
  bool hitTest(final BoxHitTestResult result, {required final Offset position}) {
    // Test label first since it's visually on top
    final label = lastChild!;
    final labelParentData = label.parentData! as _BeLabelChildParentData;
    final labelLocalPosition = position - labelParentData.offset;

    if (label.size.contains(labelLocalPosition)) {
      if (label.hitTest(result, position: labelLocalPosition)) {
        result.add(BoxHitTestEntry(this, position));
        return true;
      }
    }

    // Then test the main child
    final child = firstChild!;
    final childParentData = child.parentData! as _BeLabelChildParentData;
    final childLocalPosition = position - childParentData.offset;

    if (child.size.contains(childLocalPosition)) {
      if (child.hitTest(result, position: childLocalPosition)) {
        result.add(BoxHitTestEntry(this, position));
        return true;
      }
    }

    return false;
  }

  @override
  void performLayout() {
    final child = firstChild!;
    final label = lastChild!;

    // Layout the main child
    child.layout(constraints, parentUsesSize: true);
    size = child.size;

    // Layout the label with appropriate constraints
    if (_childSized) {
      label.layout(BoxConstraints.loose(size), parentUsesSize: true);
    } else {
      label.layout(constraints, parentUsesSize: true);
    }

    // Calculate and set label offset
    final labelParentData = label.parentData! as _BeLabelChildParentData;
    final labelOffset =
        _innerLabel
            ? _getInnerLabelOffset(label.size.width, label.size.height)
            : _getOffset(label.size.width, label.size.height);
    labelParentData.offset = labelOffset;
  }

  @override
  void paint(final PaintingContext context, final Offset offset) {
    defaultPaint(context, offset);
  }

  Offset _getOffset(final double labelWidth, final double labelHeight) {
    final (double x, double y) = switch (_position) {
      BeLabelPosition.topLeft => (0, -labelHeight),
      BeLabelPosition.leftTop => (-labelWidth, 0),
      BeLabelPosition.topCenter => ((size.width - labelWidth) / 2, -labelHeight),
      BeLabelPosition.topRight => (size.width - labelWidth, -labelHeight),
      BeLabelPosition.rightTop => (size.width, 0),
      BeLabelPosition.bottomRight => (size.width - labelWidth, size.height),
      BeLabelPosition.rightBottom => (size.width, size.height - labelHeight),
      BeLabelPosition.rightCenter => (size.width, (size.height - labelHeight) / 2),
      BeLabelPosition.bottomCenter => ((size.width - labelWidth) / 2, size.height),
      BeLabelPosition.bottomLeft => (0, size.height),
      BeLabelPosition.leftBottom => (-labelWidth, size.height - labelHeight),
      BeLabelPosition.leftCenter => (-labelWidth, (size.height - labelHeight) / 2),
      BeLabelPosition.center => ((size.width - labelWidth) / 2, (size.height - labelHeight) / 2),
    };

    return Offset(x + _offset.dx, y + _offset.dy);
  }

  Offset _getInnerLabelOffset(final double labelWidth, final double labelHeight) {
    final (double x, double y) = switch (_position) {
      BeLabelPosition.topLeft => (0, 0),
      BeLabelPosition.leftTop => (0, 0),
      BeLabelPosition.topCenter => ((size.width - labelWidth) / 2, 0),
      BeLabelPosition.topRight => (size.width - labelWidth, 0),
      BeLabelPosition.rightTop => (size.width - labelWidth, 0),
      BeLabelPosition.bottomRight => (size.width - labelWidth, size.height - labelHeight),
      BeLabelPosition.rightBottom => (size.width - labelWidth, size.height - labelHeight),
      BeLabelPosition.rightCenter => (size.width - labelWidth, (size.height - labelHeight) / 2),
      BeLabelPosition.bottomCenter => ((size.width - labelWidth) / 2, size.height - labelHeight),
      BeLabelPosition.bottomLeft => (0, size.height - labelHeight),
      BeLabelPosition.leftBottom => (0, size.height - labelHeight),
      BeLabelPosition.leftCenter => (0, (size.height - labelHeight) / 2),
      BeLabelPosition.center => ((size.width - labelWidth) / 2, (size.height - labelHeight) / 2),
    };

    return Offset(x + _offset.dx, y + _offset.dy);
  }
}

class _BeLabelChildParentData extends ContainerBoxParentData<RenderBox> with ContainerParentDataMixin<RenderBox> {}

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
