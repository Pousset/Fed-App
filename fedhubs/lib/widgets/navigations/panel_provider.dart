import 'package:flutter/material.dart';

class PanelProvider extends ChangeNotifier {
  PanelProvider(
    this.panel, {
    this.header,
    this.minHeight = 0,
    this.maxHeight = 510,
    this.backdropEnabled = true,
    this.backdropOpacity = 0.6,
    this.borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
  });

  Widget panel;
  Widget? header;
  double minHeight;
  double maxHeight;
  bool backdropEnabled;
  double backdropOpacity;
  BorderRadiusGeometry? borderRadius;

  void setPanel({
    Widget? panel,
    Widget? header,
    double? minHeight,
    double? maxHeight,
    bool? backdropEnabled,
    double? backdropOpacity,
    BorderRadiusGeometry? borderRadius,
  }) {
    if (panel != null) this.panel = panel;
    if (header != null) this.header = header;
    if (minHeight != null) this.minHeight = minHeight;
    if (maxHeight != null) this.maxHeight = maxHeight;
    if (backdropEnabled != null) this.backdropEnabled = backdropEnabled;
    if (backdropOpacity != null) this.backdropOpacity = backdropOpacity;
    if (borderRadius != null) this.borderRadius = borderRadius;
    notifyListeners();
  }
}
