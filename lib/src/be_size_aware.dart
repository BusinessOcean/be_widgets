// ignore_for_file: library_private_types_in_public_api, avoid_setters_without_getters, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Custom Flutter widget that provides size information to its child builder
/// with additional features like aspect ratio, orientation detection, and more.
///
/// The [builder] function receives a [BeSizeAwareData] object containing
/// size information and utilities, and should return a widget.
///
/// This is useful for creating responsive widgets that need to know their
/// parent's dimensions to make layout decisions.
///
/// Example:
/// ```dart
/// BeSizeAware(
///   builder: (data) => Container(
///     width: data.width * 0.5, // Use half the available width
///     height: data.height * 0.3, // Use 30% of available height
///     child: Text('Aspect: ${data.aspectRatio.toStringAsFixed(2)}'),
///   ),
/// )
/// ```
///
/// With custom constraints and size change listener:
/// ```dart
/// BeSizeAware(
///   constraints: BoxConstraints(maxWidth: 300, maxHeight: 200),
///   onSizeChanged: (oldSize, newSize) => print('Size changed: $newSize'),
///   builder: (data) => Container(
///     width: data.width,
///     height: data.height,
///     child: Text('Constrained content'),
///   ),
/// )
/// ```
class BeSizeAware extends StatefulWidget {
  const BeSizeAware({
    required this.builder,
    super.key,
    this.constraints,
    this.onSizeChanged,
    this.debounceDuration = const Duration(milliseconds: 16),
  });

  /// Builder function that receives size data and returns a widget
  final Widget Function(BeSizeAwareData data) builder;

  /// Optional constraints to apply before measuring size
  final BoxConstraints? constraints;

  /// Optional callback that gets called when the size changes
  final void Function(Size oldSize, Size newSize)? onSizeChanged;

  /// Debounce duration for size change events to avoid too frequent callbacks
  final Duration debounceDuration;

  @override
  State<BeSizeAware> createState() => _BeSizeAwareState();

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BoxConstraints?>('constraints', constraints))
      ..add(DiagnosticsProperty<bool>('hasOnSizeChanged', onSizeChanged != null))
      ..add(DiagnosticsProperty<Duration>('debounceDuration', debounceDuration));
  }
}

/// Data class containing size information and utility methods
class BeSizeAwareData {
  BeSizeAwareData(this.size);

  final Size size;

  /// Get the available width
  double get width => size.width;

  /// Get the available height
  double get height => size.height;

  /// Get the aspect ratio (width/height)
  double get aspectRatio => width / height;

  /// Check if the orientation is landscape
  bool get isLandscape => width > height;

  /// Check if the orientation is portrait
  bool get isPortrait => height > width;

  /// Check if the size is approximately square
  bool get isSquare => (aspectRatio - 1.0).abs() < 0.1;

  /// Get the smaller dimension
  double get minDimension => size.shortestSide;

  /// Get the larger dimension
  double get maxDimension => size.longestSide;

  /// Calculate a responsive value based on available width
  double responsiveWidth(final double percentage) => width * percentage.clamp(0.0, 1.0);

  /// Calculate a responsive value based on available height
  double responsiveHeight(final double percentage) => height * percentage.clamp(0.0, 1.0);

  /// Calculate a responsive value based on the smaller dimension
  double responsiveMin(final double percentage) => minDimension * percentage.clamp(0.0, 1.0);

  /// Calculate a responsive value based on the larger dimension
  double responsiveMax(final double percentage) => maxDimension * percentage.clamp(0.0, 1.0);

  /// Check if the available width is greater than a threshold
  bool isWiderThan(final double threshold) => width > threshold;

  /// Check if the available height is greater than a threshold
  bool isTallerThan(final double threshold) => height > threshold;

  @override
  String toString() =>
      'BeSizeAwareData(width: $width, height: $height, aspectRatio: ${aspectRatio.toStringAsFixed(2)})';
}

class _BeSizeAwareState extends State<BeSizeAware> {
  Size _availableSize = Size.zero;
  DateTime? _lastSizeChange;

  @override
  Widget build(final BuildContext context) {
    return LayoutBuilder(
      builder: (final context, final constraints) {
        // Use custom constraints if provided, otherwise use parent constraints
        final effectiveConstraints = widget.constraints?.enforce(constraints) ?? constraints;

        // Calculate the available size based on constraints
        final availableSize = Size(
          effectiveConstraints.maxWidth.isFinite ? effectiveConstraints.maxWidth : 0,
          effectiveConstraints.maxHeight.isFinite ? effectiveConstraints.maxHeight : 0,
        );

        // Check if size has changed and notify if callback is provided
        if (_availableSize != availableSize && widget.onSizeChanged != null) {
          _handleSizeChange(_availableSize, availableSize);
        }

        // Update the available size
        _availableSize = availableSize;

        // Build the child with the available size data
        return widget.builder(BeSizeAwareData(_availableSize));
      },
    );
  }

