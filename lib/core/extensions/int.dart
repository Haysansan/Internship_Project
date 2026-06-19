import 'package:flutter/material.dart';

extension IntX on int {
  Duration get minute => Duration(minutes: this);
  Duration get second => Duration(seconds: this);
  Duration get milliSecond => Duration(milliseconds: this);
  Duration get microseconds => Duration(microseconds: this);

  Widget get width => SizedBox(width: toDouble());
  Widget get height => SizedBox(height: toDouble());

  BorderRadius get radiusAll => BorderRadius.circular(toDouble());

  EdgeInsets get padAll => EdgeInsets.all(toDouble());
  EdgeInsets get padHorizontal => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get padVertical => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets get padLeft => EdgeInsets.only(left: toDouble());
  EdgeInsets get padRight => EdgeInsets.only(right: toDouble());
  EdgeInsets get padBottom => EdgeInsets.only(bottom: toDouble());
  EdgeInsets get padTop => EdgeInsets.only(top: toDouble());
}
