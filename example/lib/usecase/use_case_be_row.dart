import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'BeRow', path: '/', type: BeRow)
Widget useCaseBeRow(final BuildContext context) {
  // Row Configuration
  final spacing = context.knobs.double
      .slider(label: 'Column Spacing', initialValue: 16, min: 0, max: 48);
  final runSpacing = context.knobs.double
      .slider(label: 'Row Spacing', initialValue: 16, min: 0, max: 48);

  final mainAxisAlignment = context.knobs.object.dropdown(
    label: 'Main Axis Alignment',
    options: MainAxisAlignment.values,
    labelBuilder: (final value) => value.toString().split('.').last,
  );

  final crossAxisAlignment = context.knobs.object.dropdown(
    label: 'Cross Axis Alignment',
    options: CrossAxisAlignment.values,
    labelBuilder: (final value) => value.toString().split('.').last,
  );

  final mainAxisSize = context.knobs.object.dropdown(
    label: 'Main Axis Size',
    options: MainAxisSize.values,
    labelBuilder: (final value) => value.toString().split('.').last,
  );

  // Column Configuration for Demo
  final columnCount = context.knobs.int
      .slider(label: 'Number of Columns', initialValue: 3, min: 1, max: 6);
  final columnWidth = context.knobs.int.slider(
      label: 'Each Column Width (1-12)', initialValue: 4, min: 1, max: 12);

  // Appearance
  final showBorders =
      context.knobs.boolean(label: 'Show Borders', initialValue: true);
  final cardElevation = context.knobs.double
      .slider(label: 'Card Elevation', initialValue: 2, min: 0, max: 8);
  final paddingValue = context.knobs.double
      .slider(label: 'Row Padding', initialValue: 16, min: 0, max: 32);

  // Demo Type
  final demoType = context.knobs.list(
    label: 'Demo Type',
    options: [
      'Basic Layout',
      'Responsive Cards',
      'Form Fields',
      'Statistics',
      'Navigation Items',
      'Image Gallery'
    ],
  );

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildRowHeader(demoType),
          const SizedBox(height: 24),

          // Main Demo
          _buildRowDemo(
            demoType: demoType,
            spacing: spacing,
            runSpacing: runSpacing,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: mainAxisSize,
            columnCount: columnCount,
            columnWidth: columnWidth,
            showBorders: showBorders,
            cardElevation: cardElevation,
            paddingValue: paddingValue,
          ),

          const SizedBox(height: 32),

          // Configuration Info
          _buildConfigurationInfo(
            spacing: spacing,
            runSpacing: runSpacing,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: mainAxisSize,
          ),

          const SizedBox(height: 32),

          // Property Examples
          _buildRowPropertyExamples(cardElevation),
        ],
      ),
    ),
  );
}

