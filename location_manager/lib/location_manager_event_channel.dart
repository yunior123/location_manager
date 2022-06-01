import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'location_manager_platform_interface.dart';
import 'models/config.dart';
import 'models/location_model.dart';

/// An implementation of [LocationManagerPlatform] that uses event channels.
class MethodChannelLocationManager extends LocationManagerPlatform {
  /// The event channel used to interact with the native platform.
  @visibleForTesting
  final EventChannel eventChannel = const EventChannel(
    'location_manager/event_channel',
  );

  @override
  Stream<Either<String, LocationModel>> getLocation({
    ConfigLocationManager? config,
  }) {
    try {
      final locationStream = eventChannel.receiveBroadcastStream(
        [
          config?.toJson(),
        ],
      ).map<Right<String, LocationModel>>(
        (dynamic element) {
          final result = LocationModel.fromMap(
            element.cast<String, dynamic>(),
          );
          return Right(result);
        },
      );
      return locationStream;
    } catch (e) {
      if (e is PlatformException) {
        return Stream.value(
          const Left<String, LocationModel>("Platform Exception"),
        );
      }
      return Stream.value(
        const Left<String, LocationModel>("Unknown Exception"),
      );
    }
  }
}
