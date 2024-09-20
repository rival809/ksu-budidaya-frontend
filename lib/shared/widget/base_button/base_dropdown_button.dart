import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class BaseDropdownButton<T> extends StatefulWidget {
  final String Function(T) itemAsString;
  final List<T> items;
  final String? label;
  final String? helperMessage;
  final bool? require;
  final bool? isSearch;
  final String? Function(String?)? validator;
  final String? hint;
  final T? value;
  final bool? useBorder;
  final bool? enabled;
  final bool? isExpand;
  final void Function(T?)? onChanged;
  final Function()? onClear;
  final AutovalidateMode? autoValidate;

  const BaseDropdownButton({
    super.key,
    required this.itemAsString,
    required this.items,
    this.label,
    this.helperMessage,
    this.require,
    this.hint,
    this.useBorder,
    required this.value,
    this.enabled,
    required this.onChanged,
    this.isSearch,
    this.validator,
    this.onClear,
    this.isExpand,
    this.autoValidate,
  });

  @override
  State<BaseDropdownButton<T>> createState() => _BaseDropdownButtonState<T>();
}

class _BaseDropdownButtonState<T> extends State<BaseDropdownButton<T>> {
  TextEditingController textController = TextEditingController();
  final ValueNotifier<bool> _isValid = ValueNotifier<bool>(true);
  List<T> sortedItems = [];
  @override
  void initState() {
    super.initState();
    sortedItems = widget.items;
    sortedItems.sort(
        (a, b) => widget.itemAsString(a).compareTo(widget.itemAsString(b)));

    textController.text = widget.value.toString();
    selectedItem = widget.value;
    textController.addListener(_validateInput);
  }

  void _validateInput() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.validator != null) {
        final isValid = widget.validator!(textController.text) == null;
        if (_isValid.value != isValid) {
          _isValid.value = isValid;
        }
      }
    });
  }

  @override
  void dispose() {
    textController.removeListener(_validateInput);
    _isValid.dispose();
    textController.dispose();
    super.dispose();
  }

  T? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: _isValid,
          builder: (context, isValid, child) {
            return widget.label != null && widget.label!.isNotEmpty
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        text: widget.label,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: isValid ? gray900 : error,
                            ),
                        children: [
                          if (widget.require ?? false)
                            TextSpan(
                              text: ' *',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: error,
                                  ),
                            ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
        if (widget.helperMessage != null && widget.helperMessage!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              widget.helperMessage!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: gray500,
                    height: 1.8,
                  ),
              textHeightBehavior: const TextHeightBehavior(
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ),
        DropdownSearch<T>(
          items: sortedItems,
          itemAsString: widget.itemAsString,
          selectedItem: selectedItem,
          enabled: widget.enabled ?? true,
          autoValidateMode: widget.autoValidate,
          validator: widget.enabled ?? true
              ? (value) {
                  final error = widget.validator?.call(value?.toString());
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _isValid.value = error == null;
                  });
                  return error;
                }
              : null,
          onChanged: (T? data) {
            setState(() {
              selectedItem = data;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(data);
            }
          },
          clearButtonProps: ClearButtonProps(
            isVisible: widget.onClear != null,
            onPressed: widget.onClear,
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: widget.enabled ?? true ? gray900 : gray600,
                ),
            dropdownSearchDecoration: InputDecoration(
              hintMaxLines: 1,
              helperMaxLines: 1,
              errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: error,
                  ),
              errorMaxLines: 1,
              hintText: widget.hint,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: gray600,
                  ),
              filled: true,
              hoverColor: gray200,
              fillColor: widget.enabled ?? true ? neutralWhite : gray200,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 16.5,
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: error, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.useBorder ?? true ? gray300 : neutralWhite,
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: error, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.useBorder ?? true ? gray300 : neutralWhite,
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.useBorder ?? true ? gray300 : neutralWhite,
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              isDense: true,
            ),
          ),
          dropdownBuilder: (context, selectedItem) {
            return selectedItem == null
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.enabled ?? true ? trimString(widget.hint) : '-',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: gray600,
                            height: 1.25,
                          ),
                      textHeightBehavior: const TextHeightBehavior(
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                      softWrap: false,
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.itemAsString(selectedItem),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: gray900,
                            height: 1.25,
                          ),
                      textHeightBehavior: const TextHeightBehavior(
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                      softWrap: false,
                    ),
                  );
          },
          dropdownButtonProps: DropdownButtonProps(
            tooltip: "Pilih ${widget.label}",
            icon: SvgPicture.asset(
              iconChevronDown,
              colorFilter: widget.enabled ?? true
                  ? colorFilterPrimary
                  : colorFilterGray600,
            ),
          ),
          popupProps: PopupProps.menu(
            emptyBuilder: (context, searchEntry) {
              return SingleChildScrollView(
                controller: ScrollController(),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Tidak ada data"),
                  ),
                ),
              );
            },
            fit: FlexFit.loose,
            listViewProps: const ListViewProps(
              itemExtent: 32,
            ),
            itemBuilder: (BuildContext context, T item, bool isSelected) {
              return Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  widget.itemAsString(item),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: gray900,
                      ),
                ),
              );
            },
            showSearchBox: widget.isSearch ?? true,
            searchDelay: const Duration(milliseconds: 250),
            menuProps: const MenuProps(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                side: BorderSide(color: blueGray50),
              ),
            ),
            scrollbarProps: const ScrollbarProps(),
            searchFieldProps: TextFieldProps(
              autofocus: true,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: gray600,
                    ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SvgPicture.asset(
                    iconSearch,
                    height: 24,
                    width: 24,
                    colorFilter: colorFilterPrimary,
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  maxWidth: 50,
                  maxHeight: 50,
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: error, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.useBorder ?? true ? gray300 : neutralWhite,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: error, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.useBorder ?? true ? gray300 : neutralWhite,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.useBorder ?? true ? gray300 : neutralWhite,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
