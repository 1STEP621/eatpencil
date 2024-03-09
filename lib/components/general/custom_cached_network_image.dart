import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends CachedNetworkImage {
  CustomCachedNetworkImage({
    super.key,
    required super.imageUrl,
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
    super.fit,
    super.alignment = Alignment.topLeft,
    super.repeat,
    super.matchTextDirection,
    super.cacheManager,
    super.useOldImageOnUrlChange,
    super.color,
    super.filterQuality,
    super.colorBlendMode,
    PlaceholderWidgetBuilder? placeholder,
    super.placeholderFadeInDuration = Duration.zero,
    super.memCacheWidth,
    super.memCacheHeight,
    super.cacheKey,
    super.maxWidthDiskCache,
    super.maxHeightDiskCache,
    super.errorListener,
    super.imageRenderMethodForWeb,
  }) : super(
          placeholder: placeholder ?? (context, url) => const SizedBox.shrink(),
        );
}
