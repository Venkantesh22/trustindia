import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/controllers/wallet_controller.dart';
import 'package:lekra/data/models/transaction_model.dart.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/base/shimmer.dart';
import 'package:lekra/views/screens/dashboard/wallet/create_wallet_pin_screen/wallet_create_pin_screen.dart';
import 'package:lekra/views/screens/dashboard/wallet/wallet_screen/components/profile-balalnce_section.dart';
import 'package:lekra/views/screens/dashboard/wallet/wallet_screen/components/transaction_container.dart';
import 'package:lekra/views/screens/drawer/drawer_screen.dart';
import 'package:lekra/views/screens/widget/custom_appbar/custom_appbar2.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool isWallPinCreate = true;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<WalletController>().fetchWallet().then((value) {
        if (value.isSuccess) {
          Get.find<WalletController>().fetchWalletTransaction();
          setState(() {
            isWallPinCreate = false;
          });
        } else {
          Get.find<WalletController>().updatePage(const WalletScreen());
          navigate(context: context, page: const WalletCreatePinScreen());
        }
      });
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final walletController = Get.find<WalletController>();
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300 &&
        !walletController.fetchWalletTransactionState.isMoreLoading &&
        walletController.fetchWalletTransactionState.canLoadMore) {
      // trigger load more
      walletController.fetchWalletTransaction(loadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: white,
      onRefresh: () async {
        final res = await Get.find<WalletController>()
            .fetchWalletTransaction(refresh: true);
        Get.find<WalletController>().fetchWallet();
        // Optionally show a snackbar on failure
        if (!res.isSuccess) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(res.message)),
          );
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: const DrawerScreen(),
        appBar: const CustomAppBar2(
          title: "Wallet",
          showBackButton: false,
        ),
        body: isWallPinCreate
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                controller: _scrollController,
                padding: AppConstants.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProfileBalanceSection(),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recent Transactions",
                          style:
                              Helper(context).textTheme.titleSmall?.copyWith(),
                        ),
                        const SizedBox(height: 12),
                        GetBuilder<WalletController>(
                            builder: (walletController) {
                          final isInitialLoading = walletController
                              .fetchWalletTransactionState.isInitialLoading;
                          final isMoreLoading = walletController
                              .fetchWalletTransactionState.isMoreLoading;
                          final items = walletController.transactionList;

                          final showLoaderTile = isMoreLoading;

                          final itemCount = isInitialLoading
                              ? 4 // skeleton placeholders
                              : items.length + (showLoaderTile ? 1 : 0);

                          return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (isInitialLoading) {
                                  final transactionModel = TransactionModel();
                                  return CustomShimmer(
                                    isLoading: true,
                                    child: TransactionsContainer(
                                        transactionModel: transactionModel),
                                  );
                                }
                                // if this is the loader tile (last tile)
                                if (showLoaderTile && index == items.length) {
                                  final transactionModel = TransactionModel();
                                  return CustomShimmer(
                                    isLoading: true,
                                    child: TransactionsContainer(
                                        transactionModel: transactionModel),
                                  );
                                }

                                final transactionModel = walletController
                                        .isLoading
                                    ? TransactionModel()
                                    : walletController.transactionList[index];
                                return CustomShimmer(
                                    isLoading: walletController.isLoading,
                                    child: TransactionsContainer(
                                      transactionModel: transactionModel,
                                    ));
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 12,
                                );
                              },
                              itemCount: itemCount);
                        }),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
