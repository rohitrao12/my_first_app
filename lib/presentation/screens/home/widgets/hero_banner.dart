import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/primary_button.dart';

class HeroBanner extends StatefulWidget {
  final String imageUrl;
  final VoidCallback onShopNow;

  const HeroBanner({
    super.key,
    required this.imageUrl,
    required this.onShopNow,
  });

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> {
  int _activeDot = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Stack(
            children: [
              // Background Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomImage(
                  imageUrl: widget.imageUrl,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  overlay: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.85),
                          Colors.black.withValues(alpha: 0.4),
                          Colors.transparent,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
              ),

              // Banner Content
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'BUILT TO\nMOVE.',
                      style: AppTextStyles.heroHeading,
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Performance meets\nstreet style.',
                      style: AppTextStyles.subHeading,
                    ),
                    const SizedBox(height: 14),
                    PrimaryButton(
                      text: 'SHOP NOW',
                      showArrow: true,
                      height: 36,
                      borderRadius: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      onPressed: widget.onShopNow,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Carousel Indicator Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _activeDot = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                width: _activeDot == index ? 16 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: _activeDot == index ? AppColors.limeAccent : AppColors.borderLight,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
