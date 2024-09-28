import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class SimpleDropdownButton extends StatefulWidget {
  final List<String> items;
  final String? label;
  final bool? require;
  final bool? isSearch;
  final String? helperMessage;
  final String? Function(String?)? validator;
  final String? hint;
  final String? value;
  final bool? useBorder;
  final bool? enabled;
  final bool? isExpand;
  final Function(String? value) onChanged;
  final Function()? onClear;
  final AutovalidateMode? autoValidate;

  const SimpleDropdownButton({
    Key? key,
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
    this.autoValidate,
    this.isExpand,
  }) : super(key: key);

  @override
  State<SimpleDropdownButton> createState() => _SimpleDropdownButtonState();
}

class _SimpleDropdownButtonState extends State<SimpleDropdownButton> {
  TextEditingController textController = TextEditingController();
  final ValueNotifier<bool> _isValid = ValueNotifier<bool>(true);
  @override
  void initState() {
    super.initState();
    textController.text = widget.value ?? '';
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

  @override
  Widget build(BuildContext context) {
    return Column(
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
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
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
            }),
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
        const SizedBox(
          height: 2.0,
        ),
        DropdownSearch(
          validator: widget.enabled ?? true
              ? (value) {
                  final error = widget.validator?.call(value.toString());
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final isValid = error == null;
                    if (_isValid.value != isValid) {
                      _isValid.value = isValid;
                    }
                  });
                  return error;
                }
              : null,
          items: widget.items,
          enabled: widget.enabled ?? true,
          clearButtonProps: ClearButtonProps(
            isVisible: widget.onClear != null ? true : false,
            color: red400,
            icon: const Icon(
              Icons.close,
            ),
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
                vertical: 18,
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
          dropdownButtonProps: DropdownButtonProps(
            tooltip: "Pilih ${widget.label}",
            icon: SvgPicture.asset(
              iconChevronDown,
              colorFilter: widget.enabled ?? true
                  ? colorFilterPrimary
                  : colorFilterGray600,
            ),
          ),
          onChanged: widget.enabled ?? true ? widget.onChanged : null,
          selectedItem: widget.value,
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
            itemBuilder: (BuildContext context, String item, bool isSelected) {
              return Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  item,
                  textAlign: TextAlign.left,
                  style: myTextTheme.bodyMedium?.copyWith(color: gray600),
                ),
              );
            },
            showSearchBox: widget.isSearch ?? true,
            searchDelay: const Duration(milliseconds: 250),
            menuProps: const MenuProps(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  side: BorderSide(
                    color: blueGray50,
                  )),
            ),
            scrollbarProps: const ScrollbarProps(),
            searchFieldProps: TextFieldProps(
              autofocus: true,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: myTextTheme.bodyMedium?.copyWith(
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
                  borderSide: BorderSide(color: red500, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryGreen, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: gray300, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: red500, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: gray300, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
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
