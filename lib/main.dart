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
      home: MyHomePage(),
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

class MyGoogleLoginPage extends StatefulWidget {
  @override
  _MyGoogleLoginPageState createState() => _MyGoogleLoginPageState();
}

class _MyGoogleLoginPageState extends State<MyGoogleLoginPage>{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    return user;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('none'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 24.0),
            RaisedButton(
              child: const Text('Test SignIn/SignOut'),
              onPressed: () => _pushPage(context, SignInPage()),
            ),
            FlatButton(
              child: Text('SignIn'),
              onPressed: () => _handleSignIn()
                .then((FirebaseUser user) => print(user))
                .catchError((e) => print(e))
            ),
          ],
        ),
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}