import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bewhaos A/S',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Bewhaos - Ask Archibald'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String chatbot_reply = 'I\'m Archibald, what can I help you with?';
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network('https://png2.cleanpng.com/sh/c5d779c73c0f3c73aa995743ad511f38/L0KzQYm3VMA6N6N3fZH0aYP2gLBuTgJwapD5gdV8LYToc7n1jBxwb6oye9H2cIX3dcO0ifNwdqQygdD9ZYLxdcW0gv91NaN0etH9aXP2PYbogBI6OpZnT6Y6NnK4PoK8VsIxQGc7Sac7M0K8QIm8WcQ4PWYziNDw/kisspng-robotics-technology-computer-icons-internet-bot-robotics-5acb92eb7416b5.1562086615232908594755.png'),
            Text(
              chatbot_reply
            ),
            TextFormField(
              controller: _controller,
              textAlign: TextAlign.center,
              decoration: new InputDecoration.collapsed(
                hintText: 'Ask Archibald a question'
              ),
              onFieldSubmitted: (String text) async {
                if (text != '') {
                  setState(() {
                    chatbot_reply = "let me think about that";
                  });
                  http.Response Frank_response = await http.get('https://us-central1-bewhaos.cloudfunctions.net/receive_message?message=' + text);
                  setState(() {
                    // . BUG: uuid: 5e566d3c-75cc-11ea-af35-acde48001122
                    // description: Special characters are currently not rendered correctly
                    chatbot_reply = new String.fromCharCodes(Frank_response.bodyBytes);
                  });
                  _controller.clear();
                };
              },
            )
          ],
        ),
      ),
    );
  }
}
