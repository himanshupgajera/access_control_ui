import 'package:flutter/widgets.dart';

/// Provides access control context (roles, permissions, subscription plans)
/// to the entire widget tree.
///
/// This widget should wrap the root of your app or any subtree that
/// needs access control logic.
///
/// Example:
/// ```dart
/// AccessControlProvider(
///   roles: ['admin'],
///   permissions: ['manage.users'],
///   plan: 'pro',
///   child: MyApp(),
/// );
/// ```
class AccessControlProvider extends InheritedWidget {
  /// The list of roles associated with the current user.
  final List<String> roles;

  /// The list of permissions available to the current user.
  final List<String> permissions;

  /// The subscription plan the user is on (e.g., 'free', 'pro').
  final String? plan;

  /// Creates an [AccessControlProvider].
  const AccessControlProvider({
    super.key,
    required super.child,
    required this.roles,
    required this.permissions,
    this.plan,
  });

  /// Access the nearest [AccessControlProvider] up the widget tree.
  static AccessControlProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AccessControlProvider>();
  }

  /// Determines if the widget should notify dependents when values change.
  @override
  bool updateShouldNotify(covariant AccessControlProvider oldWidget) {
    return roles != oldWidget.roles ||
        permissions != oldWidget.permissions ||
        plan != oldWidget.plan;
  }

  /// Checks if the current user has a specific role.
  bool hasRole(String role) => roles.contains(role);

  /// Checks if the current user has a specific permission.
  bool hasPermission(String permission) => permissions.contains(permission);

  /// Checks if the current user's plan matches the required plan.
  bool isOnPlan(String value) => plan == value;
}
