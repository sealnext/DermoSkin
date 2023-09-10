// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_logic.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isFirstTimeHash() => r'a49173885ed2dfb6c437adcdcae2ac58eb033317';

/// See also [isFirstTime].
@ProviderFor(isFirstTime)
final isFirstTimeProvider = AutoDisposeFutureProvider<bool>.internal(
  isFirstTime,
  name: r'isFirstTimeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isFirstTimeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsFirstTimeRef = AutoDisposeFutureProviderRef<bool>;
String _$appStateHash() => r'c33cf29b2cebcdb777398d779c9d2c7e365d8060';

/// See also [AppState].
@ProviderFor(AppState)
final appStateProvider =
    AutoDisposeNotifierProvider<AppState, AppStatus>.internal(
  AppState.new,
  name: r'appStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppState = AutoDisposeNotifier<AppStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
