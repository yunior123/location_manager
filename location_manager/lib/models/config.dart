import 'dart:convert';

// convert from ConfigLocationManagerActivityType enum
String configLocationManagerActivityTypeToString(
    ConfigLocationManagerActivityType activityType) {
  switch (activityType) {
    case ConfigLocationManagerActivityType.automotiveNavigation:
      return 'automotiveNavigation';
    case ConfigLocationManagerActivityType.fitness:
      return 'fitness';
    case ConfigLocationManagerActivityType.otherNavigation:
      return 'otherNavigation';
    case ConfigLocationManagerActivityType.airborne:
      return 'airborne';
    case ConfigLocationManagerActivityType.other:
      return 'other';
  }
}

abstract class ConfigLocationManager {
  final ConfigLocationManagerAccuracy accuracy;
  final int distanceFilter;
  ConfigLocationManager({
    required this.accuracy,
    required this.distanceFilter,
  });

  String toJson();
}

enum ConfigLocationManagerAccuracy {
  lowest,
  low,
  medium,
  high,
  best,
  bestForNavigation,
  reduced;

  // to string
  @override
  String toString() {
    switch (this) {
      case ConfigLocationManagerAccuracy.lowest:
        return 'lowest';
      case ConfigLocationManagerAccuracy.low:
        return 'low';
      case ConfigLocationManagerAccuracy.medium:
        return 'medium';
      case ConfigLocationManagerAccuracy.high:
        return 'high';
      case ConfigLocationManagerAccuracy.best:
        return 'best';
      case ConfigLocationManagerAccuracy.bestForNavigation:
        return 'bestForNavigation';
      case ConfigLocationManagerAccuracy.reduced:
        return 'reduced';
    }
  }

  // from string
  static ConfigLocationManagerAccuracy? fromString(String value) {
    switch (value) {
      case 'lowest':
        return ConfigLocationManagerAccuracy.lowest;
      case 'low':
        return ConfigLocationManagerAccuracy.low;
      case 'medium':
        return ConfigLocationManagerAccuracy.medium;
      case 'high':
        return ConfigLocationManagerAccuracy.high;
      case 'best':
        return ConfigLocationManagerAccuracy.best;
      case 'bestForNavigation':
        return ConfigLocationManagerAccuracy.bestForNavigation;
      case 'reduced':
        return ConfigLocationManagerAccuracy.reduced;
    }
    return null;
  }
}

enum ConfigLocationManagerActivityType {
  automotiveNavigation,
  fitness,
  otherNavigation,
  airborne,
  other;

  // to string

  @override
  String toString() {
    switch (this) {
      case ConfigLocationManagerActivityType.automotiveNavigation:
        return 'automotiveNavigation';
      case ConfigLocationManagerActivityType.fitness:
        return 'fitness';
      case ConfigLocationManagerActivityType.otherNavigation:
        return 'otherNavigation';
      case ConfigLocationManagerActivityType.airborne:
        return 'airborne';
      case ConfigLocationManagerActivityType.other:
        return 'other';
    }
  }

  // from string

  static ConfigLocationManagerActivityType? fromString(String value) {
    switch (value) {
      case 'automotiveNavigation':
        return ConfigLocationManagerActivityType.automotiveNavigation;
      case 'fitness':
        return ConfigLocationManagerActivityType.fitness;
      case 'otherNavigation':
        return ConfigLocationManagerActivityType.otherNavigation;
      case 'airborne':
        return ConfigLocationManagerActivityType.airborne;
      case 'other':
        return ConfigLocationManagerActivityType.other;
    }
    return null;
  }
}

class IOSConfigLocationManager extends ConfigLocationManager {
  final bool pauseLocationUpdatesAutomatically;
  final ConfigLocationManagerActivityType activityType;
  final bool showBackgroundLocationIndicator;
  IOSConfigLocationManager({
    this.pauseLocationUpdatesAutomatically = false,
    this.activityType = ConfigLocationManagerActivityType.other,
    ConfigLocationManagerAccuracy accuracy = ConfigLocationManagerAccuracy.best,
    int distanceFilter = 0,
    Duration? timeLimit,
    this.showBackgroundLocationIndicator = false,
  }) : super(
          accuracy: accuracy,
          distanceFilter: distanceFilter,
        );

  factory IOSConfigLocationManager.fromJson(String source) =>
      IOSConfigLocationManager.fromMap(json.decode(source));

  factory IOSConfigLocationManager.fromMap(Map<String, dynamic> map) {
    return IOSConfigLocationManager(
      pauseLocationUpdatesAutomatically:
          map['pauseLocationUpdatesAutomatically'] ?? false,
      activityType: ConfigLocationManagerActivityType.fromString(
            map['activityType'] ?? ConfigLocationManagerActivityType.other,
          ) ??
          ConfigLocationManagerActivityType.other,
      showBackgroundLocationIndicator:
          map['showBackgroundLocationIndicator'] ?? false,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll(
      {'pauseLocationUpdatesAutomatically': pauseLocationUpdatesAutomatically},
    );
    result.addAll(
      {
        'activityType': activityType.toString(),
      },
    );
    result.addAll(
      {
        'showBackgroundLocationIndicator': showBackgroundLocationIndicator,
      },
    );

    return result;
  }
}
