import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BeTextMore extends LeafRenderObjectWidget {
  final String text;
  final TextStyle textStyle;
  final int maxLines;
  final bool isExpanded;
  final VoidCallback onToggle;

  const BeTextMore({
    super.key,
    required this.text,
    this.textStyle = const TextStyle(),
    this.maxLines = 1,
    this.isExpanded = true,
    required this.onToggle,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return BeTextMoreRender(
      text: text,
      textStyle: textStyle,
      maxLines: maxLines,
      textDirection: Directionality.of(context),
      isExpanded: isExpanded,
      onToggle: onToggle,
    );
  }

  @override
  void updateRenderObject(BuildContext context, BeTextMoreRender renderObject) {
    renderObject
      ..text = text
      ..isExpanded = isExpanded;
  }
}

class BeTextMoreRender extends RenderBox {
  BeTextMoreRender({
    required String text,
    TextStyle textStyle = const TextStyle(),
    int maxLines = 10,
    TextDirection textDirection = TextDirection.ltr,
    required void Function() onToggle,
    bool isExpanded = false,
  }) {
    _text = text;
    _textStyle = textStyle;
    _maxLines = maxLines;
    _textDirection = textDirection;
    _onToggle = onToggle;
    _isExpanded = isExpanded;

    _textPainter = TextPainter(
      text: TextSpan(text: _text, style: _textStyle),
      textDirection: _textDirection,
      maxLines: _isExpanded ? null : _maxLines,
      ellipsis: _isExpanded ? null : '...',
    );
  }

  late String _text;
  late TextStyle _textStyle;
  late int _maxLines;
  late TextDirection _textDirection;
  late TextPainter _textPainter;
  late bool _isExpanded;
  late void Function() _onToggle;

  String get text => _text;
  set text(String val) {
    if (_text != val) {
      _text = val;
      _updateTextPainter();
    }
  }

  set isExpanded(bool val) {
    if (_isExpanded != val) {
      _isExpanded = val;
      _updateTextPainter();
    }
  }

  void _updateTextPainter() {
    _textPainter.text = TextSpan(text: _text, style: _textStyle);
    _textPainter.maxLines = _isExpanded ? null : _maxLines;
    _textPainter.ellipsis = _isExpanded ? null : '...';
    markNeedsLayout();
    markNeedsPaint();
  }

  @override
  void performLayout() {
    _textPainter.layout(maxWidth: constraints.maxWidth);
    size = constraints.constrain(
      Size(_textPainter.width, _textPainter.height),
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _textPainter.paint(context.canvas, offset);

    final toggleText = _isExpanded ? '' : '...';
    final toggleTextPainter = TextPainter(
      text: TextSpan(
        text: toggleText,
        style: _textStyle.copyWith(
            color: Colors.blue, fontWeight: FontWeight.bold),
      ),
      textDirection: _textDirection,
    );
    toggleTextPainter.layout();

    final toggleOffset = Offset(
      offset.dx + _textPainter.width - toggleTextPainter.width,
      offset.dy + _textPainter.height - toggleTextPainter.height,
    );

    toggleTextPainter.paint(context.canvas, toggleOffset);
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    if (event is PointerUpEvent) {
      _onToggle();
    }
  }
}
