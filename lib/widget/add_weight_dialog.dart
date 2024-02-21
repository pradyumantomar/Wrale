import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wrale/core/notifier.dart';

showAddWeightDialog(
  required BuildContext context,
  required double weight,
  required DateTime date,
){

    final WraleNotifier wraleNotifier =
    Provider.of<WraleNotifier>(context, listen: false);

    double currentSliderValue = weight.toDouble();
    DateTime cureentDate = date;
    
}