import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class DrawerProvider with ChangeNotifier {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();

  bool _isDrawerOpen = false;

  GlobalKey<SliderDrawerState> get sliderDrawerKey => _sliderDrawerKey;
  bool get isDrawerOpen => _isDrawerOpen;

  void toggleDrawer() {
    if (_sliderDrawerKey.currentState?.isDrawerOpen == true) {
      _sliderDrawerKey.currentState?.closeSlider();
      _isDrawerOpen = false;
    } else {
      _sliderDrawerKey.currentState?.openSlider();
      _isDrawerOpen = true;
    }
    notifyListeners();
  }
}
