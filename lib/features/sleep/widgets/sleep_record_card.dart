import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gympanion/core/extensions/duration_extension.dart';
import 'package:gympanion/core/constants/constants.dart';
import 'package:gympanion/features/sleep/providers/sleep_manager.dart';
import 'package:gympanion/features/shared/widgets/custom_card_element.dart';
import 'package:intl/intl.dart';

class SleepRecordCard extends StatelessWidget {
  const SleepRecordCard(
      {super.key,
      this.title,
      required this.sleepRecord,
      this.disableBorder = true,
      this.backgroundColor = Colors.black45});

  final String? title;
  final SleepRecord sleepRecord;
  final bool disableBorder;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return CustomCardElement(
      enableShadow: false,
      margin: EdgeInsets.all(12),
      border: disableBorder ? null : Border.all(color: AppColors.cardioColor),
      color: backgroundColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title != null
                ? Center(
                    child: Text(
                      title ?? '',
                      style: AppTextStyles.titleLarge,
                    ),
                  )
                : SizedBox.shrink(),
            Center(
              child: Text(
                sleepRecord.duration.inSeconds.toReadableDuration(),
                style: AppTextStyles.titleMedium.copyWith(
                    color: sleepRecord.duration.inHours < 5
                        ? Colors.red
                        : sleepRecord.duration.inHours < 7
                            ? Colors.amber
                            : Colors.green),
              ),
            ),
            Divider(),
            Row(
              children: [
                Text(
                  'Quality: ',
                  style: AppTextStyles.titleMedium,
                ),
                RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: sleepRecord.rating,
                  itemBuilder: (context, index) => Icon(Icons.star),
                  itemSize: 24,
                  onRatingUpdate: (value) {},
                )
              ],
            ),
            Text(
              'From: ${sleepRecord.from!.format(context)}',
              style: AppTextStyles.titleMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'To: ${sleepRecord.to!.format(context)}',
                  style: AppTextStyles.titleMedium,
                ),
                Text(
                  DateFormat('dd MMM yyyy')
                      .format(sleepRecord.date ?? DateTime.now()),
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
