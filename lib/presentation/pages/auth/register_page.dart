import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../routes/app_router.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nipController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  
  // State untuk toggle password
  bool _obscurePassword = true;

  // Fungsi untuk tombol "Silahkan Scan Wajah"
  Future<void> _goToFaceScan() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pushNamed(context, AppRoutes.faceRegistration);
    }
  }

  // Fungsi untuk tombol "Buat Akun"
  void _createAccount() {
    // Simulasi penyimpanan akun berhasil
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Akun berhasil dibuat! Silakan login.'),
        backgroundColor: AppColors.success,
      ),
    );
    // Langsung arahkan ke halaman Login
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  void dispose() {
    _nipController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3B5998),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 100),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Column(
                    children: [
                      const Text(
                        'Registrasi',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Serif',
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 40),

                      CustomTextField(
                        hintText: 'Masukkan NIP',
                        controller: _nipController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),

                      // Input Password dengan Toggle
                      CustomTextField(
                        hintText: 'Masukkan Password',
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        suffixIcon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          size: 20,
                          color: Colors.grey,
                        ),
                        onSuffixIconPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      const SizedBox(height: 32),

                      // Tombol 1: Scan Wajah
                      CustomButton(
                        text: 'Silahkan Scan Wajah',
                        onPressed: _goToFaceScan,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(height: 12),

                      // Tombol 2: Buat Akun (Langsung ke Login)
                      CustomButton(
                        text: 'Buat Akun',
                        onPressed: _createAccount,
                        isLoading: false,
                      ),
                      const SizedBox(height: 20),

                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
                        child: RichText(
                          text: const TextSpan(
                            text: 'Sudah punya akun? ',
                            style: TextStyle(color: Colors.black54, fontSize: 12),
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
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
}