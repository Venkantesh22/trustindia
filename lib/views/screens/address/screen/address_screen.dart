import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/basic_controller.dart';
import 'package:lekra/data/models/body/address_model.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/address/screen/add_address_screen.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar_drawer.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<BasicController>().fetchAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: CustomAppbarDrawer( title: "Address"),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(12)),
        child: TextButton.icon(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8),
            foregroundColor: primaryColor,
            textStyle: Helper(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            navigate(context: context, page: const AddAddressScreen());
          },
          icon: const Icon(
            Icons.add,
            size: 18,
            color: white,
          ),
          label: Text(
            'Add New Address',
            style: Helper(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14, fontWeight: FontWeight.bold, color: white),
          ),
        ),
      ),
      body: GetBuilder<BasicController>(builder: (basicController) {
        if (basicController.addressList.isEmpty) {
          return const Center(child: Text("No Address "));
        }
        return ListView.separated(
          padding: AppConstants.screenPadding,
          itemBuilder: (context, index) {
            final address = basicController.isLoading
                ? AddressModel()
                : basicController.addressList[index];
            index = index + 1;
            return CustomShimmer(
                isLoading: basicController.isLoading,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: white,
                      boxShadow: [
                        BoxShadow(
                            color: black.withValues(alpha: 0.1),
                            blurRadius: 6,
                            spreadRadius: 0,
                            offset: const Offset(0, 6))
                      ]),
                  child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.home,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "Home $index",
                                style: Helper(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: black),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            overflow: TextOverflow.clip,
                            address.fullAddress,
                            style: Helper(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: black),
                          ),
                        ],
                      ),
                      trailing: basicController.addressDeleteLoading
                          ? const CircularProgressIndicator()
                          : IconButton(
                              onPressed: () {
                                {
                                  Get.find<BasicController>()
                                      .deleteAddress(addressId: address.id)
                                      .then((value) {
                                    if (value.isSuccess) {
                                      showToast(
                                          message: value.message,
                                          typeCheck: value.isSuccess);
                                    } else {
                                      showToast(
                                          message: value.message,
                                          typeCheck: value.isSuccess);
                                    }
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: red,
                              ))),
                ));
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: basicController.isLoading
              ? 4
              : basicController.addressList.length,
        );
      }),
    );
  }
}