  void _handleSizeChange(final Size oldSize, final Size newSize) {
    final now = DateTime.now();

    // Debounce size change events
    if (_lastSizeChange == null || now.difference(_lastSizeChange!) >= widget.debounceDuration) {
      _lastSizeChange = now;

      // Schedule the callback to be called after the build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          widget.onSizeChanged?.call(oldSize, newSize);
        }
      });
    }
  }
}

/// A more advanced version that uses RenderObject for better performance
/// when you need precise control over layout and painting
class BeSizeAwareRender extends SingleChildRenderObjectWidget {
  const BeSizeAwareRender({
    required super.child,
    super.key,
    this.onSizeAvailable,
    this.constraints,
    this.debounceDuration = const Duration(milliseconds: 16),
  });

  /// Callback that receives the calculated size before child layout
  final void Function(Size size)? onSizeAvailable;

  /// Optional constraints to apply
  final BoxConstraints? constraints;

  /// Debounce duration for size availability events
  final Duration debounceDuration;

  @override
  RenderObject createRenderObject(final BuildContext context) => _BeSizeAwareRenderObject(
    onSizeAvailable: onSizeAvailable,
    customConstraints: constraints,
    debounceDuration: debounceDuration,
  );

  @override
  void updateRenderObject(final BuildContext context, final _BeSizeAwareRenderObject renderObject) {
    renderObject
      ..onSizeAvailable = onSizeAvailable
      ..customConstraints = constraints
      ..debounceDuration = debounceDuration;
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BoxConstraints?>('constraints', constraints))
      ..add(DiagnosticsProperty<bool>('hasOnSizeAvailable', onSizeAvailable != null))
      ..add(DiagnosticsProperty<Duration>('debounceDuration', debounceDuration));
  }
}

class _BeSizeAwareRenderObject extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  _BeSizeAwareRenderObject({
    final void Function(Size size)? onSizeAvailable,
    final BoxConstraints? customConstraints,
    final Duration debounceDuration = const Duration(milliseconds: 16),
  }) : _onSizeAvailable = onSizeAvailable,
       _customConstraints = customConstraints,
       _debounceDuration = debounceDuration;

  void Function(Size size)? _onSizeAvailable;
  set onSizeAvailable(final void Function(Size size)? value) {
    _onSizeAvailable = value;
  }

  BoxConstraints? _customConstraints;
  set customConstraints(final BoxConstraints? value) {
    if (_customConstraints == value) return;
    _customConstraints = value;
    markNeedsLayout();
  }

  Duration _debounceDuration;
  set debounceDuration(final Duration value) {
    if (_debounceDuration == value) return;
    _debounceDuration = value;
  }

  DateTime? _lastSizeNotification;
  Size? _lastNotifiedSize;

  @override
  void performLayout() {
    // Use custom constraints if provided, otherwise use parent constraints
    final effectiveConstraints = _customConstraints?.enforce(constraints) ?? constraints;

    // Calculate the available size
    final availableSize = Size(
      effectiveConstraints.maxWidth.isFinite ? effectiveConstraints.maxWidth : 0,
      effectiveConstraints.maxHeight.isFinite ? effectiveConstraints.maxHeight : 0,
    );

    // Notify about the available size with debouncing
    _notifySizeAvailable(availableSize);

    // Layout the child with the effective constraints
    if (child != null) {
      child!.layout(effectiveConstraints, parentUsesSize: true);
      size = child!.size;
    } else {
      size = effectiveConstraints.smallest;
    }
  }

  void _notifySizeAvailable(final Size availableSize) {
    final now = DateTime.now();

    // Check if size has changed significantly and debounce period has passed
    if ((_lastNotifiedSize == null || _lastNotifiedSize != availableSize) &&
        (_lastSizeNotification == null || now.difference(_lastSizeNotification!) >= _debounceDuration)) {
      _lastSizeNotification = now;
      _lastNotifiedSize = availableSize;
      _onSizeAvailable?.call(availableSize);
    }
  }

  @override
  void paint(final PaintingContext context, final Offset offset) {
    if (child != null) {
      context.paintChild(child!, offset);
    }
  }

  @override
  bool hitTestChildren(final BoxHitTestResult result, {required final Offset position}) {
    if (child != null) {
      return child!.hitTest(result, position: position);
    }
    return false;
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BoxConstraints?>('customConstraints', _customConstraints))
      ..add(DiagnosticsProperty<Duration>('debounceDuration', _debounceDuration));
  }
}

/// Extension methods for BoxConstraints
extension BoxConstraintsExtensions on BoxConstraints {
  BoxConstraints enforce(final BoxConstraints other) {
    return BoxConstraints(
      minWidth: minWidth.clamp(other.minWidth, other.maxWidth),
      maxWidth: maxWidth.clamp(other.minWidth, other.maxWidth),
      minHeight: minHeight.clamp(other.minHeight, other.maxHeight),
      maxHeight: maxHeight.clamp(other.minHeight, other.maxHeight),
    );
  }
}
