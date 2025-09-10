import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'BeBadge', path: '/', type: BeBadge)
Widget renderBeBadgeWidget(final BuildContext context) {
  final BeBadgePosition position = context.knobs.object
      .dropdown(label: 'Position', options: BeBadgePosition.values);
  final icon = context.knobs.object.dropdown(
    label: 'Icon',
    options: [
      Icons.not_accessible,
      Icons.troubleshoot,
      Icons.abc,
      Icons.align_vertical_bottom
    ],
  );
  final rounded = context.knobs.boolean(label: 'Rounded', initialValue: false);
  final offsetX = context.knobs.double
      .slider(label: 'Offset X', initialValue: 0, min: -20, max: 20);
  final offsetY = context.knobs.double
      .slider(label: 'Offset Y', initialValue: 0, min: -20, max: 20);

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('BeBadge Examples:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),

          // Main customizable example
          Center(
            child: BeBadge(
              position: position,
              rounded: rounded,
              offset: Offset(offsetX, offsetY),
              badge: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(rounded ? 12 : 4)),
                child: Icon(icon, color: Colors.white, size: 16),
              ),
              child: const SizedBox(
                width: 120,
                height: 80,
                child: Card(
                  child: Center(
                      child: Text('Interactive Demo',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Practical examples grid
          const Text('Practical Use Cases:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              // Notification badge
              BeBadge(
                position: BeBadgePosition.topRight,
                rounded: true,
                badge: _buildNotificationBadge('12'),
                child: _buildIconContainer(Icons.person, Colors.blue),
              ),

              // Shopping cart with item count
              BeBadge(
                position: BeBadgePosition.topRight,
                rounded: true,
                badge: _buildCountBadge('3'),
                child: _buildIconContainer(Icons.shopping_cart, Colors.green),
              ),

              // Profile with online status
              BeBadge(
                position: BeBadgePosition.bottomRight,
                rounded: true,
                badge: _buildStatusBadge(Colors.green),
                child: _buildProfileAvatar(),
              ),

              // Message with unread indicator
              BeBadge(
                position: BeBadgePosition.topRight,
                rounded: true,
                badge: _buildUnreadBadge(),
                child: _buildIconContainer(Icons.message, Colors.purple),
              ),

              // Product with discount badge
              BeBadge(
                position: BeBadgePosition.topLeft,
                rounded: false,
                badge: _buildDiscountBadge('20% OFF'),
                child: _buildProductCard(),
              ),

              // App with update badge
              BeBadge(
                position: BeBadgePosition.topRight,
                rounded: true,
                badge: _buildUpdateBadge(),
                child: _buildAppIcon(),
              ),

              // Document with priority marker
              BeBadge(
                position: BeBadgePosition.topRight,
                rounded: false,
                badge: _buildPriorityBadge(),
                child: _buildDocumentIcon(),
              ),

              // Event with live indicator
              BeBadge(
                position: BeBadgePosition.topLeft,
                rounded: false,
                badge: _buildLiveBadge(),
                child: _buildEventCard(),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Position demonstration
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('All Badge Positions:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: BeBadgePosition.values.map((final pos) {
                      return BeBadge(
                        position: pos,
                        badge: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPositionColor(pos),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _getPositionName(pos),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              _getPositionAbbreviation(pos),
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          const Text('Use Cases:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            '• Notification counters on icons and buttons\n'
            '• Shopping cart item indicators\n'
            '• User status indicators (online, offline, busy)\n'
            '• Unread message notifications\n'
            '• Product discount and promotion badges\n'
            '• App update and version indicators\n'
            '• Priority markers on documents\n'
            '• Live status indicators for events',
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 16),
          const Text('Benefits:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            '• Clean way to add contextual information\n'
            '• Flexible positioning around any widget\n'
            '• Customizable appearance and styling\n'
            '• Perfect for UI polish and user feedback\n'
            '• Maintains focus on main content\n'
            '• Responsive to parent widget changes',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    ),
  );
}

Widget _buildNotificationBadge(final String count) {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    child: Text(count,
        style: const TextStyle(
            color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
  );
}

Widget _buildCountBadge(final String count) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
        color: Colors.orange, borderRadius: BorderRadius.circular(8)),
    child: Text(count,
        style: const TextStyle(
            color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
  );
}

Widget _buildStatusBadge(final Color color) {
  return Container(
    width: 12,
    height: 12,
    decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2)),
  );
}

Widget _buildUnreadBadge() {
  return Container(
      width: 10,
      height: 10,
      decoration:
          const BoxDecoration(color: Colors.red, shape: BoxShape.circle));
}

Widget _buildDiscountBadge(final String discount) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
        color: Colors.red, borderRadius: BorderRadius.circular(4)),
    child: Text(discount,
        style: const TextStyle(
            color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
  );
}

Widget _buildUpdateBadge() {
  return Container(
    width: 16,
    height: 16,
    decoration:
        const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
    child: const Center(
        child: Icon(Icons.download, color: Colors.white, size: 10)),
  );
}

Widget _buildPriorityBadge() {
  return Container(
    padding: const EdgeInsets.all(2),
    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    child: const Icon(Icons.priority_high, color: Colors.white, size: 12),
  );
}

Widget _buildLiveBadge() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    decoration: BoxDecoration(
        color: Colors.red, borderRadius: BorderRadius.circular(4)),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, color: Colors.white, size: 6),
        SizedBox(width: 2),
        Text('LIVE',
            style: TextStyle(
                color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Widget _buildIconContainer(final IconData icon, final Color color) {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1 * 255),
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Icon(icon, color: color, size: 24),
  );
}

Widget _buildProfileAvatar() {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.blue.shade100,
      shape: BoxShape.circle,
      image: const DecorationImage(
          image: NetworkImage('https://picsum.photos/50/50?random=1'),
          fit: BoxFit.cover),
    ),
  );
}

Widget _buildProductCard() {
  return Container(
    width: 80,
    height: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withValues(alpha: 0.1 * 255),
            blurRadius: 4,
            offset: const Offset(0, 2)),
      ],
    ),
    child: Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child:
                const Center(child: Icon(Icons.headphones, color: Colors.grey)),
          ),
        ),
        const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Headphones', style: TextStyle(fontSize: 10))),
      ],
    ),
  );
}

