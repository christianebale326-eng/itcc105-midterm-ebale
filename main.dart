import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  final List<String> messages = [];

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add("You: $text");

      String input = text.toLowerCase();
      String response;

      // 🤖 SMART KEYWORD AI LOGIC
      if (input.contains("clearance")) {
        response = "✅ You are fully cleared. No pending issues.";
      } 
      else if (input.contains("schedule")) {
        response = "📅 Your schedule:\n• 9:00 AM - IT Class\n• 1:00 PM - Project Meeting";
      } 
      else if (input.contains("fee") || input.contains("payment")) {
        response = "💳 Payment options: GCash, Credit/Debit Card.";
      } 
      else if (input.contains("grade")) {
        response = "📊 Your grades are available in the student portal.";
      } 
      else {
        response = "🤖 I understand you said: '$text'\nPlease try asking about clearance, schedule, fees, or grades.";
      }

      messages.add("AI: $response");
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        title: const Text("Smart Portal AI"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // 💬 CHAT LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: messages[index].startsWith("You")
                        ? Colors.blue[100]
                        : Colors.green[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(messages[index]),
                );
              },
            ),
          ),

          // ⌨ INPUT AREA
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) => sendMessage(value),
                  ),
                ),

                const SizedBox(width: 10),

                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => sendMessage(controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}