
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import '../view/produk_view.dart';

class ProdukController extends State<ProdukView> {
    static late ProdukController instance;
    late ProdukView view;

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
        
    