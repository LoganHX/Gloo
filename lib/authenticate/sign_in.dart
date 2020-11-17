// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:alpha_gloo/graphics/gloo_theme.dart';
// import 'package:alpha_gloo/src/components/bubble_indication_painter.dart';
//
// class SignIn extends StatefulWidget {
//   final Function toggleView;
//   SignIn({this.toggleView});
//   //SignIn({Key key}) : super(key: key);
//
//   @override
//   _SignInState createState() => new _SignInState();
// }
//
// class _SignInState extends State<SignIn>
//     with SingleTickerProviderStateMixin {
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   final FocusNode myFocusNodeEmailLogin = FocusNode();
//   final FocusNode myFocusNodePasswordLogin = FocusNode();
//
//   final FocusNode myFocusNodePassword = FocusNode();
//   final FocusNode myFocusNodeEmail = FocusNode();
//   final FocusNode myFocusNodeName = FocusNode();
//
//   TextEditingController loginEmailController = new TextEditingController();
//   TextEditingController loginPasswordController = new TextEditingController();
//
//   bool _obscureTextLogin = true;
//   bool _obscureTextSignup = true;
//   bool _obscureTextSignupConfirm = true;
//
//   TextEditingController signupEmailController = new TextEditingController();
//   TextEditingController signupNameController = new TextEditingController();
//   TextEditingController signupPasswordController = new TextEditingController();
//   TextEditingController signupConfirmPasswordController =
//   new TextEditingController();
//
//   PageController _pageController;
//
//   Color left = GlooTheme.grey;
//   Color right = Colors.white;
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       key: _scaffoldKey,
//       body: NotificationListener<OverscrollIndicatorNotification>(
//         onNotification: (overscroll) {
//           overscroll.disallowGlow();
//         },
//         child: SingleChildScrollView(
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height >= 775.0
//                 ? MediaQuery.of(context).size.height
//                 : 775.0,
//             decoration: new BoxDecoration(
//               gradient: new LinearGradient(
//                   colors: [
//
//                     GlooTheme.purple,
//                     GlooTheme.nearlyPurple,
//                   ],
//                   begin: const FractionalOffset(0.0, 0.0),
//                   end: const FractionalOffset(1.0, 1.0),
//                   stops: [0.0, 1.0],
//                   tileMode: TileMode.clamp),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(top: 5.0),
//                   child: new Image(
//                       height: 300,
//                       fit: BoxFit.fill,
//                       image: new AssetImage('assets/images/login.png')),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 20.0),
//                   child: _buildMenuBar(context),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: PageView(
//                     controller: _pageController,
//                     onPageChanged: (i) {
//                       if (i == 0) {
//                         setState(() {
//                           right = Colors.white;
//                           left = GlooTheme.grey;
//                         });
//                       } else if (i == 1) {
//                         setState(() {
//                           right = GlooTheme.grey;
//                           left = Colors.white;
//                         });
//                       }
//                     },
//                     children: <Widget>[
//                       new ConstrainedBox(
//                         constraints: const BoxConstraints.expand(),
//                         child: _buildSignIn(context),
//                       ),
//                       new ConstrainedBox(
//                         constraints: const BoxConstraints.expand(),
//                         child: _buildSignUp(context),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     myFocusNodePassword.dispose();
//     myFocusNodeEmail.dispose();
//     myFocusNodeName.dispose();
//     _pageController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//
//     _pageController = PageController();
//   }
//
//   void showInSnackBar(String value) {
//     FocusScope.of(context).requestFocus(new FocusNode());
//     _scaffoldKey.currentState?.removeCurrentSnackBar();
//     _scaffoldKey.currentState.showSnackBar(new SnackBar(
//       content: new Text(
//         value,
//         textAlign: TextAlign.center,
//         style: TextStyle(
//             color: Colors.white,
//             fontSize: 16.0,
//             fontFamily: "WorkSansSemiBold"),
//       ),
//       backgroundColor: Colors.blue,
//       duration: Duration(seconds: 3),
//     ));
//   }
//
//   Widget _buildMenuBar(BuildContext context) {
//     return Container(
//       width: 300.0,
//       height: 50.0,
//       decoration: BoxDecoration(
//         color: Color(0x552B2B2B),
//         borderRadius: BorderRadius.all(Radius.circular(25.0)),
//       ),
//       child: CustomPaint(
//         painter: TabIndicationPainter(pageController: _pageController),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Expanded(
//               child: FlatButton(
//                 splashColor: Colors.transparent,
//                 highlightColor: Colors.transparent,
//                 onPressed: _onSignInButtonPress,
//                 child: Text(
//                   "Existing",
//                   style: TextStyle(
//                       color: left,
//                       fontSize: 16.0,
//                       fontFamily: "WorkSansSemiBold"),
//                 ),
//               ),
//             ),
//             //Container(height: 33.0, width: 1.0, color: Colors.white),
//             Expanded(
//               child: FlatButton(
//                 splashColor: Colors.transparent,
//                 highlightColor: Colors.transparent,
//                 onPressed: _onSignUpButtonPress,
//                 child: Text(
//                   "New",
//                   style: TextStyle(
//                       color: right,
//                       fontSize: 16.0,
//                       fontFamily: "WorkSansSemiBold"),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSignIn(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 23.0),
//       child: Column(
//         children: <Widget>[
//           Stack(
//             alignment: Alignment.topCenter,
//             overflow: Overflow.visible,
//             children: <Widget>[
//               Card(
//                 elevation: 2.0,
//                 color: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Container(
//                   width: 300.0,
//                   height: 190.0,
//                   child: Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                         child: TextField(
//                           focusNode: myFocusNodeEmailLogin,
//                           controller: loginEmailController,
//                           keyboardType: TextInputType.emailAddress,
//                           style: TextStyle(
//                               fontFamily: "WorkSansSemiBold",
//                               fontSize: 16.0,
//                               color: GlooTheme.grey),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             icon: Icon(
//                               FontAwesomeIcons.envelope,
//                               color: GlooTheme.grey,
//                               size: 22.0,
//                             ),
//                             hintText: "Email Address",
//                             hintStyle: TextStyle(
//                                 fontFamily: "WorkSansSemiBold", fontSize: 17.0),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 250.0,
//                         height: 1.0,
//                         color: Colors.grey[400],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                         child: TextField(
//                           focusNode: myFocusNodePasswordLogin,
//                           controller: loginPasswordController,
//                           obscureText: _obscureTextLogin,
//                           style: TextStyle(
//                               fontFamily: "WorkSansSemiBold",
//                               fontSize: 16.0,
//                               color: GlooTheme.grey),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             icon: Icon(
//                               FontAwesomeIcons.lock,
//                               size: 22.0,
//                               color: GlooTheme.grey,
//                             ),
//                             hintText: "Password",
//                             hintStyle: TextStyle(
//                                 fontFamily: "WorkSansSemiBold", fontSize: 17.0),
//                             suffixIcon: GestureDetector(
//                               onTap: _toggleLogin,
//                               child: Icon(
//                                 _obscureTextLogin
//                                     ? FontAwesomeIcons.eye
//                                     : FontAwesomeIcons.eyeSlash,
//                                 size: 15.0,
//                                 color: GlooTheme.grey,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 170.0),
//                 decoration: new BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                   boxShadow: <BoxShadow>[
//                     BoxShadow(
//                       color: GlooTheme.nearlyPurple,
//                       offset: Offset(1.0, 6.0),
//                       blurRadius: 20.0,
//                     ),
//                     BoxShadow(
//                       color: GlooTheme.purple,
//                       offset: Offset(1.0, 6.0),
//                       blurRadius: 20.0,
//                     ),
//                   ],
//                   gradient: new LinearGradient(
//                       colors: [
//                         GlooTheme.purple,
//                         GlooTheme.purple
//                       ],
//                       begin: const FractionalOffset(0.2, 0.2),
//                       end: const FractionalOffset(1.0, 1.0),
//                       stops: [0.0, 1.0],
//                       tileMode: TileMode.clamp),
//                 ),
//                 child: MaterialButton(
//                     highlightColor: Colors.transparent,
//                     //splashColor: Theme.Colors.loginGradientEnd,
//                     //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 42.0),
//                       child: Text(
//                         "LOGIN",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 25.0,
//                             fontFamily: "WorkSansBold"),
//                       ),
//                     ),
//                     onPressed: () =>
//                         showInSnackBar("Login button pressed")),
//               ),
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 10.0),
//             child: FlatButton(
//                 onPressed: () {},
//                 child: Text(
//                   "Forgot Password?",
//                   style: TextStyle(
//                       decoration: TextDecoration.underline,
//                       color: Colors.white,
//                       fontSize: 16.0,
//                       fontFamily: "WorkSansMedium"),
//                 )),
//           ),
//           // Padding(
//           //   padding: EdgeInsets.only(top: 10.0),
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.center,
//           //     children: <Widget>[
//           //       Container(
//           //         decoration: BoxDecoration(
//           //           gradient: new LinearGradient(
//           //               colors: [
//           //                 Colors.white10,
//           //                 Colors.white,
//           //               ],
//           //               begin: const FractionalOffset(0.0, 0.0),
//           //               end: const FractionalOffset(1.0, 1.0),
//           //               stops: [0.0, 1.0],
//           //               tileMode: TileMode.clamp),
//           //         ),
//           //         width: 100.0,
//           //         height: 1.0,
//           //       ),
//           //       Padding(
//           //         padding: EdgeInsets.only(left: 15.0, right: 15.0),
//           //         child: Text(
//           //           "Or",
//           //           style: TextStyle(
//           //               color: Colors.white,
//           //               fontSize: 16.0,
//           //               fontFamily: "WorkSansMedium"),
//           //         ),
//           //       ),
//           //       Container(
//           //         decoration: BoxDecoration(
//           //           gradient: new LinearGradient(
//           //               colors: [
//           //                 Colors.white,
//           //                 Colors.white10,
//           //               ],
//           //               begin: const FractionalOffset(0.0, 0.0),
//           //               end: const FractionalOffset(1.0, 1.0),
//           //               stops: [0.0, 1.0],
//           //               tileMode: TileMode.clamp),
//           //         ),
//           //         width: 100.0,
//           //         height: 1.0,
//           //       ),
//           //     ],
//           //   ),
//           // ),
//
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSignUp(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 23.0),
//       child: Column(
//         children: <Widget>[
//           Stack(
//             alignment: Alignment.topCenter,
//             overflow: Overflow.visible,
//             children: <Widget>[
//               Card(
//                 elevation: 2.0,
//                 color: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Container(
//                   width: 300.0,
//                   height: 360.0,
//                   child: Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                         child: TextField(
//                           focusNode: myFocusNodeName,
//                           controller: signupNameController,
//                           keyboardType: TextInputType.text,
//                           textCapitalization: TextCapitalization.words,
//                           style: TextStyle(
//                               fontFamily: "WorkSansSemiBold",
//                               fontSize: 16.0,
//                               color: GlooTheme.grey),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             icon: Icon(
//                               FontAwesomeIcons.user,
//                               color: GlooTheme.grey,
//                             ),
//                             hintText: "Name",
//                             hintStyle: TextStyle(
//                                 fontFamily: "WorkSansSemiBold", fontSize: 16.0),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 250.0,
//                         height: 1.0,
//                         color: Colors.grey[400],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                         child: TextField(
//                           focusNode: myFocusNodeEmail,
//                           controller: signupEmailController,
//                           keyboardType: TextInputType.emailAddress,
//                           style: TextStyle(
//                               fontFamily: "WorkSansSemiBold",
//                               fontSize: 16.0,
//                               color: GlooTheme.grey),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             icon: Icon(
//                               FontAwesomeIcons.envelope,
//                               color: GlooTheme.grey,
//                             ),
//                             hintText: "Email Address",
//                             hintStyle: TextStyle(
//                                 fontFamily: "WorkSansSemiBold", fontSize: 16.0),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 250.0,
//                         height: 1.0,
//                         color: Colors.grey[400],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                         child: TextField(
//                           focusNode: myFocusNodePassword,
//                           controller: signupPasswordController,
//                           obscureText: _obscureTextSignup,
//                           style: TextStyle(
//                               fontFamily: "WorkSansSemiBold",
//                               fontSize: 16.0,
//                               color: GlooTheme.grey),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             icon: Icon(
//                               FontAwesomeIcons.lock,
//                               color: GlooTheme.grey,
//                             ),
//                             hintText: "Password",
//                             hintStyle: TextStyle(
//                                 fontFamily: "WorkSansSemiBold", fontSize: 16.0),
//                             suffixIcon: GestureDetector(
//                               onTap: _toggleSignup,
//                               child: Icon(
//                                 _obscureTextSignup
//                                     ? FontAwesomeIcons.eye
//                                     : FontAwesomeIcons.eyeSlash,
//                                 size: 15.0,
//                                 color: GlooTheme.grey,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 250.0,
//                         height: 1.0,
//                         color: Colors.grey[400],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                         child: TextField(
//                           controller: signupConfirmPasswordController,
//                           obscureText: _obscureTextSignupConfirm,
//                           style: TextStyle(
//                               fontFamily: "WorkSansSemiBold",
//                               fontSize: 16.0,
//                               color: GlooTheme.grey),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             icon: Icon(
//                               FontAwesomeIcons.lock,
//                               color: GlooTheme.grey,
//                             ),
//                             hintText: "Confirmation",
//                             hintStyle: TextStyle(
//                                 fontFamily: "WorkSansSemiBold", fontSize: 16.0),
//                             suffixIcon: GestureDetector(
//                               onTap: _toggleSignupConfirm,
//                               child: Icon(
//                                 _obscureTextSignupConfirm
//                                     ? FontAwesomeIcons.eye
//                                     : FontAwesomeIcons.eyeSlash,
//                                 size: 15.0,
//                                 color: GlooTheme.grey,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 340.0),
//                 decoration: new BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                   boxShadow: <BoxShadow>[
//                     BoxShadow(
//                       color: GlooTheme.nearlyPurple,
//                       offset: Offset(1.0, 6.0),
//                       blurRadius: 20.0,
//                     ),
//                     BoxShadow(
//                       color:GlooTheme.purple,
//                       offset: Offset(1.0, 6.0),
//                       blurRadius: 20.0,
//                     ),
//                   ],
//                   gradient: new LinearGradient(
//                       colors: [
//                         GlooTheme.purple,
//                         GlooTheme.nearlyPurple
//                       ],
//                       begin: const FractionalOffset(0.2, 0.2),
//                       end: const FractionalOffset(1.0, 1.0),
//                       stops: [0.0, 1.0],
//                       tileMode: TileMode.clamp),
//                 ),
//                 child: MaterialButton(
//                     highlightColor: Colors.transparent,
//                     splashColor: GlooTheme.purple,
//                     //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 42.0),
//                       child: Text(
//                         "SIGN UP",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 25.0,
//                             fontFamily: "WorkSansBold"),
//                       ),
//                     ),
//                     onPressed: () =>
//                         showInSnackBar("SignUp button pressed")),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _onSignInButtonPress() {
//     _pageController.animateToPage(0,
//         duration: Duration(milliseconds: 500), curve: Curves.decelerate);
//   }
//
//   void _onSignUpButtonPress() {
//     _pageController?.animateToPage(1,
//         duration: Duration(milliseconds: 500), curve: Curves.decelerate);
//   }
//
//   void _toggleLogin() {
//     setState(() {
//       _obscureTextLogin = !_obscureTextLogin;
//     });
//   }
//
//   void _toggleSignup() {
//     setState(() {
//       _obscureTextSignup = !_obscureTextSignup;
//     });
//   }
//
//   void _toggleSignupConfirm() {
//     setState(() {
//       _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
//     });
//   }
// }


import 'package:alpha_gloo/services/auth.dart';
import 'package:alpha_gloo/shared/constants.dart';
import 'package:alpha_gloo/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:alpha_gloo/graphics/gloo_theme.dart';

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