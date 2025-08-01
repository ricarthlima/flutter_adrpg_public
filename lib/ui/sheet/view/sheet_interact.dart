import 'dart:math';

import 'package:flutter/material.dart';
import '../helpers/sheet_subpages.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/action_template.dart';
import '../../../domain/models/roll_log.dart';
import '../../statistics/view/statistics_view_model.dart';
import '../components/roll_body_dialog.dart';
import 'sheet_view_model.dart';

abstract class SheetInteract {
  static Future<void> onRollBodyDice(
      {required BuildContext context, required bool isSerious}) {
    int roll = Random().nextInt(6) + 1;
    return showRollBodyDialog(
      context: context,
      roll: roll,
      isSerious: isSerious,
    );
  }

  static onItemsButtonClicked(BuildContext context) async {
    context.read<SheetViewModel>().currentPage = SheetSubpages.items;
  }

  static Future<void> onNotesButtonClicked(BuildContext context) async {
    context.read<SheetViewModel>().currentPage = SheetSubpages.notes;
  }

  static onStatisticsButtonClicked(BuildContext context) async {
    //TODO: Provovalmente é melhor isso estar no initState da tela
    context.read<StatisticsViewModel>().listCompleteRollLog =
        context.read<SheetViewModel>().sheet!.listRollLog;

    context.read<SheetViewModel>().currentPage = SheetSubpages.statistics;
  }

  static void onSettingsButtonClicked(BuildContext context) async {
    context.read<SheetViewModel>().currentPage = SheetSubpages.settings;
  }

  static Future<void> rollAction({
    required BuildContext context,
    required ActionTemplate action,
    required String groupId,
  }) async {
    SheetViewModel sheetVM = context.read<SheetViewModel>();

    List<int> rolls = [];

    int newActionValue = sheetVM.getTrainLevelByAction(action.id) +
        (sheetVM.modValueGroup(groupId));

    if (newActionValue < 0) {
      newActionValue = 0;
    }

    if (newActionValue > 4) {
      newActionValue = 4;
    }

    if (context
        .read<SheetViewModel>()
        .actionRepo
        .isOnlyFreeOrPreparation(action.id)) {
      rolls.add(Random().nextInt(20) + 1);
    } else {
      if (newActionValue == 0 || newActionValue == 4) {
        rolls.add(Random().nextInt(20) + 1);
        rolls.add(Random().nextInt(20) + 1);
        rolls.add(Random().nextInt(20) + 1);
      } else if (newActionValue == 1 || newActionValue == 3) {
        rolls.add(Random().nextInt(20) + 1);
        rolls.add(Random().nextInt(20) + 1);
      } else if (newActionValue == 2) {
        rolls.add(Random().nextInt(20) + 1);
      }
    }

    RollLog roll = RollLog(
      rolls: rolls,
      idAction: action.id,
      dateTime: DateTime.now(),
      isGettingLower: newActionValue <= 1,
    );

    sheetVM.onRoll(roll: roll, groupId: groupId);
  }

  static Future<void> onUploadBioImageClicked(BuildContext context) async {
    ImagePicker picker = ImagePicker();

    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      requestFullMetadata: false,
    );

    if (image != null) {
      if (!context.mounted) return;
      context.read<SheetViewModel>().onUploadBioImageClicked(image);
    }
  }
}
