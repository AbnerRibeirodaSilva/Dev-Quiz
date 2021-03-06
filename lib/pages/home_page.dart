import 'package:devquiz/controllers/home_controller.dart';
import 'package:devquiz/core/app_colors.dart';
import 'package:devquiz/widgets/app_bar_widget.dart';
import 'package:devquiz/widgets/level_button_widget.dart';
import 'package:devquiz/widgets/quiz_card_widget.dart';
import 'package:flutter/material.dart';
import 'challenge_page.dart';
import 'home_state.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();

    controller.getUser();
    controller.getQuizzes();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state == HomeState.success) {
      return Scaffold(
          appBar: AppBarWidget(
            user: controller.user!,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LevelButtonWidget(
                      label: 'Facil',
                    ),
                    LevelButtonWidget(
                      label: 'Medio',
                    ),
                    LevelButtonWidget(
                      label: 'Dificil',
                    ),
                    LevelButtonWidget(
                      label: 'Perito',
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    crossAxisCount: 2,
                    children: controller.quizzes!
                        .map((e) => QuizCardWidget(
                              title: e.title,
                              percent: e.questionsAwnsered / e.questions.length,
                              completed:
                                  '${e.questionsAwnsered}/${e.questions.length}',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChallengePage(
                                              title: e.title,
                                              questions: e.questions,
                                            )));
                              },
                            ))
                        .toList(),
                  ),
                )
              ],
            ),
          ));
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
          ),
        ),
      );
    }
  }
}
