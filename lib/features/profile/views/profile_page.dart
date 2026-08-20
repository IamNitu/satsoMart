import 'package:flutter/material.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';
import 'package:sasto_mart/features/authentication/views/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          "My Profile",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.navyBlue,
            fontSize: context.sp(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: context.wp(5),
          right: context.wp(5),
          bottom: context.hp(12),
        ),
        child: Column(
          children: [
            SizedBox(height: context.hp(1)),

            // User Info Card
            Container(
              padding: EdgeInsets.all(context.wp(4.5)),
              decoration: BoxDecoration(
                color: AppColors.navyBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: context.sp(26),
                    backgroundColor: AppColors.accentBlue,
                    child: Icon(
                      Icons.person_rounded,
                      size: context.sp(30),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: context.wp(3.5)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "John Doe",
                          style: TextStyle(
                            fontSize: context.sp(17),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: context.hp(0.3)),
                        Text(
                          "john.doe@example.com",
                          style: TextStyle(
                            fontSize: context.sp(12),
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            SizedBox(height: context.hp(3)),

            // Settings / Actions Group
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                children: [
                  _buildProfileTile(
                    context,
                    icon: Icons.receipt_long_rounded,
                    title: "Order History",
                    subtitle: "Track your past and active orders",
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  _buildProfileTile(
                    context,
                    icon: Icons.location_on_outlined,
                    title: "Shipping Addresses",
                    subtitle: "Manage your delivery locations",
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  _buildProfileTile(
                    context,
                    icon: Icons.payment_rounded,
                    title: "Payment Methods",
                    subtitle: "Saved cards and wallets",
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  _buildProfileTile(
                    context,
                    icon: Icons.notifications_none_rounded,
                    title: "Notifications",
                    subtitle: "Configure alerts & promos",
                    onTap: () {},
                  ),
                ],
              ),
            ),

            SizedBox(height: context.hp(3)),

            // Logout Action
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: _buildProfileTile(
                context,
                icon: Icons.logout_rounded,
                title: "Log Out",
                subtitle: "Sign out of your SastoMart account",
                iconColor: AppColors.error,
                textColor: AppColors.error,
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(
        horizontal: context.wp(4),
        vertical: context.hp(0.5),
      ),
      leading: Container(
        padding: EdgeInsets.all(context.wp(2.2)),
        decoration: BoxDecoration(
          color: (iconColor ?? AppColors.accentBlue).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: context.sp(20),
          color: iconColor ?? AppColors.accentBlue,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: context.sp(14),
          fontWeight: FontWeight.w700,
          color: textColor ?? AppColors.textDark,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: context.sp(11.5),
          color: AppColors.textGrey,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: context.sp(14),
        color: AppColors.textLight,
      ),
    );
  }
}
