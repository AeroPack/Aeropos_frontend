import 'package:flutter/material.dart';
import '../layout/pos_design_system.dart';

class DataColumnConfig {
  final String label;
  final int flex;
  final Alignment alignment;

  const DataColumnConfig({
    required this.label,
    this.flex = 1,
    this.alignment = Alignment.centerLeft,
  });
}

class FilterOption<T> {
  final String label;
  final T value;

  const FilterOption({required this.label, required this.value});
}

class DataFilter<T> {
  final String label;
  final List<FilterOption<dynamic>>? options;
  final bool Function(T item, dynamic selectedValue) filter;
  final bool isRangeFilter;
  final double Function(T item)? rangeValueExtractor;

  const DataFilter({
    required this.label,
    this.options,
    required this.filter,
    this.isRangeFilter = false,
    this.rangeValueExtractor,
  }) : assert(
         (isRangeFilter && rangeValueExtractor != null) ||
             (!isRangeFilter && options != null),
         'Range filters must have rangeValueExtractor, dropdown filters must have options',
       );

  // Factory for dropdown filters
  factory DataFilter.dropdown({
    required String label,
    required List<FilterOption<dynamic>> options,
    required bool Function(T item, dynamic selectedValue) filter,
  }) {
    return DataFilter(
      label: label,
      options: options,
      filter: filter,
      isRangeFilter: false,
    );
  }

  // Factory for range slider filters
  factory DataFilter.range({
    required String label,
    required double Function(T item) rangeValueExtractor,
    required bool Function(T item, dynamic selectedValue) filter,
  }) {
    return DataFilter(
      label: label,
      filter: filter,
      isRangeFilter: true,
      rangeValueExtractor: rangeValueExtractor,
    );
  }
}

class GenericDataTable<T> extends StatefulWidget {
  final List<T> data;
  final List<DataColumnConfig> columns;
  final Widget Function(T item, int index) rowBuilder;
  final bool Function(T item, String query)? searchPredicate;
  final List<DataFilter<T>>? filters;
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget? emptyState;
  final bool isLoading;
  final VoidCallback? onRefresh;
  final int? totalItems;
  final int currentPage;
  final int rowsPerPage;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<String>? onSearch;

  const GenericDataTable({
    super.key,
    required this.data,
    required this.columns,
    required this.rowBuilder,
    this.searchPredicate,
    this.filters,
    required this.title,
    this.subtitle,
    this.actions,
    this.emptyState,
    this.isLoading = false,
    this.onRefresh,
    this.totalItems,
    this.currentPage = 1,
    this.rowsPerPage = 20,
    this.onPageChanged,
    this.onSearch,
  });

  @override
  State<GenericDataTable<T>> createState() => _GenericDataTableState<T>();
}

class _GenericDataTableState<T> extends State<GenericDataTable<T>> {
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  final Map<String, dynamic> _activeFilters = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    // If onSearch is provided, we assume data is already filtered/paginated externally.
    // Otherwise, we perform client-side filtering.
    List<T> filteredData;
    if (widget.onSearch != null) {
      filteredData = widget.data;
    } else {
      filteredData = widget.data.where((item) {
        // 1. Apply Search
        bool matchesSearch = true;
        if (_searchQuery.isNotEmpty) {
          matchesSearch =
              widget.searchPredicate?.call(item, _searchQuery) ?? true;
        }
        if (!matchesSearch) return false;

        // 2. Apply Filters
        if (widget.filters != null) {
          for (final filter in widget.filters!) {
            final selectedValue = _activeFilters[filter.label];
            if (selectedValue != null) {
              if (!filter.filter(item, selectedValue)) {
                return false;
              }
            }
          }
        }

        return true;
      }).toList();
    }

