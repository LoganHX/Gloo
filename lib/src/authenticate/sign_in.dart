import 'package:alpha_gloo/services/auth.dart';
import 'package:alpha_gloo/shared/constants.dart';
import 'package:alpha_gloo/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:alpha_gloo/src/gloo_theme.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      // backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   title: Text("Sign in to Gloo"),
      //   actions: <Widget>[
      //     // FlatButton.icon(
      //     //   icon: Icon(Icons.person),
      //     //   label: Text("Register"),
      //     //   onPressed: () {
      //     //     widget.toggleView();
      //     //   },
      //     // )
      //   ],
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                GlooTheme.purple.withOpacity(0.9),
                GlooTheme.nearlyPurple
              ]),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text("Login", style: TextStyle(color: GlooTheme.nearlyPurple, fontSize: 32),),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                      fillColor: GlooTheme.nearlyPurple,
                      filled: true,
                      
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: GlooTheme.purple),
                        borderRadius: BorderRadius.circular(8),

                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: GlooTheme.nearlyPurple),
                        borderRadius: BorderRadius.circular(8),
                      )
                  ),
                  validator: (val) => val.isEmpty ? "Enter an email" : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: InputDecoration(
                        fillColor: GlooTheme.nearlyPurple,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: GlooTheme.purple),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: GlooTheme.nearlyPurple),
                          borderRadius: BorderRadius.circular(8),
                        )
                    ),
                  obscureText: true,
                  validator: (val) => val.length < 8 ? "Password must be longer than 8 chars" : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    RaisedButton(
                      color: GlooTheme.purple,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Text(
                          "Login",
                          style: TextStyle(color: GlooTheme.nearlyPurple),
                        ),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          setState(() => loading = true);
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                          if(result == null){
                            setState(() {
                              error = "Can't sign in with those credentials";
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    FlatButton(
                      color: Colors.transparent,
                      child: Text(
                        "Register",
                        style: TextStyle(color: GlooTheme.nearlyPurple),
                      ),
                      onPressed: () {
                        widget.toggleView();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.0,),
                Text(
                    error,
                    style: TextStyle(color: GlooTheme.purple, fontSize: 14.0)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
