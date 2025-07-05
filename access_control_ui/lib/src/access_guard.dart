import 'package:flutter/material.dart';
import 'access_control_provider.dart';

/// A widget used to guard access to full screens or routes
/// based on user roles, permissions, or subscription plans.
///
/// Typically used in `MaterialPageRoute`, `Navigator`, or as a root
/// of a page to restrict visibility based on access control.
///
/// If the user meets the specified access requirements, the [child] is shown.
/// Otherwise, [fallback] is displayed. If [fallback] is not provided,
/// a default scaffold with "You don't have access." is rendered.
class AccessGuard extends StatelessWidget {
  /// List of roles required to view the screen.
  /// If null, role check is skipped.
  final List<String>? requiredRoles;

  /// List of permissions required to view the screen.
  /// If null, permission check is skipped.
  final List<String>? requiredPermissions;

  /// Optional plan (e.g. 'free', 'pro') required to view the screen.
  /// If null, plan check is skipped.
  final String? requiredPlan;

  /// The widget to show when access is allowed.
  final Widget child;

  /// The widget to show when access is denied.
  /// Defaults to a scaffold with a message.
  final Widget? fallback;

  const AccessGuard({
    super.key,
    this.requiredRoles,
    this.requiredPermissions,
    this.requiredPlan,
    required this.child,
    this.fallback,
  });

  /// Evaluates whether the current user has access.
  bool _canAccess(BuildContext context) {
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
    return _canAccess(context)
        ? child
        : (fallback ??
              const Scaffold(
                body: Center(child: Text("You don't have access.")),
              ));
  }
}
