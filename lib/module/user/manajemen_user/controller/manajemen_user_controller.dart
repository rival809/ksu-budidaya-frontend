
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import '../view/manajemen_user_view.dart';

class ManajemenUserController extends State<ManajemenUserView> {
    static late ManajemenUserController instance;
    late ManajemenUserView view;

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
        
    