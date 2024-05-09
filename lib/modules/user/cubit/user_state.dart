part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class OtpSent extends UserState {
  final String otp;
  const OtpSent({required this.otp});

  @override
  List<Object> get props => super.props..addAll([otp]);
}

final class UserRegistered extends UserState {}

final class UserLoggedIn extends UserState {}

final class TokenError extends UserState {}

final class TokenVerified extends UserState {}

final class UserUpdated extends UserState {}

final class UserError extends UserState {
  final String errorMsg;
  const UserError({required this.errorMsg});

  @override
  List<Object> get props => super.props..addAll([errorMsg]);
}
