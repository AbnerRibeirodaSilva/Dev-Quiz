import 'package:devquiz/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:devquiz/core/app_text_styles.dart';

class QuestionIndicatorWidget extends StatelessWidget {
  final int currentPage;
  final int length;
  const QuestionIndicatorWidget({
    Key? key,
    required this.currentPage,
    required this.length,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Questão $currentPage",
                  style: AppTextStyles.body,
                ),
                Text(
                  "de $length",
                  style: AppTextStyles.body,
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            ProgressIndicatorWidget(value: currentPage / length)
          ],
        ),
      ),
    );
  }
}
