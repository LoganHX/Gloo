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
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [GlooTheme.purple, GlooTheme.nearlyPurple]),
      ),
      child:  Center(
        child: Stack(

          children: <Widget>[
            ClipPath(
              child: Container(color: GlooTheme.nearlyPurple),
              clipper: getClipper(),
            ),
            Positioned(
                width: MediaQuery.of(context).size.width,
                top: MediaQuery.of(context).size.height / 6,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            color: GlooTheme.nearlyPurple,
                            image: DecorationImage(
                                image: AssetImage('assets/images/carra.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ])),
                    SizedBox(height: 45.0),
                    Text(
                      'Raffaella Carrà',
                      style: TextStyle(
                        color: GlooTheme.nearlyPurple,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Credo molto nel lifelong learning',
                      style: TextStyle(
                        color: GlooTheme.nearlyPurple,
                        fontSize: 17.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25.0),
                    MaterialButton(
                      onPressed: () {},
                      color: GlooTheme.grey,
                      textColor: GlooTheme.nearlyPurple,
                      child: Icon(
                        Icons.edit_outlined,
                        size: 24,
                      ),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),

                    SizedBox(height: 25.0),
                    MaterialButton(
                      onPressed: () async {
                        await _auth.signOut();
                        Navigator.pushNamed(context,
                            '/'); //todo da fare meglio, dubito si faccia così
                      },
                      color: GlooTheme.purple,
                      textColor: GlooTheme.nearlyPurple,
                      child: Icon(
                        Icons.logout,
                        size: 24,
                      ),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),

                  ],
                )),
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
                      color: GlooTheme.nearlyPurple,
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
    // TODO: implement shouldReclip
    return true;
  }
}
