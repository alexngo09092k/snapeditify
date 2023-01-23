part of '../extensions.dart';

extension MPermissionStore on UserPermission {
  requestStoragePermission(
    BuildContext context, {
    Function? onHasPermisson,
    Function? onNoPermisson,
  }) async {
    requestPermission(
      permission: [Permission.storage],
      onNoPermisson: () {
        WidgetUtils.instance.showRequestPermissionPopup(
          context,
          title: "Photo",
          message: 'Allow ${Configuration.instance.businessConfig.appName} to access photos on your device.',
          onForeground: () {
            requestPermission(
              permission: [Permission.storage],
              onHasPermisson: Navigator.of(context).pop,
            );
          },
        );
        if (onNoPermisson != null) {
          onNoPermisson();
        }
      },
      onHasPermisson: onHasPermisson,
    );
  }

//   requestLocationPermission(
//     BuildContext context, {
//     Function? onHasPermisson,
//     Function? onNoPermisson,
//   }) async {
//     requestIOSLocationPermission(
//         onNoPermisson: () {
//           requestPermission(
//             permission: [Permission.location],
//             onNoPermisson: () {
//               WidgetUtils.instance.showRequestPermissionPopup(
//                 context,
//                 title: "Location",
//                 message:
//                     'Allow ${Configuration.instance.businessConfig.appName} to collect location data to enable fitness tracking even when the app is closed or not in use.',
//                 onForeground: () {
//                   requestPermission(
//                     permission: [Permission.location],
//                     onHasPermisson: Navigator.of(context).pop,
//                   );
//                 },
//               );

//               if (onNoPermisson != null) {
//                 onNoPermisson();
//               }
//             },
//             onHasPermisson: onHasPermisson,
//           );
//         },
//         onHasPermisson: onHasPermisson);
//   }
// }

// extension IOSLocationPermissionExt on UserPermission {
//   requestIOSLocationPermission({
//     Function? onHasPermisson,
//     Function? onNoPermisson,
//   }) async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       if (onNoPermisson != null) return onNoPermisson();
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         if (onNoPermisson != null) return onNoPermisson();
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       if (onNoPermisson != null) return onNoPermisson();
//     }

//     if (onHasPermisson != null) return onHasPermisson();
//   }
}
