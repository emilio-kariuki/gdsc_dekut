import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageContainer extends StatelessWidget {
  const NetworkImageContainer({
    super.key,
    required this.imageUrl,
    required this.borderRadius,
    required this.height,
    required this.width,
    this.isCirlce = false,
    this.border,
  });

  final String imageUrl;
  final double height;
  final double width;
  final bool isCirlce;
  final BoxBorder? border;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.medium,
      errorWidget: (context, url, error) => const Center(
        child: Icon(
          Icons.error_outline_sharp,
          size: 20,
          color: Colors.red,
        ),
      ),
      placeholder: (context, url) => Container(
        height: height,
        width: width,
        decoration: isCirlce
            ? BoxDecoration(
                shape: BoxShape.circle,
                border: border,
              )
            : BoxDecoration(
                shape: BoxShape.rectangle,
                border: border,
                borderRadius: borderRadius,
              ),
      ),
      imageBuilder: (context, imageProvider) => AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: height,
        width: width,
        decoration: isCirlce
            ? BoxDecoration(
                shape: BoxShape.circle,
                border: border,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              )
            : BoxDecoration(
                shape: BoxShape.rectangle,
                border: border,
                borderRadius: borderRadius,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
