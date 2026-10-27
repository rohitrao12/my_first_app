import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/primary_button.dart';

class ComboVaultCard extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onExplore;

  const ComboVaultCard({
    super.key,
    required this.imageUrl,
    required this.onExplore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 154,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          // Background Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CustomImage(
              imageUrl: imageUrl,
              width: double.infinity,
              height: 154,
              fit: BoxFit.cover,
              overlay: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.92),
                      Colors.black.withValues(alpha: 0.65),
                      Colors.black.withValues(alpha: 0.3),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'THE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    color: AppColors.limeAccent,
                  ),
                ),
                const Text(
                  'COMBO VAULT',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.5,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Save more on 2 & 3 packs',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                PrimaryButton(
                  text: 'EXPLORE COMBOS',
                  showArrow: true,
                  height: 32,
                  borderRadius: 6,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  onPressed: onExplore,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
