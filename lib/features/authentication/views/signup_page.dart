import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';
import 'package:sasto_mart/features/authentication/bloc/signup_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final headerHeight = context.hp(context.isSmallScreen ? 32 : 35);
    final cardOffset = context.hp(context.isSmallScreen ? -5 : -6);

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Solid Navy Header
            Container(
              height: headerHeight,
              width: double.infinity,
              color: AppColors.navyBlue,
              child: Stack(
                children: [
                  // Subtle geometric accents
                  Positioned(
                    top: -50,
                    right: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.03),
                      ),
                    ),
                  ),
                  Positioned(
                    top: context.hp(context.isSmallScreen ? 6.5 : 8.0),
                    left: context.wp(7),
                    right: context.wp(7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back button
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(context.wp(2.2)),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: context.sp(18),
                            ),
                          ),
                        ),
                        SizedBox(height: context.hp(1.6)),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: context.sp(28),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                        SizedBox(height: context.hp(0.5)),
                        Text(
                          "Join SastoMart today!",
                          style: TextStyle(
                            fontSize: context.sp(14),
                            color: Colors.white.withValues(alpha: 0.75),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 2. The Adaptive Floating Card
            Transform.translate(
              offset: Offset(0, cardOffset),
              child: Padding(
                padding: context.isTablet
                    ? EdgeInsets.symmetric(horizontal: context.wp(20))
                    : AdaptiveSize.horizontalPadding(context, percent: 5.5),
                child: AdaptiveCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildAdaptiveTextField(
                        label: "Full Name",
                        hint: "John Doe",
                        icon: Icons.person_outline,
                        onChanged: (value) {
                          context.read<SignupBloc>().add(SignupFullnameChanged(value));
                        },
                      ),
                      SizedBox(height: context.hp(1.8)),
                      _buildAdaptiveTextField(
                        label: "Email Address",
                        hint: "yourname@example.com",
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          context.read<SignupBloc>().add(SignupEmailChanged(value));
                        },
                      ),
                      SizedBox(height: context.hp(1.8)),
                      _buildAdaptiveTextField(
                        label: "Password",
                        hint: "••••••••",
                        icon: Icons.lock_outline_rounded,
                        isPassword: true,
                        obscureText: _obscurePassword,
                        onToggleVisibility: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        onChanged: (value) {
                          context.read<SignupBloc>().add(SignupPasswordChanged(value));
                        },
                      ),
                      SizedBox(height: context.hp(1.8)),
                      _buildAdaptiveTextField(
                        label: "Confirm Password",
                        hint: "••••••••",
                        icon: Icons.lock_outline_rounded,
                        isPassword: true,
                        obscureText: _obscureConfirmPassword,
                        onToggleVisibility: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                        onChanged: (value) {
                          context.read<SignupBloc>().add(SignupConfirmPasswordChanged(value));
                        },
                      ),
                      SizedBox(height: context.hp(2.8)),

                      // 3. Adaptive Sign Up Button
                      AdaptiveButton(
                        text: "Sign Up",
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Account created successfully!"),
                              backgroundColor: AppColors.success,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: context.hp(2.5)),

                      // Login Prompt
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color: AppColors.textGrey,
                              fontWeight: FontWeight.w500,
                              fontSize: context.sp(13.5),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: AppColors.accentBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: context.sp(13.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdaptiveTextField({
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    TextInputType keyboardType = TextInputType.text,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: context.sp(13.5),
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: context.hp(0.6)),
        TextField(
          onChanged: onChanged,
          obscureText: isPassword ? obscureText : false,
          keyboardType: keyboardType,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
            fontSize: context.sp(14.5),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.textLight,
              fontSize: context.sp(13.5),
            ),
            filled: true,
            fillColor: AppColors.backgroundWhite,
            prefixIcon: Icon(icon, color: AppColors.textGrey, size: context.sp(20)),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.textGrey,
                      size: context.sp(20),
                    ),
                    onPressed: onToggleVisibility,
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(
              vertical: context.hp(context.isSmallScreen ? 1.3 : 1.5),
              horizontal: context.wp(3.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.accentBlue, width: 1.8),
            ),
          ),
        ),
      ],
    );
  }
}
