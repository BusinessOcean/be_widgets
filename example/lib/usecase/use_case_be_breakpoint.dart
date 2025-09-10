import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'BeBreakpoint', path: '/', type: BeBreakpoint)
Widget renderBeBreakpointWidget(final BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final breakpoint = calculateBreakpoint(screenWidth);
      return Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.devices, size: 48, color: Colors.blue),
              const SizedBox(height: 16),
              Text(
                'Current Breakpoint: ${breakpoint.name}',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Screen width: ${screenWidth.toStringAsFixed(0)} px',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                breakpoint.isMobile
                    ? 'Device: Mobile'
                    : breakpoint.isTablet
                        ? 'Device: Tablet'
                        : 'Device: Desktop',
                style: TextStyle(
                  fontSize: 16,
                  color: breakpoint.isMobile
                      ? Colors.green
                      : breakpoint.isTablet
                          ? Colors.orange
                          : Colors.purple,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
