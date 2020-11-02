import 'package:alpha_gloo/src/gloo_theme.dart';
import 'package:alpha_gloo/src/models/category.dart';
import 'package:alpha_gloo/main.dart';
import 'package:flutter/material.dart';

class DeckListView extends StatefulWidget {
  const DeckListView({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  _DeckListViewState createState() => _DeckListViewState();
}

class _DeckListViewState extends State<DeckListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 1),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return GridView(
              padding: const EdgeInsets.only(top:8, left:12, right:8, bottom: 8), //bottom è 30 perché se no il riquadro dell'ultima riga di tiles non ci entra
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
                Category.popularCourseList.length,
                    (int index) {
                  final int count = Category.popularCourseList.length;
                  final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController.forward();
                  return CategoryView(
                    callback: () {
                      widget.callBack();
                    },
                    category: Category.popularCourseList[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 32.0,
                childAspectRatio: 0.8,
              ),
            );
          }
        },
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key key,
        this.category,
        this.animationController,
        this.animation,
        this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Category category;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback();
              },
              child: SizedBox(
                height: 280,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Container(

                      child: Column(

                        children: <Widget>[
                          Expanded(

                            child: Container(

                              decoration: BoxDecoration(
                                color: GlooTheme.nearlyPurple,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: GlooTheme.nearlyPurple.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                    offset: Offset(-5, 3), // changes position of shadow
                                  ),
                                ],
                                // border: new Border.all(
                                //     color: GlooTheme.notWhite),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8,
                                        left: 16,
                                        right: 16,
                                        bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${category.lessonCount} cards',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 12,
                                            letterSpacing: 0.27,
                                            color: GlooTheme
                                                .purple,
                                          ),
                                        ),

                                        Container(

                                          child: Row(

                                            children: <Widget>[

                                              Text(

                                                '${category.rating} ',
                                                textAlign:
                                                TextAlign.right,
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w200,
                                                  fontSize: 12,
                                                  letterSpacing: 0.0,
                                                  color: GlooTheme.purple,
                                                ),
                                              ),
                                              Icon(
                                                Icons.star,
                                                color:
                                                GlooTheme
                                                    .purple,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(

                                    child: Container(

                                      child: Center(
                                      child: Column(
                                        mainAxisAlignment:MainAxisAlignment.center, crossAxisAlignment:CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16, bottom: 32),
                                            child:
                                            Center(child:Text(
                                              category.title,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: GlooTheme
                                                    .purple,
                                              ),
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 280,
                          // ),
                        ],
                      ),
                    ),
                    // Container(
                    //   child: Padding(
                    //     padding:
                    //     const EdgeInsets.only(top: 24, right: 16, left: 16),
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         borderRadius:
                    //         const BorderRadius.all(Radius.circular(16.0)),
                    //         boxShadow: <BoxShadow>[
                    //           BoxShadow(
                    //               color: GlooTheme.purple.withOpacity(0.2),
                    //               offset: const Offset(0.0, 0.0),
                    //               blurRadius: 6.0),
                    //         ],
                    //       ),
                    //       child: ClipRRect(
                    //         borderRadius:
                    //         const BorderRadius.all(Radius.circular(16.0)),
                    //         child: AspectRatio(
                    //             aspectRatio: 1.28,
                    //             child: Image.asset(category.imagePath)),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}