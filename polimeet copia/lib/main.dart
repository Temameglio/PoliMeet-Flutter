import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import "auth_sercive.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor mycolor = MaterialColor(
      Color.fromARGB(255, 0, 0, 0).value,
      <int, Color>{
        50: Color.fromRGBO(196, 45, 255, 0.1),
        100: Color.fromRGBO(196, 45, 255, 0.2),
        200: Color.fromRGBO(196, 45, 255, 0.3),
        300: Color.fromRGBO(196, 45, 255, 0.4),
        400: Color.fromRGBO(196, 45, 255, 0.5),
        500: Color.fromRGBO(196, 45, 255, 0.6),
        600: Color.fromRGBO(196, 45, 255, 0.7),
        700: Color.fromRGBO(196, 45, 255, 0.8),
        800: Color.fromRGBO(196, 45, 255, 0.9),
        900: Color.fromRGBO(196, 45, 255, 1),
      },
    );

    return MaterialApp(
      title: 'Flutter Demo',
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
          primarySwatch: mycolor),
      home: MyHomePage(title: 'PoliMeet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color mycolor1 = Color.fromARGB(255, 196, 45, 225);
  Color mycolor2 = Color.fromARGB(255, 65, 245, 255);
  Color mycolor3 = Color.fromARGB(255, 0, 255, 187);
  List<int> MyColorList1 = [196, 45, 225];
  List<int> MyColorList2 = [65, 245, 255];
  List<int> MyColorList3 = [0, 255, 187];

  List<int> getColor(int rDisplacement, int gDisplacement, int bDisplacement) {
    /*int abs = 2000;
    print("a");
    double phi = asin(bDisplacement / abs);
    double theta = asin(gDisplacement / (abs * cos(phi)));
    List<List<double>> matrixList = [
      [cos(counter), 0, sin(counter) * cos(theta)],
      [0, cos(counter), sin(counter) * cos(theta)],
      [-(sin(counter) / cos(theta)), 0, cos(counter)]
    ];
    List<double> startVector = [
      rDisplacement * 0.7,
      gDisplacement * 0.7,
      bDisplacement * 0.7
    ];
    List<int> result = [];
    for (int i = 0; i < 3; ++i) {
      result.add(((matrixList[i][0] * startVector[0]).abs() +
              (matrixList[i][1] * startVector[1]).abs() +
              (matrixList[i][2] * startVector[2]).abs())
          .toInt());
    }
    print(result);*/
    List<int> startVector = [
      rDisplacement.toInt(),
      gDisplacement.toInt(),
      bDisplacement.toInt()
    ];

    int max_value = startVector.reduce(max);
    int min_value = startVector.reduce(min);
    double track = 0;
    int MaxCount = 0;
    int MinCount = 0;

    for (int i = 0; i < 3; ++i) {
      if (startVector[i] == max_value) {
        MaxCount++;
        if (MaxCount == 2) {
          if (i == 1) {
            startVector[i] -= 1;
          } else if (startVector[0] == max_value) {
            startVector[0] -= 1;
          } else {
            startVector[2] -= 1;
          }
        }
      } else if (startVector[i] == min_value) {
        MinCount++;
        if (MinCount == 2) {
          if (i == 1) {
            startVector[i] += 1;
          } else if (startVector[0] == min_value) {
            startVector[0] += 1;
          } else {
            startVector[2] += 1;
          }
        }
      } else {
        if (startVector[0] == max_value && startVector[2] == min_value) {
          startVector[1] -= 1;
        } else if (startVector[0] == min_value && startVector[2] == max_value) {
          startVector[1] += 1;
        } else if (startVector[1] == max_value && startVector[2] == min_value) {
          startVector[0] += 1;
        } else if (startVector[1] == min_value && startVector[2] == max_value) {
          startVector[0] -= 1;
        } else if (startVector[0] == max_value && startVector[1] == min_value) {
          startVector[2] += 1;
        } else if (startVector[0] == min_value && startVector[1] == max_value) {
          startVector[2] -= 1;
        }
      }
    }
    return startVector;
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void ChangeColor() {
    setState(() {
      int colorcounter = _counter;
      MyColorList1 =
          getColor(MyColorList1[0], MyColorList1[1], MyColorList1[2]);
      MyColorList2 =
          getColor(MyColorList2[0], MyColorList2[1], MyColorList2[2]);
      MyColorList3 =
          getColor(MyColorList3[0], MyColorList3[1], MyColorList3[2]);
      mycolor1 = Color.fromARGB(
          255, MyColorList1[0], MyColorList1[1], MyColorList1[2]);
      mycolor2 = Color.fromARGB(
          255, MyColorList2[0], MyColorList2[1], MyColorList2[2]);
      mycolor3 = Color.fromARGB(
          255, MyColorList3[0], MyColorList3[1], MyColorList3[2]);
    });
  }

  @override
  void initState() {
    super.initState();
    Timer timer =
        Timer.periodic(Duration(milliseconds: 20), (Timer t) => ChangeColor());
  }

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
        title: Text(widget.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            )),

        shadowColor: Color.fromARGB(0, 85, 0, 127),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            mycolor1,
            mycolor2,
            mycolor3,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Center(
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
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50), maximumSize: Size(400, 100)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => SignUpPage())));
                  },
                  child: Text("Login")),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 50),
                        maximumSize: Size(600, 150)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => SignUpPage())));
                    },
                    child: Text("New Account")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String password = "";
  String email = "";
  AuthService? auth;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("PoliMeet",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              )),
          shadowColor: Color.fromARGB(0, 85, 0, 127),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Create new user",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
            Center(
                child: TextFormField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        /*focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),*/
                        labelStyle: TextStyle(
                          color: Color.fromARGB(100, 255, 255, 255),
                        ),
                        labelText: "Mail",
                        constraints:
                            BoxConstraints(maxWidth: 300, minWidth: 100)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Inserire la mail";
                      }
                      email = value;
                      return null;
                    })),
            Center(
                child: TextFormField(
                    obscureText: true,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        /*focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),*/
                        labelStyle: TextStyle(
                          color: Color.fromARGB(100, 255, 255, 255),
                        ),
                        labelText: "Password",
                        constraints:
                            BoxConstraints(maxWidth: 300, minWidth: 100)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter some text";
                      }
                      password = value;
                      return null;
                    })),
            Center(
                child: TextFormField(
                    obscureText: true,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        /*focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),*/
                        labelStyle: TextStyle(
                          color: Color.fromARGB(100, 255, 255, 255),
                        ),
                        labelText: "Reinserire Password",
                        constraints:
                            BoxConstraints(maxWidth: 300, minWidth: 100)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter some text";
                      }
                      if (value != password) {
                        return "Le password non corrispondono";
                      }
                      return null;
                    })),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 1.0, color: Colors.white),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //auth?.signUp(email: email, password: password);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ProfileSetupPage())));
                      }
                    },
                    child: Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ),
      ),
    );
  }
}

