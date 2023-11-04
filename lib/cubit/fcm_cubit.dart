import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FCMCubit extends Cubit<FCMState> {
  final String _fcmToken;

  FCMCubit(
    this._fcmToken,
    RemoteMessage? bgMessage,
  ) : super(FCMState.fromBgMessage(bgMessage)) {
    // fcm listening
    // at foground
    FirebaseMessaging.onMessage.listen(listenFCM);
    // at background
    FirebaseMessaging.onMessageOpenedApp.listen(listenFCM);
    // at terminate
    FirebaseMessaging.instance.getInitialMessage().then(listenFCM);
  }

  // token getter
  String get token => _fcmToken;

  // listening fcm to bloc state
  void listenFCM(RemoteMessage? message) {
    if (message != null) {
      if (message.notification != null) {
        print('fg fcm: ${message.notification?.title}');
        emit(FCMState(
          state: FCMEvent.message,
          body: message.notification!.body,
          data: message.data,
        ));
      }
    }
    emit(const FCMState());
  }
}

enum FCMEvent {
  none,
  signal,
  message,
}

class FCMState extends Equatable {
  final FCMEvent state;
  final String? body;
  final Map<String, dynamic>? data;

  const FCMState({
    this.state = FCMEvent.none,
    this.body,
    this.data,
  });

  factory FCMState.fromBgMessage(RemoteMessage? message) {
    if (message != null) {
      if (message.notification != null) {
        return FCMState(
          state: FCMEvent.message,
          body: message.notification!.body,
          data: message.data,
        );
      }
    }
    return const FCMState();
  }

  @override
  List<Object?> get props => [
        state,
        body,
        data,
      ];
}
