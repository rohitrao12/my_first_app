import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/mock_shop_repository.dart';
import '../../../logic/navigation/navigation_cubit.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/primary_button.dart';

class BrandStoryScreen extends StatelessWidget {
  const BrandStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = MockShopRepository();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '11FIT',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            letterSpacing: 0.5,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner: "MORE THAN JUST CLOTHES. It's a lifestyle."
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CustomImage(
                      imageUrl: repo.brandStoryImg,
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                      overlay: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.9),
                              Colors.black.withValues(alpha: 0.6),
                              Colors.black.withValues(alpha: 0.2),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'MORE THAN\nJUST CLOTHES.',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            color: AppColors.textPrimary,
                            height: 1.15,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "It's a lifestyle.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.limeAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 4 Grid Value Propositions (Premium Quality, Athletic Fit, Built for Performance, Trusted by Athletes)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 8,
                childAspectRatio: 0.85,
                children: [
                  _buildValueProp(Icons.workspace_premium_outlined, 'Premium Quality'),
                  _buildValueProp(Icons.accessibility_new_rounded, 'Athletic Fit'),
                  _buildValueProp(Icons.speed_rounded, 'Built for Performance'),
                  _buildValueProp(Icons.verified_outlined, 'Trusted by Athletes'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Secondary Promo: "FROM GYM TO STREET - Gear for every move."
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CustomImage(
                      imageUrl: repo.streetGymImg,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      overlay: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.92),
                              Colors.black.withValues(alpha: 0.5),
                              Colors.transparent,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'FROM GYM\nTO STREET',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            color: AppColors.textPrimary,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Gear for every move.',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        PrimaryButton(
                          text: 'SHOP NOW',
                          showArrow: true,
                          height: 34,
                          borderRadius: 18,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          onPressed: () {
                            Navigator.pop(context);
                            context.read<NavigationCubit>().setTab(1);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  Widget _buildValueProp(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.limeAccent, size: 24),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
