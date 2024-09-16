import 'package:flutter/material.dart';

import '../../../core.dart';

class RowCheckbox extends StatefulWidget {
  final bool statusCheckbox;
  final String title;
  final Function(bool?)? onChanged;

  const RowCheckbox({
    super.key,
    required this.statusCheckbox,
    required this.title,
    required this.onChanged,
  });

  @override
  State<RowCheckbox> createState() => _RowCheckboxState();
}

class _RowCheckboxState extends State<RowCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 20.0,
          width: 20.0,
          child: Checkbox(
            value: widget.statusCheckbox,
            onChanged: widget.onChanged,
            activeColor: green700,
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Text(
          widget.title,
          style: myTextTheme.bodySmall,
        ),
      ],
    );
  }
}