    final bool isEmpty = filteredData.isEmpty && !widget.isLoading;
    final bool isTotallyEmpty =
        widget.data.isEmpty && !widget.isLoading && _searchQuery.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTopHeader(
          isMobile,
          showActions: !isTotallyEmpty || widget.actions != null,
        ),
        const SizedBox(height: 24),
        Container(
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
          child: widget.isLoading
              ? const Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(child: CircularProgressIndicator()),
                )
              : Column(
                  children: [
                    if (!isTotallyEmpty || widget.onSearch != null) ...[
                      _buildFilterBar(isMobile),
                      const Divider(height: 1, color: PosColors.border),
                    ],
                    if (isTotallyEmpty && widget.onSearch == null)
                      widget.emptyState ?? _defaultEmptyState()
                    else if (isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(40),
                        child: Center(
                          child: Text("No items found matching your search"),
                        ),
                      )
                    else
                      LayoutBuilder(
                        builder: (context, constraints) {
                          // Allow horizontal scroll on smaller screens
                          final double minTableWidth = 800.0;
                          final double tableWidth =
                              constraints.maxWidth < minTableWidth
                              ? minTableWidth
                              : constraints.maxWidth;

                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              width: tableWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildTableHeader(),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: filteredData.length,
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                          height: 1,
                                          color: PosColors.border,
                                        ),
                                    itemBuilder: (context, index) {
                                      // If purely client side, map index to calculate row number if needed,
                                      // but normally we just pass the item.
                                      return widget.rowBuilder(
                                        filteredData[index],
                                        index,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    if (!isEmpty && !isTotallyEmpty)
                      _buildPaginationFooter(filteredData.length),
                  ],
                ),
        ),
      ],
    );
  }

  // ... (keep _buildTopHeader same)

  Widget _buildFilterBar(bool isMobile) {
    // Only show search field if searchPredicate OR onSearch is provided
    if (widget.searchPredicate == null && widget.onSearch == null)
      return const SizedBox.shrink();

    final searchField = SizedBox(
      height: 45,
      child: TextField(
        controller: _searchController,
        onChanged: (val) {
          setState(() => _searchQuery = val);
          if (widget.onSearch != null) {
            widget.onSearch!(val);
          }
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            size: 20,
            color: PosColors.textLight,
          ),
          hintText: 'Search...',
          hintStyle: const TextStyle(fontSize: 14, color: PosColors.textLight),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 10,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: PosColors.border),
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: PosColors.border),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );

    // ... (keep rest of _buildFilterBar same)
    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchField,
            if (widget.filters != null && widget.filters!.isNotEmpty)
              ...widget.filters!.map(
                (filter) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _buildFilterDropdown(filter),
                ),
              ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(flex: 1, child: searchField),
          const SizedBox(width: 16),
          if (widget.filters != null)
            ...widget.filters!.map(
              (filter) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _buildFilterDropdown(filter),
              ),
            ),
          if (widget.filters == null || widget.filters!.isEmpty)
            const Expanded(flex: 2, child: SizedBox()),
        ],
      ),
    );
  }

  // ... (keep dropdown/range filters same)

  // ... (keep _buildTableHeader same)

  Widget _buildPaginationFooter(int count) {
    if (widget.totalItems != null && widget.onPageChanged != null) {
      // Real Server-Side Pagination
      final totalPages = (widget.totalItems! / widget.rowsPerPage).ceil();
      final startItem = (widget.currentPage - 1) * widget.rowsPerPage + 1;
      final endItem = (startItem + count - 1).clamp(0, widget.totalItems!);

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Showing $startItem - $endItem of ${widget.totalItems} items",
              style: const TextStyle(color: PosColors.textLight, fontSize: 13),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: PosColors.border),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: widget.currentPage > 1
                        ? () => widget.onPageChanged!(widget.currentPage - 1)
                        : null,
                    child: Icon(
                      Icons.chevron_left,
                      size: 20,
                      color: widget.currentPage > 1
                          ? PosColors.textMain
                          : PosColors.textLight,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${widget.currentPage}",
                    style: const TextStyle(
                      color: Colors.white,
                      backgroundColor: PosColors.blue,
                    ),
                  ),
                  // We could show total pages too: Text(" / $totalPages"),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: widget.currentPage < totalPages
                        ? () => widget.onPageChanged!(widget.currentPage + 1)
                        : null,
                    child: Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: widget.currentPage < totalPages
                          ? PosColors.textMain
                          : PosColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Default Mock Pagination (Backward Compatibility)
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Showing $count items",
            style: const TextStyle(color: PosColors.textLight, fontSize: 13),
          ),
          const SizedBox(width: 16),
          // Mock pagination buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: PosColors.border),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: const [
                Icon(Icons.chevron_left, size: 20, color: PosColors.textLight),
                SizedBox(width: 8),
                Text(
                  "1",
                  style: TextStyle(
                    color: Colors.white,
                    backgroundColor: PosColors.blue,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.chevron_right, size: 20, color: PosColors.textLight),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeader(bool isMobile, {bool showActions = true}) {
    final actionRow = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.onRefresh != null) ...[
          _headerIconButton(
            Icons.sync,
            Colors.blue.shade50,
            Colors.blue.shade700,
            onTap: widget.onRefresh,
          ),
          const SizedBox(width: 8),
        ],
        if (showActions && widget.actions != null) ...widget.actions!,
      ],
    );

    final titleSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: PosColors.textMain,
          ),
        ),
        if (widget.subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.subtitle!,
            style: const TextStyle(fontSize: 14, color: PosColors.textLight),
          ),
        ],
      ],
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [titleSection, const SizedBox(height: 16), actionRow],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [titleSection, actionRow],
    );
  }

  Widget _buildFilterDropdown(DataFilter<T> filter) {
    if (filter.isRangeFilter) {
      return _buildRangeFilter(filter);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: PosColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<dynamic>(
          value: _activeFilters[filter.label],
          hint: Text(
            filter.label,
            style: const TextStyle(fontSize: 14, color: PosColors.textLight),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: PosColors.textLight),
          elevation: 2,
          style: const TextStyle(fontSize: 14, color: PosColors.textMain),
          onChanged: (dynamic newValue) {
            setState(() {
              if (newValue == null) {
                _activeFilters.remove(filter.label);
              } else {
                _activeFilters[filter.label] = newValue;
              }
            });
          },
          items: [
            DropdownMenuItem<dynamic>(
              value: null,
              child: Text(
                "All",
                style: const TextStyle(color: PosColors.textLight),
              ),
            ),
            ...filter.options!.map<DropdownMenuItem<dynamic>>((option) {
              return DropdownMenuItem<dynamic>(
                value: option.value,
                child: Text(option.label),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRangeFilter(DataFilter<T> filter) {
    // Calculate min and max from data
    double minValue = double.infinity;
    double maxValue = double.negativeInfinity;

    for (final item in widget.data) {
      final value = filter.rangeValueExtractor!(item);
      if (value < minValue) minValue = value;
      if (value > maxValue) maxValue = value;
    }

    // Handle edge cases
    if (minValue == double.infinity || maxValue == double.negativeInfinity) {
      minValue = 0;
      maxValue = 100;
    }
    if (minValue == maxValue) {
      maxValue = minValue + 1;
    }

    // Get current range or use full range
    final currentRange = _activeFilters[filter.label] as RangeValues?;
    final rangeValues = currentRange ?? RangeValues(minValue, maxValue);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: PosColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                filter.label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: PosColors.textMain,
                ),
              ),
              Text(
                '₹${rangeValues.start.toStringAsFixed(0)} - ₹${rangeValues.end.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: PosColors.textLight,
                ),
              ),
            ],
          ),
          RangeSlider(
            values: rangeValues,
            min: minValue,
            max: maxValue,
            divisions: ((maxValue - minValue) / 10).round().clamp(1, 100),
            activeColor: PosColors.blue,
            inactiveColor: PosColors.border,
            onChanged: (RangeValues values) {
              setState(() {
                _activeFilters[filter.label] = values;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: const Color(0xFFFAFAFA),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: widget.columns.map((col) {
          return Expanded(
            flex: col.flex,
            child: Align(
              alignment: col.alignment,
              child: Text(
                col.label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: PosColors.textMain,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _defaultEmptyState() {
    return const Padding(
      padding: EdgeInsets.all(40),
      child: Center(
        child: Text(
          'No data available',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: PosColors.textMain,
          ),
        ),
      ),
    );
  }

  Widget _headerIconButton(
    IconData icon,
    Color bg,
    Color iconColor, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}
