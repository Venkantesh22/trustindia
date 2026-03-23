import 'package:flutter/material.dart';
import 'package:lekra/services/constants.dart';

class MobileRechargeSelectOptionsWalletDynamicScreen extends StatelessWidget {
  const MobileRechargeSelectOptionsWalletDynamicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => pop(context), icon: const Icon(Icons.close)),
      ),
    );
  }
}
