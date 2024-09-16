// ignore_for_file: camel_case_types
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class FooterTableWidget extends StatefulWidget {
  final String? itemPerpage;
  final String? page;
  final Function(String?)? onChangePerPage;
  final Function(String?)? onChangePage;
  final int? totalRow;
  final int? maxPage;
  final Function()? onPressLeft;
  final Function()? onPressRight;
  const FooterTableWidget({
    Key? key,
    required this.itemPerpage,
    required this.page,
    required this.onChangePerPage,
    required this.onChangePage,
    required this.totalRow,
    required this.maxPage,
    required this.onPressLeft,
    required this.onPressRight,
  }) : super(key: key);

  @override
  State<FooterTableWidget> createState() => _FooterTableWidgetState();
}

class _FooterTableWidgetState extends State<FooterTableWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      child: Container(
        height: 45,
        decoration: const BoxDecoration(
          color: gray50,
          border: Border(
            top: BorderSide(
              color: primaryColor,
            ),
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Tampilkan",
                      style: myTextTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    SizedBox(
                      width: 100,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: false,
                          items: ["10", "25", "50", "75", "100"]
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: myTextTheme.bodyMedium?.copyWith(
                                        color: gray900,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value:
                              trimString(widget.itemPerpage).toString().isEmpty
                                  ? "10"
                                  : trimString(widget.itemPerpage),
                          onChanged: widget.onChangePerPage,
                          iconStyleData: IconStyleData(
                            iconEnabledColor: primaryColor,
                            icon: SvgPicture.asset(
                              iconChevronDown,
                              colorFilter: colorFilter(color: primaryColor),
                            ),
                          ),
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            width: 140,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Item",
                      style: myTextTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "dari total ",
                        style: myTextTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: trimStringStrip(widget.totalRow.toString()),
                            style: myTextTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Halaman",
                      style: myTextTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    SizedBox(
                      width: 100,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: false,
                          items: getPageList(
                                  trimString((widget.maxPage ?? 0).toString()))
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: myTextTheme.bodyMedium?.copyWith(
                                        color: gray900,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: widget.page,
                          onChanged: widget.onChangePage,
                          iconStyleData: IconStyleData(
                            iconEnabledColor: yellow600,
                            icon: SvgPicture.asset(
                              iconChevronDown,
                              colorFilter: colorFilter(color: primaryColor),
                            ),
                          ),
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            width: 140,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "dari ",
                        style: myTextTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: trimStringStrip(
                                (widget.maxPage ?? 0).toString()),
                            style: myTextTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: widget.onPressLeft,
                      icon: SvgPicture.asset(
                        iconChevronLeft,
                        colorFilter: ((widget.maxPage ?? 0) >
                                    (int.tryParse(widget.page ?? "0") ?? 0) &&
                                (int.tryParse(widget.page ?? "0") != 1))
                            ? colorFilter(color: primaryColor)
                            : colorFilter(color: gray300),
                      ),
                    ),
                    IconButton(
                      onPressed: widget.onPressRight,
                      icon: SvgPicture.asset(
                        iconChevronKanan,
                        colorFilter: (widget.maxPage ?? 0) <=
                                int.parse(widget.page ?? "0")
                            ? colorFilter(color: gray300)
                            : colorFilter(color: primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
