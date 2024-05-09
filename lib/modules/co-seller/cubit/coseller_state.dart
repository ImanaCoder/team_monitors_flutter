part of 'coseller_cubit.dart';

sealed class CosellerState extends Equatable {
  const CosellerState();

  @override
  List<Object> get props => [];
}

final class CosellerInitial extends CosellerState {}

final class CosellerLoading extends CosellerState {}

final class CosellerProfileLoading extends CosellerState {}

final class CosellerProfileLoaded extends CosellerState {
  final dynamic coseller;
  const CosellerProfileLoaded({required this.coseller});

  @override
  List<Object> get props => super.props..addAll([coseller]);
}

final class CosellerListLoaded extends CosellerState {
  final List<dynamic> cosellers;
  const CosellerListLoaded({required this.cosellers});

  @override
  List<Object> get props => super.props..addAll([cosellers]);
}

final class BankDetailsListLoaded extends CosellerState {
  final List<dynamic> bankDetails;
  const BankDetailsListLoaded({required this.bankDetails});

  @override
  List<Object> get props => super.props..addAll([bankDetails]);
}

final class BankDetailsLoaded extends CosellerState {
  final dynamic bankDetails;
  const BankDetailsLoaded({required this.bankDetails});

  @override
  List<Object> get props => super.props..addAll([bankDetails]);
}

final class DigitalWalletListLoaded extends CosellerState {
  final List<dynamic> digitalWallets;
  const DigitalWalletListLoaded({required this.digitalWallets});

  @override
  List<Object> get props => super.props..addAll([digitalWallets]);
}

final class DigitalWalletLoaded extends CosellerState {
  final dynamic digitalWallet;
  const DigitalWalletLoaded({required this.digitalWallet});

  @override
  List<Object> get props => super.props..addAll([digitalWallet]);
}

final class CosellerSuccess extends CosellerState {
  final String successMsg;
  const CosellerSuccess({required this.successMsg});

  @override
  List<Object> get props => super.props..addAll([successMsg]);
}

final class CosellerError extends CosellerState {
  final String errorMsg;
  const CosellerError({required this.errorMsg});

  @override
  List<Object> get props => super.props..addAll([errorMsg]);
}
