
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import '../view/manajemen_role_view.dart';

class ManajemenRoleController extends State<ManajemenRoleView> {
    static late ManajemenRoleController instance;
    late ManajemenRoleView view;

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
        
    