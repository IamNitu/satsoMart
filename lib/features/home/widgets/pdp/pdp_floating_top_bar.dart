import 'package:flutter/material.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';

class PdpFloatingTopBar extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onBack;
  final VoidCallback onShare;
  final VoidCallback onFavoriteToggle;

  const PdpFloatingTopBar({
    super.key,
    required this.isFavorite,
    required this.onBack,
    required this.onShare,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.wp(4),
          vertical: context.hp(0.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildGlassBtn(
              icon: Icons.arrow_back_ios_new_rounded,
              iconColor: AppColors.navyBlue,
              onTap: onBack,
            ),
            Row(
              children: [
                _buildGlassBtn(
                  icon: Icons.share_outlined,
                  iconColor: AppColors.navyBlue,
                  onTap: onShare,
                ),
                SizedBox(width: context.wp(2.5)),
                _buildGlassBtn(
                  icon: isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  iconColor: isFavorite ? Colors.redAccent : AppColors.navyBlue,
                  onTap: onFavoriteToggle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassBtn({
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.92),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: 17),
      ),
    );
  }
}
