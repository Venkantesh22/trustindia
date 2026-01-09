import 'package:flutter/material.dart';
import 'package:lekra/views/screens/widget/custom_back_button.dart';

class CustomAppbarBackButton extends StatelessWidget
    implements PreferredSizeWidget {
  bool goHomeScreen;
  CustomAppbarBackButton({super.key, this.goHomeScreen = false});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: CustomBackButton(),
    );
  }
}
