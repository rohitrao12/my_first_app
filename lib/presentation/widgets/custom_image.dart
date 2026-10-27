import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Robust image component that gracefully handles network loading and offline fallbacks
/// with athletic dark gradient placeholders.
class CustomImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? overlay;

  const CustomImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.overlay,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      imageWidget = Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildPlaceholder(context, isLoading: true);
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder(context, isLoading: false);
        },
      );
    } else {
      imageWidget = _buildPlaceholder(context, isLoading: false);
    }

    if (borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    if (overlay != null) {
      return Stack(
        fit: StackFit.passthrough,
        children: [
          imageWidget,
          Positioned.fill(child: overlay!),
        ],
      );
    }

    return imageWidget;
  }

  Widget _buildPlaceholder(BuildContext context, {required bool isLoading}) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1F2024),
            Color(0xFF141517),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.limeAccent,
                ),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  final isSmall = constraints.maxHeight < 80 || constraints.maxWidth < 80;
                  return FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.fitness_center_rounded,
                            color: const Color(0xFF33353B),
                            size: isSmall ? 22 : 32,
                          ),
                          if (!isSmall) ...[
                            const SizedBox(height: 3),
                            const Text(
                              '11FIT',
                              style: TextStyle(
                                color: Color(0xFF484B54),
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                fontSize: 11,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
