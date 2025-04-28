import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'message.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Message> _message = [
    Message(text: "Hi", isUser: true),
    Message(text: "Hello, what's up?", isUser: false),
    Message(text: "Great and you?", isUser: true),
    Message(text: "Fine thanks", isUser: false)
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
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
                Text('Gemini GPT', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold))
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.volume_up_outlined, color: Theme.of(context).colorScheme.primary))
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
                  alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: message.isUser ? Theme.of(context).colorScheme.primary : Colors.grey[300],
                        borderRadius: message.isUser ? const BorderRadius.only(
                            topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                        ) : const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)
                        )
                      ),
                      child: Text(message.text, style: TextStyle(color: message.isUser ? Theme.of(context).colorScheme.inversePrimary : Colors.black))),
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32, top: 16, left: 16, right: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.05),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0,-3)
                  )
                ]
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Write ur message',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20)
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SvgPicture.asset('assets/send.svg',colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
                    ),
                  ),
                  // IconButton(onPressed: () {}, icon: const Icon(Icons.send))
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}