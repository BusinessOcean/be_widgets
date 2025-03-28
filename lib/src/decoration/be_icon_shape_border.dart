// Center(
//               child: Container(
//                 width: 100,
//                 height: 100,
//                 decoration: const ShapeDecoration(
//                   shape: BeIconOutlinedBorder(
//                     iconData: Icons.import_contacts_sharp,
//                     iconSize: 24,
//                     roundRadius: 8,
//                     borderColor: Colors.red,
//                     borderWidth: 2,
//                     iconAlignment: BeIconAlignment.bottomRight,
//                     iconOffset: Offset(
//                       -100,
//                       10,
//                     ), // Adjust icon position slightly inward
//                   ),
//                 ),
//                 child: const Center(
//                   child: Text("Hello", style: TextStyle(color: Colors.green)),
//                 ),
//               ),
//             ),

import 'package:flutter/material.dart' hide IconAlignment;

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
    this.color = Colors.transparent,
    this.size = 24.0,
    this.radius = 4.0,
    this.width = 2.0,
    this.alignment = BeIconAlignment.topCenter,
    this.offset = Offset.zero,
  });

  final IconData icon;
  final double size;
  final Color color;
  final double radius;
  final double width;
  final BeIconAlignment alignment;
  final Offset offset;

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

  Offset _getIconPosition(Rect rect) {
    double x, y;

    switch (alignment) {
      case BeIconAlignment.topLeft:
        x = rect.left;
        y = rect.top;
        break;
      case BeIconAlignment.topCenter:
        x = rect.center.dx;
        y = rect.top;
        break;
      case BeIconAlignment.topRight:
        x = rect.right;
        y = rect.top;
        break;
      case BeIconAlignment.centerLeft:
        x = rect.left;
        y = rect.center.dy;
        break;
      case BeIconAlignment.center:
        x = rect.center.dx;
        y = rect.center.dy;
        break;
      case BeIconAlignment.centerRight:
        x = rect.right;
        y = rect.center.dy;
        break;
      case BeIconAlignment.bottomLeft:
        x = rect.left;
        y = rect.bottom;
        break;
      case BeIconAlignment.bottomCenter:
        x = rect.center.dx;
        y = rect.bottom;
        break;
      case BeIconAlignment.bottomRight:
        x = rect.right;
        y = rect.bottom;
        break;
    }

    return Offset(x, y) + offset;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // Draw the border
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(radius)),
      paint,
    );

    // Draw the icon
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: icon.fontFamily,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final iconPosition = _getIconPosition(rect);
    final textOffset = Offset(
      iconPosition.dx - textPainter.width / 2,
      iconPosition.dy - textPainter.height / 2,
    );

    textPainter.paint(canvas, textOffset);
  }

  @override
  BeIconShapeBorder copyWith({
    BorderSide? side,
    IconData? iconData,
    double? iconSize,
    Color? borderColor,
    double? roundRadius,
    double? borderWidth,
    BeIconAlignment? iconAlignment,
    Offset? iconOffset,
  }) =>
      BeIconShapeBorder(
        icon: iconData ?? icon,
        size: iconSize ?? size,
        color: borderColor ?? color,
        radius: roundRadius ?? radius,
        width: borderWidth ?? width,
        alignment: iconAlignment ?? alignment,
        offset: iconOffset ?? offset,
      );
}
