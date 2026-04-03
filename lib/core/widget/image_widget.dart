import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constant/class/app_color.dart';


class ImageWidget extends StatelessWidget {
  final String? imageUrl; // For network images
  final String? assetPath; // For asset images
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool? smallIcon;
  const ImageWidget({
    super.key,
    this.imageUrl,
    this.assetPath = "assets/images/no_image.png",
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
    this.loadingWidget,
    this.errorWidget,
    this.iconColor,
    this.backgroundColor,
    this.smallIcon = false,
  }) : assert(
  imageUrl != null || assetPath != null,
  'Either imageUrl or assetPath must be provided',
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        color: backgroundColor ?? AppColor.scaffoldColor,
        child:
        imageUrl != null
            ? CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: fit,
          width: width,
          height: height,
          placeholder:
              (context, url) =>
          loadingWidget ??
              Shimmer.fromColors(
                baseColor: AppColor.grey,
                highlightColor: AppColor.lightGrey,
                child: Container(
                  width: width,
                  height: height,
                  // color: AppColor.grey,
                ),
              ),

          // const Center(
          //   child: CircularProgressIndicator(
          //     color: ColorManager.primary,
          //   ),
          // )
          errorWidget:
              (context, url, error) =>
          errorWidget ??
              Container(
                color: backgroundColor ?? AppColor.scaffoldColor,

                child: Center(
                  child: Icon(
                    Icons.error_outline,
                    color: iconColor ?? AppColor.primaryColor,
                    size: smallIcon! ? 18 : 40,
                  ),
                ),
              ),
        )
            : Image.asset(
          assetPath!,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ??
                Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                );
          },
        ),
      ),
    );
  }
}
