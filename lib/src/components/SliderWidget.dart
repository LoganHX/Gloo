import 'package:alpha_gloo/graphics/gloo_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_slider_thumb_circle.dart';

class SliderWidget extends StatefulWidget {
  final double sliderHeight;
  final int min;
  final int max;
  final fullWidth;
  final Function onSelectedValue;

  SliderWidget(
      {this.sliderHeight = 45,
      this.max = 5,
      this.min = 0,
      this.fullWidth = false,
      this.onSelectedValue});

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    double paddingFactor = .2;

    if (this.widget.fullWidth) paddingFactor = .3;

    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      width: this.widget.fullWidth
          ? double.infinity
          : (this.widget.sliderHeight) * 6.6,
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(
          Radius.circular((this.widget.sliderHeight * 0.7)),
        ),
        color: GlooTheme.nearlyPurple,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(this.widget.sliderHeight * paddingFactor,
            2, this.widget.sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            Text(
              '${this.widget.min}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: this.widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: GlooTheme.purple.withOpacity(0.85),
              ),
            ),
            SizedBox(
              width: this.widget.sliderHeight * .1,
            ),
            Expanded(
              child: Center(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: GlooTheme.purple.withOpacity(0.85),
                    inactiveTrackColor: GlooTheme.purple.withOpacity(0.85),

                    trackHeight: 4.0,
                    thumbShape: CustomSliderThumbCircle(
                      thumbRadius: this.widget.sliderHeight * .4,
                      min: this.widget.min,
                      max: this.widget.max,
                    ),
                    overlayColor: GlooTheme.nearlyPurple.withOpacity(.4),
                    //valueIndicatorColor: Colors.white,
                    activeTickMarkColor: GlooTheme.nearlyPurple,
                    inactiveTickMarkColor: GlooTheme.purple.withOpacity(.7),
                  ),
                  child: Slider(
                    min: widget.min.toDouble(),
                    max: widget.max.toDouble(),
                    value: _value,
                    onChanged: (value) {
                      if (_value != value) {
                        setState(() {
                          _value = value;
                        });
                      }
                    },
                    onChangeEnd: (value) {
                      widget.onSelectedValue((value).round());
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: this.widget.sliderHeight * .1,
            ),
            Text(
              '${this.widget.max}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: this.widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: GlooTheme.purple.withOpacity(0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
