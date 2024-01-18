import 'package:flutter/material.dart';

class CustomSwitchAuto extends StatefulWidget {
  final bool value;
  final double width;
  final double height;


  const CustomSwitchAuto(
      {super.key,
      required this.value,
      required this.width,
      required this.height});

  @override
  State<CustomSwitchAuto> createState() => _CustomSwitchAutoState();
}

class _CustomSwitchAutoState extends State<CustomSwitchAuto>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;
  final disableColor = const Color(0xFFD8D8D8);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    // this will change the switch state on the bases of the value of widget.value
    if ((widget.value ? Alignment.centerRight : Alignment.centerLeft) !=
        _circleAnimation.value) {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    }

    final enableColor = Theme.of(context).colorScheme.primary;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: _circleAnimation.value == Alignment.centerLeft
                ? disableColor
                : enableColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              alignment:
                  widget.value ? Alignment.centerRight : Alignment.centerLeft,
              child: Align(
                alignment: _circleAnimation.value,
                child: Container(
                  width: widget.width * 0.37,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5, 
                        offset:const Offset(0, 1), 
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


            // if (_animationController.isCompleted) {
            //   _animationController.reverse();
            // } else {
            //   _animationController.forward();
            // }
            // widget.value == false
            //     ? widget.onChanged(true)
            //     : widget.onChanged(false);