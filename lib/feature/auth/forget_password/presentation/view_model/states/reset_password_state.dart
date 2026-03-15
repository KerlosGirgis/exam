class ResetPasswordState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final bool isObscure;

  ResetPasswordState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.isObscure = false,
  });

  ResetPasswordState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool? isObscure,
  }) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      isObscure: isObscure ?? this.isObscure,
    );
  }
}
