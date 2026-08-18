import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sasto_mart/features/authentication/bloc/signup_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Refined Solid Color Palette (Matches Login Page)
  final Color navyBlue = const Color(0xFF0F2041);
  final Color accentBlue = const Color(0xFF2563EB);
  final Color backgroundWhite = const Color(0xFFF4F6F8);
  final Color textDark = const Color(0xFF111827);
  final Color textGrey = const Color(0xFF6B7280);

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
              height: size.height * 0.35,
              width: double.infinity,
              color: navyBlue,
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
                        color: Colors.white.withValues(alpha:0.03),
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.10,
                    left: 32,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back button (useful for navigation back to login)
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha:0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Join SastoMart today!",
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
            
            // 2. The Floating White Card
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
                        label: "Full Name",
                        icon: Icons.person_outline,
                        onChanged: (value){
                          context.read<SignupBloc>().add(SignupFullnameChanged(value));
                        }
                      ),
                      const SizedBox(height: 20),
                      _buildSolidTextField(
                        label: "Email Address",
                        icon: Icons.email_outlined,
                        onChanged: (value){
                          context.read<SignupBloc>().add(SignupEmailChanged(value));
                        }
                      ),
                      const SizedBox(height: 20),
                      _buildSolidTextField(
                        label: "Password",
                        icon: Icons.lock_outline_rounded,
                        isPassword: true,
                        onChanged: (value){
                          context.read<SignupBloc>().add(SignupPasswordChanged(value));
                        }
                      ),
                      const SizedBox(height: 20),
                      _buildSolidTextField(
                        label: "Confirm Password",
                        icon: Icons.lock_outline_rounded,
                        isPassword: true,
                        onChanged: (value){
                          context.read<SignupBloc>().add(SignupConfirmPasswordChanged(value));
                        }
                      ),
                      
                      const SizedBox(height: 36),
                      
                      // 3. Solid Accent Blue Button
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            print("${context.read<SignupBloc>().state.fullname}");
                            print("${context.read<SignupBloc>().state.email}");
                            print("${context.read<SignupBloc>().state.password}");
                            print("${context.read<SignupBloc>().state.confirmPassword}");
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
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Login Prompt
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color: textGrey,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Go back to login
                            },
                            child: Text(
                              "Sign In",
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
          obscureText: isPassword,
          onChanged: onChanged,
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
            contentPadding: const EdgeInsets.symmetric(vertical: 16), // Slightly tighter padding for 4 fields
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
