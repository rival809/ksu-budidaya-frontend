import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ColumnSelectorDropdown extends StatefulWidget {
  final List<ColumnOption> availableColumns;
  final ValueNotifier<List<String>> selectedColumnsNotifier;
  final Function(List<String>) onSelectionChanged;

  const ColumnSelectorDropdown({
    super.key,
    required this.availableColumns,
    required this.selectedColumnsNotifier,
    required this.onSelectionChanged,
  });

  @override
  State<ColumnSelectorDropdown> createState() => _ColumnSelectorDropdownState();
}

class _ColumnSelectorDropdownState extends State<ColumnSelectorDropdown> {
  bool isOpen = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  void _toggleDropdown() {
    if (isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      isOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    setState(() {
      isOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _closeDropdown,
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                width: 300,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: Offset(0.0, size.height + 5.0),
                  child: GestureDetector(
                    onTap: () {}, // Prevent closing when tapping inside dropdown
                    child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 300),
                        decoration: BoxDecoration(
                          color: neutralWhite,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: blueGray50),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: const BoxDecoration(
                                color: gray50,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pilih Kolom',
                                    style: myTextTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: _selectAll,
                                        child: Text(
                                          'Pilih Semua',
                                          style: myTextTheme.bodySmall?.copyWith(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text('|', style: myTextTheme.bodySmall),
                                      const SizedBox(width: 8),
                                      InkWell(
                                        onTap: _deselectAll,
                                        child: Text(
                                          'Hapus Semua',
                                          style: myTextTheme.bodySmall?.copyWith(
                                            color: red600,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: ValueListenableBuilder<List<String>>(
                                valueListenable: widget.selectedColumnsNotifier,
                                builder: (context, selectedColumns, child) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: widget.availableColumns.length,
                                    itemBuilder: (context, index) {
                                      final column = widget.availableColumns[index];
                                      final isSelected = selectedColumns.contains(column.field);

                                      return InkWell(
                                        onTap: () => _toggleColumn(column.field),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0,
                                            vertical: 8.0,
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 20.0,
                                                width: 20.0,
                                                child: Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(4.0),
                                                  ),
                                                  value: isSelected,
                                                  onChanged: (_) => _toggleColumn(column.field),
                                                  activeColor: primaryColor,
                                                ),
                                              ),
                                              const SizedBox(width: 12.0),
                                              Expanded(
                                                child: Text(
                                                  column.displayName,
                                                  style: myTextTheme.bodyMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleColumn(String columnField) {
    List<String> newSelection = List.from(widget.selectedColumnsNotifier.value);

    if (newSelection.contains(columnField)) {
      // Prevent removing all columns - keep at least one
      if (newSelection.length > 1) {
        newSelection.remove(columnField);
      }
    } else {
      newSelection.add(columnField);
    }

    // Notify parent widget immediately - ValueNotifier will handle UI updates
    widget.onSelectionChanged(newSelection);
  }

  void _selectAll() {
    List<String> allColumns = widget.availableColumns.map((e) => e.field).toList();
    widget.onSelectionChanged(allColumns);
  }

  void _deselectAll() {
    // Keep at least one column selected (first available column)
    List<String> minimalSelection =
        widget.availableColumns.isNotEmpty ? [widget.availableColumns.first.field] : [];

    widget.onSelectionChanged(minimalSelection);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: ValueListenableBuilder<List<String>>(
        valueListenable: widget.selectedColumnsNotifier,
        builder: (context, selectedColumns, child) {
          return BaseSecondaryButton(
            onPressed: _toggleDropdown,
            text: "Kolom (${selectedColumns.length})",
            suffixIcon: isOpen ? iconArrowDropUp : iconArrowDropDown,
            isDense: true,
          );
        },
      ),
    );
  }
}

class ColumnOption {
  final String field;
  final String displayName;

  ColumnOption({
    required this.field,
    required this.displayName,
  });
}
