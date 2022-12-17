import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ArrowButton extends StatelessWidget {
  bool isHover;
  final IconData icon;
  final Function() onTap;
  ArrowButton({Key? key, this.isHover = false, required this.onTap, required this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: 60,
        width: 25,
        decoration: BoxDecoration(
          color: isHover ? Colors.black.withOpacity(0.5) : Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(4),
          ),
        ),
        child: SizedBox(
          height: 30,
          width: 20,
          child: FittedBox(
            child: Icon(
              icon,
              size: 30,
              color: isHover ? Colors.white : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
