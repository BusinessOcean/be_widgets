import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';

class DashboardExample extends StatelessWidget {
  const DashboardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BeWidgets Dashboard Example')),
      body: BeContainer(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BeLabel(
              label: null,
              position: BeLabelPosition.topLeft,
              child: Text(
                'Welcome to Your Dashboard',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.blueAccent),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                BeBadge(
                  badge: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('New',
                        style: TextStyle(color: Colors.white)),
                  ),
                  position: BeBadgePosition.topRight,
                  child: const Icon(Icons.dashboard, size: 32),
                ),
                const SizedBox(width: 24),
                BeBadge(
                  badge: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('Sale',
                        style: TextStyle(color: Colors.white)),
                  ),
                  position: BeBadgePosition.topRight,
                  child: const Icon(Icons.shopping_cart, size: 32),
                ),
                const SizedBox(width: 24),
                BeBadge(
                  badge: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('Featured',
                        style: TextStyle(color: Colors.white)),
                  ),
                  position: BeBadgePosition.topRight,
                  child: const Icon(Icons.star, size: 32),
                ),
              ],
            ),
            const SizedBox(height: 24),
            BeWrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                BeContainer(
                  padding: const EdgeInsets.all(16),
                  child: BeLabel(
                    label: null,
                    position: BeLabelPosition.topLeft,
                    child: Text('Analytics',
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                ),
                BeContainer(
                  padding: const EdgeInsets.all(16),
                  child: BeLabel(
                    label: null,
                    position: BeLabelPosition.topLeft,
                    child: Text('Reports',
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                ),
                BeContainer(
                  padding: const EdgeInsets.all(16),
                  child: BeLabel(
                    label: null,
                    position: BeLabelPosition.topLeft,
                    child: Text('Settings',
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const BeTextMore(
              text:
                  'This dashboard uses BeWidgets for layout, badges, and labels. '
                  'Try resizing the window or switching devices to see responsive behavior.',
              trimLines: 2,
              trimMode: TrimMode.line,
              trimExpandedText: 'Show less',
              trimCollapsedText: 'Show more',
            ),
          ],
        ),
      ),
    );
  }
}
