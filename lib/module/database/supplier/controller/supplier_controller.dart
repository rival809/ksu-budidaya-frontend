
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import '../view/supplier_view.dart';

class SupplierController extends State<SupplierView> {
    static late SupplierController instance;
    late SupplierView view;

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
        
    