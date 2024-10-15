import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meus_fiis/shared/in18.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_radius.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_spacing.dart';
import 'package:meus_fiis/shared/n_widgets/n_button.dart';

class NewFiiButton extends StatelessWidget {
  const NewFiiButton({super.key});

  @override
  Widget build(BuildContext context) {
    return NButton(
      radius: NRadius.circular,
      onTap: () {},
      padding: const EdgeInsets.symmetric(
        horizontal: NSpacing.n8,
      ),
      color: Colors.white.withOpacity(0.75),
      child: Row(
        children: [
          Icon(MdiIcons.plus),
          Text(In18.fiiViewAddText.name.tr),
        ],
      ),
    );
  }
}
