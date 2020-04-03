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
      home: MyHomePage(title: 'Bewhaos admin page'),
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
  TextEditingController keyvalue_controller = new TextEditingController();
  TextEditingController response_controller = new TextEditingController();

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
      body: Builder(builder: (context) => Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.all(300.0),
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
              Text("Add response to keyword"),

              Padding(padding: EdgeInsets.all(5)),

              TextFormField(
                controller: keyvalue_controller,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  hintText: 'keyvalue: nails',
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.all(5)),

              TextFormField(
                controller: response_controller,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  hintText: "Response: nails can be found in isle 5",
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  ),
              ),

              Builder(builder: (context) => RaisedButton(
                onPressed: () async {
                  if (keyvalue_controller.text == '' || response_controller.text == '') {
                      Scaffold.of(context).showSnackBar(
                        new SnackBar(
                                content: Text('please add a keyvalue and the chatbots response'),
                                duration: Duration(seconds: 3),
                        ));
                  } else {
                    http.Response upload_status = await http.get('https://us-central1-bewhaos.cloudfunctions.net/update_keywords?keyword=' + keyvalue_controller.text + '&message=' + response_controller.text);
                    if (upload_status.body == '"success"') {
                      keyvalue_controller.clear();
                      response_controller.clear();
                      Scaffold.of(context).showSnackBar(
                        new SnackBar(
                                content: Text('Sucessfully added keyword and response to chatbot'),
                                duration: Duration(seconds: 3),
                        ));
                    }
                  }
                },
                child: Text('update chatbot'),

                ),
              ),
            ]
          ),
        ),
      ),),
    );
  }
}
