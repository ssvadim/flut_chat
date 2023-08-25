import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(details.exception.toString()),
        ),
      ),
    );
  };

  try {
    //await Firebase.initializeApp(
    //    options: firebaseOptions,
    //);
    runApp(const MyApp());
  } catch (error) {
    if (kDebugMode) {
      print('Firebase initialization error: $error');
    }
    // handle error or show error message to user
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat AI',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/', // default is '/'
      routes: {
        // '/': (context) => ChatScreen(),
        '/': (context) => const MyHomePage(),
        // Other routes go here
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final List<ChatMessage> messages = [
    ChatMessage(messageContent: "Привет, V1adim", messageType: "receiver"),
    ChatMessage(messageContent: "Как у тебя дела?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Привет AgilePeg AI, у меня все хорошо",
        messageType: "sender"),
    ChatMessage(messageContent: "А у тебя как?", messageType: "sender"),
    ChatMessage(messageContent: "Привет, Vadim", messageType: "receiver"),
    ChatMessage(messageContent: "Как у тебя дела?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Привет AgilePeg AI, у меня все хорошо",
        messageType: "sender"),
    ChatMessage(messageContent: "А у тебя как?", messageType: "sender"),
    ChatMessage(messageContent: "Привет, Vadim", messageType: "receiver"),
    ChatMessage(messageContent: "Как у тебя дела?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Привет AgilePeg AI, у меня все хорошо",
        messageType: "sender"),
    ChatMessage(messageContent: "А у тебя как?", messageType: "sender"),
  ];

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat Demo'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Chat Rooms'),
            ),
            ListTile(
              title: const Text('Chat Room 1'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Chat Room 1
              },
            ),
            ListTile(
              title: const Text('Chat Room 2'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Chat Room 2
              },
            ),
            ListTile(
              title: const Text('Create New Chat Room'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Create New Chat Room Screen
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (messages[index].messageType == "receiver"
                            ? Colors.grey.shade200
                            : Colors.blue[200]),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(messages[index].messageContent,
                          style: const TextStyle(fontSize: 15)),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: "Write a message...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  setState(() {
                    if (textController.text.isNotEmpty) {
                      messages.add(ChatMessage(
                          messageContent: textController.text,
                          messageType: "sender"));
                      textController.clear();
                    }
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String messageContent;
  final String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}
