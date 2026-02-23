import 'package:flutter/material.dart';
import 'package:ezo/core/layout/pos_design_system.dart';

class PosDataTable<T> extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String addNewLabel;
  final VoidCallback onAddNew;
  final ValueChanged<String> onSearchChanged;
  final List<T> data;
  final List<DataColumn> columns;
  final DataRow Function(T) rowBuilder;
  final bool isLoading;

  const PosDataTable({
    super.key,
    required this.title,
    this.subTitle,
    required this.addNewLabel,
    required this.onAddNew,
    required this.onSearchChanged,
    required this.data,
    required this.columns,
    required this.rowBuilder,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: PosColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Filter Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: onSearchChanged,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search, size: 20, color: PosColors.textLight),
                      hintText: 'Search...',
                      border: OutlineInputBorder(borderSide: BorderSide(color: PosColors.border)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: PosColors.border)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: PosColors.blue)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: onAddNew,
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(addNewLabel),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9F43), // Use orange like in product list or use PosColors.blue
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: PosColors.border),
          
          if (isLoading)
             const Padding(padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator()))
          else if (data.isEmpty)
              const Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(child: Text("No records found", style: TextStyle(color: PosColors.textLight))),
              )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                 constraints: const BoxConstraints(minWidth: 800),
                 child: DataTable(
                   columns: columns,
                   rows: data.map((item) => rowBuilder(item)).toList(),
                   headingRowColor: MaterialStateProperty.all(const Color(0xFFFAFAFA)),
                   dataRowColor: MaterialStateProperty.all(Colors.white),
                   headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: PosColors.textMain),
                   dataTextStyle: const TextStyle(color: PosColors.textMain, fontSize: 13),
                   columnSpacing: 24,
                   horizontalMargin: 24,
                 ),
              ),
            ),
        ],
      ),
    );
  }
}
