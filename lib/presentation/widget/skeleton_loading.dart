import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonLoading extends StatelessWidget {
  final double width;
  final double height;
  final double cornerRadius;
  final BoxShape shape;

  const SkeletonLoading({
    Key? key,
    required this.width,
    required this.height,
    this.cornerRadius = 0,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      borderRadius: BorderRadius.circular(cornerRadius),
      shimmerColor: Colors.grey,
      shimmerDuration: 1500,
      curve: Curves.linear,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape,
          borderRadius: shape == BoxShape.circle
              ? null
              : BorderRadius.circular(cornerRadius),
          color: Colors.grey[300],
        ),
      ),
    );
  }
}