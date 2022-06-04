library flutter_rating_stars;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/splash/generated/assets.dart';

/// This is a RatingStars widget. it shows a row of stars that describes how many scores a field gets.
/// Star items have an action also that allows use in more cases.
///
/// {@tool snippet}
/// Example:
/// ```dart

/// ```
/// {@end-tool}
class RatingStars extends StatefulWidget {
  /// [maxValue]
  final double maxValue;

  /// [value] is value in 0...[maxValue].
  final double value;

  /// [starCount] count of stars, whatever you want.
  final int starCount;

  /// [starSize] is size of star widget.
  final double starSize;

  /// [valueLabelColor] is the color background of label widget.
  final Color valueLabelColor;

  /// [valueLabelTextStyle] is the textStyle of text widget inside the label.
  final TextStyle valueLabelTextStyle;

  /// [valueLabelRadius] is the border radius of the label widget.
  final double valueLabelRadius;

  /// [starSpacing] is spacing between stars.
  final double starSpacing;

  /// [maxValueVisibility] show/hide max value in value label at the left side.
  final bool maxValueVisibility;

  /// [valueLabelVisibility] show/hide value label at the left side.
  final bool valueLabelVisibility;

  /// [valueLabelPadding] is the padding of the label widget.
  final EdgeInsets valueLabelPadding;

  /// [valueLabelMargin] is the margin of label widget.
  final EdgeInsets valueLabelMargin;

  /// [starOffColor] is the color of the star widget that [value] doesn't reach yet.
  final Color starOffColor;

  /// [starColor]  is the color of the star widget that [value] reaches.
  final Color starColor;

  /// [onValueChanged] if it is not null RatingStars is able to click to change the value, and it is calculated by rounded star count only. Ex: [maxValue] is 12, [starCount] is 5, clicked on 3th star, [onValueChanged] is called with [value] is 3*12/5=7.2
  final Function(double value)? onValueChanged;

  /// [starBuilder] use to build your own star widget. By default, it use a star image from assets.
  final Widget Function(int index, Color? color)? starBuilder;

  /// [animationDuration] animated when the [value] is changed.
  final Duration animationDuration;

  /// Constructor
  const RatingStars({
    Key? key,
    this.value = 0,
    this.starCount = 5,
    this.starSize = 20,
    this.valueLabelColor = const Color(0xff9b9b9b),
    this.valueLabelTextStyle = const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 12.0),
    this.valueLabelRadius = 10,
    this.maxValue = 5,
    this.starSpacing = 2,
    this.maxValueVisibility = true,
    this.valueLabelVisibility = true,
    this.animationDuration = Duration.zero,
    this.valueLabelPadding =
        const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
    this.valueLabelMargin = const EdgeInsets.only(right: 8),
    this.starOffColor = const Color(0xffe7e8ea),
    this.starColor = Colors.yellow,
    this.onValueChanged,
    this.starBuilder,
  }) : super(key: key);

  @override
  _RatingStarsState createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars>
    with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: _calculateDuration());
    _animationController!.forward(from: 0);
    super.initState();
  }

  Duration _calculateDuration() {
    var millis = (widget.animationDuration.inMilliseconds *
            widget.value /
            widget.maxValue)
        .round();
    return Duration(milliseconds: millis);
  }

  @override
  void didUpdateWidget(covariant RatingStars oldWidget) {
    if (widget.value != oldWidget.value) {
      _animationController!.duration = _calculateDuration();
      _animationController!.forward(from: 0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (widget.valueLabelVisibility)
          Container(
            padding: widget.valueLabelPadding,
            margin: widget.valueLabelMargin,
            child: Text(
                "${widget.value.toStringAsPrecision(2)}${widget.maxValueVisibility ? '/${widget.maxValue.toStringAsPrecision(2)}' : ''}",
                style: widget.valueLabelTextStyle),
            decoration: BoxDecoration(
                color: widget.valueLabelColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(widget.valueLabelRadius)),
          ),
        Stack(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                widget.starCount,
                (index) {
                  return Container(
                    margin: index == widget.starCount - 1
                        ? null
                        : EdgeInsets.symmetric(
                            horizontal: widget.starSpacing / 2),
                    alignment: Alignment.center,
                    child: _starWidget(index, true, widget.starOffColor),
                  );
                },
              ),
            ),
            IgnorePointer(
              child: AnimatedBuilder(
                animation: _animationController!,
                builder: (context, child) {
                  return ClipRect(
                    child: Container(
                      child: Align(
                        widthFactor: max(
                            0,
                            min(widget.maxValue.toDouble(),
                                widget.value / widget.maxValue)),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            widget.starCount,
                            (index) {
                              return Container(
                                margin: index == widget.starCount - 1
                                    ? null
                                    : EdgeInsets.symmetric(
                                        horizontal: widget.starSpacing / 2),
                                alignment: Alignment.center,
                                child: Transform.scale(
                                  scale: Tween<double>(begin: 0.0, end: 1.0)
                                      .chain(CurveTween(
                                          curve: Interval(0.15 * index, 1.0,
                                              curve: Curves.elasticOut)))
                                      .evaluate(_animationController!),
                                  child: _starWidget(
                                      index, false, widget.starColor),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _starWidget(int index, bool action, [Color? color]) {
    var _star = widget.starBuilder != null
        ? SizedBox(
            child: widget.starBuilder!(index, color),
            width: widget.starSize,
            height: widget.starSize,
          )
        : Image.asset(
            Assets.assetsStarOff,
            width: widget.starSize,
            height: widget.starSize,
            package: 'flutter_rating_stars',
            color: color,
          );
    if (!action) return _star;
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.starSize / 2))),
        minimumSize: MaterialStateProperty.all<Size>(
            Size(widget.starSize, widget.starSize)),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        elevation: MaterialStateProperty.all<double>(0.0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        overlayColor:
            MaterialStateProperty.all<Color>(widget.starColor.withOpacity(0.2)),
        animationDuration: Duration(milliseconds: 100),
      ),
      onPressed: widget.onValueChanged == null
          ? null
          : () {
              var v = index + 1.0;
              v = v * widget.maxValue / widget.starCount;
              // print('_RatingStarsState._starWidget.onValueChanged: $v');
              widget.onValueChanged!(v);
            },
      child: _star,
    );
  }
}
