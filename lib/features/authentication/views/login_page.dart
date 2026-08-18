import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sasto_mart/features/authentication/bloc/login_bloc.dart';
import 'package:sasto_mart/features/authentication/views/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Refined Solid Color Palette (No Gradients)
  final Color navyBlue = const Color(0xFF0F2041); // Deep, premium navy blue
  final Color accentBlue = const Color(0xFF2563EB); // Vibrant actionable blue
  final Color backgroundWhite = const Color(0xFFF4F6F8); // Very soft grey for contrast
  final Color textDark = const Color(0xFF111827); // Almost black for readability
  final Color textGrey = const Color(0xFF6B7280); // Softer grey for labels

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Solid Navy Header
            Container(
              height: size.height * 0.40,
              width: double.infinity,
              color: navyBlue,
              child: Stack(
                children: [
                  // Subtle geometric accents (solid color, no gradients)
                  Positioned(
                    top: -50,
                    right: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha:0.03),
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.15,
                    left: 32,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Small Icon Box
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha:0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Sign in to your SastoMart account",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withValues(alpha:0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // 2. The Floating White Card (No Gradients)
            Transform.translate(
              offset: const Offset(0, -60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: navyBlue.withValues(alpha:0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSolidTextField(
                        label: "Email Address",
                        icon: Icons.email_outlined,
                        onChanged: (value) {
                          context.read<LoginBloc>().add(LoginEmailChanged(value));
                        },
                      ),
                      const SizedBox(height: 24),
                      _buildSolidTextField(
                        label: "Password",
                        icon: Icons.lock_outline_rounded,
                        isPassword: true,
                        onChanged: (value) {
                          context.read<LoginBloc>().add(LoginPasswordChanged(value));
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Forgot Password Link
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: accentBlue,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // 3. Solid Accent Blue Button
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            print("${context.read<LoginBloc>().state.email}");
                            print("${context.read<LoginBloc>().state.password}");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentBlue,
                            foregroundColor: Colors.white,
                            elevation: 0, // Perfectly flat modern look
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),


                          
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Sign Up Prompt
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: textGrey,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: accentBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      )
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

  // Minimalist, solid-color text fields
  Widget _buildSolidTextField({
    required String label,
    required IconData icon,
    bool isPassword = false,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textDark,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: onChanged,
          obscureText: isPassword,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: textDark,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(icon, color: textGrey, size: 22),
            suffixIcon: isPassword 
                ? Icon(Icons.visibility_off_outlined, color: textGrey, size: 20)
                : null,
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: accentBlue, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}