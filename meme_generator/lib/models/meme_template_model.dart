import 'package:flutter/material.dart';

class MemeTemplateModel {
  MemeTemplateModel(
      {required this.title,
      required this.previewImgUrl,
      required this.widgetRoute});
  final String title;
  final String previewImgUrl;
  Widget widgetRoute;
}
