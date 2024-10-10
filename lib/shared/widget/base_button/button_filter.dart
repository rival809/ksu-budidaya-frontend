import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ButtonFilter extends StatefulWidget {
  final bool status;
  final Function()? onTapFIlter;
  final String textFilter;
  final String icon;

  const ButtonFilter({
    Key? key,
    required this.status,
    required this.onTapFIlter,
    required this.textFilter,
    required this.icon,
  }) : super(key: key);

  @override
  State<ButtonFilter> createState() => _ButtonFilterState();
}

class _ButtonFilterState extends State<ButtonFilter> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTapFIlter,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: widget.status ? primaryColor : blueGray50,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            SvgPicture.asset(
              widget.icon,
              height: 24,
              colorFilter: colorFilter(
                color: widget.status ? primaryColor : gray900,
              ),
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              widget.textFilter,
              style: myTextTheme.titleMedium?.copyWith(
                color: widget.status ? primaryColor : gray900,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
