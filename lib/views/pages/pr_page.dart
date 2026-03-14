import 'package:flutter/material.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/prs/pr_manager.dart';
import 'package:gympanion/views/data/user_stats.dart';
import 'package:gympanion/views/pages/pr_viewer_page.dart';
import 'package:gympanion/views/widgets/custom_card_element.dart';
import 'package:gympanion/views/widgets/new_label_widget.dart';
import 'package:provider/provider.dart';

class PRPage extends StatelessWidget {
  const PRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PRs'),
      ),
      body: Consumer<UserStats>(
        builder: (context, userStats, child) {
          return userStats.previousPRs.isEmpty
              ? Center(
                  child: Text(
                    'No data yet!',
                    style: AppTextStyles.displayLarge,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: ListView.separated(
                    itemCount: userStats.previousPRs.keys.length,
                    itemBuilder: (context, index) => CustomCardElement(
                      border: Border.all(
                          color: index % 2 == 1
                              ? AppColors.cardioColor
                              : AppColors.cardioColor,
                          width: 2),
                      // margin: EdgeInsets.all(8),
                      color: Colors.transparent,
                      dock: index % 2 == 1 ? Dock.dockLeft : Dock.dockRight,
                      margin: index % 2 == 1
                          ? EdgeInsets.only(right: 48)
                          : EdgeInsets.only(left: 48),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              userStats.previousPRs.keys.elementAt(index),
                              style: AppTextStyles.titleLarge,
                            ),
                            ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: userStats.previousPRs.entries
                                  .elementAt(index)
                                  .value
                                  .length,
                              itemBuilder: (context, i) {
                                final prEntries = userStats.previousPRs.entries
                                    .elementAt(index)
                                    .value
                                    .toList();
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(children: [
                                    ListTile(
                                      onTap: () {
                                        Provider.of<PRManager>(context,
                                                listen: false)
                                            .markPRRead(
                                                userStats.previousPRs.entries
                                                    .elementAt(index)
                                                    .key,
                                                i);
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => PrViewerPage(
                                            exercisePR: prEntries[i],
                                          ),
                                        ));
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16))),
                                      tileColor: index % 2 == 1
                                          ? AppColors.cardioColor.withAlpha(122)
                                          : AppColors.cardioColor
                                              .withAlpha(122),
                                      leading: Text(
                                        prEntries[i].exerciseName,
                                        style: AppTextStyles.titleMedium,
                                      ),
                                      trailing: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.keyboard_arrow_right,
                                            size: 32,
                                          )),
                                    ),
                                    !prEntries[i].isSeen
                                        ? NewLabelWidget()
                                        : SizedBox.shrink()
                                  ]),
                                );
                              },
                              separatorBuilder: (context, index) => Divider(),
                            )
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 24,
                    ),
                  ));
        },
      ),
    );
  }
}
