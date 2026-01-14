import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/order_controlller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';

class CheckBoxOfOrderUserReward extends StatelessWidget {
  const CheckBoxOfOrderUserReward({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "User Reward Coins",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Row(
            children: [
              Checkbox(
                  value: orderController.userRewordCoinsState,
                  onChanged: (value) {
                    orderController.updateRewordCoinsState(value: value);
                  }),
              Text(
                "You can user 65",
                style: Helper(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: greyDark,
                    ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
