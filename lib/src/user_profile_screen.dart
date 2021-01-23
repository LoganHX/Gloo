import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:alpha_gloo/services/auth.dart';
import 'package:alpha_gloo/src/home/gloo_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => new _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return new Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: GlooTheme.bgGradient),
      child: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(color: GlooTheme.nearlyWhite),
            clipper: getClipper(),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).padding.top +
                          AppBar().preferredSize.height),
                  Text(
                    'Raffaella Carrà',
                    style: TextStyle(
                      color: GlooTheme.nearlyWhite,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 45.0),
                  Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                          color: GlooTheme.nearlyWhite,
                          image: DecorationImage(
                              image: AssetImage('assets/images/carra.jpg'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(75.0)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 7.0, color: GlooTheme.nearlyWhite)
                          ])),
                  SizedBox(height: 45.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Bio",
                          style: TextStyle(
                              fontSize: 24,
                              color: GlooTheme.nearlyWhite,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        "Com'è bello far l'amore da Trieste in Gloo",
                        style: TextStyle(
                            fontSize: 20, color: GlooTheme.nearlyWhite),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 24, color: GlooTheme.nearlyWhite),
                        ),
                      ),
                      Text(
                        "raffaella@carra.it",
                        style: TextStyle(
                            fontSize: 20, color: GlooTheme.nearlyWhite),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Università",
                          style: TextStyle(
                              fontSize: 24, color: GlooTheme.nearlyWhite),
                        ),
                      ),
                      Text(
                        "Università degli studi di Salerno",
                        style: TextStyle(
                            fontSize: 20, color: GlooTheme.nearlyWhite),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
          //   child: Text(
          //     "Com'è bello far l'amore da Trieste in Gloo",
          //     style: TextStyle(
          //       color: GlooTheme.nearlyWhite,
          //       fontSize: 17.0,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          SizedBox(height: 25.0),
          // MaterialButton(
          //   onPressed: () {},
          //   color: GlooTheme.grey,
          //   textColor: GlooTheme.nearlyWhite,
          //   child: Icon(
          //     Icons.edit_outlined,
          //     size: 24,
          //   ),
          //   padding: EdgeInsets.all(16),
          //   shape: CircleBorder(),
          // ),
          // SizedBox(height: 25.0),
          // MaterialButton(
          //   onPressed: () async {
          //     await _auth.signOut();
          //     Navigator.pushNamed(
          //         context, '/');
          //   },
          //   color: GlooTheme.purple,
          //   textColor: GlooTheme.nearlyWhite,
          //   child: Icon(
          //     Icons.logout,
          //     size: 24,
          //   ),
          //   padding: EdgeInsets.all(16),
          //   shape: CircleBorder(),
          // ),
          Padding(
            //App bar da mettere anche nella pagina seguente
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(
              width: AppBar().preferredSize.height,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    Icons.arrow_back_ios, //ios
                    color: GlooTheme.nearlyWhite,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, 0.0 / 1.9);
    path.lineTo(0.0, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
