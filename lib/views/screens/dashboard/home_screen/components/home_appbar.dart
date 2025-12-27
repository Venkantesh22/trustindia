import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/screens/dashboard/profile_screen/profile_screen.dart';
import 'package:lekra/views/screens/dashboard/search_screen/search_screen.dart';
import 'package:lekra/views/screens/widget/card_icon.dart';
import 'package:lekra/views/screens/widget/not_icon.dart';

class HomeApp extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomeApp({
    super.key,
    required this.scaffoldKey,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: GetBuilder<AuthController>(builder: (authController) {
        return GestureDetector(
          onTap: () {
            navigate(context: context, page: const ProfileScreen());
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 12, left: 16),
            child: Stack(
              children: [
                CustomImage(
                  path: authController.userModel?.image ?? "",
                  height: 36,
                  width: 36,
                  isProfile: true,
                  radius: 100,
                ),
                Positioned(
                  bottom: 4,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(40)),
                    child: Text(
                      "Premium",
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: white,
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
      //  IconButton(
      //   onPressed: () {
      //     scaffoldKey.currentState?.openDrawer();
      //   },
      //   icon: const Icon(
      //     Icons.menu_rounded,
      //     color: black,
      //     size: 30,
      //   ),
      // ),
      title: GestureDetector(
        onTap: () {
          navigate(context: context, page: const SearchScreen());
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
              color: grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: grey.withValues(
                  alpha: 0.6,
                ),
                size: 24,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Search ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w600, color: grey),
              )
            ],
          ),
        ),
      ),
      actions: const [
        NotIcon(),
        CardIcon(),
        SizedBox(
          width: 6,
        ),
      ],
    );
  }
}
