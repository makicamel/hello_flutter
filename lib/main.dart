import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'random_words.dart';
import 'image_manager.dart';
import './signin_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator!',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/signInPage': (context) => SignInPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    ImageManager.uploadImage(image);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('none'),
      ),
      body: (new RandomWords()).buildSuggestions(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: getImage,
      ),
      bottomNavigationBar: bottomNavigationBar()
    );
  }
}

Widget bottomNavigationBar () {
  return BottomNavigationBar(
    currentIndex: 0,
    onTap: (int index) {
      print("==> ${index}");
    },
    items: [
      new BottomNavigationBarItem(
        icon: new Icon(Icons.home),
        title: new Text("Home")
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.settings),
        title: new Text("Setting")
      ),
    ],
  );
}
