import 'package:everide_frontend/src/constants/app_contants.dart';
import 'package:everide_frontend/src/constants/colors.dart';
import 'package:everide_frontend/src/widgets/buttons/pick_me_up_button.dart';
import 'package:everide_frontend/src/widgets/saved_carbon_big_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:go_router/go_router.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController feedbackController = TextEditingController();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Feedback Screen'),
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              const SavedCarbonBigCard(carbonValue: 700),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(kBorderRadiusCards)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 25,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'We love your feedback!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: EmojiFeedback(
                          emojiPreset: const [
                            EmojiModel(src: 'assets/emoji-sad.svg', label: ''),
                            EmojiModel(
                                src: 'assets/emoji-face-confused.svg',
                                label: ''),
                            EmojiModel(
                                src: 'assets/emoji-smile-beam.svg', label: ''),
                            EmojiModel(
                                src: 'assets/emoji-smile-wink.svg', label: ''),
                            EmojiModel(
                                src: 'assets/emoji-laugh-beam.svg', label: '')
                          ],
                          spaceBetweenItems: 4,
                          elementSize: 50,
                          showLabel: false,
                          labelTextStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          animDuration: const Duration(milliseconds: 300),
                          curve: Curves.bounceIn,
                          inactiveElementScale: .5,
                          onChanged: (value) {},
                        ),
                      ),
                      TextField(
                        maxLines: 10,
                        controller: feedbackController,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Write your feedback here...',
                          fillColor: secondaryColor,
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black38,
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(kBorderRadiusSearchBar),
                            borderSide: const BorderSide(color: secondaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(kBorderRadiusSearchBar),
                            borderSide: const BorderSide(color: secondaryColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(kBorderRadiusSearchBar),
                            borderSide: const BorderSide(color: secondaryColor),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        onChanged: (value) {
                          feedbackController.text = value.toString();
                        },
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GreenButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          actionsAlignment: MainAxisAlignment.start,
                          elevation: 5.0,
                          backgroundColor: primaryColor,
                          content: Container(
                            height: 200,
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle_outline_rounded,
                                  size: 75,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Feedback submitted',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.goNamed("home");
                              },
                              child: const Text(
                                'Back to homepage',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text(
                                'Submit another feedback',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    );
                  },
                  text: 'Submit Feedback'),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
