import 'package:flutter/material.dart';

class AbstractBackgroundConfig {
  final Alignment glowAlignment;
  final Alignment secondaryAlignment;
  final double glowSize;
  final double secondarySize;

  const AbstractBackgroundConfig({
    required this.glowAlignment,
    required this.secondaryAlignment,
    required this.glowSize,
    required this.secondarySize,
  });
}

class AbstractBackground extends StatelessWidget {
  final List<Color> gradient;
  final AbstractBackgroundConfig config;

  const AbstractBackground({
    super.key,
    required this.gradient,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          // Base Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Main Glow
          Align(
            alignment: config.glowAlignment,
            child: FractionallySizedBox(
              widthFactor: config.glowSize,
              heightFactor: config.glowSize,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Secondary Soft Blob
          Align(
            alignment: config.secondaryAlignment,
            child: FractionallySizedBox(
              widthFactor: config.secondarySize,
              heightFactor: config.secondarySize,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final AbstractBackgroundConfig bgConfig;
  final VoidCallback onTap;

  const StatsCard({
    super.key,
    required this.title,
    required this.icon,
    required this.gradient,
    required this.bgConfig,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AbstractBackground(
            gradient: gradient,
            config: bgConfig,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 54, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
