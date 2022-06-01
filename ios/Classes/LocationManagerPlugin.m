#import "LocationManagerPlugin.h"
#if __has_include(<location_manager/location_manager-Swift.h>)
#import <location_manager/location_manager-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "location_manager-Swift.h"
#endif

@implementation LocationManagerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLocationManagerPlugin registerWithRegistrar:registrar];
}
@end
