// ignore_for_file: library_private_types_in_public_api, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Custom Flutter widget for rendering a badge on another widget </br>
/// [child] of Widget Type. badge widget respects child widget dimention
/// [labels] of Widget Type. badge widget respects child
class BeMultiLabel extends MultiChildRenderObjectWidget {
  BeMultiLabel({required this.child, required this.labels, super.key}) : super(children: [child, ...labels]);
  final Widget child;
  final List<BeLabelChild> labels;
  @override
  RenderObject createRenderObject(final BuildContext context) => _BeMultiLabelRenderObject();

  @override
  void updateRenderObject(final BuildContext context, final _BeMultiLabelRenderObject renderObject) {}
}

class _BeMultiLabelRenderObject extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _BeMultiLabelParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _BeMultiLabelParentData> {
  _BeMultiLabelRenderObject();

  @override
  void setupParentData(covariant final RenderObject child) {
    child.parentData = _BeMultiLabelParentData();
  }

  @override
  void performLayout() {
    final child = firstChild!;
    child.layout(constraints, parentUsesSize: true);
    size = child.size;

    // Layout all label children
    final children = getChildrenAsList();
    for (final c in children) {
      if (c == firstChild) continue;

      final label = c;
      label.layout(const BoxConstraints(), parentUsesSize: true);

      final labelParentData = label.parentData! as _BeMultiLabelParentData;
      final labelRenderBox = label as _LabelRenderBox;
      final labelOffset = _getOffset(
        labelRenderBox._position,
        labelRenderBox._offset,
        label.size.width,
        label.size.height,
      );
      labelParentData.offset = labelOffset;
    }
  }

  @override
  void paint(final PaintingContext context, final Offset offset) => defaultPaint(context, offset);

  Offset _getOffset(
    final BeMultiLabelPosition position,
    final Offset childOffset,
    final double labelWidth,
    final double labelHeight,
  ) {
    final (double x, double y) = switch (position) {
      BeMultiLabelPosition.topLeft => (0, -labelHeight),
      BeMultiLabelPosition.leftTop => (-labelWidth, 0),
      BeMultiLabelPosition.topCenter => ((size.width - labelWidth) / 2, -labelHeight),
      BeMultiLabelPosition.topRight => (size.width - labelWidth, -labelHeight),
      BeMultiLabelPosition.rightTop => (size.width, 0),
      BeMultiLabelPosition.bottomRight => (size.width - labelWidth, size.height),
      BeMultiLabelPosition.rightBottom => (size.width, size.height - labelHeight),
      BeMultiLabelPosition.rightCenter => (size.width, (size.height - labelHeight) / 2),
      BeMultiLabelPosition.bottomCenter => ((size.width - labelWidth) / 2, size.height),
      BeMultiLabelPosition.bottomLeft => (0, size.height),
      BeMultiLabelPosition.leftBottom => (-labelWidth, size.height - labelHeight),
      BeMultiLabelPosition.leftCenter => (-labelWidth, (size.height - labelHeight) / 2),
      BeMultiLabelPosition.center => ((size.width - labelWidth) / 2, (size.height - labelHeight) / 2),
    };

    return Offset(x + childOffset.dx, y + childOffset.dy);
  }

  @override
  bool hitTest(final BoxHitTestResult result, {required final Offset position}) {
    // Test labels first (in reverse order since later ones are visually on top)
    final children = getChildrenAsList();

    // Test labels from last to first (visual z-order)
    for (var i = children.length - 1; i >= 0; i--) {
      final child = children[i];
      final childParentData = child.parentData! as _BeMultiLabelParentData;

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
        // Label children
        final labelLocalPosition = position - childParentData.offset;
        if (child.size.contains(labelLocalPosition)) {
          if (child.hitTest(result, position: labelLocalPosition)) {
            result.add(BoxHitTestEntry(this, position));
            return true;
          }
        }
      }
    }

    return false;
  }
}

class _BeMultiLabelParentData extends ContainerBoxParentData<RenderBox> with ContainerParentDataMixin<RenderBox> {}

// ==========================================================================
/// Custom Flutter widget for rendering a badge on another widget </br>
/// [child] of Widget Type. badge widget respects child widget dimention
/// [offset] translate widget to offset based on [Offset] default is [Offset.zero]
/// [position] set alignment position of badge
class BeLabelChild extends SingleChildRenderObjectWidget {
  const BeLabelChild({required this.position, required super.child, super.key, this.offset = Offset.zero});
  final BeMultiLabelPosition position;
  final Offset offset;

  @override
  RenderObject createRenderObject(final BuildContext context) => _LabelRenderBox(offset: offset, position: position);

  @override
  void updateRenderObject(final BuildContext context, final _LabelRenderBox renderObject) {
    renderObject
      ..position = position
      ..offset = offset;
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<BeMultiLabelPosition>('position', position))
      ..add(DiagnosticsProperty<Offset>('offset', offset));
  }
}

class _LabelRenderBox extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  _LabelRenderBox({required final BeMultiLabelPosition position, required final Offset offset})
    : _position = position,
      _offset = offset;

  var _lastSize = Size.zero;

  BeMultiLabelPosition _position;
  set position(final BeMultiLabelPosition position) {
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

enum BeMultiLabelPosition {
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