Widget _buildRowHeader(final String demoType) {
  return Card(
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Icon(_getRowDemoIcon(demoType), size: 32, color: Colors.blue),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('BeRow Widget Demo',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Demo: $demoType',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                const SizedBox(height: 8),
                const Text(
                  'BeRow provides a 12-column grid system with responsive breakpoints and flexible layouts.',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildRowDemo({
  required final String demoType,
  required final double spacing,
  required final double runSpacing,
  required final MainAxisAlignment mainAxisAlignment,
  required final CrossAxisAlignment crossAxisAlignment,
  required final MainAxisSize mainAxisSize,
  required final int columnCount,
  required final int columnWidth,
  required final bool showBorders,
  required final double cardElevation,
  required final double paddingValue,
}) {
  return Card(
    elevation: cardElevation,
    child: Padding(
      padding: EdgeInsets.all(paddingValue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('BeRow - $demoType',
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            decoration: showBorders
                ? BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  )
                : null,
            child: BeRow(
              spacing: spacing,
              runSpacing: runSpacing,
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              mainAxisSize: mainAxisSize,
              padding: EdgeInsets.all(paddingValue / 2),
              children: _generateDemoContent(demoType, columnCount, columnWidth,
                  showBorders, cardElevation),
            ),
          ),
        ],
      ),
    ),
  );
}

List<Widget> _generateDemoContent(
  final String demoType,
  final int columnCount,
  final int columnWidth,
  final bool showBorders,
  final double cardElevation,
) {
  switch (demoType) {
    case 'Basic Layout':
      return List.generate(
        columnCount,
        (final index) => BeColumn(
          xs: columnWidth,
          child: _buildBasicCard(
            'Column ${index + 1}',
            'Width: $columnWidth/12',
            Colors.primaries[index % Colors.primaries.length],
            showBorders,
            cardElevation,
          ),
        ),
      );

    case 'Responsive Cards':
      return [
        BeColumn(
          xs: 12,
          sm: 6,
          md: 4,
          child: _buildResponsiveCard(
              'Mobile First', 'xs:12 sm:6 md:4', Colors.blue, cardElevation),
        ),
        BeColumn(
          xs: 12,
          sm: 6,
          md: 4,
          child: _buildResponsiveCard(
              'Tablet Ready', 'xs:12 sm:6 md:4', Colors.green, cardElevation),
        ),
        BeColumn(
          xs: 12,
          sm: 12,
          md: 4,
          child: _buildResponsiveCard('Desktop Optimized', 'xs:12 sm:12 md:4',
              Colors.orange, cardElevation),
        ),
      ];

    case 'Form Fields':
      return [
        BeColumn(
            xs: 12,
            md: 6,
            child: _buildFormField(
                'First Name', 'Enter your first name', cardElevation)),
        BeColumn(
            xs: 12,
            md: 6,
            child: _buildFormField(
                'Last Name', 'Enter your last name', cardElevation)),
        BeColumn(
            xs: 12,
            child: _buildFormField(
                'Email Address', 'Enter your email address', cardElevation)),
      ];

    case 'Statistics':
      return [
        BeColumn(
          xs: 12,
          sm: 6,
          lg: 3,
          child: _buildStatCard(
              'Users', '12.5K', Icons.people, Colors.blue, cardElevation),
        ),
        BeColumn(
          xs: 12,
          sm: 6,
          lg: 3,
          child: _buildStatCard('Revenue', '\$85.2K', Icons.attach_money,
              Colors.green, cardElevation),
        ),
        BeColumn(
          xs: 12,
          sm: 6,
          lg: 3,
          child: _buildStatCard('Orders', '1,245', Icons.shopping_cart,
              Colors.orange, cardElevation),
        ),
        BeColumn(
          xs: 12,
          sm: 6,
          lg: 3,
          child: _buildStatCard('Growth', '+12.5%', Icons.trending_up,
              Colors.purple, cardElevation),
        ),
      ];

    case 'Navigation Items':
      return [
        BeColumn(
            xs: 6,
            md: 2,
            child: _buildNavItem('Home', Icons.home, cardElevation)),
        BeColumn(
            xs: 6,
            md: 2,
            child: _buildNavItem('Products', Icons.inventory, cardElevation)),
        BeColumn(
            xs: 6,
            md: 2,
            child: _buildNavItem(
                'Services', Icons.miscellaneous_services, cardElevation)),
        BeColumn(
            xs: 6,
            md: 2,
            child: _buildNavItem('About', Icons.info, cardElevation)),
        BeColumn(
            xs: 6,
            md: 2,
            child: _buildNavItem('Contact', Icons.contact_mail, cardElevation)),
        BeColumn(
            xs: 6,
            md: 2,
            child: _buildNavItem('Support', Icons.support, cardElevation)),
      ];

    case 'Image Gallery':
      return List.generate(
        6,
        (final index) => BeColumn(
            xs: 12,
            sm: 6,
            md: 4,
            lg: 2,
            child: _buildGalleryItem('Image ${index + 1}', cardElevation)),
      );

    default:
      return [
        BeColumn(
            xs: 4,
            child: _buildBasicCard(
                'Column 1', '4/12', Colors.red, showBorders, cardElevation)),
        BeColumn(
            xs: 4,
            child: _buildBasicCard(
                'Column 2', '4/12', Colors.green, showBorders, cardElevation)),
        BeColumn(
            xs: 4,
            child: _buildBasicCard(
                'Column 3', '4/12', Colors.blue, showBorders, cardElevation)),
      ];
  }
}

Widget _buildConfigurationInfo({
  required final double spacing,
  required final double runSpacing,
  required final MainAxisAlignment mainAxisAlignment,
  required final CrossAxisAlignment crossAxisAlignment,
  required final MainAxisSize mainAxisSize,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Current BeRow Configuration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _buildConfigChip(
                  'Spacing', '${spacing.toStringAsFixed(0)}px', Colors.blue),
              _buildConfigChip('Run Spacing',
                  '${runSpacing.toStringAsFixed(0)}px', Colors.green),
              _buildConfigChip('Main Axis',
                  mainAxisAlignment.toString().split('.').last, Colors.orange),
              _buildConfigChip('Cross Axis',
                  crossAxisAlignment.toString().split('.').last, Colors.purple),
              _buildConfigChip('Main Size',
                  mainAxisSize.toString().split('.').last, Colors.red),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildRowPropertyExamples(final double cardElevation) {
  return Card(
    elevation: cardElevation,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('BeRow Property Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          // Equal Columns Example
          _buildPropertyExample(
            'Equal Width Columns',
            'BeRow with three columns of equal width (4/12 each)',
            BeRow(
              spacing: 8,
              children: [
                BeColumn(
                    xs: 4,
                    child: _buildExampleCard('4/12', Colors.blue.shade200)),
                BeColumn(
                    xs: 4,
                    child: _buildExampleCard('4/12', Colors.blue.shade200)),
                BeColumn(
                    xs: 4,
                    child: _buildExampleCard('4/12', Colors.blue.shade200)),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Unequal Columns Example
          _buildPropertyExample(
            'Unequal Width Columns',
            'BeRow with mixed column widths (8/12 + 4/12)',
            BeRow(
              spacing: 8,
              children: [
                BeColumn(
                    xs: 8,
                    child: _buildExampleCard(
                        '8/12 (Main Content)', Colors.green.shade200)),
                BeColumn(
                    xs: 4,
                    child: _buildExampleCard(
                        '4/12 (Sidebar)', Colors.green.shade300)),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Wrapping Example
          _buildPropertyExample(
            'Column Wrapping',
            'BeRow with columns that wrap to new lines when needed',
            BeRow(
              spacing: 8,
              runSpacing: 12,
              children: [
                BeColumn(
                    xs: 7,
                    child: _buildExampleCard('7/12', Colors.orange.shade200)),
                BeColumn(
                    xs: 7,
                    child: _buildExampleCard(
                        '7/12 (wraps)', Colors.orange.shade300)),
                BeColumn(
                    xs: 6,
                    child: _buildExampleCard('6/12', Colors.orange.shade200)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPropertyExample(
    final String title, final String description, final Widget example) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 4),
      Text(description,
          style: TextStyle(color: Colors.grey[600], fontSize: 14)),
      const SizedBox(height: 12),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        child: example,
      ),
    ],
  );
}

// Helper functions for building different types of cards
Widget _buildBasicCard(
  final String title,
  final String subtitle,
  final Color color,
  final bool showBorders,
  final double elevation,
) {
  return Container(
    constraints: const BoxConstraints(minHeight: 80),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      border: showBorders
          ? Border.all(color: color, width: 2)
          : Border.all(color: color.withValues(alpha: 0.3)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Material(
      color: Colors.transparent,
      elevation: elevation,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(subtitle,
                style: TextStyle(
                    color: color.withValues(alpha: 0.8), fontSize: 12)),
          ],
        ),
      ),
    ),
  );
}

Widget _buildResponsiveCard(final String title, final String breakpoints,
    final Color color, final double elevation) {
  return Card(
    elevation: elevation,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.devices, color: color, size: 24),
          const SizedBox(height: 8),
          Text(title,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(
            breakpoints,
            style: TextStyle(
                color: color.withValues(alpha: 0.7),
                fontSize: 12,
                fontFamily: 'monospace'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildFormField(
    final String label, final String hint, final double elevation) {
  return Card(
    elevation: elevation,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(hint, style: TextStyle(color: Colors.grey[500])),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildStatCard(
  final String title,
  final String value,
  final IconData icon,
  final Color color,
  final double elevation,
) {
  return Card(
    elevation: elevation,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color.withValues(alpha: 0.05),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(title,
                  style: TextStyle(
                      color: color.withValues(alpha: 0.8), fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Text(value,
              style: TextStyle(
                  color: color, fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

Widget _buildNavItem(
    final String title, final IconData icon, final double elevation) {
  return Card(
    elevation: elevation,
    child: InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: Colors.grey[600], size: 24),
            const SizedBox(height: 8),
            Text(title,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}

Widget _buildGalleryItem(final String title, final double elevation) {
  return Card(
    elevation: elevation,
    child: Column(
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: const Center(
              child: Icon(Icons.image, size: 24, color: Colors.grey)),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}

Widget _buildConfigChip(
    final String label, final String value, final Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Text('$label: $value',
        style:
            TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
  );
}

Widget _buildExampleCard(final String text, final Color color) {
  return Container(
    height: 60,
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

IconData _getRowDemoIcon(final String demoType) {
  switch (demoType) {
    case 'Basic Layout':
      return Icons.view_column;
    case 'Responsive Cards':
      return Icons.devices;
    case 'Form Fields':
      return Icons.edit_note;
    case 'Statistics':
      return Icons.analytics;
    case 'Navigation Items':
      return Icons.menu;
    case 'Image Gallery':
      return Icons.photo_library;
    default:
      return Icons.grid_view;
  }
}
