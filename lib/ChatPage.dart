import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


// class ChatApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Chat Page',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => MassagesPage()),);
//             },
//           ),
//           title: const Text('Chat Page'),
//         ),
//         body: ChatScreen(),
//       ),
//     );
//   }
//
// }

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> messages = [
    'Hello, how are you?',
    'I\'m doing well, thank you!',
    'Do you have any plans for the weekend?',
    'Yes, I\'m going hiking with some friends.',
  ];

  TextEditingController _controller = TextEditingController();

  void _sendMessage(String message) {
    setState(() {
      messages.add(message);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Chatting'),
        // backgroundColor: Color.fromRGBO(69, 69, 113, 1),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: index % 2 == 0 ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: index % 2 == 0 ? const Color.fromRGBO(69, 69, 113, 1) : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      messages[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:  InputDecoration(
                      hintText: 'Type  message...'.tr(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send,color: Color.fromRGBO(69, 69, 113, 1),),
                  onPressed: () {
                    _sendMessage(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
