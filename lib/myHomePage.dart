import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini_chat/themeNotifier.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'message.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final List<Message> _message = [
    Message(text: "Hi", isUser: true),
    Message(text: "Hello, what's up?", isUser: false),
    Message(text: "Great and you?", isUser: true),
    Message(text: "Fine thanks", isUser: false)
  ];
  TextEditingController controller = TextEditingController();

  callGeminiModel() async {
    try {
      if (controller.text.isNotEmpty) {
        setState(() {
          _message.add(Message(text: controller.text, isUser: true));
        });
      }
      final model = GenerativeModel(
          model: "gemini-2.0-flash", apiKey: dotenv.env["GOOGLE_APIKEY"]!);
      final prompt = controller.text;

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      setState(() {
        _message.add(Message(text: response.text!, isUser: false));
      });
      controller.clear();
    } catch (e) {
      log("error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.read(themeProvider);
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          centerTitle: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/robot.png', width: 32),
                  const SizedBox(width: 12),
                  Text('Gemini GPT',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold))
                ],
              ),
              IconButton(
                  onPressed: () {
                    ref.read(themeProvider.notifier).toggleTheme();
                  },
                  icon: Icon(
                      currentTheme == ThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: Theme.of(context).colorScheme.primary))
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                  itemCount: _message.length,
                  itemBuilder: (context, index) {
                    final message = _message[index];
                    return ListTile(
                      title: Align(
                        alignment: message.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: message.isUser
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context)
                                        .colorScheme
                                        .surfaceContainerHighest,
                                borderRadius: message.isUser
                                    ? const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20))
                                    : const BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20))),
                            child: Text(message.text,
                                style: TextStyle(
                                    color: message.isUser
                                        ? Theme.of(context).colorScheme.surface
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface))),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 32, top: 16, left: 16, right: 16),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .inverseSurface
                              .withOpacity(0.05),
                          spreadRadius: 5,
                          blurRadius: 17,
                          offset: const Offset(0, 0))
                    ]),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            hintText: 'Write ur message',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                        onPressed: callGeminiModel,
                        icon: SvgPicture.asset('assets/send.svg',
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.primary,
                                BlendMode.srcIn)))
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
