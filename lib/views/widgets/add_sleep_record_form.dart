import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gympanion/extensions/duration_extension.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/notifiers.dart';
import 'package:gympanion/views/data/sleep_manager.dart';
import 'package:gympanion/views/widgets/custom_card_element.dart';
import 'package:gympanion/views/widgets/wide_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void _calculateSleepDuration() {
  if (selectedTime1.value == null || selectedTime2.value == null) {
    sleepDuration.value = null;
    return;
  }
  int durationMins =
      (selectedTime2.value!.hour * 60 + selectedTime2.value!.minute) -
          (selectedTime1.value!.hour * 60 + selectedTime1.value!.minute);
  if (durationMins < 0) durationMins += 1440;
  sleepDuration.value = Duration(minutes: durationMins);
}

void addSleepRecordForm(BuildContext ctx) {
  selectedDate.value = DateTime.now();
  selectedTime1.value = null;
  selectedTime2.value = null;
  sleepDuration.value = null;
  bool time1Selected = false;
  bool time2Selected = false;
  showModalBottomSheet(
    showDragHandle: true,
    isScrollControlled: true,
    context: ctx,
    builder: (context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(ctx).size.height / 1.5,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              'Add a sleep record',
              style: AppTextStyles.titleLarge,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ValueListenableBuilder(
                    valueListenable: selectedDate,
                    builder: (context, value, child) {
                      return Text(
                        DateTime.now().day - value.day < 1
                            ? 'Today: ${DateFormat('dd MMM yyyy').format(value)}'
                            : DateFormat('dd MMM yyyy').format(value),
                        style: AppTextStyles.titleMedium,
                      );
                    }),
                TextButton(
                    onPressed: () async {
                      selectedDate.value = await showDatePicker(
                              context: context,
                              firstDate:
                                  DateTime.now().subtract(Duration(days: 30)),
                              lastDate: DateTime.now()) ??
                          DateTime.now();
                    },
                    child: Text('Change')),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCardElement(
                    child: SizedBox(
                  height: 45,
                  width: 120,
                  child: Center(
                    child: Text(
                      'From',
                      style: AppTextStyles.titleLarge,
                    ),
                  ),
                )),
                SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () async {
                    selectedTime1.value = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());

                    if (selectedTime1.value != null) {
                      time1Selected = true;
                      _calculateSleepDuration();
                    }
                  },
                  child: Container(
                    width: 180,
                    height: 45,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.cardioColor),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: ValueListenableBuilder(
                        valueListenable: selectedTime1,
                        builder: (context, value, child) {
                          return Text(
                            time1Selected ? value?.format(context) ?? '' : '',
                            style: AppTextStyles.titleMedium,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCardElement(
                    child: SizedBox(
                  height: 45,
                  width: 120,
                  child: Center(
                    child: Text(
                      'To',
                      style: AppTextStyles.titleLarge,
                    ),
                  ),
                )),
                SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () async {
                    selectedTime2.value = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());

                    if (selectedTime2.value != null) {
                      time2Selected = true;
                      _calculateSleepDuration();
                    }
                  },
                  child: Container(
                    width: 180,
                    height: 45,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.cardioColor),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: ValueListenableBuilder(
                        valueListenable: selectedTime2,
                        builder: (context, value, child) {
                          return Text(
                            time2Selected ? value?.format(context) ?? '' : '',
                            style: AppTextStyles.titleMedium,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Divider(),
            ValueListenableBuilder(
              valueListenable: sleepDuration,
              builder: (context, value, child) {
                return value != null
                    ? Text(
                        'Total sleep: ${value.inSeconds.toReadableDuration()}',
                        style: AppTextStyles.titleMedium,
                      )
                    : SizedBox();
              },
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'How would you rate your sleep?',
              style: AppTextStyles.titleLarge,
            ),
            SizedBox(
              height: 12,
            ),
            RatingBar.builder(
              itemBuilder: (context, index) {
                return Icon(Icons.star);
              },
              onRatingUpdate: (value) {
                sleepRating.value = value;
              },
            ),
            Spacer(),
            WideButton(
                onTap: () {
                  Provider.of<SleepManager>(context, listen: false)
                      .addSleepRecord(SleepRecord(
                          selectedDate.value,
                          selectedTime1.value,
                          selectedTime2.value,
                          sleepDuration.value ?? Duration.zero,
                          sleepRating.value));
                  Navigator.of(context).pop();
                },
                title: 'Add',
                color: Colors.grey),
          ],
        ),
      );
    },
  );
}
