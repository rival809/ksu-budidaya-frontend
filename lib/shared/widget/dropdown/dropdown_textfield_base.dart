import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:searchfield/searchfield.dart';

class DropdownTextfieldBase extends StatefulWidget {
  final List<String> items;
  final String? label;
  final bool? require;
  final String? Function(String?)? validator;
  final String hint;
  final String? value;
  final bool? useBorder;
  final bool? enabled;
  final bool? isExpand;
  final Function(String? value)? onSubmit;
  final Function(SearchFieldListItem<String>)? onItemTap;
  final TextEditingController textController;

  const DropdownTextfieldBase({
    Key? key,
    required this.items,
    this.label,
    this.require,
    required this.hint,
    this.useBorder,
    required this.value,
    this.enabled,
    this.validator,
    this.isExpand,
    required this.textController,
    this.onSubmit,
    this.onItemTap,
  }) : super(key: key);

  @override
  State<DropdownTextfieldBase> createState() => _DropdownTextfieldBase();
}

class _DropdownTextfieldBase extends State<DropdownTextfieldBase> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(
          height: 2.0,
        ),
        SearchField(
          enabled: widget.enabled,
          suggestionDirection: SuggestionDirection.flex,
          onSearchTextChanged: (query) {
            final filter = widget.items
                .where((element) =>
                    element.toLowerCase().contains(query.toLowerCase()))
                .toList();
            return filter
                .map((e) => SearchFieldListItem<String>(e,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 12),
                      child: Text(e,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black)),
                    )))
                .toList();
          },
          onSubmit: widget.onSubmit,
          onSuggestionTap: widget.onItemTap,
          controller: widget.textController,
          initialValue: trimString(widget.value).isEmpty
              ? null
              : SearchFieldListItem<String>(trimString(widget.value)),
          validator: widget.validator,
          hint: widget.hint,
          itemHeight: 50,
          scrollbarDecoration: ScrollbarDecoration(
            thickness: 12,
            radius: const Radius.circular(6),
            trackColor: gray50,
            trackBorderColor: red500,
            thumbColor: yellow500,
          ),
          suggestionStyle: myTextTheme.bodyMedium,
          searchStyle: myTextTheme.bodyMedium,
          suggestionItemDecoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: blueGray50,
                width: 1,
              ),
            ),
          ),
          searchInputDecoration: InputDecoration(
            filled: true,
            fillColor: widget.enabled ?? true
                ? neutralWhite
                : widget.useBorder == false
                    ? neutralWhite
                    : gray200,
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
          suggestionsDecoration: SuggestionDecoration(
            selectionColor: neutralWhite,
            hoverColor: gray200,
            color: neutralWhite,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          suggestions: widget.items
              .map((e) => SearchFieldListItem<String>(e,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 12),
                    child: Text(e,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black)),
                  )))
              .toList(),
        )
      ],
    );
  }
}
