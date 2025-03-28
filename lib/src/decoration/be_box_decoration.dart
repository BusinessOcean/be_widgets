// ignore_for_file: comment_references

import 'dart:math' as math;

import 'package:be_widgets/src/decoration/be_box_shadow.dart';
import 'package:flutter/painting.dart';

class BeBoxDecoration extends BoxDecoration {
  const BeBoxDecoration({
    super.color,
    super.image,
    super.border,
    super.borderRadius,
    List<BeBoxShadow>? super.boxShadow,
    super.gradient,
    super.backgroundBlendMode,
    super.shape,
  });

  /// Creates a copy of this object but with the given fields replaced with the
  /// new values.
  @override
  BeBoxDecoration copyWith({
    Color? color,
    DecorationImage? image,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BlendMode? backgroundBlendMode,
    BoxShape? shape,
  }) =>
      BeBoxDecoration(
        color: color ?? this.color,
        image: image ?? this.image,
        border: border ?? this.border,
        borderRadius: borderRadius ?? this.borderRadius,
        boxShadow: (boxShadow ?? this.boxShadow) as List<BeBoxShadow>?,
        gradient: gradient ?? this.gradient,
        backgroundBlendMode: backgroundBlendMode ?? this.backgroundBlendMode,
        shape: shape ?? this.shape,
      );

  /// Returns a new box decoration that is scaled by the given factor.
  @override
  BeBoxDecoration scale(double factor) => BeBoxDecoration(
        color: Color.lerp(null, color, factor),
        image: image, // @TODO(ianh): fade the image from transparent
        border: BoxBorder.lerp(null, border, factor),
        borderRadius: BorderRadiusGeometry.lerp(null, borderRadius, factor),
        boxShadow: BeBoxShadow.lerpList(
          null,
          boxShadow as List<BeBoxShadow>,
          factor,
        ),
        gradient: gradient?.scale(factor),
        shape: shape,
      );

  @override
  BeBoxDecoration? lerpFrom(Decoration? a, double t) {
    if (a == null) return scale(t);
    if (a is BeBoxDecoration) return BeBoxDecoration.lerp(a, this, t);
    return super.lerpFrom(a, t) as BeBoxDecoration?;
  }

  @override
  BeBoxDecoration? lerpTo(Decoration? b, double t) {
    if (b == null) return scale(1.0 - t);
    if (b is BeBoxDecoration) return BeBoxDecoration.lerp(this, b, t);
    return super.lerpTo(b, t) as BeBoxDecoration?;
  }

  /// Linearly interpolate between two box decorations.
  ///
  /// Interpolates each parameter of the box decoration separately.
  ///
  /// The [shape] is not interpolated. To interpolate the shape, consider using
  /// a [ShapeDecoration] with different border shapes.
  ///
  /// If both values are null, this returns null. Otherwise, it returns a
  /// non-null value. If one of the values is null, then the result is obtained
  /// by applying [scale] to the other value. If neither value is null and `t ==
  /// 0.0`, then `a` is returned unmodified; if `t == 1.0` then `b` is returned
  /// unmodified. Otherwise, the values are computed by interpolating the
  /// properties appropriately.
  ///
  /// {@macro dart.ui.shadow.lerp}
  ///
  /// See also:
  ///
  ///  * [Decoration.lerp], which can interpolate between any two types of
  ///    [Decoration]s, not just [BeBoxDecoration]s.
  ///  * [lerpFrom] and [lerpTo], which are used to implement [Decoration.lerp]
  ///    and which use [BeBoxDecoration.lerp] when interpolating two
  ///    [BeBoxDecoration]s or a [BeBoxDecoration] to or from null.
  static BeBoxDecoration? lerp(
    BeBoxDecoration? a,
    BeBoxDecoration? b,
    double t,
  ) {
    if (a == null && b == null) {
      return null;
    }
    if (a == null) {
      return b!.scale(t);
    }
    if (b == null) {
      return a.scale(1.0 - t);
    }
    if (t == 0.0) {
      return a;
    }
    if (t == 1.0) {
      return b;
    }
    return BeBoxDecoration(
      color: Color.lerp(a.color, b.color, t),
      image: t < 0.5 ? a.image : b.image, // @TODO(ianh): cross-fade the image
      border: BoxBorder.lerp(a.border, b.border, t),
      borderRadius: BorderRadiusGeometry.lerp(
        a.borderRadius,
        b.borderRadius,
        t,
      ),
      boxShadow: BeBoxShadow.lerpList(
        a.boxShadow as List<BeBoxShadow>,
        b.boxShadow as List<BeBoxShadow>,
        t,
      ),
      gradient: Gradient.lerp(a.gradient, b.gradient, t),
      shape: t < 0.5 ? a.shape : b.shape,
    );
  }

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    assert(
      onChanged != null || image == null,
      'onChanged != null || image == null',
    );
    return _InsetBoxDecorationPainter(this, onChanged);
  }
}

