import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

FirebaseUser data;

final GoogleSignIn googleSignIn = new GoogleSignIn();
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  Future<FirebaseUser> _signIn() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: gSA.idToken, accessToken: gSA.accessToken);
    final AuthResult authResult = await _auth.signInWithCredential(credential);
     FirebaseUser user = authResult.user;

   
    data = user;
    print("User name: ${user.displayName}");
    Navigator.push(context, MaterialPageRoute(builder: (context)=> new Openpage()));
    return user;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 150.0,
                ),
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/images/logo.jpg",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                TextField(
                  keyboardType: TextInputType.number,
                  style: style,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Mobile No.",
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                ),
                SizedBox(height: 35.0),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {},
                    child: Text("Login With Mobile no.",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),

                SizedBox(
                  height: 35.0,
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: ()=> _signIn(),
                    child: new Row(
                      children: <Widget>[
                        new Image.asset('assets/images/google_sign_in.png',
                        height: 30.0,),
                        new Expanded(child: Text('Sign in with google',
                          style: style.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                          )
                        )
                      ],
                    )
                  ),
                ),
                SizedBox(
                  height: 125.0,
                ),
              ],
            ),
          ),
        ),
      ),
        )
    );
  }
   
}

class Openpage extends StatefulWidget {
  @override
  _OpenpageState createState() => _OpenpageState();
}

class _OpenpageState extends State<Openpage> {

  void _signOut(){
    googleSignIn.signOut();
    print("sign out");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 150.0
          ),
          Center(
            child: Text("${data.displayName}"),
          ),
          new RaisedButton(
            onPressed:_signOut,
            child: Text("Sign out"),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}


