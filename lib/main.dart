import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'random_words.dart';
import 'image_manager.dart';
import 'package:hello_flutter/signin_page.dart';
import 'package:hello_flutter/widget_sample.dart';

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
        '/widgetSample': (context) => WidgetSample(),
      },
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('none'),
      ),
      body: (new RandomWords()).buildSuggestions(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/signInPage');
              break;
            case 1:
              Navigator.pushNamed(context, '/');
              break;
            case 2:
              Navigator.pushNamed(context, '/widgetSample');
              break;
            default:
              Navigator.pushNamed(context, '/');
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("SignIn")),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text("RandomWords")),
          BottomNavigationBarItem(
              icon: Icon(Icons.widgets), title: Text("Samples")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: getImage,
      ),
    );
  }
}
