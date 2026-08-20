import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';
import 'package:sasto_mart/features/authentication/bloc/login_bloc.dart';
import 'package:sasto_mart/features/authentication/views/signup_page.dart';
import 'package:sasto_mart/features/home/views/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final headerHeight = context.hp(context.isSmallScreen ? 36 : 38);
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
                  // Subtle geometric decorative accent
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
                    top: context.hp(context.isSmallScreen ? 7.5 : 9.5),
                    left: context.wp(7),
                    right: context.wp(7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Small Icon Box
                        Container(
                          padding: EdgeInsets.all(context.wp(2.8)),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                            size: context.sp(26),
                          ),
                        ),
                        SizedBox(height: context.hp(1.8)),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: context.sp(30),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                        SizedBox(height: context.hp(0.6)),
                        Text(
                          "Sign in to your SastoMart account",
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
                        label: "Email Address",
                        hint: "yourname@example.com",
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          context.read<LoginBloc>().add(LoginEmailChanged(value));
                        },
                      ),
                      SizedBox(height: context.hp(2.2)),
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
                          context.read<LoginBloc>().add(LoginPasswordChanged(value));
                        },
                      ),
                      SizedBox(height: context.hp(1.2)),

                      // Forgot Password Link
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.accentBlue,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: context.sp(13),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: context.hp(2.8)),

                      // 3. Adaptive Sign In Button
                      AdaptiveButton(
                        text: "Sign In",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        },
                      ),
                      SizedBox(height: context.hp(2.8)),

                      // Sign Up Prompt
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: AppColors.textGrey,
                              fontWeight: FontWeight.w500,
                              fontSize: context.sp(13.5),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignupPage()),
                              );
                            },
                            child: Text(
                              "Sign Up",
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
        SizedBox(height: context.hp(0.8)),
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
              vertical: context.hp(context.isSmallScreen ? 1.4 : 1.7),
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