import 'package:flutter/material.dart';


// lib/core/widgets/responsive_data_view.dart
class ResponsiveDataView extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final Widget Function(int index) mobileItemBuilder; // How it looks on mobile

  const ResponsiveDataView({
     required this.columns,
     required this.rows,
     required this.mobileItemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    // If width < 600, show list. If > 600, show table.
    // Written ONCE, used on 50+ different pages.
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return ListView.builder(
            itemBuilder: (context, index) => mobileItemBuilder(index),
          );
        } else {
          return SingleChildScrollView(
            child: DataTable(columns: columns, rows: rows),
          );
        }
      },
    );
  }
}