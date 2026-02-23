import 'package:flutter/material.dart';

class PosColors {
  static const Color background = Color(0xFFF5F7FA); // Light Grey Background
  static const Color surface = Color(0xFFFFFFFF); // White Surfaces
  static const Color navy = Color(0xFF0F172A); // Dark Navy
  static const Color blue = Color(0xFF2563EB); // Primary Blue
  static const Color textMain = Color(0xFF1E293B); // Dark Slate Text
  static const Color textMuted = Color(0xFF64748B); // Grey Text
  static const Color border = Color(0xFF94A3B8); // Darker Border (More Visible)
  static const Color textLight = Color(
    0xFF64748B,
  ); // Grey Text (For compatibility)
}
// --- B. REUSABLE INPUT WIDGETS ---

// 1. Base Label Wrapper (Puts label above child)
class _LabeledWrapper extends StatelessWidget {
  final String label;
  final bool isRequired;
  final Widget? extraAction;
  final Widget child;

  const _LabeledWrapper({
    required this.label,
    required this.child,
    this.isRequired = false,
    this.extraAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: PosColors.textMain,
                  fontSize: 14,
                ),
                children: [
                  if (isRequired)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
            if (extraAction != null) extraAction!,
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

// 2. Standard Text Input
class PosTextInput extends StatelessWidget {
  final String label;
  final String? placeholder;
  final TextEditingController? controller;
  final bool isRequired;
  final bool isPassword;
  final Widget? suffix;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  const PosTextInput({
    super.key,
    required this.label,
    this.controller,
    this.placeholder,
    this.isRequired = false,
    this.isPassword = false,
    this.suffix,
    this.maxLines = 1,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _LabeledWrapper(
      label: label,
      isRequired: isRequired,
      child: TextFormField(
        obscureText: isPassword,
        controller: controller,
        maxLines: isPassword ? 1 : maxLines,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: const TextStyle(color: PosColors.textLight, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: PosColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: PosColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: PosColors.blue),
          ),
          suffixIcon: suffix,
        ),
      ),
    );
  }
}

// 3. Standard Dropdown
class PosDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final bool isRequired;
  final Widget? extraLabelWidget;
  final String? hint;

  const PosDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.hint = "Select",
    this.isRequired = false,
    this.extraLabelWidget,
  });

  @override
  Widget build(BuildContext context) {
    return _LabeledWrapper(
      label: label,
      isRequired: isRequired,
      extraAction: extraLabelWidget,
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: PosColors.textLight, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: PosColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: PosColors.border),
          ),
        ),
        icon: const Icon(Icons.keyboard_arrow_down, color: PosColors.textLight),
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}

// --- C. LAYOUT WIDGETS ---

// 1. The White Content Card
class PosContentCard extends StatelessWidget {
  final String title;
  final Widget child;

  const PosContentCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 252, 252, 252),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, color: PosColors.blue, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Divider(height: 32, color: PosColors.border),
          child,
        ],
      ),
    );
  }
}

// 2. Page Header (Title + Back Button)
class PosPageHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onBack;

  const PosPageHeader({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: PosColors.textMain,
              ),
            ),
            const SizedBox(height: 4),
            Text(subTitle, style: const TextStyle(color: PosColors.textLight)),
          ],
        ),
        ElevatedButton.icon(
          onPressed: onBack,
          style: ElevatedButton.styleFrom(
            backgroundColor: PosColors.navy,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(Icons.arrow_back, size: 18),
          label: const Text("Back"),
        ),
      ],
    );
  }
}

// 3. Responsive Grid Helper (Auto-generates rows)
class PosFormGrid extends StatelessWidget {
  final List<Widget> children;

  const PosFormGrid({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    if (!isDesktop) {
      // Mobile: Simple column with spacing
      return Column(
        children: (children)
            .map(
              (c) =>
                  Padding(padding: const EdgeInsets.only(bottom: 16), child: c),
            )
            .toList(),
      );
    }

    // Desktop: Chunk list into pairs
    List<Widget> rows = [];
    for (var i = 0; i < children.length; i += 2) {
      Widget left = children[i];
      Widget? right = (i + 1 < children.length) ? children[i + 1] : null;

      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: left),
              const SizedBox(width: 24), // Gap
              Expanded(
                child: right ?? const SizedBox(),
              ), // Empty box if odd number
            ],
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}
