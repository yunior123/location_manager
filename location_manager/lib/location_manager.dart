import 'package:either_dart/either.dart';
import 'package:location_manager/models/location_model.dart';

import 'location_manager_platform_interface.dart';

class LocationManager {
  Stream<Either<String, LocationModel>> getLocation() {
    return LocationManagerPlatform.instance.getLocation();
  }
}
