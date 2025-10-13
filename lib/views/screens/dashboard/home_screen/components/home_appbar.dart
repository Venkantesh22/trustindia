import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/custom_image.dart';
import 'package:lekra/views/base/dialogs/logout_dialog.dart' show LogoutDialog;

class HomeApp extends StatelessWidget implements PreferredSizeWidget {
  const HomeApp({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: const Icon(
        Icons.menu_rounded,
        color: black,
        size: 30,
      ),
      title: Container(
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
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shopping_cart_rounded,
            color: black,
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        GestureDetector(
          onTap: () {
            log("Logout Dialog");
            showDialog(
                context: context, builder: (context) => const LogoutDialog());
          },
          child: const CustomImage(
            isProfile: true,
            radius: 20,
            path: "",
            width: 30,
            height: 30,
          ),
        ),
        const SizedBox(
          width: 14,
        )
      ],
    );
  }
}
