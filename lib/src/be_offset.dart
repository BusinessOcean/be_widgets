// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Custom Flutter widget for rendering a label on another widget </br>
/// [child] of Widget Type. badge widget respects child widget dimension
/// [offset] translate widget to offset based on [Offset] default is [Offset.zero]
class BeOffset extends SingleChildRenderObjectWidget {
  const BeOffset({
    super.key,
    required super.child,
    this.offset = Offset.zero,
  });
  final Offset offset;
  @override
  RenderObject createRenderObject(BuildContext context) =>
      _BeOffsetRenderObject(
        offset: offset,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    _BeOffsetRenderObject renderObject,
  ) {
    renderObject.offset = offset;
  }
}

class _BeOffsetRenderObject extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  _BeOffsetRenderObject({
    required Offset offset,
  }) : _offset = offset;

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
      size = constraints.constrain(child.size + _offset);
    } else {
      size = constraints.smallest;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // defaultPaint(context, offset);
    final child = this.child;
    if (child != null) {
      context.paintChild(child, offset + _offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    // Transform the hit position based on the child's offset
    return child?.hitTest(result, position: position - _offset) == true;
  }
}
