import 'package:eatpencil/components/avatar_with_badge.dart';
import 'package:eatpencil/components/emoji.dart';
import 'package:eatpencil/components/general/icon_with_background.dart';
import 'package:eatpencil/components/general/row_with_gap.dart';
import 'package:eatpencil/consts.dart';
import 'package:eatpencil/utils/get_part_from_reaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eatpencil/providers.dart';
import 'package:misskey_dart/misskey_dart.dart';
import 'package:tabler_icons_for_flutter/tabler_icons_for_flutter.dart';
import 'package:eatpencil/utils/get_note_summary.dart';
import 'package:eatpencil/components/general/custom_cached_network_image.dart';

class NotificationCard extends ConsumerWidget {
  final INotificationsResponse notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final originUser = notification.user ?? notification.note?.user;
    final originNote = notification.type == NotificationType.renote ? notification.note?.renote : notification.note;

    // TODO: いい感じにウィジェットを分割する
    final leftContent = switch (notification.type) {
      NotificationType.achievementEarned => const IconWithBackground(
          icon: TablerIcons.trophy,
          size: 45,
          backgroundColor: eventOther,
        ),
      // TODO: https://github.com/shiosyakeyakini-info/misskey_dart/pull/47がマージされ次第修正
      NotificationType.app => notification.customIcon == null
          ? const IconWithBackground(
              icon: TablerIcons.apps,
              size: 45,
              backgroundColor: eventOther,
            )
          : CustomCachedNetworkImage(
              imageUrl: notification.customIcon.toString(),
            ),
      NotificationType.follow => AvatarWithBadge(
          user: originUser!,
          badge: const IconWithBackground(
            icon: TablerIcons.plus,
            backgroundColor: eventFollow,
          ),
        ),
      NotificationType.followRequestAccepted => AvatarWithBadge(
          user: originUser!,
          badge: const IconWithBackground(
            icon: TablerIcons.check,
            backgroundColor: eventFollow,
          ),
        ),
      NotificationType.mention => AvatarWithBadge(
          user: originUser!,
          badge: const IconWithBackground(
            icon: TablerIcons.at,
            backgroundColor: eventOther,
          ),
        ),
      NotificationType.note => AvatarWithBadge(
          user: originUser!,
          badge: const IconWithBackground(
            icon: TablerIcons.bell,
            backgroundColor: eventOther,
          ),
        ),
      NotificationType.pollEnded => AvatarWithBadge(
          user: originUser!,
          badge: const IconWithBackground(
            icon: TablerIcons.chart_arrows,
            backgroundColor: eventOther,
          ),
        ),
      NotificationType.quote => AvatarWithBadge(
          user: originUser!,
          badge: const IconWithBackground(
            icon: TablerIcons.quote,
            backgroundColor: eventRenote,
          ),
        ),
      NotificationType.reaction => AvatarWithBadge(
          user: originUser!,
          badge: EmojiImage(
            shortcode: getShortcode(notification.reaction!),
            serverUrl: getServerUrl(notification.reaction!),
            additionalEmojis: notification.note!.reactionEmojis,
            height: 22,
          ),
        ),
      NotificationType.receiveFollowRequest => AvatarWithBadge(
          user: originUser!,
          badge: const IconWithBackground(
            icon: TablerIcons.plus,
            backgroundColor: eventFollow,
          ),
        ),
      NotificationType.renote => AvatarWithBadge(
          user: originUser!,
          badge: const IconWithBackground(
            icon: TablerIcons.repeat,
            backgroundColor: eventRenote,
          ),
        ),
      NotificationType.reply => AvatarWithBadge(
          user: originUser!,
          badge: const IconWithBackground(
            icon: TablerIcons.arrow_back_up,
            backgroundColor: eventReply,
          ),
        ),
      NotificationType.roleAssigned => const IconWithBackground(
          icon: TablerIcons.user_plus,
          backgroundColor: eventFollow,
          size: 45,
        ),
      NotificationType.test => const IconWithBackground(
          icon: TablerIcons.flask,
          backgroundColor: eventOther,
          size: 45,
        ),
      _ => throw UnimplementedError(),
    };
    final headerContent = Text(
      originUser?.name ??
          switch (notification.type) {
            NotificationType.achievementEarned => "実績を解除しました",
            // TODO: https://github.com/shiosyakeyakini-info/misskey_dart/pull/47がマージされ次第修正
            NotificationType.app => notification.customHeader ?? "連携アプリからの通知",
            NotificationType.roleAssigned => "ロールにアサインされました",
            NotificationType.test => "テスト通知",
            _ => throw UnimplementedError(),
          },
      style: TextStyle(
        color: theme(ref).fg,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
    );
    final mainContent = Text(
      getNoteSummary(originNote)?.replaceAll("\n", " ") ??
          switch (notification.type) {
            NotificationType.achievementEarned => notification.achievement!,
            // TODO: https://github.com/shiosyakeyakini-info/misskey_dart/pull/47がマージされ次第修正
            NotificationType.app => notification.customBody ?? "連携アプリからの通知です",
            NotificationType.follow => "フォローされました",
            NotificationType.followRequestAccepted => "フォローリクエストが承認されました",
            NotificationType.receiveFollowRequest => "新しいフォロー申請があります",
            NotificationType.roleAssigned => notification.role!.name,
            NotificationType.test => "テスト通知です",
            _ => throw UnimplementedError(),
          },
      style: TextStyle(
        color: theme(ref).fg,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 1,
    );

    return Container(
      decoration: BoxDecoration(
        color: theme(ref).panel,
        // 一番上と一番下に余計なBorderがつくので、
        // https://github.com/flutter/flutter/issues/48226
        // が実装され次第修正
        border: Border.symmetric(
          horizontal: BorderSide(
            color: theme(ref).divider,
            width: 0.5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: RowWithGap(
          gap: 10,
          children: [
            Container(
              width: 45,
              height: 45,
              alignment: Alignment.center,
              child: leftContent,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerContent,
                  mainContent,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
