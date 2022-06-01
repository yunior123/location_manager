import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:location_manager/location_manager_platform_interface.dart';
import 'package:location_manager/models/location_model.dart';

class LocationHandler with ChangeNotifier {
  StreamSubscription<Either<String, LocationModel>>? _subscription;
  final StreamController<LocationModel> _streamController =
      StreamController.broadcast();

  LocationHandler() {
    _subscription = LocationManagerPlatform.instance.getLocation().listen(
      (event) {
        if (event is Left<String, LocationModel>) {
          _streamController.addError(event.left);
        } else {
          _streamController.add(event.right);
        }
      },
    );
  }

  Stream<LocationModel> get stream => _streamController.stream;

  @override
  void dispose() {
    _streamController.close();
    _subscription?.cancel();
    super.dispose();
  }
}
