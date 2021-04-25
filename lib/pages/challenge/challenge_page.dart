import 'package:flutter/material.dart';

import 'package:devquiz/controllers/challenge_controller.dart';
import 'package:devquiz/pages/challenge/widgets/next_button.dart/next_button_widget.dart';
import 'package:devquiz/pages/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:devquiz/pages/challenge/widgets/quiz/quiz_widget.dart';
import 'package:devquiz/result_page/result_page.dart';
import 'package:devquiz/shared/models/question_model.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;
  const ChallengePage({
    Key? key,
    required this.questions,
    required this.title,
  }) : super(key: key);
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });

    super.initState();
  }

  void nextPage() {
    if (controller.currentPage < widget.questions.length)
      pageController.nextPage(
        duration: Duration(milliseconds: 250),
        curve: Curves.linear,
      );
  }

  void onSelected(bool value) {
    if (value == true) {
      controller.qtdAwnserRigth++;
    }
    nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => QuestionIndicatorWidget(
                  currentPage: value,
                  length: widget.questions.length,
                ),
              )
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.questions
            .map((e) => QuizWidget(
                  question: e,
                  onSelected: onSelected,
                ))
            .toList(),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: ValueListenableBuilder(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (value != widget.questions.length)
                          Expanded(
                              child: NextButtonWidget.white(
                                  label: "Pular", onTap: nextPage)),
                        if (value == widget.questions.length)
                          Expanded(
                              child: NextButtonWidget.gren(
                            label: "Confirmar",
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResultPage(
                                            awnseredsRigth:
                                                controller.qtdAwnserRigth,
                                            length: widget.questions.length,
                                            title: widget.title,
                                          )));
                            },
                          ))
                      ],
                    ))),
      ),
    );
  }
}
