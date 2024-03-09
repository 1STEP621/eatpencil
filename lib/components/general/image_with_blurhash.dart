import 'package:eatpencil/components/general/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class ImageWithBlurHash extends CustomCachedNetworkImage {
  ImageWithBlurHash({
    super.key,
    required super.imageUrl,
    required String? blurHash,
    super.httpHeaders,
    super.imageBuilder,
    super.progressIndicatorBuilder,
    super.errorWidget,
    super.fadeOutDuration,
    super.fadeOutCurve,
    super.fadeInDuration,
    super.fadeInCurve,
    super.width,
    super.height,
    super.fit,
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
          placeholder: blurHash == null
              ? null
              : (context, url) => BlurHash(
                    hash: blurHash,
                    imageFit: fit ?? BoxFit.fill,
                    duration: fadeInDuration,
                  ),
        );
}