class ProfileSetupPage extends StatefulWidget {
  ProfileSetupPage({super.key});
  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("PoliMeet",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              )),
          shadowColor: Color.fromARGB(0, 85, 0, 127),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Create new user",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
            Center(
                child: TextFormField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        /*focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),*/
                        labelStyle: TextStyle(
                          color: Color.fromARGB(100, 255, 255, 255),
                        ),
                        labelText: "Nome",
                        constraints:
                            BoxConstraints(maxWidth: 300, minWidth: 100)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Inserire nome";
                      }
                      return null;
                    })),
            Center(
                child: TextFormField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        /*focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),*/
                        labelStyle: TextStyle(
                          color: Color.fromARGB(100, 255, 255, 255),
                        ),
                        labelText: "Cognome",
                        constraints:
                            BoxConstraints(maxWidth: 300, minWidth: 100)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Inserire cognome";
                      }
                      return null;
                    })),
            Center(
                child: TextFormField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        /*focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),*/
                        labelStyle: TextStyle(
                          color: Color.fromARGB(100, 255, 255, 255),
                        ),
                        labelText: "Username",
                        constraints:
                            BoxConstraints(maxWidth: 300, minWidth: 100)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter some text";
                      }
                      return null;
                    })),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 1.0, color: Colors.white),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //auth?.signUp(email: email, password: password);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ),
      ),
    );
  }
}
