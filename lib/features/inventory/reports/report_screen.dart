import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if we are on mobile
    final isMobile = MediaQuery.of(context).size.width <= 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Report", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        leading: isMobile
            ? IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              )
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Overview",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

             LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 2; 
                if (constraints.maxWidth > 1100) crossAxisCount = 4;
                else if (constraints.maxWidth > 600) crossAxisCount = 3; 

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
    );
  }
}

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