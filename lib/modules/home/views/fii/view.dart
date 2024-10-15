import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meus_fiis/modules/home/controller.dart';
import 'package:meus_fiis/modules/home/views/fii/widgets/new_fii_button.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_spacing.dart';

class FiiView extends GetView<HomeController> {
  const FiiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Theme.of(context).appBarTheme.backgroundColor,
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: NSpacing.n4),
          child: const SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: NSpacing.n4),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: NSpacing.n16,
                    ),
                    child: NewFiiButton(),
                  ),
                ],
              ),
            ),
          ),
        ),
        for (final fii in controller.wallet)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: NSpacing.n4,
              horizontal: NSpacing.n16,
            ),
            child: Text(fii.tag),
          )
      ],
    );
  }
}
