import 'package:flutter/material.dart';
import 'package:ezo/core/layout/pos_design_system.dart'; 

class PosDataForm extends StatelessWidget {
  /// The top-level page title (e.g., "Create Product")
  final String title;
  
  /// The page subtitle
  final String subTitle;
  
  /// The title of the main form card (e.g., "Basic Information")
  final String formTitle;
  
  /// The list of input widgets (TextInputs, Dropdowns) to go inside the grid
  final List<Widget> fields;
  
  /// Any extra widgets to show below the main form (e.g., DataTables, Image Pickers)
  final List<Widget>? extraSections;
  
  /// Navigation callback
  final VoidCallback onBack;
  
  /// Submit action
  final VoidCallback onSubmit;
  
  /// Label for the submit button (Default: "Save")
  final String submitLabel;
  
  /// Show a loading spinner on the button
  final bool isLoading;

  const PosDataForm({
    super.key,
    required this.title,
    required this.subTitle,
    required this.fields,
    required this.onBack,
    required this.onSubmit,
    this.formTitle = "General Information",
    this.submitLabel = "Save",
    this.extraSections,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PosColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive padding logic
          final padding = constraints.maxWidth < 600 ? 12.0 : 
                         constraints.maxWidth < 1024 ? 16.0 : 24.0;
                         
          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              children: [
                // 1. Standard Header
                PosPageHeader(
                  title: title, 
                  subTitle: subTitle,
                  onBack: onBack,
                ),
                
                const SizedBox(height: 24),
                
                // 2. Main Form Card
                PosContentCard(
                  title: formTitle,
                  child: PosFormGrid(
                    children: fields,
                  ),
                ),
                
                // 3. Extra Sections (Optional)
                if (extraSections != null) ...[
                  const SizedBox(height: 24),
                  ...extraSections!,
                ],

                const SizedBox(height: 24),

                // 4. Submit Action Bar
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PosColors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: isLoading 
                      ? const SizedBox(
                          width: 20, height: 20, 
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        )
                      : Text(submitLabel),
                  ),
                ),
                
                const SizedBox(height: 40), // Bottom spacer
              ],
            ),
          );
        },
      ),
    );
  }
}