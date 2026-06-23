
import 'package:crm_project/core/theme/app_tokens.dart';
import 'package:crm_project/data/featuers/user_management/presentation/controllers/auth_controller.dart';
import 'package:crm_project/data/featuers/user_management/presentation/widgets/custom_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final LoginController _controller = Get.find<LoginController>();
  final TextEditingController _usernameOrEmailController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameOrEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTokens.neutral50,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Form(
              key: _formKey,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onLongPress: () {
                        _controller.isTenantMode.value =
                            !_controller.isTenantMode.value;
                        _usernameOrEmailController.clear();
                        _passwordController.clear();

                        setState(() {
                          _autoValidateMode = AutovalidateMode.disabled;
                        });

                        Get.snackbar(
                          'System Notification',
                          _controller.isTenantMode.value
                              ? 'Switched to Tenant Mode'
                              : 'Secure Admin Portal Activated',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppTokens.neutral900.withOpacity(
                            0.9,
                          ),
                          colorText: Colors.white,
                          duration: const Duration(seconds: 2),
                        );
                      },
                      child: const _LogoSection(),
                    ),
                    const SizedBox(height: 25.0),

                    Obx(
                      () => _HeaderTitles(
                        isTenant: _controller.isTenantMode.value,
                      ),
                    ),
                    const SizedBox(height: 30.0),

                  
                    Obx(() {
                      final isTenant = _controller.isTenantMode.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _FieldLabel(
                            label: isTenant
                                ? 'Company Identifier'
                                : 'Platform Email Address',
                          ),
                          const SizedBox(height: 6.0),
                          TextFormField(
                            controller: _usernameOrEmailController,
                            autovalidateMode: _autoValidateMode,
                            keyboardType: isTenant
                                ? TextInputType.text
                                : TextInputType.emailAddress,
                            onChanged: (value) {
                              if (_autoValidateMode ==
                                  AutovalidateMode.onUserInteraction) {
                                setState(() {
                                  _formKey.currentState!.validate();
                                });
                              }
                            },
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontFamily: AppTokens.fontFamily,
                              fontSize: 14,
                              color: AppTokens.neutral900,
                            ),
                            decoration: CustomInputDecoration.build(
                              hintText: isTenant
                                  ? 'company:username'
                                  : 'admin@loopchat.com',
                              prefixIcon: Icon(
                                isTenant
                                    ? Icons.assignment_ind_rounded
                                    : Icons.mail_outline_rounded,
                                size: 20,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return isTenant
                                    ? 'Required field'
                                    : 'Email is required';
                              }

                              final trimmedValue = value.trim();

                              if (isTenant) {
                                if (!trimmedValue.contains(':')) {
                                  return 'Missing ":" (e.g., company:username)';
                                }

                                final firstColonIndex = trimmedValue.indexOf(
                                  ':',
                                );
                                final companyPart = trimmedValue
                                    .substring(0, firstColonIndex)
                                    .trim();
                                final userOrEmailPart = trimmedValue
                                    .substring(firstColonIndex + 1)
                                    .trim();

                                if (companyPart.isEmpty ||
                                    userOrEmailPart.isEmpty) {
                                  return 'Format must be company:user';
                                }

                                if (companyPart.contains(' ')) {
                                  return 'Company name cannot have spaces';
                                }

                                if (userOrEmailPart.contains('@')) {
                                  final emailRegex = RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                                  );
                                  if (!emailRegex.hasMatch(userOrEmailPart)) {
                                    return 'Invalid email format';
                                  }
                                } else {
                                  if (userOrEmailPart.contains(' ')) {
                                    return 'Username cannot have spaces';
                                  }
                                }
                              } else {
                                final emailRegex = RegExp(
                                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                                );
                                if (!emailRegex.hasMatch(trimmedValue)) {
                                  return 'Invalid email address';
                                }
                              }
                              return null;
                            },
                          ),
                        ],
                      );
                    }),

                    const SizedBox(height: 24.0),

                    // حقل كلمة المرور
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const _FieldLabel(label: 'Password'),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontFamily: AppTokens.fontFamily,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppTokens.primary600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    TextFormField(
                      controller: _passwordController,
                      autovalidateMode: _autoValidateMode,
                      obscureText: !_isPasswordVisible,
                      onChanged: (value) {
                        if (_autoValidateMode ==
                            AutovalidateMode.onUserInteraction) {
                          setState(() {
                            _formKey.currentState!.validate();
                          });
                        }
                      },
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontFamily: AppTokens.fontFamily,
                        fontSize: 14,
                        color: AppTokens.neutral900,
                      ),
                      decoration: CustomInputDecoration.build(
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          size: 20,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 8 || value.length > 20) {
                          return 'Must be between 8 and 20 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32.0),

                  
                    _SubmitButton(
                      formKey: _formKey,
                      controller: _controller,
                      usernameOrEmailController: _usernameOrEmailController,
                      passwordController: _passwordController,
                      onValidationError: () {
                        setState(() {
                          _autoValidateMode =
                              AutovalidateMode.onUserInteraction;
                        });
                      },
                    ),
                    const SizedBox(height: 32.0),
                    const _FooterSupport(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// Widgets الفرعية المعزولة
// =========================================================================

class _LogoSection extends StatelessWidget {
  const _LogoSection();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: AppTokens.primary600.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: const DecorationImage(
              image: AssetImage(AppTokens.logoPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderTitles extends StatelessWidget {
  final bool isTenant;
  const _HeaderTitles({required this.isTenant});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isTenant ? 'Welcome Back' : 'Platform Control',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: AppTokens.fontFamily,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppTokens.neutral900,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          isTenant
              ? 'Login to Your Account'
              : 'Access your central management dashboard',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: AppTokens.fontFamily,
            fontSize: 14,
            color: AppTokens.neutral500,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontFamily: AppTokens.fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppTokens.neutral800,
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final LoginController controller;
  final TextEditingController usernameOrEmailController;
  final TextEditingController passwordController;
  final VoidCallback onValidationError;

  const _SubmitButton({
    required this.formKey,
    required this.controller,
    required this.usernameOrEmailController,
    required this.passwordController,
    required this.onValidationError,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = controller.isLoading.value;

      return Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            colors: isLoading
                ? [Colors.grey, Colors.grey[400]!]
                : [AppTokens.buttonGradient.colors[0], AppTokens.buttonGradient.colors[1]],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: isLoading
              ? []
              : [
                  BoxShadow(
                    color: AppTokens.primary600.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: isLoading
              ? null
              : () {
                  if (formKey.currentState!.validate()) {
                    final input = usernameOrEmailController.text.trim();
                    final password = passwordController.text;

                    if (controller.isTenantMode.value) {
                      controller.loginTenant(input, password);
                    } else {
                      controller.loginPlatform(input, password);
                    }
                  } else {
                    onValidationError();
                  }
                },
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : const Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: AppTokens.fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      );
    });
  }
}

class _FooterSupport extends StatelessWidget {
  const _FooterSupport();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Facing issues with login?',
          style: TextStyle(
            fontFamily: AppTokens.fontFamily,
            fontSize: 14,
            color: AppTokens.neutral500,
          ),
        ),
        const SizedBox(width: 6.0),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'Technical Support',
            style: TextStyle(
              fontFamily: AppTokens.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTokens.primary600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
