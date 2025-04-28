import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini_chat/myHomePage.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text("Your AI Assistant", style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary
                )),
                const SizedBox(height: 16),
                Text("Using Artificial Inteligence. All of questions?   this the answer", style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.inverseSurface), textAlign: TextAlign.center),
              ],
            ),
            const SizedBox(height: 32),
            SvgPicture.asset('assets/chatbot_ills.svg'),
            const SizedBox(height: 32),
            ElevatedButton(onPressed: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MyHomePage()), (route) => false);
            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Continue", style: TextStyle(color: Theme.of(context).colorScheme.surface)),
                  const SizedBox(width: 16),
                  Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.surface)
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
