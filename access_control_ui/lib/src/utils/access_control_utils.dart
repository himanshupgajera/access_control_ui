import '../access_control_provider.dart';
import 'package:flutter/widgets.dart';

/// Utility class providing static methods to perform
/// quick access control checks within the widget tree.
///
/// These methods allow conditionally showing widgets or
/// enabling features based on access logic without the need
/// to wrap the widget in `AccessControl`.
class AccessControlUtils {
  /// Returns true if the current user has the given [role].
  static bool hasRole(BuildContext context, String role) {
    final provider = AccessControlProvider.of(context);
    return provider?.roles.contains(role) ?? false;
  }

  /// Returns true if the current user has the given [permission].
  static bool hasPermission(BuildContext context, String permission) {
    final provider = AccessControlProvider.of(context);
    return provider?.permissions.contains(permission) ?? false;
  }

  /// Returns true if the user's subscription [plan] matches.
  static bool isOnPlan(BuildContext context, String plan) {
    final provider = AccessControlProvider.of(context);
    return provider?.plan == plan;
  }

  /// Returns true if the user has any of the [roles] listed.
  static bool hasAnyRole(BuildContext context, List<String> roles) {
    final provider = AccessControlProvider.of(context);
    if (provider == null) return false;
    return roles.any((r) => provider.roles.contains(r));
  }

  /// Returns true if the user has any of the [permissions] listed.
  static bool hasAnyPermission(BuildContext context, List<String> permissions) {
    final provider = AccessControlProvider.of(context);
    if (provider == null) return false;
    return permissions.any((p) => provider.permissions.contains(p));
  }
}
