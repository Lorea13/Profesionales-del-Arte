import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../fragments/topPanel.dart';
import '../fragments/topPanelEconomics.dart';


class CombinedTopPanelDelegate extends SliverPersistentHeaderDelegate {
  final double maxExtentValue;
  final double minHeightValue;
  final int tabIndex;

  CombinedTopPanelDelegate(this.tabIndex, this.maxExtentValue, this.minHeightValue);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        TopPanel(1),
        TopPanelEconomics(tabIndex),
      ],
    );
  }

  @override
  double get maxExtent => this.maxExtentValue;
  
  @override
  double get minExtent => this.minHeightValue;


  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
