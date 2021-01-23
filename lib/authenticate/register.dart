import 'package:alpha_gloo/services/auth.dart';
import 'package:alpha_gloo/shared/constants.dart';
import 'package:alpha_gloo/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:alpha_gloo/graphics/gloo_theme.dart';


class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

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
      // backgroundColor: Colors.brown[100],
      // appBar: AppBar(
      //   backgroundColor: Colors.brown[400],
      //   elevation: 0.0,
      //   title: Text("Sign up to Gloo"),
      //   actions: <Widget>[
      //     FlatButton.icon(
      //       icon: Icon(Icons.person),
      //       label: Text("Sign in"),
      //       onPressed: () {
      //         widget.toggleView();
      //       },
      //     )
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
                Text("Register", style: TextStyle(color: GlooTheme.nearlyPurple, fontSize: 32),),

                SizedBox(height: 20.0),
                TextFormField(

                  decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(
                        12.0,
                      ),
                    fillColor: GlooTheme.nearlyPurple,
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: "Email",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: GlooTheme.purple),
                      ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: GlooTheme.nearlyPurple ),
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
                    hintStyle: TextStyle(
                      color: GlooTheme.nearlyPurple,
                    ),
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(
                        12.0,
                      ),
                      fillColor: GlooTheme.nearlyPurple,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: GlooTheme.purple),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Password",
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(8),
                         borderSide: BorderSide(color: GlooTheme.nearlyPurple),
                       )
                  ),
                  obscureText: true,
                  validator: (val) => val.length < 8 ? "Password must be longer than 8 chars" : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: GlooTheme.purple,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "Register",
                      style: TextStyle(color: GlooTheme.nearlyPurple),
                    ),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          error = "Please supply a valid email";
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                  FlatButton(
                    color: Colors.transparent,
                    child: Text(
                      "Login",
                      style: TextStyle(color: GlooTheme.nearlyPurple),
                    ),
                    onPressed: () {
                      widget.toggleView();
                    },
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
