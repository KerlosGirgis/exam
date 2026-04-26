import 'package:exam/config/di/di.dart';
import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/core/utils/app_validation.dart';
import 'package:exam/feature/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:exam/feature/profile/presentation/view_model/states/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getProfile(),
      child: Scaffold(
        backgroundColor: const Color(0xffF8F9FB),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            final cubit = context.read<ProfileCubit>();

            if (state.profile != null) {
              cubit.fillControllers(state.profile!, force: state.updateSuccess);
            }

            if (state.updateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            }

            if (state.updateErrorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.updateErrorMessage!),
                  backgroundColor: ColorManager.errorColor,
                ),
              );
            }

            if (state.logoutSuccess) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.login, (route) => false);
            }
          },
          builder: (context, state) {
            final cubit = context.read<ProfileCubit>();

            if (state.isLoading1) {
              return const Center(
                  child: CircularProgressIndicator(color: ColorManager.primeColor));
            }

            if (state.errorMessage1 != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 60, color: ColorManager.errorColor),
                    const SizedBox(height: 16),
                    Text(state.errorMessage1!,
                        style: const TextStyle(color: ColorManager.greyColor)),
                    TextButton(
                      onPressed: () => cubit.getProfile(),
                      child: const Text('Retry',
                          style: TextStyle(color: ColorManager.primeColor)),
                    ),
                  ],
                ),
              );
            }

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Stunning Modern Header with Avatar
                SliverAppBar(
                  expandedHeight: 250,
                  pinned: true,
                  stretch: true,
                  backgroundColor: ColorManager.primeColor,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                        child: IconButton(
                          icon: state.isLoggingOut
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.logout_rounded,
                                  color: Colors.white, size: 20),
                          onPressed: state.isLoggingOut
                              ? null
                              : () => cubit.logout(),
                        ),
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                    ],
                    centerTitle: true,
                    title: LayoutBuilder(builder: (context, constraints) {
                      final double appBarHeight = constraints.biggest.height;
                      final bool isCollapsed = appBarHeight <=
                          kToolbarHeight + MediaQuery.of(context).padding.top + 10;
                      return AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isCollapsed ? 1.0 : 0.0,
                        child: Text(
                          '${state.profile?.firstName ?? ""} ${state.profile?.lastName ?? ""}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Gradient Background
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [ColorManager.primeColor, Color(0xff1A4BAF)],
                            ),
                          ),
                        ),
                        // Abstract decorative shapes
                        Positioned(
                          top: -50,
                          right: -50,
                          child: CircleAvatar(
                            radius: 120,
                            backgroundColor: Colors.white.withValues(alpha: 0.05),
                          ),
                        ),

                        // Expanded Profile Content
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              _buildAvatar(state, size: 55),
                              const SizedBox(height: 16),
                              Text(
                                '${state.profile?.firstName ?? ""} ${state.profile?.lastName ?? ""}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.5,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                state.profile?.email ?? "",
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Profile Form
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Personal Information'),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: cubit.usernameController,
                            label: 'Username',
                            icon: Icons.person_outline,
                            validator: (value) => value == null || value.trim().isEmpty
                                ? 'User name is required'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  controller: cubit.firstNameController,
                                  label: 'First Name',
                                  validator: AppValidators.nameValidation,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildTextField(
                                  controller: cubit.lastNameController,
                                  label: 'Last Name',
                                  validator: AppValidators.nameValidation,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: cubit.emailController,
                            label: 'Email',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: AppValidators.emailValidation,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: cubit.phoneController,
                            label: 'Phone Number',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Phone number is required'
                                    : null,
                          ),
                          const SizedBox(height: 32),
                          _buildSectionTitle('Security'),
                          const SizedBox(height: 16),
                          _buildPasswordField(context),
                          const SizedBox(height: 48),

                          // Update Button
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: (state.isUpdating || !state.hasChanges)
                                  ? null
                                  : () => cubit.submitEditProfile(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.primeColor,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                disabledBackgroundColor:
                                    ColorManager.hintColor.withValues(alpha: 0.5),
                              ),
                              child: state.isUpdating
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Update Profile',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAvatar(ProfileState state,
      {double size = 55, bool showCamera = true}) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white24, width: 2),
          ),
          child: CircleAvatar(
            radius: size,
            backgroundColor: Colors.white,
            backgroundImage: const NetworkImage(
              'https://imgs.search.brave.com/ksdQg7llO3DKHrb1bYlesLG-lm219KtqYBcniCGaNm0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJzLmNvbS9p/bWFnZXMvaGQvY3I3/LXllbGxvdy1idXJz/dC0ycTJvbHdscHlj/dmI0cTN6LmpwZw',
            ),
          ),
        ),
        if (showCamera)
          Positioned(
            bottom: 4,
            right: 4,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                color: ColorManager.primeColor,
                size: 20,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: ColorManager.blackColor,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null
            ? Icon(icon, color: ColorManager.primeColor, size: 20)
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorManager.whiteBlueColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorManager.whiteBlueColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: ColorManager.primeColor, width: 1.5),
        ),
        labelStyle: const TextStyle(color: ColorManager.hintColor, fontSize: 14),
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorManager.whiteBlueColor),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.lock_outline, color: ColorManager.primeColor, size: 20),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: TextStyle(color: ColorManager.hintColor, fontSize: 12),
                ),
                Text(
                  '••••••••',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.changePassword),
            child: const Text(
              'Change',
              style: TextStyle(
                color: ColorManager.primeColor,
                fontWeight: FontWeight.bold,
              ),

            ),
          ),
        ],
      ),
    );
  }
}