Widget _buildAppIcon() {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade400, Colors.blue.shade600],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Center(child: Icon(Icons.apps, color: Colors.white, size: 24)),
  );
}

Widget _buildDocumentIcon() {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Icon(Icons.description, color: Colors.grey, size: 24),
  );
}

Widget _buildEventCard() {
  return Container(
    width: 80,
    height: 60,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade300, Colors.blue.shade300],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event, color: Colors.white, size: 20),
          Text('Event', style: TextStyle(color: Colors.white, fontSize: 8)),
        ],
      ),
    ),
  );
}

Color _getPositionColor(final BeBadgePosition position) {
  final colors = {
    BeBadgePosition.topLeft: Colors.red,
    BeBadgePosition.topCenter: Colors.orange,
    BeBadgePosition.topRight: Colors.yellow.shade700,
    BeBadgePosition.centerLeft: Colors.green,
    BeBadgePosition.center: Colors.teal,
    BeBadgePosition.centerRight: Colors.blue,
    BeBadgePosition.bottomLeft: Colors.indigo,
    BeBadgePosition.bottomCenter: Colors.purple,
    BeBadgePosition.bottomRight: Colors.pink,
  };
  return colors[position] ?? Colors.grey;
}

String _getPositionName(final BeBadgePosition position) {
  return position.name;
}

String _getPositionAbbreviation(final BeBadgePosition position) {
  final abbreviations = {
    BeBadgePosition.topLeft: 'TL',
    BeBadgePosition.topCenter: 'TC',
    BeBadgePosition.topRight: 'TR',
    BeBadgePosition.centerLeft: 'CL',
    BeBadgePosition.center: 'C',
    BeBadgePosition.centerRight: 'CR',
    BeBadgePosition.bottomLeft: 'BL',
    BeBadgePosition.bottomCenter: 'BC',
    BeBadgePosition.bottomRight: 'BR',
  };
  return abbreviations[position] ?? '??';
}
