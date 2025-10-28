import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/address/screen/address_screen.dart';
import 'package:lekra/views/screens/dashboard/dashboard_screen.dart';
import 'package:lekra/views/screens/drawer/components/drawer_item.dart';
import 'package:lekra/views/screens/order_screem/screen/order_screen.dart';
import 'package:lekra/views/screens/rewards/screen/rewards_screen/rewards_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<AuthController>(builder: (authController) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomImage(
                        path: authController.userModel?.image ?? "",
                        height: 70,
                        width: 70,
                        radius: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            authController.userModel?.name ?? "",
                            style:
                                Helper(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Welcome back!",
                            style: Helper(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 14, color: grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(
                  color: grey,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: drawerItemList.length,
                  itemBuilder: (context, index) {
                    final drawer = drawerItemList[index];
                    return DrawerItem(
                      label: drawer.label,
                      isActive: isActive,
                      onTap: () {
                        if (drawer.onTap != null) drawer.onTap!(context);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text("App version 1.0.0",
                    style: Helper(context).textTheme.bodySmall),
              ),
            ],
          ),
        ));
  }
}

class DrawerItemModel {
  final String label;
  final bool isActive;
  final Function(BuildContext context)? onTap;

  DrawerItemModel({
    required this.label,
    this.isActive = false,
    required this.onTap,
  });
}

List<DrawerItemModel> drawerItemList = [
  DrawerItemModel(
    label: "Home",
    onTap: (ctx) {
      navigate(context: ctx, page: const DashboardScreen());
    },
  ),
  DrawerItemModel(
    label: "Order",
    onTap: (ctx) {
      navigate(context: ctx, page: const OrderScreen());
    },
  ),
  DrawerItemModel(
    label: "Rewards",
    onTap: (ctx) {
      navigate(context: ctx, page: const RewardsScreen());
    },
  ),
  DrawerItemModel(
    label: "Payment",
    onTap: (ctx) {},
  ),
  DrawerItemModel(
    label: "Address",
    onTap: (ctx) {
      navigate(context: ctx, page: const AddressScreen());
    },
  ),
  DrawerItemModel(
    label: "Customer Service",
    onTap: (ctx) {},
  ),
  DrawerItemModel(
    label: "Gift Ideas",
    onTap: (ctx) {},
  ),
];
