import 'package:eatpencil/components/general/animated_list_with_controller.dart';
import 'package:eatpencil/components/general/loading_circle.dart';
import 'package:eatpencil/components/notification.dart';
import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:misskey_dart/misskey_dart.dart';

class Notifications extends ConsumerStatefulWidget {
  const Notifications({super.key});

  @override
  ConsumerState<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends ConsumerState<Notifications> {
  final _controller = AnimatedListController<INotificationsResponse>();
  bool _isFetching = false;

  void cleanConnections(Misskey server) {
    server.streamingService.close();
  }

  void cleanNotifications() {
    _controller.clear();
  }

  void initNotifications(Misskey server) {
    setState(() {
      _isFetching = true;
    });
    server.i
        .notifications(
      const INotificationsRequest(limit: 50),
    )
        .then((initialNotifications) {
      _controller.addAll(initialNotifications.toList());
      setState(() {
        _isFetching = false;
      });
    });
  }

  void connectStream(Misskey server) {
    server.streamingService.startStreaming();
    server.mainStream(
      onNotification: (INotificationsResponse newNotification) {
        _controller.addAll([newNotification]);
      },
    );
  }

  @override
  void initState() {
    initNotifications(ref.read(focusedServerProvider));
    connectStream(ref.read(focusedServerProvider));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        cleanConnections(ref.read(focusedServerProvider));
        cleanNotifications();
        initNotifications(ref.read(focusedServerProvider));
        connectStream(ref.read(focusedServerProvider));
      },
      child: Column(
        children: [
          if (_isFetching) ...[
            const Gap(40),
            const LoadingCircle(),
            const Gap(40),
          ],
          Expanded(
            child: AnimatedListWithController<INotificationsResponse>(
              controller: _controller,
              itemBuilder: (context, notification, animation) {
                return NotificationCard(
                  notification: notification,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
