// import 'package:flutter_test/flutter_test.dart';
// import 'package:location_manager/location_manager.dart';
// import 'package:location_manager/location_manager_method_channel.dart';
// import 'package:location_manager/location_manager_platform_interface.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// void main() {
//   final LocationManagerPlatform initialPlatform =
//       LocationManagerPlatform.instance;

//   test('$MethodChannelLocationManager is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelLocationManager>());
//   });

//   test('getPlatformVersion', () async {
//     LocationManager locationManagerPlugin = LocationManager();
//     MockLocationManagerPlatform fakePlatform = MockLocationManagerPlatform();
//     LocationManagerPlatform.instance = fakePlatform;

//     // expect(await locationManagerPlugin.getPlatformVersion(), '42');
//   });
// }

// class MockLocationManagerPlatform
//     with MockPlatformInterfaceMixin
//     implements LocationManagerPlatform {
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
