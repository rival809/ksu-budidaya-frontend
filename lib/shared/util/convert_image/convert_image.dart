import 'dart:convert';

import 'package:flutter/material.dart';

Image imageFromBase64String(String base64String) {
  if (base64String.length < 10) {
    return Image.asset(
      "assets/images/illustration/image_not_found.png",
    );
  }
  return Image.memory(
    base64Decode(base64String),
    fit: BoxFit.cover,
  );
}
