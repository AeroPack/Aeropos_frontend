import 'package:flutter/material.dart';
import '../../core/di/service_locator.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Text(
              "Overview",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // RESPONSIVE GRID SECTION
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 1; 
                if (constraints.maxWidth > 1200) {
                  crossAxisCount = 4;
                } else if (constraints.maxWidth > 800) {
                  crossAxisCount = 3;
                } else if (constraints.maxWidth > 600) {
                  crossAxisCount = 2;
                }

                double childAspectRatio = constraints.maxWidth > 600 ? 1.5 : 1.2;

                return GridView.count(
                  shrinkWrap: true, 
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: childAspectRatio,
                  children: const [
                    _StatCard(title: "Total Sales", value: "₹45,231", color: Colors.blue),
                    _StatCard(title: "Transactions", value: "128", color: Colors.orange),
                    _StatCard(title: "New Products", value: "12", color: Colors.green),
                    _StatCard(title: "Returns", value: "3", color: Colors.red),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Show confirmation dialog
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Clean Database & Sync'),
              content: const Text(
                'This will delete all local data and sync from the API. Are you sure?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Confirm'),
                ),
              ],
            ),
          );

          if (confirmed == true && context.mounted) {
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );

            try {
              final success = await ServiceLocator.instance.syncService.cleanAndSync();
              
              if (context.mounted) {
                Navigator.pop(context); // Close loading dialog
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success 
                        ? 'Database cleaned and synced successfully!' 
                        : 'Clean and sync failed. Check console for details.',
                    ),
                    backgroundColor: success ? Colors.green : Colors.red,
                  ),
                );
              }
            } catch (e) {
              if (context.mounted) {
                Navigator.pop(context); // Close loading dialog
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          }
        },
        icon: const Icon(Icons.sync),
        label: const Text('Clean & Sync'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

// ... Keep your _StatCard class here ...
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.analytics, color: color),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(title, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}