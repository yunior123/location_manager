# location_manager
 A plugin for using native location APIs

# Steps followed for creating the plugin
flutter create --org com.location_manager --template=plugin --platforms=ios -i swift location_manager

# Host platform code is in the ios directories under location_manager.
To edit platform code in an IDE see https://flutter.dev/developing-packages/#edit-plugin-package.


# To add platforms, run `flutter create -t plugin --platforms <platforms> .` under location_manager.
For more information, see https://flutter.dev/go/plugin-platforms.

# Try building the app at least once.

# For publishing
flutter pub publish --dry-run
flutter pub publish