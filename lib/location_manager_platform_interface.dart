import 'package:either_dart/either.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'location_manager_event_channel.dart';
import 'models/config.dart';
import 'models/location_model.dart';

abstract class LocationManagerPlatform extends PlatformInterface {
  static final Object _token = Object();

  static LocationManagerPlatform _instance = MethodChannelLocationManager();

  /// The default instance of [LocationManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelLocationManager].
  static LocationManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LocationManagerPlatform] when
  /// they register themselves.
  static set instance(LocationManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Constructs a LocationManagerPlatform.
  LocationManagerPlatform() : super(token: _token);

  Stream<Either<String, LocationModel>> getLocation({
    ConfigLocationManager? config,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
