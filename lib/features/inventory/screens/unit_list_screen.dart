import 'package:flutter/material.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/models/unit.dart';

class UnitListScreen extends StatelessWidget {
  const UnitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = ServiceLocator.instance.unitRepository;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Units'),
      ),
      body: StreamBuilder<List<Unit>>(
        stream: repository.watchAllUnits(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final units = snapshot.data ?? [];

          if (units.isEmpty) {
            return const Center(child: Text('No units found'));
          }

          return ListView.builder(
            itemCount: units.length,
            itemBuilder: (context, index) {
              final unit = units[index];
              return ListTile(
                title: Text(unit.name),
                subtitle: Text('Symbol: ${unit.symbol}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to unit form
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
