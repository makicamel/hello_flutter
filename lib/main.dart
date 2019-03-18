import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'random_words.dart';
import 'image_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator!',
      home: MyGoogleLoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    );
  }
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
}