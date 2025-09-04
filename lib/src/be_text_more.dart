// ignore_for_file: avoid_setters_without_getters, always_put_control_body_on_new_line, lines_longer_than_80_chars

import 'dart:ui' as ui show TextHeightBehavior;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum TrimMode { length, line }

const String _kEllipsis = '\u2026';

/// Defines a customizable pattern within text, such as hashtags, URLs, or mentions.
///
/// Enables applying custom styles and interactions to matched patterns,
/// enhancing text interactivity. Utilize this class to highlight specific text
/// segments or to add clickable functionality, facilitating navigation or other actions.
@immutable
class Annotation {
  const Annotation({required this.regExp, required this.spanBuilder});

  final RegExp regExp;
  final TextSpan Function({required String text, required TextStyle textStyle}) spanBuilder;
}

class BeTextMore extends LeafRenderObjectWidget {
  const BeTextMore({
    required this.text,
    super.key,
    this.isCollapsed,
    this.preDataText,
    this.postDataText,
    this.preDataTextStyle,
    this.postDataTextStyle,
    this.trimExpandedText = 'show less',
    this.trimCollapsedText = 'read more',
    this.colorClickableText,
    this.trimLength = 240,
    this.trimLines = 2,
    this.trimMode = TrimMode.length,
    this.moreStyle,
    this.lessStyle,
    this.delimiter = '$_kEllipsis ',
    this.delimiterStyle,
    this.annotations,
    this.isExpandable = true,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : richData = null,
       richPreData = null,
       richPostData = null;

  const BeTextMore.rich(
    this.richData, {
    super.key,
    this.richPreData,
    this.richPostData,
    this.isCollapsed,
    this.trimExpandedText = 'show less',
    this.trimCollapsedText = 'read more',
    this.colorClickableText,
    this.trimLength = 240,
    this.trimLines = 2,
    this.trimMode = TrimMode.length,
    this.moreStyle,
    this.lessStyle,
    this.delimiter = '$_kEllipsis ',
    this.delimiterStyle,
    this.isExpandable = true,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : text = null,
       annotations = null,
       preDataText = null,
       postDataText = null,
       preDataTextStyle = null,
       postDataTextStyle = null;

  final ValueNotifier<bool>? isCollapsed;

  /// Used on TrimMode.Length
  final int trimLength;

  /// Used on TrimMode.Lines
  final int trimLines;

  /// Determines the type of trim. TrimMode.Length takes into account
  /// the number of letters, while TrimMode.Lines takes into account
  /// the number of lines
  final TrimMode trimMode;

  /// TextStyle for expanded text
  final TextStyle? moreStyle;

  /// TextStyle for compressed text
  final TextStyle? lessStyle;

  /// Textspan used before the data any heading or something
  final String? preDataText;

  /// Textspan used after the data end or before the more/less
  final String? postDataText;

  /// Textspan used before the data any heading or something
  final TextStyle? preDataTextStyle;

  /// Textspan used after the data end or before the more/less
  final TextStyle? postDataTextStyle;

  /// Rich version of [preDataText]
  final TextSpan? richPreData;

  /// Rich version of [postDataText]
  final TextSpan? richPostData;

  final List<Annotation>? annotations;

  /// Expand text on readMore press
  final bool isExpandable;

  final String delimiter;
  final String? text;
  final TextSpan? richData;
  final String trimExpandedText;
  final String trimCollapsedText;
  final Color? colorClickableText;
  final TextStyle? delimiterStyle;

  // DefaultTextStyle properties
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  @override
  RenderObject createRenderObject(final BuildContext context) => RenderExpandableText(
    text: text,
    richData: richData,
    isCollapsed: isCollapsed,
    preDataText: preDataText,
    postDataText: postDataText,
    preDataTextStyle: preDataTextStyle,
    postDataTextStyle: postDataTextStyle,
    richPreData: richPreData,
    richPostData: richPostData,
    trimExpandedText: trimExpandedText,
    trimCollapsedText: trimCollapsedText,
    colorClickableText: colorClickableText,
    trimLength: trimLength,
    trimLines: trimLines,
    trimMode: trimMode,
    moreStyle: moreStyle,
    lessStyle: lessStyle,
    delimiter: delimiter,
    delimiterStyle: delimiterStyle,
    annotations: annotations,
    isExpandable: isExpandable,
    style: style,
    strutStyle: strutStyle,
    textAlign: textAlign,
    textDirection: textDirection ?? Directionality.of(context),
    locale: locale,
    softWrap: softWrap,
    overflow: overflow,
    textScaler: textScaler,
    semanticsLabel: semanticsLabel,
    textWidthBasis: textWidthBasis,
    textHeightBehavior: textHeightBehavior,
    selectionColor: selectionColor,
  );

  @override
  void updateRenderObject(final BuildContext context, final RenderExpandableText renderObject) {
    renderObject
      ..text = text
      ..richData = richData
      ..isCollapsed = isCollapsed
      ..preDataText = preDataText
      ..postDataText = postDataText
      ..preDataTextStyle = preDataTextStyle
      ..postDataTextStyle = postDataTextStyle
      ..richPreData = richPreData
      ..richPostData = richPostData
      ..trimExpandedText = trimExpandedText
      ..trimCollapsedText = trimCollapsedText
      ..colorClickableText = colorClickableText
      ..trimLength = trimLength
      ..trimLines = trimLines
      ..trimMode = trimMode
      ..moreStyle = moreStyle
      ..lessStyle = lessStyle
      ..delimiter = delimiter
      ..delimiterStyle = delimiterStyle
      ..annotations = annotations
      ..isExpandable = isExpandable
      ..style = style
      ..strutStyle = strutStyle
      ..textAlign = textAlign
      ..textDirection = textDirection ?? Directionality.of(context)
      ..locale = locale
      ..softWrap = softWrap
      ..overflow = overflow
      ..textScaler = textScaler
      ..semanticsLabel = semanticsLabel
      ..textWidthBasis = textWidthBasis
      ..textHeightBehavior = textHeightBehavior
      ..selectionColor = selectionColor;
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('text', text))
      ..add(DiagnosticsProperty<TextSpan>('richData', richData))
      ..add(IntProperty('trimLength', trimLength))
      ..add(IntProperty('trimLines', trimLines))
      ..add(EnumProperty<TrimMode>('trimMode', trimMode))
      ..add(DiagnosticsProperty<TextStyle>('style', style))
      ..add(DiagnosticsProperty<TextStyle>('moreStyle', moreStyle))
      ..add(DiagnosticsProperty<TextStyle>('lessStyle', lessStyle))
      ..add(StringProperty('trimExpandedText', trimExpandedText))
      ..add(StringProperty('trimCollapsedText', trimCollapsedText))
      ..add(FlagProperty('isExpandable', value: isExpandable, ifFalse: 'not expandable'));
  }
}

class RenderExpandableText extends RenderBox {
  RenderExpandableText({
    final String? text,
    final TextSpan? richData,
    final ValueNotifier<bool>? isCollapsed,
    final String? preDataText,
    final String? postDataText,
    final TextStyle? preDataTextStyle,
    final TextStyle? postDataTextStyle,
    final TextSpan? richPreData,
    final TextSpan? richPostData,
    final String trimExpandedText = 'show less',
    final String trimCollapsedText = 'read more',
    final Color? colorClickableText,
    final int trimLength = 240,
    final int trimLines = 2,
    final TrimMode trimMode = TrimMode.length,
    final TextStyle? moreStyle,
    final TextStyle? lessStyle,
    final String delimiter = '$_kEllipsis ',
    final TextStyle? delimiterStyle,
    final List<Annotation>? annotations,
    final bool isExpandable = true,
    final TextStyle? style,
    final StrutStyle? strutStyle,
    final TextAlign? textAlign,
    required final TextDirection textDirection,
    final Locale? locale,
    final bool? softWrap,
    final TextOverflow? overflow,
    final TextScaler? textScaler,
    final String? semanticsLabel,
    final TextWidthBasis? textWidthBasis,
    final ui.TextHeightBehavior? textHeightBehavior,
    final Color? selectionColor,
  }) : _text = text,
       _richData = richData,
       _isCollapsedNotifier = isCollapsed,
       _preDataText = preDataText,
       _postDataText = postDataText,
       _preDataTextStyle = preDataTextStyle,
       _postDataTextStyle = postDataTextStyle,
       _richPreData = richPreData,
       _richPostData = richPostData,
       _trimExpandedText = trimExpandedText,
       _trimCollapsedText = trimCollapsedText,
       _colorClickableText = colorClickableText,
       _trimLength = trimLength,
       _trimLines = trimLines,
       _trimMode = trimMode,
       _moreStyle = moreStyle,
       _lessStyle = lessStyle,
       _delimiter = delimiter,
       _delimiterStyle = delimiterStyle,
       _annotations = annotations,
       _isExpandable = isExpandable,
       _style = style,
       _strutStyle = strutStyle,
       _textAlign = textAlign,
       _textDirection = textDirection,
       _locale = locale,
       _softWrap = softWrap,
       _overflow = overflow,
       _textScaler = textScaler,
       _semanticsLabel = semanticsLabel,
       _textWidthBasis = textWidthBasis,
       _textHeightBehavior = textHeightBehavior,
       _selectionColor = selectionColor {
    _isCollapsed = _isCollapsedNotifier?.value ?? true;
    _tapRecognizer = TapGestureRecognizer()..onTap = _handleTap;
    _isCollapsedNotifier?.addListener(_onCollapsedChanged);
    _updateTextPainter();
  }

  static final _nonCapturingGroupPattern = RegExp(r'\((?!\?:)');

  String? _text;
  TextSpan? _richData;
  ValueNotifier<bool>? _isCollapsedNotifier;
  String? _preDataText;
  String? _postDataText;
  TextStyle? _preDataTextStyle;
  TextStyle? _postDataTextStyle;
  TextSpan? _richPreData;
  TextSpan? _richPostData;
  String _trimExpandedText;
  String _trimCollapsedText;
  Color? _colorClickableText;
  int _trimLength;
  int _trimLines;
  TrimMode _trimMode;
  TextStyle? _moreStyle;
  TextStyle? _lessStyle;
  String _delimiter;
  TextStyle? _delimiterStyle;
  List<Annotation>? _annotations;
  bool _isExpandable;
  TextStyle? _style;
  StrutStyle? _strutStyle;
  TextAlign? _textAlign;
  TextDirection _textDirection;
  Locale? _locale;
  bool? _softWrap;
  TextOverflow? _overflow;
  TextScaler? _textScaler;
  String? _semanticsLabel;
  TextWidthBasis? _textWidthBasis;
  ui.TextHeightBehavior? _textHeightBehavior;
  Color? _selectionColor;

  bool _isCollapsed = true;
  bool _needsLink = false;
  late TextPainter _textPainter;
  late TextSpan _effectiveTextSpan;
  late Rect _linkRect;
  late TapGestureRecognizer _tapRecognizer;

  // Getters and setters for all properties
  String? get text => _text;
  set text(final String? value) {
    if (_text == value) return;
    _text = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  TextSpan? get richData => _richData;
  set richData(final TextSpan? value) {
    if (_richData == value) return;
    _richData = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  ValueNotifier<bool>? get isCollapsed => _isCollapsedNotifier;
  set isCollapsed(final ValueNotifier<bool>? value) {
    if (_isCollapsedNotifier == value) return;
    _isCollapsedNotifier?.removeListener(_onCollapsedChanged);
    _isCollapsedNotifier = value;
    _isCollapsed = value?.value ?? true;
    _isCollapsedNotifier?.addListener(_onCollapsedChanged);
    _updateTextPainter();
    markNeedsLayout();
  }

  String? get preDataText => _preDataText;
  set preDataText(final String? value) {
    if (_preDataText == value) return;
    _preDataText = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  String? get postDataText => _postDataText;
  set postDataText(final String? value) {
    if (_postDataText == value) return;
    _postDataText = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  TextStyle? get preDataTextStyle => _preDataTextStyle;
  set preDataTextStyle(final TextStyle? value) {
    if (_preDataTextStyle == value) return;
    _preDataTextStyle = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  TextStyle? get postDataTextStyle => _postDataTextStyle;
  set postDataTextStyle(final TextStyle? value) {
    if (_postDataTextStyle == value) return;
    _postDataTextStyle = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  TextSpan? get richPreData => _richPreData;
  set richPreData(final TextSpan? value) {
    if (_richPreData == value) return;
    _richPreData = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  TextSpan? get richPostData => _richPostData;
  set richPostData(final TextSpan? value) {
    if (_richPostData == value) return;
    _richPostData = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  String get trimExpandedText => _trimExpandedText;
  set trimExpandedText(final String value) {
    if (_trimExpandedText == value) return;
    _trimExpandedText = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  String get trimCollapsedText => _trimCollapsedText;
  set trimCollapsedText(final String value) {
    if (_trimCollapsedText == value) return;
    _trimCollapsedText = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  Color? get colorClickableText => _colorClickableText;
  set colorClickableText(final Color? value) {
    if (_colorClickableText == value) return;
    _colorClickableText = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  int get trimLength => _trimLength;
  set trimLength(final int value) {
    if (_trimLength == value) return;
    _trimLength = value;
    markNeedsLayout();
  }

  int get trimLines => _trimLines;
  set trimLines(final int value) {
    if (_trimLines == value) return;
    _trimLines = value;
    markNeedsLayout();
  }

  TrimMode get trimMode => _trimMode;
  set trimMode(final TrimMode value) {
    if (_trimMode == value) return;
    _trimMode = value;
    markNeedsLayout();
  }

  TextStyle? get moreStyle => _moreStyle;
  set moreStyle(final TextStyle? value) {
    if (_moreStyle == value) return;
    _moreStyle = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  TextStyle? get lessStyle => _lessStyle;
  set lessStyle(final TextStyle? value) {
    if (_lessStyle == value) return;
    _lessStyle = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  String get delimiter => _delimiter;
  set delimiter(final String value) {
    if (_delimiter == value) return;
    _delimiter = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  TextStyle? get delimiterStyle => _delimiterStyle;
  set delimiterStyle(final TextStyle? value) {
    if (_delimiterStyle == value) return;
    _delimiterStyle = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  List<Annotation>? get annotations => _annotations;
  set annotations(final List<Annotation>? value) {
    if (_annotations == value) return;
    _annotations = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  bool get isExpandable => _isExpandable;
  set isExpandable(final bool value) {
    if (_isExpandable == value) return;
    _isExpandable = value;
    markNeedsLayout();
  }

  TextStyle? get style => _style;
  set style(final TextStyle? value) {
    if (_style == value) return;
    _style = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  StrutStyle? get strutStyle => _strutStyle;
  set strutStyle(final StrutStyle? value) {
    if (_strutStyle == value) return;
    _strutStyle = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  TextAlign? get textAlign => _textAlign;
  set textAlign(final TextAlign? value) {
    if (_textAlign == value) return;
    _textAlign = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  TextDirection get textDirection => _textDirection;
  set textDirection(final TextDirection value) {
    if (_textDirection == value) return;
    _textDirection = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  Locale? get locale => _locale;
  set locale(final Locale? value) {
    if (_locale == value) return;
    _locale = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  bool? get softWrap => _softWrap;
  set softWrap(final bool? value) {
    if (_softWrap == value) return;
    _softWrap = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  TextOverflow? get overflow => _overflow;
  set overflow(final TextOverflow? value) {
    if (_overflow == value) return;
    _overflow = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  TextScaler? get textScaler => _textScaler;
  set textScaler(final TextScaler? value) {
    if (_textScaler == value) return;
    _textScaler = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  String? get semanticsLabel => _semanticsLabel;
  set semanticsLabel(final String? value) {
    if (_semanticsLabel == value) return;
    _semanticsLabel = value;
    markNeedsSemanticsUpdate();
  }

  TextWidthBasis? get textWidthBasis => _textWidthBasis;
  set textWidthBasis(final TextWidthBasis? value) {
    if (_textWidthBasis == value) return;
    _textWidthBasis = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  ui.TextHeightBehavior? get textHeightBehavior => _textHeightBehavior;
  set textHeightBehavior(final ui.TextHeightBehavior? value) {
    if (_textHeightBehavior == value) return;
    _textHeightBehavior = value;
    _updateTextPainter();
    markNeedsLayout();
  }

  Color? get selectionColor => _selectionColor;
  set selectionColor(final Color? value) {
    if (_selectionColor == value) return;
    _selectionColor = value;
    markNeedsPaint();
  }

  void _onCollapsedChanged() {
    if (_isCollapsed != _isCollapsedNotifier!.value) {
      _isCollapsed = _isCollapsedNotifier!.value;
      _updateTextPainter();
      markNeedsLayout();
    }
  }

  void _handleTap() {
    if (_isExpandable) {
      _isCollapsed = !_isCollapsed;
      if (_isCollapsedNotifier != null) {
        _isCollapsedNotifier!.value = _isCollapsed;
      } else {
        _updateTextPainter();
        markNeedsLayout();
        markNeedsPaint();
      }
    }
  }

  RegExp? _mergeRegexPatterns(final List<Annotation>? annotations) {
    if (annotations == null || annotations.isEmpty) {
      return null;
    } else if (annotations.length == 1) {
      return annotations[0].regExp;
    }

    return RegExp(
      annotations.map((final a) => '(${a.regExp.pattern.replaceAll(_nonCapturingGroupPattern, '(?:')})').join('|'),
    );
  }

  TextSpan _buildAnnotatedTextSpan({
    required final String data,
    required final TextStyle textStyle,
    required final RegExp? regExp,
    required final List<Annotation>? annotations,
  }) {
    if (regExp == null || data.isEmpty) {
      return TextSpan(text: data, style: textStyle);
    }

    final contents = <TextSpan>[];

    data.splitMapJoin(
      regExp,
      onMatch: (final Match regexMatch) {
        final matchedText = regexMatch.group(0)!;
        late final Annotation matchedAnnotation;

        if (annotations!.length == 1) {
          matchedAnnotation = annotations[0];
        } else {
          for (var i = 0; i < regexMatch.groupCount; i++) {
            if (matchedText == regexMatch.group(i + 1)) {
              matchedAnnotation = annotations[i];
              break;
            }
          }
        }

        final content = matchedAnnotation.spanBuilder(text: matchedText, textStyle: textStyle);

        contents.add(content);
        return '';
      },
      onNonMatch: (final String unmatchedText) {
        contents.add(TextSpan(text: unmatchedText));
        return '';
      },
    );

    return TextSpan(style: textStyle, children: contents);
  }

  _TextSpanTrimResult _trimTextSpan({
    required final TextSpan textSpan,
    required final int spanStartIndex,
    required final int endIndex,
    required final bool splitByRunes,
  }) {
    var spanEndIndex = spanStartIndex;

    final text = textSpan.text;
    if (text != null) {
      final textLen = splitByRunes ? text.runes.length : text.length;
      spanEndIndex += textLen;

      if (spanEndIndex >= endIndex) {
        final newText =
            splitByRunes
                ? String.fromCharCodes(text.runes, 0, endIndex - spanStartIndex)
                : text.substring(0, endIndex - spanStartIndex);

        final nextSpan = TextSpan(
          text: newText,
          children: null,
          style: textSpan.style,
          recognizer: textSpan.recognizer,
          mouseCursor: textSpan.mouseCursor,
          onEnter: textSpan.onEnter,
          onExit: textSpan.onExit,
          semanticsLabel: textSpan.semanticsLabel,
          locale: textSpan.locale,
          spellOut: textSpan.spellOut,
        );

        return _TextSpanTrimResult(textSpan: nextSpan, spanEndIndex: spanEndIndex, didTrim: true);
      }
    }

    var didTrim = false;
    final newChildren = <InlineSpan>[];

    final children = textSpan.children;
    if (children != null) {
      for (final child in children) {
        if (child is TextSpan) {
          final result = _trimTextSpan(
            textSpan: child,
            spanStartIndex: spanEndIndex,
            endIndex: endIndex,
            splitByRunes: splitByRunes,
          );

          spanEndIndex = result.spanEndIndex;
          newChildren.add(result.textSpan);

          if (result.didTrim) {
            didTrim = true;
            break;
          }
        } else {
          newChildren.add(child);
        }
      }
    }

    final resultTextSpan =
        didTrim
            ? TextSpan(
              text: textSpan.text,
              children: newChildren,
              style: textSpan.style,
              recognizer: textSpan.recognizer,
              mouseCursor: textSpan.mouseCursor,
              onEnter: textSpan.onEnter,
              onExit: textSpan.onExit,
              semanticsLabel: textSpan.semanticsLabel,
              locale: textSpan.locale,
              spellOut: textSpan.spellOut,
            )
            : textSpan;

    return _TextSpanTrimResult(textSpan: resultTextSpan, spanEndIndex: spanEndIndex, didTrim: didTrim);
  }

  _TextSpanTrimResult _trimTextSpanByLines({
    required final TextSpan textSpan,
    required final int maxLines,
    required final double maxWidth,
    required final TextSpan delimiter,
    required final TextSpan link,
  }) {
    // Create a test painter to measure how much text fits in the given lines
    final testPainter = TextPainter(
      text: textSpan,
      textAlign: _textAlign ?? TextAlign.start,
      textDirection: _textDirection,
      locale: _locale,
      textScaler: _textScaler ?? TextScaler.noScaling,
      maxLines: maxLines,
      strutStyle: _strutStyle,
      textWidthBasis: _textWidthBasis ?? TextWidthBasis.parent,
      textHeightBehavior: _textHeightBehavior,
    );
    testPainter.layout(maxWidth: maxWidth);

    if (!testPainter.didExceedMaxLines) {
      // Text fits within the maxLines, no trimming needed
      return _TextSpanTrimResult(textSpan: textSpan, spanEndIndex: 0, didTrim: false);
    }

    // Find the last character that fits within maxLines
    final plainText = textSpan.toPlainText();
    final textLength = plainText.length;

    // Binary search to find the optimal cutoff point
    int left = 0;
    int right = textLength;
    int bestCutoff = 0;

    while (left <= right) {
      final mid = (left + right) ~/ 2;
      final testText = plainText.substring(0, mid);

      // Create test span with delimiter and link
      final testSpan = TextSpan(children: [_createTextSpanFromSubstring(textSpan, testText), delimiter, link]);

      final cutoffPainter = TextPainter(
        text: testSpan,
        textAlign: _textAlign ?? TextAlign.start,
        textDirection: _textDirection,
        locale: _locale,
        textScaler: _textScaler ?? TextScaler.noScaling,
        maxLines: maxLines,
        strutStyle: _strutStyle,
        textWidthBasis: _textWidthBasis ?? TextWidthBasis.parent,
        textHeightBehavior: _textHeightBehavior,
      );
      cutoffPainter.layout(maxWidth: maxWidth);

      if (!cutoffPainter.didExceedMaxLines) {
        bestCutoff = mid;
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }

    // If we couldn't fit anything, fallback to a minimal cutoff
    if (bestCutoff == 0) {
      bestCutoff = 1;
    }

    final trimmedText = plainText.substring(0, bestCutoff);
    final trimmedSpan = _createTextSpanFromSubstring(textSpan, trimmedText);

    return _TextSpanTrimResult(textSpan: trimmedSpan, spanEndIndex: bestCutoff, didTrim: true);
  }

  TextSpan _createTextSpanFromSubstring(final TextSpan originalSpan, final String targetText) {
    if (originalSpan.text != null) {
      // Simple case: single text span
      return TextSpan(
        text: targetText,
        style: originalSpan.style,
        recognizer: originalSpan.recognizer,
        mouseCursor: originalSpan.mouseCursor,
        onEnter: originalSpan.onEnter,
        onExit: originalSpan.onExit,
        semanticsLabel: originalSpan.semanticsLabel,
        locale: originalSpan.locale,
        spellOut: originalSpan.spellOut,
      );
    }

    // Complex case: nested spans
    final List<InlineSpan> newChildren = [];
    int processedLength = 0;

    final children = originalSpan.children;
    if (children != null) {
      for (final child in children) {
        if (child is TextSpan) {
          final childText = child.toPlainText();
          final childLength = childText.length;

          if (processedLength + childLength <= targetText.length) {
            // Include entire child
            newChildren.add(child);
            processedLength += childLength;
          } else if (processedLength < targetText.length) {
            // Partially include child
            final remainingLength = targetText.length - processedLength;
            final trimmedChildText = childText.substring(0, remainingLength);
            final trimmedChild = _createTextSpanFromSubstring(child, trimmedChildText);
            newChildren.add(trimmedChild);
            break;
          } else {
            break;
          }
        } else {
          newChildren.add(child);
        }
      }
    }

    return TextSpan(
      text: originalSpan.text,
      children: newChildren,
      style: originalSpan.style,
      recognizer: originalSpan.recognizer,
      mouseCursor: originalSpan.mouseCursor,
      onEnter: originalSpan.onEnter,
      onExit: originalSpan.onExit,
      semanticsLabel: originalSpan.semanticsLabel,
      locale: originalSpan.locale,
      spellOut: originalSpan.spellOut,
    );
  }

  void _updateTextPainter() {
    // Default text style
    final effectiveStyle = _style ?? const TextStyle();

    // Build pre and post spans
    TextSpan? preTextSpan;
    TextSpan? postTextSpan;

    if (_richPreData != null) {
      preTextSpan = _richPreData;
    } else if (_preDataText != null) {
      preTextSpan = TextSpan(text: '${_preDataText!} ', style: _preDataTextStyle ?? effectiveStyle);
    }

    if (_richPostData != null) {
      postTextSpan = _richPostData;
    } else if (_postDataText != null) {
      postTextSpan = TextSpan(text: ' ${_postDataText!}', style: _postDataTextStyle ?? effectiveStyle);
    }

    // Build data span
    final TextSpan dataTextSpan;
    if (_richData != null) {
      dataTextSpan = TextSpan(style: effectiveStyle, children: [_richData!]);
    } else if (_text != null) {
      dataTextSpan = _buildAnnotatedTextSpan(
        data: _text!,
        textStyle: effectiveStyle,
        regExp: _mergeRegexPatterns(_annotations),
        annotations: _annotations,
      );
    } else {
      dataTextSpan = TextSpan(text: '', style: effectiveStyle);
    }

    // Simple text span for now, layout will handle trimming
    _effectiveTextSpan = TextSpan(
      children: [if (preTextSpan != null) preTextSpan, dataTextSpan, if (postTextSpan != null) postTextSpan],
    );

    _textPainter = TextPainter(
      text: _effectiveTextSpan,
      textAlign: _textAlign ?? TextAlign.start,
      textDirection: _textDirection,
      locale: _locale,
      textScaler: _textScaler ?? TextScaler.noScaling,
      maxLines: _isCollapsed ? _trimLines : null,
      strutStyle: _strutStyle,
      textWidthBasis: _textWidthBasis ?? TextWidthBasis.parent,
      textHeightBehavior: _textHeightBehavior,
    );
  }

  @override
  void performLayout() {
    final constraints = this.constraints;
    final maxWidth = constraints.maxWidth;

    // First, check if we need trimming at all
    final testPainter = TextPainter(
      text: _effectiveTextSpan,
      textAlign: _textAlign ?? TextAlign.start,
      textDirection: _textDirection,
      locale: _locale,
      textScaler: _textScaler ?? TextScaler.noScaling,
      maxLines: _trimLines,
      strutStyle: _strutStyle,
      textWidthBasis: _textWidthBasis ?? TextWidthBasis.parent,
      textHeightBehavior: _textHeightBehavior,
    );
    testPainter.layout(maxWidth: maxWidth);

    bool needsTrimming = false;
    if (_trimMode == TrimMode.line) {
      needsTrimming = testPainter.didExceedMaxLines;
    } else {
      final plainText = _effectiveTextSpan.toPlainText();
      needsTrimming = plainText.runes.length > _trimLength;
    }

    _needsLink = needsTrimming;

    if (needsTrimming && _isCollapsed) {
      // Create trimmed version with link
      final linkText = _trimCollapsedText;
      final effectiveColorClickableText = _colorClickableText ?? Colors.blue;
      final effectiveStyle = _style ?? const TextStyle();
      final defaultMoreStyle = _moreStyle ?? effectiveStyle.copyWith(color: effectiveColorClickableText);
      final defaultDelimiterStyle = _delimiterStyle ?? effectiveStyle;

      final link = TextSpan(text: linkText, style: defaultMoreStyle, recognizer: _tapRecognizer);

      final delimiter = TextSpan(text: _trimCollapsedText.isNotEmpty ? _delimiter : '', style: defaultDelimiterStyle);

      // Build trimmed content
      TextSpan trimmedSpan;
      if (_trimMode == TrimMode.length) {
        final dataSpan = _getDataSpan();
        final trimResult = _trimTextSpan(
          textSpan: dataSpan,
          spanStartIndex: 0,
          endIndex: _trimLength,
          splitByRunes: true,
        );
        trimmedSpan = TextSpan(
          children:
              [
                _getPreSpan(),
                trimResult.textSpan,
                delimiter,
                link,
                _getPostSpan(),
              ].where((final span) => span != null).cast<TextSpan>().toList(),
        );
      } else {
        // For line trimming, we need to calculate based on layout
        final dataSpan = _getDataSpan();
        final trimResult = _trimTextSpanByLines(
          textSpan: dataSpan,
          maxLines: _trimLines,
          maxWidth: maxWidth,
          delimiter: delimiter,
          link: link,
        );
        trimmedSpan = TextSpan(
          children:
              [
                _getPreSpan(),
                trimResult.textSpan,
                delimiter,
                link,
                _getPostSpan(),
              ].where((final span) => span != null).cast<TextSpan>().toList(),
        );
      }

      _textPainter = TextPainter(
        text: trimmedSpan,
        textAlign: _textAlign ?? TextAlign.start,
        textDirection: _textDirection,
        locale: _locale,
        textScaler: _textScaler ?? TextScaler.noScaling,
        maxLines: _isCollapsed ? _trimLines : null,
        strutStyle: _strutStyle,
        textWidthBasis: _textWidthBasis ?? TextWidthBasis.parent,
        textHeightBehavior: _textHeightBehavior,
      );
    } else if (!_isCollapsed && _needsLink) {
      // Show collapse link
      final linkText = _trimExpandedText;
      final effectiveColorClickableText = _colorClickableText ?? Colors.blue;
      final effectiveStyle = _style ?? const TextStyle();
      final defaultLessStyle = _lessStyle ?? effectiveStyle.copyWith(color: effectiveColorClickableText);

      final link = TextSpan(text: ' $linkText', style: defaultLessStyle, recognizer: _tapRecognizer);

      final expandedSpan = TextSpan(children: [_effectiveTextSpan, link]);

      _textPainter = TextPainter(
        text: expandedSpan,
        textAlign: _textAlign ?? TextAlign.start,
        textDirection: _textDirection,
        locale: _locale,
        textScaler: _textScaler ?? TextScaler.noScaling,
        maxLines: null,
        strutStyle: _strutStyle,
        textWidthBasis: _textWidthBasis ?? TextWidthBasis.parent,
        textHeightBehavior: _textHeightBehavior,
      );
    } else {
      // No trimming needed, use original span
      _textPainter = TextPainter(
        text: _effectiveTextSpan,
        textAlign: _textAlign ?? TextAlign.start,
        textDirection: _textDirection,
        locale: _locale,
        textScaler: _textScaler ?? TextScaler.noScaling,
        maxLines: null,
        strutStyle: _strutStyle,
        textWidthBasis: _textWidthBasis ?? TextWidthBasis.parent,
        textHeightBehavior: _textHeightBehavior,
      );
    }

    _textPainter.layout(maxWidth: maxWidth);

    // Calculate link rectangle for hit testing
    if (_needsLink) {
      final text = _textPainter.text!.toPlainText();
      final linkText = _isCollapsed ? _trimCollapsedText : _trimExpandedText;
      final linkIndex = text.indexOf(linkText);
      if (linkIndex >= 0) {
        final linkOffset = _textPainter.getOffsetForCaret(TextPosition(offset: linkIndex), Rect.zero);
        final linkWidth = _textPainter.width - linkOffset.dx;
        final linkHeight = _textPainter.preferredLineHeight;
        _linkRect = Rect.fromLTWH(linkOffset.dx, linkOffset.dy, linkWidth, linkHeight);
      } else {
        _linkRect = Rect.zero;
      }
    } else {
      _linkRect = Rect.zero;
    }

    size = constraints.constrain(_textPainter.size);
  }

  TextSpan? _getPreSpan() {
    if (_richPreData != null) {
      return _richPreData;
    } else if (_preDataText != null) {
      final effectiveStyle = _style ?? const TextStyle();
      return TextSpan(text: '${_preDataText!} ', style: _preDataTextStyle ?? effectiveStyle);
    }
    return null;
  }

  TextSpan? _getPostSpan() {
    if (_richPostData != null) {
      return _richPostData;
    } else if (_postDataText != null) {
      final effectiveStyle = _style ?? const TextStyle();
      return TextSpan(text: ' ${_postDataText!}', style: _postDataTextStyle ?? effectiveStyle);
    }
    return null;
  }

  TextSpan _getDataSpan() {
    final effectiveStyle = _style ?? const TextStyle();
    if (_richData != null) {
      return TextSpan(style: effectiveStyle, children: [_richData!]);
    } else if (_text != null) {
      return _buildAnnotatedTextSpan(
        data: _text!,
        textStyle: effectiveStyle,
        regExp: _mergeRegexPatterns(_annotations),
        annotations: _annotations,
      );
    } else {
      return TextSpan(text: '', style: effectiveStyle);
    }
  }

  @override
  void paint(final PaintingContext context, final Offset offset) {
    _textPainter.paint(context.canvas, offset);
  }

  @override
  bool hitTestSelf(final Offset position) => true;

  @override
  void handleEvent(final PointerEvent event, covariant final BoxHitTestEntry entry) {
    if (event is PointerUpEvent && _needsLink && _isExpandable) {
      final localPosition = event.localPosition;
      if (_linkRect.contains(localPosition)) {
        _handleTap();
      }
    }
  }

  @override
  void describeSemanticsConfiguration(final SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config
      ..label = _semanticsLabel ?? _text ?? ''
      ..textDirection = _textDirection
      ..onTap = () {
        if (_needsLink && _isExpandable) {
          _handleTap();
        }
      };
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    _isCollapsedNotifier?.removeListener(_onCollapsedChanged);
    super.dispose();
  }
}

@immutable
class _TextSpanTrimResult {
  const _TextSpanTrimResult({required this.textSpan, required this.spanEndIndex, required this.didTrim});

  final TextSpan textSpan;
  final int spanEndIndex;
  final bool didTrim;
}
