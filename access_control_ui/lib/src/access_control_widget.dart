import 'package:flutter/material.dart';
import 'access_control_provider.dart';

/// A widget that shows or hides its child based on access control checks.
///
/// You can restrict by providing any combination of:
/// - [requiredRoles]
/// - [requiredPermissions]
/// - [requiredPlan]
///
/// If the user satisfies **all** the provided conditions, the [child] widget
/// is rendered. Otherwise, the [fallback] widget is shown, or nothing if null.
///
/// Example:
/// ```dart
/// AccessControl(
///   requiredRoles: ['admin'],
///   requiredPermissions: ['dashboard.view'],
///   child: ElevatedButton(onPressed: () {}, child: Text('Admin Action')),
///   fallback: SizedBox.shrink(),
/// )
/// ```
class AccessControl extends StatelessWidget {
  /// List of roles required to render the widget.
  final List<String>? requiredRoles;

  /// List of permissions required to render the widget.
  final List<String>? requiredPermissions;

  /// Optional subscription plan name required (e.g. 'pro', 'enterprise').
  final String? requiredPlan;

  /// The widget to show if access is granted.
  final Widget child;

  /// The widget to show if access is denied.
  /// If null, nothing will be rendered.
  final Widget? fallback;

  const AccessControl({
    super.key,
    this.requiredRoles,
    this.requiredPermissions,
    this.requiredPlan,
    required this.child,
    this.fallback,
  });

  /// Determines whether the current context satisfies the access requirements.
  bool _hasAccess(BuildContext context) {
    final provider = AccessControlProvider.of(context);
    if (provider == null) return false;

    final hasRole =
        requiredRoles == null ||
        requiredRoles!.any((r) => provider.roles.contains(r));
    final hasPermission =
        requiredPermissions == null ||
        requiredPermissions!.any((p) => provider.permissions.contains(p));
    final hasPlan = requiredPlan == null || provider.plan == requiredPlan;

    return hasRole && hasPermission && hasPlan;
  }

  @override
  Widget build(BuildContext context) {
    final canAccess = _hasAccess(context);
    return canAccess ? child : (fallback ?? const SizedBox.shrink());
  }
}
