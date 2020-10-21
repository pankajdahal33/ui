import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: new Design(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Design extends StatefulWidget {
  @override
  _DesignState createState() => _DesignState();
}

class _DesignState extends State<Design> {
  bool isLogIn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Center(
                child: new Image.asset(
                  'assets/img.png',
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/Login.png'),
                    backgroundColor: Colors.white,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Pacifico',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    width: 250.0,
                    child: Divider(
                      color: Colors.teal.shade100,
                    ),
                  ),
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(
                          Icons.mail,
                          color: Colors.green,
                        ),
                        title: TextField(
                          decoration: InputDecoration(hintText: 'Email'),
                          controller: emailTextController,
                        ),
                      )),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(
                        Icons.lock,
                        color: Colors.green,
                      ),
                      title: TextField(
                        decoration: InputDecoration(hintText: 'Password'),
                        controller: passwordTextController,
                        obscureText: true,
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      child: Text(
                        'LogIn',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontFamily: 'Girassol',
                            letterSpacing: 2.5),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        isLogIn
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondPage()))
                            : _login();
                        emailTextController.text = '';
                        passwordTextController.text = '';
                      },
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                    child: Column(
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Girassol',
                                letterSpacing: 2.5),
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(
                          height: 20.0,
                          width: 350.0,
                          child: Divider(
                            color: Colors.teal.shade100,
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Still not connected?'),
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Girassol',
                                    letterSpacing: 2.5),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(FontAwesomeIcons.facebook),
                              iconSize: 40.0,
                              onPressed: () {
                                _facebookLogin();
                              },
                              color: Colors.blueAccent,
                            ),
                            IconButton(
                              icon: Icon(FontAwesomeIcons.google),
                              iconSize: 40.0,
                              onPressed: () {
                                _googleSignUp();
                              },
                              color: Colors.orangeAccent,
                            ),
                            IconButton(
                              icon: Icon(Icons.mail),
                              iconSize: 40.0,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpWithEmail(),
                                  ),
                                );
                              },
                              color: Colors.green,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  Future<void> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SecondPage()));
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> _facebookLogin() async{
    try {
      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);

      if(result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,

        );
        final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        print('signed in ' + user.displayName);
        return user;
      }
    }catch (e) {
      print(e.message);
    }
  }

  Future<FirebaseUser> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SecondPage()));
      // since something changed, let's notify the listeners...
    } catch (e) {
      // throw the Firebase AuthException that we caught
      // print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Email or Password Mismatch!!!'),
            );
          });
    }
    setState(() {
      isLogIn = false;
    });
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Column(
        children: <Widget>[Center(child: Text('you are loggedin as'))],
      ),
    );
  }
}

class SignUpWithEmail extends StatefulWidget {
  @override
  _SignUpWithEmailState createState() => _SignUpWithEmailState();
}

class _SignUpWithEmailState extends State<SignUpWithEmail> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  Future<void> signUpWithMail() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("SignUp Success"),
            );
          });
    } catch (e) {
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Center(
                child: new Image.asset(
                  'assets/img.png',
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/Login.png'),
                    backgroundColor: Colors.white,
                  ),
                  Text(
                    'Sign UP',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Pacifico',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    width: 250.0,
                    child: Divider(
                      color: Colors.teal.shade100,
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(
                        Icons.supervised_user_circle,
                        color: Colors.green,
                      ),
                      title: TextField(
                        decoration: InputDecoration(hintText: 'Email'),
                        controller: emailTextController,
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(
                        Icons.lock,
                        color: Colors.green,
                      ),
                      title: TextField(
                        decoration: InputDecoration(hintText: 'Password'),
                        controller: passwordTextController,
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      child: Text(
                        'SignUp',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontFamily: 'Girassol',
                            letterSpacing: 2.5),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        signUpWithMail();
                      },
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Already A Member?',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Girassol',
                          letterSpacing: 2.5),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
