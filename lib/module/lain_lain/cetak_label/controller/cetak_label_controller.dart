import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class CetakLabelController extends State<CetakLabelView> {
  static late CetakLabelController instance;
  late CetakLabelView view;

  TextEditingController textController = TextEditingController();

  List<DataDetailProduct> getDetailSuggestions(
      String query, List<DataDetailProduct>? states) {
    List<DataDetailProduct> matches = [];

    if (states != null) {
      matches.addAll(states);
      matches.retainWhere((s) =>
          trimString(s.idProduct).toLowerCase().contains(query.toLowerCase()));
    }

    return matches;
  }

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
