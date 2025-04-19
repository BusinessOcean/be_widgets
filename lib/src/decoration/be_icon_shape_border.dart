import 'package:flutter/material.dart';

enum BeIconAlignment {
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

class BeIconShapeBorder extends OutlinedBorder {
  const BeIconShapeBorder({
    required this.icon,
    this.size = 24.0,
    this.radius = 4.0,
    this.color,
    this.width = 2.0,
    this.alignment = BeIconAlignment.topCenter,
    this.offset = Offset.zero,
    this.iconInset = 8.0,
    this.iconStyle,
  });

  final IconData icon;
  final double size;
  final Color? color;
  final double radius;
  final double width;
  final BeIconAlignment alignment;
  final Offset offset;
  final double iconInset; // New property
  final TextStyle? iconStyle; // New property

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  OutlinedBorder scale(double t) => BeIconShapeBorder(
        icon: icon,
        size: size * t,
        color: color,
        radius: radius * t,
        width: width * t,
        alignment: alignment,
        offset: offset * t,
        iconInset: iconInset * t,
        iconStyle: iconStyle?.copyWith(
          fontSize:
              iconStyle?.fontSize != null ? iconStyle!.fontSize! * t : null,
        ),
      );

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(rect.deflate(width), Radius.circular(radius)),
      );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
  }

  Offset _getIconPosition(Rect rect, Size iconSize) {
    final insetRect = rect.deflate(iconInset + width);
    final halfIconWidth = iconSize.width / 2;
    final halfIconHeight = iconSize.height / 2;

    switch (alignment) {
      case BeIconAlignment.topLeft:
        return Offset(
          insetRect.left + halfIconWidth,
          insetRect.top + halfIconHeight,
        );
      case BeIconAlignment.topCenter:
        return Offset(insetRect.center.dx, insetRect.top + halfIconHeight);
      case BeIconAlignment.topRight:
        return Offset(
          insetRect.right - halfIconWidth,
          insetRect.top + halfIconHeight,
        );
      case BeIconAlignment.centerLeft:
        return Offset(insetRect.left + halfIconWidth, insetRect.center.dy);
      case BeIconAlignment.center:
        return insetRect.center;
      case BeIconAlignment.centerRight:
        return Offset(insetRect.right - halfIconWidth, insetRect.center.dy);
      case BeIconAlignment.bottomLeft:
        return Offset(
          insetRect.left + halfIconWidth,
          insetRect.bottom - halfIconHeight,
        );
      case BeIconAlignment.bottomCenter:
        return Offset(insetRect.center.dx, insetRect.bottom - halfIconHeight);
      case BeIconAlignment.bottomRight:
        return Offset(
          insetRect.right - halfIconWidth,
          insetRect.bottom - halfIconHeight,
        );
    }
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // Draw the border
    final paint = Paint()
      ..color = color ?? Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(radius)),
      paint,
    );

    // Prepare icon text style
    final effectiveStyle = (iconStyle ?? const TextStyle()).copyWith(
      color: iconStyle?.color ?? color,
      fontSize: iconStyle?.fontSize ?? size,
      fontFamily: icon.fontFamily,
      package: icon.fontPackage, // Support for custom icon packages
    );

    // Draw the icon
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: effectiveStyle,
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final iconPosition = _getIconPosition(rect, textPainter.size) + offset;

    // Ensure icon stays within bounds
    final boundedPosition = Offset(
      iconPosition.dx.clamp(
        rect.left + width + iconInset,
        rect.right - width - iconInset,
      ),
      iconPosition.dy.clamp(
        rect.top + width + iconInset,
        rect.bottom - width - iconInset,
      ),
    );

    textPainter.paint(
      canvas,
      Offset(
        boundedPosition.dx - textPainter.width / 2,
        boundedPosition.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  BeIconShapeBorder copyWith({
    BorderSide? side,
    IconData? icon,
    double? size,
    Color? color,
    double? radius,
    double? width,
    BeIconAlignment? alignment,
    Offset? offset,
    double? iconInset,
    TextStyle? iconStyle,
  }) =>
      BeIconShapeBorder(
        icon: icon ?? this.icon,
        size: size ?? this.size,
        color: color ?? this.color,
        radius: radius ?? this.radius,
        width: width ?? this.width,
        alignment: alignment ?? this.alignment,
        offset: offset ?? this.offset,
        iconInset: iconInset ?? this.iconInset,
        iconStyle: iconStyle ?? this.iconStyle,
      );
}
