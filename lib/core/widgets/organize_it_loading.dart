import 'package:flutter/material.dart';

/// A branded loading widget for the "Organize It" app.
///
/// Shows a rotating gradient logo, the brand name, and an animated "Please wait"
/// subtitle with moving dots. No external assets required.
class OrganizeItLoading extends StatefulWidget {
  /// Optional main message shown below the brand.
  final String? message;

  /// Height of the widget area. If null, size is intrinsic.
  final double? height;

  const OrganizeItLoading({
    super.key,
    this.message,
    this.height,
  });

  @override
  State<OrganizeItLoading> createState() => _OrganizeItLoadingState();
}

class _OrganizeItLoadingState extends State<OrganizeItLoading>
    with TickerProviderStateMixin {
  late final AnimationController _rotateController;
  late final AnimationController _dotsController;

  @override
  void initState() {
    super.initState();
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _rotateController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  String _animatedDots() {
    final t = (_dotsController.value * 3).floor();
    return '.' * (t + 1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final double size = (widget.height ?? 160).clamp(120.0, 320.0);

    return SizedBox(
      height: widget.height ?? size,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Rotating gradient logo
            SizedBox(
              width: size * 0.45,
              height: size * 0.45,
              child: AnimatedBuilder(
                animation: _rotateController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotateController.value * 2 * 3.1415926,
                    child: child,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorScheme.primary,
                        colorScheme.secondary,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withValues(alpha: 0.12),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'OI',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Brand name
            Text(
              'Organize It',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 8),

            // Message + animated dots (dots rendered separately to avoid text shifting)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.message ?? 'Please wait while we fetch your tasks',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 2),
                SizedBox(
                  width: 36,
                  child: AnimatedBuilder(
                    animation: _dotsController,
                    builder: (context, child) {
                      return Text(
                        _animatedDots(),
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
