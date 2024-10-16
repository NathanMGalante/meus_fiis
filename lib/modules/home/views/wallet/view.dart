import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meus_fiis/modules/home/controller.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_spacing.dart';

class WalletView extends GetView<HomeController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final tag in controller.wallet.keys)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: NSpacing.n4,
                horizontal: NSpacing.n16,
              ),
              child: Text(tag),
            )
        ],
      ),
    );
  }
}
