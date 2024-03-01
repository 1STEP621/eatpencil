import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class ImageWithBlurHash extends CachedNetworkImage {
  ImageWithBlurHash({
    super.key,
    required super.imageUrl,
    required String? blurHash,
    super.httpHeaders,
    super.imageBuilder,
    super.progressIndicatorBuilder,
    super.errorWidget,
    super.fadeOutDuration = Duration.zero,
    super.fadeOutCurve,
    super.fadeInDuration = Duration.zero,
    super.fadeInCurve,
    super.width,
    super.height,
    BoxFit fit = BoxFit.fill,
    super.alignment,
    super.repeat,
    super.matchTextDirection,
    super.cacheManager,
    super.useOldImageOnUrlChange,
    super.color,
    super.filterQuality,
    super.colorBlendMode,
    super.placeholderFadeInDuration,
    super.memCacheWidth,
    super.memCacheHeight,
    super.cacheKey,
    super.maxWidthDiskCache,
    super.maxHeightDiskCache,
    super.errorListener,
    super.imageRenderMethodForWeb,
  }) : super(
          fit: fit,
          placeholder: (context, url) => BlurHash(
            hash: blurHash ?? "",
            imageFit: fit,
            duration: Duration.zero,
          ),
        );
}
