import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum BeEllipsis { start, middle, end }

class BeTextMore extends LeafRenderObjectWidget {
  final String text;
  final TextStyle? style;
  final BeEllipsis ellipsis;
  final int displayLines;
  final String expandText;
  final String collapsedText;

  const BeTextMore(
    this.text, {
    super.key,
    this.style,
    this.ellipsis = BeEllipsis.end,
    this.displayLines = 2,
    this.expandText = 'More',
    this.collapsedText = 'Less',
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderBeTextMore(
        text: text,
        style: style ?? DefaultTextStyle.of(context).style,
        ellipsis: ellipsis,
        displayLines: displayLines,
        expandText: expandText,
        collapsedText: collapsedText,
        textDirection: Directionality.of(context));
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    super.updateRenderObject(context, renderObject);
  }
}

class _RenderBeTextMore extends RenderBox {
  final TextPainter _textPainter = TextPainter();
  String text;
  TextStyle style;
  BeEllipsis ellipsis;
  int displayLines;
  String expandText;
  String collapsedText;
  TextDirection textDirection;

  bool _isExpanded = false;
  late final TapGestureRecognizer _tapGestureRecognizer;

  _RenderBeTextMore({
    required this.text,
    required this.style,
    required this.ellipsis,
    required this.displayLines,
    required this.expandText,
    required this.collapsedText,
    required this.textDirection,
  }) {
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _handleTap;
  }

  void _handleTap() {
    _isExpanded = !_isExpanded;
    markNeedsLayout();
  }

  @override
  void detach() {
    _tapGestureRecognizer.dispose();
    super.detach();
  }

  @override
  void performLayout() {
    final link = TextSpan(
      text: _isExpanded ? collapsedText : expandText,
      style: style.copyWith(color: Colors.blue),
    );
    final linkPainter = TextPainter(
      text: link,
      textDirection: textDirection,
      maxLines: 1,
    );
    linkPainter.layout();

    // compute the text span that fits within the allowed lines
    _textPainter
      ..text = TextSpan(text: text, style: style)
      ..maxLines = _isExpanded ? null : displayLines
      ..textDirection = textDirection;
    _textPainter.layout(maxWidth: constraints.maxWidth);

    final linkLength = linkPainter.width;
    // final textLength = _textPainter.width;

    if (!_isExpanded && _textPainter.didExceedMaxLines) {
      String eclipsedText = text;
      int cutoffIndex = text.length;

      while (_textPainter.didExceedMaxLines) {
        cutoffIndex--;
        eclipsedText = '${text.substring(0, cutoffIndex)}...';
        _textPainter.text = TextSpan(text: eclipsedText, style: style);
        _textPainter.layout(maxWidth: constraints.maxWidth - linkLength);
      }

      _textPainter.text = TextSpan(
        text: eclipsedText,
        style: style,
        children: [link],
      );
      _textPainter.layout(maxWidth: constraints.maxWidth);
    }
    size = Size(constraints.maxWidth,
        _isExpanded ? _textPainter.height : style.fontSize! * displayLines);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _textPainter.paint(context.canvas, offset);
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    if (event is PointerDownEvent) {
      _tapGestureRecognizer.addPointer(event);
    }
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }
}