/// An object that paints a [BeBoxDecoration] or an [InsetBoxDecoration] into a canvas.
class _InsetBoxDecorationPainter extends BoxPainter {
  _InsetBoxDecorationPainter(this._decoration, VoidCallback? onChanged)
      : super(onChanged);

  final BeBoxDecoration _decoration;

  Paint? _cachedBackgroundPaint;
  Rect? _rectForCachedBackgroundPaint;
  Paint _getBackgroundPaint(Rect rect, TextDirection? textDirection) {
    assert(
      _decoration.gradient != null || _rectForCachedBackgroundPaint == null,
      '_decoration.gradient != null || _rectForCachedBackgroundPaint == null,',
    );

    if (_cachedBackgroundPaint == null ||
        (_decoration.gradient != null &&
            _rectForCachedBackgroundPaint != rect)) {
      final paint = Paint();
      if (_decoration.backgroundBlendMode != null) {
        paint.blendMode = _decoration.backgroundBlendMode!;
      }
      if (_decoration.color != null) paint.color = _decoration.color!;
      if (_decoration.gradient != null) {
        paint.shader = _decoration.gradient!.createShader(
          rect,
          textDirection: textDirection,
        );
        _rectForCachedBackgroundPaint = rect;
      }
      _cachedBackgroundPaint = paint;
    }

    return _cachedBackgroundPaint!;
  }

  void _paintBox(
    Canvas canvas,
    Rect rect,
    Paint paint,
    TextDirection? textDirection,
  ) {
    switch (_decoration.shape) {
      case BoxShape.circle:
        assert(
          _decoration.borderRadius == null,
          '_decoration.borderRadius == null',
        );
        final center = rect.center;
        final radius = rect.shortestSide / 2.0;
        canvas.drawCircle(center, radius, paint);
        break;
      case BoxShape.rectangle:
        if (_decoration.borderRadius == null) {
          canvas.drawRect(rect, paint);
        } else {
          canvas.drawRRect(
            _decoration.borderRadius!.resolve(textDirection).toRRect(rect),
            paint,
          );
        }
        break;
    }
  }

  void _paintOuterShadows(
    Canvas canvas,
    Rect rect,
    TextDirection? textDirection,
  ) {
    if (_decoration.boxShadow == null) {
      return;
    }
    for (final boxShadow in _decoration.boxShadow!) {
      if (boxShadow is BeBoxShadow) {
        if (boxShadow.inset) {
          continue;
        }
      }
      final paint = boxShadow.toPaint();
      final bounds =
          rect.shift(boxShadow.offset).inflate(boxShadow.spreadRadius);
      _paintBox(canvas, bounds, paint, textDirection);
    }
  }

  void _paintBackgroundColor(
    Canvas canvas,
    Rect rect,
    TextDirection? textDirection,
  ) {
    if (_decoration.color != null || _decoration.gradient != null) {
      _paintBox(
        canvas,
        rect,
        _getBackgroundPaint(rect, textDirection),
        textDirection,
      );
    }
  }

