import 'package:advance_notification/advance_notification.dart';
import 'package:fashion_ecommerce/data/app_data.dart';
import 'package:fashion_ecommerce/model/base_model.dart';
import 'package:flutter/material.dart';

class AddToCart {
  static void addToCart(BaseModel baseModel, BuildContext context) {
    var contains = itemsOnCart.contains(baseModel);

    if (contains == true) {
      const AdvanceSnackBar(
        textSize: 14.0,
        bgColor: Colors.red,
        message: 'You have added this item to cart before',
        mode: Mode.ADVANCE,
        duration: Duration(seconds: 4),
      ).show(context);
    } else {
      itemsOnCart.add(baseModel);
      const AdvanceSnackBar(
        textSize: 14.0,
        bgColor: Colors.green,
        message: 'Successfully added to your cart',
        mode: Mode.ADVANCE,
        duration: Duration(seconds: 4),
      ).show(context);
    }
  }
}
