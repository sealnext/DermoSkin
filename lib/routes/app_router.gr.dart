// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:dermo/features/appointments/appointments.dart' as _i1;
import 'package:dermo/features/auth/auth_wrapper.dart' as _i2;
import 'package:dermo/features/auth/start.dart' as _i8;
import 'package:dermo/features/camera/camera.dart' as _i3;
import 'package:dermo/features/chat/rooms.dart' as _i6;
import 'package:dermo/features/home/home.dart' as _i4;
import 'package:dermo/features/navbar_wrapper.dart' as _i5;
import 'package:dermo/features/settings/settings.dart' as _i7;
import 'package:flutter/material.dart' as _i10;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    AppointmentRoute.name: (routeData) {
      final args = routeData.argsAs<AppointmentRouteArgs>();
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AppointmentPage(
          args.futureAppointment,
          key: args.key,
        ),
      );
    },
    AuthRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AuthWrapper(),
      );
    },
    CameraRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.CameraPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomePage(),
      );
    },
    NavbarWrapper.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.NavbarWrapper(),
      );
    },
    RoomsRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.RoomsPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SettingsPage(),
      );
    },
    StartRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.StartPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AppointmentPage]
class AppointmentRoute extends _i9.PageRouteInfo<AppointmentRouteArgs> {
  AppointmentRoute({
    required _i1.FutureAppointment? futureAppointment,
    _i10.Key? key,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          AppointmentRoute.name,
          args: AppointmentRouteArgs(
            futureAppointment: futureAppointment,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AppointmentRoute';

  static const _i9.PageInfo<AppointmentRouteArgs> page =
      _i9.PageInfo<AppointmentRouteArgs>(name);
}

class AppointmentRouteArgs {
  const AppointmentRouteArgs({
    required this.futureAppointment,
    this.key,
  });

  final _i1.FutureAppointment? futureAppointment;

  final _i10.Key? key;

  @override
  String toString() {
    return 'AppointmentRouteArgs{futureAppointment: $futureAppointment, key: $key}';
  }
}

/// generated route for
/// [_i2.AuthWrapper]
class AuthRoute extends _i9.PageRouteInfo<void> {
  const AuthRoute({List<_i9.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CameraPage]
class CameraRoute extends _i9.PageRouteInfo<void> {
  const CameraRoute({List<_i9.PageRouteInfo>? children})
      : super(
          CameraRoute.name,
          initialChildren: children,
        );

  static const String name = 'CameraRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.NavbarWrapper]
class NavbarWrapper extends _i9.PageRouteInfo<void> {
  const NavbarWrapper({List<_i9.PageRouteInfo>? children})
      : super(
          NavbarWrapper.name,
          initialChildren: children,
        );

  static const String name = 'NavbarWrapper';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.RoomsPage]
class RoomsRoute extends _i9.PageRouteInfo<void> {
  const RoomsRoute({List<_i9.PageRouteInfo>? children})
      : super(
          RoomsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RoomsRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SettingsPage]
class SettingsRoute extends _i9.PageRouteInfo<void> {
  const SettingsRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.StartPage]
class StartRoute extends _i9.PageRouteInfo<void> {
  const StartRoute({List<_i9.PageRouteInfo>? children})
      : super(
          StartRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
