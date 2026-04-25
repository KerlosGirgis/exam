import 'package:exam/config/di/di.dart';
import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/core/utils/validator.dart';
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
        backgroundColor: ColorManager.whiteColor,
        appBar: AppBar(
          backgroundColor: ColorManager.whiteColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: ColorManager.blackColor,
            ),
            onPressed:
                onBack ??
                () => Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(AppRoutes.explore, (route) => false),
          ),
          title: const Text(
            'Profile',
            style: TextStyle(
              color: ColorManager.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            final cubit = context.read<ProfileCubit>();

            if (state.profile != null) {
              cubit.fillControllers(state.profile!, force: state.updateSuccess);
            }

            if (state.updateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')),
              );
            }

            if (state.updateErrorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.updateErrorMessage!)),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<ProfileCubit>();

            if (state.isLoading1) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage1 != null) {
              return Center(child: Text(state.errorMessage1!));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              'https://imgs.search.brave.com/ksdQg7llO3DKHrb1bYlesLG-lm219KtqYBcniCGaNm0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJzLmNvbS9p/bWFnZXMvaGQvY3I3/LXllbGxvdy1idXJz/dC0ycTJvbHdscHlj/dmI0cTN6LmpwZw',
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: ColorManager.primeColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: ColorManager.whiteColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: cubit.usernameController,
                      decoration: const InputDecoration(labelText: 'User name'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'User name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: cubit.firstNameController,
                            decoration: const InputDecoration(
                              labelText: 'First name',
                            ),
                            validator: FormValidator.validateName,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            controller: cubit.lastNameController,
                            decoration: InputDecoration(labelText: 'Last name'),
                            validator: FormValidator.validateName,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: FormValidator.validateEmail,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      obscuringCharacter: '*',
                      initialValue: '********',
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: TextButton(
                          onPressed: () => Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.changePassword),
                          child: const Text(
                            'Change',
                            style: TextStyle(color: ColorManager.primeColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: cubit.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone number',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Phone number is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: state.isUpdating
                            ? null
                            : () => cubit.submitEditProfile(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.hintColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: state.isUpdating
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: ColorManager.whiteColor,
                                ),
                              )
                            : const Text(
                                'Update',
                                style: TextStyle(
                                  color: ColorManager.whiteColor,
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
