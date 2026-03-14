import 'package:flutter/material.dart';
import 'package:gympanion/extensions/duration_extension.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/widgets/custom_card_element.dart';

class CardioDetailsPage extends StatelessWidget {
  const CardioDetailsPage({super.key, required this.cardioJSON});

  final Map<String, dynamic> cardioJSON;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(cardioJSON['dateFinished']),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  cardioJSON['cardioTitle'],
                  style: AppTextStyles.displayLarge,
                ),
              ),
              Divider(
                thickness: 5,
              ),
              CustomCardElement(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Other Details',
                          style: AppTextStyles.displayMedium,
                        ),
                      ),
                      Divider(
                        color: Colors.amber,
                      ),
                      Text(
                        'Duration: ${(cardioJSON['timeElapsed'] as int).toReadableDuration()}',
                        style: AppTextStyles.bodyLarge,
                      ),
                      Text(
                        'Overall feeling: ${cardioJSON['rating']}',
                        style: AppTextStyles.bodyLarge,
                      ),
                      Text(
                        'PBs achieved: ',
                        style: AppTextStyles.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
