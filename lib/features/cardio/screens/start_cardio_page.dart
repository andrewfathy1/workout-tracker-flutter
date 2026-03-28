import 'package:flutter/material.dart';
import 'package:gympanion/core/app/app_data.dart';
import 'package:gympanion/features/cardio/models/cardio_data.dart';
import 'package:gympanion/core/constants/constants.dart';
import 'package:gympanion/features/cardio/providers/current_cardio_data.dart';
import 'package:gympanion/features/shared/widgets/custom_dropdownmenu.dart';
import 'package:gympanion/features/shared/widgets/wide_button.dart';
import 'package:provider/provider.dart';

enum CardioMode { start, add }

void showStartCardioPage(BuildContext ctx, CardioMode mode) async {
  double? appBarHeight = Scaffold.of(ctx).appBarMaxHeight;
  CardioData cardioData = CardioData();
  final cardioDataFuture = cardioData.getCardioDataFromFirebase();
  showModalBottomSheet(
    context: ctx,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return Consumer<CurrentCardioData>(
        builder: (context, currentCardioData, child) => Container(
          padding: EdgeInsets.all(24),
          height: MediaQuery.of(ctx).size.height - appBarHeight! - 120,
          width: MediaQuery.of(ctx).size.width,
          child: Column(
            children: [
              Text(
                mode == CardioMode.start ? 'Start Cardio' : 'Add A Cardio',
                style: AppTextStyles.displayLarge.copyWith(color: Colors.white),
              ),
              SizedBox(height: 16),
              FutureBuilder(
                  future: cardioDataFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(
                        child: Text('Error loading cardio data'),
                      );
                    } else {
                      return CustomDropdownmenu(
                        hint: 'Cardio Type',
                        onSelected: (selected) =>
                            currentCardioData.selectWhichCardio(selected!),
                        entries: cardioData.cardioData
                            .map(
                              (cardioName) => DropdownMenuEntry(
                                style: ButtonStyle(),
                                labelWidget: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.amber)),
                                  ),
                                  child: Text(
                                    cardioName,
                                    style: AppTextStyles.bodyLarge,
                                  ),
                                ),
                                value: cardioName,
                                label: cardioName,
                              ),
                            )
                            .toList(),
                      );
                    }
                  }),
              Spacer(),
              WideButton(
                  onTap: () {
                    Navigator.of(context).pop();
                    Provider.of<AppData>(context, listen: false)
                        .changeNavBarIndex(3);
                    Provider.of<CurrentCardioData>(ctx, listen: false)
                        .startCardio();
                  },
                  title: mode == CardioMode.start ? 'Start' : 'Add',
                  color: AppColors.cardioColor),
            ],
          ),
        ),
      );
    },
  );
}
