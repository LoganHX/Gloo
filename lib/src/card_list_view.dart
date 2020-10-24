import 'package:alpha_gloo/src/gloo_theme.dart';
import 'package:alpha_gloo/src/models/category.dart';
import 'package:alpha_gloo/main.dart';
import 'package:flutter/material.dart';

class CardListView extends StatefulWidget {
  const CardListView({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  _CardListViewState createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        height: 275,
        width: double.infinity,
        child: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: Category.categoryList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = Category.categoryList.length > 10
                      ? 10
                      : Category.categoryList.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController.forward();

                  return CardView(
                    category: Category.categoryList[index],
                    animation: animation,
                    animationController: animationController,
                    callback: () {
                      widget.callBack();
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class CardView extends StatelessWidget {
  const CardView(
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
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback();
              },
              child: SizedBox(
                width: 270,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 22),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(

                              decoration: BoxDecoration(
                                color: GlooTheme.nearlyPurple,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                              ),
                              child: Row(
                                children: <Widget>[

                                  Expanded(
                                    child: Container(
                                      child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 5), //bottom per il pulsante modifica
                                            child: Center(child:Text(
                                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ",
                                              textAlign: TextAlign.center,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: GlooTheme.purple,
                                              ),
                                            ),),
                                          ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child:
                                          Container(
                                              width: 40,
                                              height: 40,
                                              decoration: new BoxDecoration(color: GlooTheme.purple),


                                            child:Icon(
                                              Icons.edit,
                                              color: GlooTheme.nearlyPurple,
                                          ),
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

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
