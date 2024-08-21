import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DropdownSearchFilter extends StatefulWidget {
  final List<String> items;
  final String? label;
  final bool? require;
  final bool? isSearch;
  final String? Function(String?)? validator;
  final String hint;
  final String? value;
  final bool? useBorder;
  final bool? enabled;
  final bool? isExpand;
  final Function(String? value) onChanged;
  final Function()? onClear;

  const DropdownSearchFilter(
      {Key? key,
      required this.items,
      this.label,
      this.require,
      required this.hint,
      this.useBorder,
      required this.value,
      this.enabled,
      required this.onChanged,
      this.isSearch,
      this.validator,
      this.onClear,
      this.isExpand})
      : super(key: key);

  @override
  State<DropdownSearchFilter> createState() => _DropdownSearchFilter();
}

class _DropdownSearchFilter extends State<DropdownSearchFilter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        trimString(widget.label).isNotEmpty
            ? widget.require ?? false
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        text: trimString(widget.label),
                        style: myTextTheme.labelLarge?.copyWith(
                          color: gray900,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' *',
                            style: myTextTheme.labelLarge?.copyWith(
                              color: red600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      trimString(widget.label),
                      style: myTextTheme.labelLarge?.copyWith(color: gray900),
                    ),
                  )
            : Container(),
        trimString(widget.label).isNotEmpty
            ? const SizedBox(
                height: 2.0,
              )
            : Container(),
        DropdownSearch(
          validator: widget.enabled ?? true ? widget.validator : null,
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
            baseStyle: myTextTheme.bodyMedium
                ?.copyWith(color: widget.enabled ?? true ? gray900 : gray600),
            dropdownSearchDecoration: InputDecoration(
              constraints: const BoxConstraints(minHeight: 40, maxHeight: 46),
              filled: true,
              fillColor: widget.enabled ?? true
                  ? neutralWhite
                  : widget.useBorder == false
                      ? neutralWhite
                      : gray300,
              hintText: widget.hint,
              hintStyle: myTextTheme.bodyMedium?.copyWith(
                color: gray600,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 16.5,
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: red500, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: yellow600, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.useBorder ?? true ? gray300 : neutralWhite,
                    width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: red500, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.useBorder ?? true ? gray300 : neutralWhite,
                    width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.useBorder ?? true ? gray300 : neutralWhite,
                    width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              isDense: true,
            ),
          ),
          dropdownButtonProps: DropdownButtonProps(
            icon: SvgPicture.asset(
              "assets/icons/input/chevron_down.svg",
              color: widget.enabled ?? true ? yellow600 : gray600,
            ),
          ),
          onChanged: widget.enabled ?? true ? widget.onChanged : null,
          selectedItem: widget.value,
          popupProps: PopupProps.menu(
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
            searchDelay: const Duration(seconds: 0),
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
                // prefixIcon: Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 12),
                //   child: SvgPicture.asset(
                //     "assets/icons/misc/search.svg",
                //     height: 24,
                //     width: 24,
                //     color: gray400,
                //   ),
                // ),

                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: red500, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: yellow600, width: 1),
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