  DecorationImagePainter? _imagePainter;
  void _paintBackgroundImage(
    Canvas canvas,
    Rect rect,
    ImageConfiguration configuration,
  ) {
    if (_decoration.image == null) return;
    _imagePainter ??= _decoration.image!.createPainter(onChanged!);
    Path? clipPath;
    switch (_decoration.shape) {
      case BoxShape.circle:
        assert(
          _decoration.borderRadius == null,
          '_decoration.borderRadius == null',
        );
        final center = rect.center;
        final radius = rect.shortestSide / 2.0;
        final square = Rect.fromCircle(center: center, radius: radius);
        clipPath = Path()..addOval(square);
        break;
      case BoxShape.rectangle:
        if (_decoration.borderRadius != null) {
          clipPath = Path()
            ..addRRect(
              _decoration.borderRadius!
                  .resolve(configuration.textDirection)
                  .toRRect(rect),
            );
        }
        break;
    }
    _imagePainter!.paint(canvas, rect, clipPath, configuration);
  }

  void _paintInnerShadows(
    Canvas canvas,
    Rect rect,
    TextDirection? textDirection,
  ) {
    if (_decoration.boxShadow == null) {
      return;
    }
    for (final boxShadow in _decoration.boxShadow!) {
      if (boxShadow is! BeBoxShadow || !boxShadow.inset) {
        continue;
      }

      if (_decoration.shape == BoxShape.circle) {
        final center = rect.center;
        final radius = rect.shortestSide / 2.0;
        rect = Rect.fromCircle(center: center, radius: radius);
      }

      final color = boxShadow.color;

      final borderRadiusGeometry = _decoration.borderRadius ??
          (_decoration.shape == BoxShape.circle
              ? BorderRadius.circular(rect.longestSide)
              : BorderRadius.zero);
      final borderRadius = borderRadiusGeometry.resolve(textDirection);

      final clipRRect = borderRadius.toRRect(rect);

      final innerRect = rect.deflate(boxShadow.spreadRadius);
      if (innerRect.isEmpty) {
        final paint = Paint()..color = color;
        canvas.drawRRect(clipRRect, paint);
      }

      final innerRRect = borderRadius.toRRect(innerRect);

      canvas
        ..save()
        ..clipRRect(clipRRect);

      final outerRect = _areaCastingShadowInHole(rect, boxShadow);

      canvas
        ..drawDRRect(
          RRect.fromRectAndRadius(outerRect, Radius.zero),
          innerRRect.shift(boxShadow.offset),
          Paint()
            ..color = color
            ..colorFilter = ColorFilter.mode(color, BlendMode.src)
            ..maskFilter = MaskFilter.blur(
              BlurStyle.normal,
              boxShadow.blurSigma,
            ),
        )
        ..restore();
    }
  }

  @override
  void dispose() {
    _imagePainter?.dispose();
    super.dispose();
  }

  /// Paint the box decoration into the given location on the given canvas.
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null, 'configuration.size != null');
    final rect = offset & configuration.size!;
    final textDirection = configuration.textDirection;
    _paintOuterShadows(canvas, rect, textDirection);
    _paintBackgroundColor(canvas, rect, textDirection);
    _paintBackgroundImage(canvas, rect, configuration);
    _paintInnerShadows(canvas, rect, textDirection);
    _decoration.border?.paint(
      canvas,
      rect,
      shape: _decoration.shape,
      borderRadius: _decoration.borderRadius?.resolve(textDirection),
      textDirection: configuration.textDirection,
    );
  }

  @override
  String toString() => '_InsetBoxDecorationPainter for $_decoration';
}

Rect _areaCastingShadowInHole(Rect holeRect, BeBoxShadow shadow) {
  var bounds = holeRect;
  bounds = bounds.inflate(shadow.blurRadius);

  if (shadow.spreadRadius < 0) {
    bounds = bounds.inflate(-shadow.spreadRadius);
  }

  final offsetBounds = bounds.shift(shadow.offset);

  return _unionRects(bounds, offsetBounds);
}

Rect _unionRects(Rect a, Rect b) {
  if (a.isEmpty) {
    return b;
  }

  if (b.isEmpty) {
    return a;
  }

  final left = math.min(a.left, b.left);
  final top = math.min(a.top, b.top);
  final right = math.max(a.right, b.right);
  final bottom = math.max(a.bottom, b.bottom);

  return Rect.fromLTRB(left, top, right, bottom);
}
