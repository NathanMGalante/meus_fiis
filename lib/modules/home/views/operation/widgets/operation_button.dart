import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meus_fiis/modules/home/views/operation/widgets/operation_dialog.dart';
import 'package:meus_fiis/shared/in18.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_radius.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_spacing.dart';
import 'package:meus_fiis/shared/n_widgets/n_button.dart';

class OperationButton extends StatelessWidget {
  const OperationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return NButton(
      radius: NRadius.circular,
      onTap: () => Get.bottomSheet(const OperationDialog()),
      padding: const EdgeInsets.symmetric(
        horizontal: NSpacing.n8,
      ),
      color: Colors.white.withOpacity(0.75),
      child: Row(
        children: [
          Icon(MdiIcons.plus),
          Text(In18.operationButtonText.name.tr),
        ],
      ),
    );
  }
}
