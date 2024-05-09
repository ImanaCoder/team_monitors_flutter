part of 'company_cubit.dart';

sealed class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object> get props => [];
}

final class CompanyInitial extends CompanyState {}

final class CompanyLoading extends CompanyState {}

final class CompanyProfileLoading extends CompanyState {}

final class CompanyDashboardInfoLoaded extends CompanyState {
  final dynamic info;
  const CompanyDashboardInfoLoaded({required this.info});

  @override
  List<Object> get props => super.props..addAll([info]);
}

final class CompanyProfileLoaded extends CompanyState {
  final dynamic company;
  const CompanyProfileLoaded({required this.company});

  @override
  List<Object> get props => super.props..addAll([company]);
}

final class CompanyListLoaded extends CompanyState {
  final List<dynamic> companies;
  const CompanyListLoaded({required this.companies});

  @override
  List<Object> get props => super.props..addAll([companies]);
}

final class CompanySuccess extends CompanyState {
  final String successMsg;
  const CompanySuccess({required this.successMsg});

  @override
  List<Object> get props => super.props..addAll([successMsg]);
}

final class CompanyError extends CompanyState {
  final String errorMsg;
  const CompanyError({required this.errorMsg});

  @override
  List<Object> get props => super.props..addAll([errorMsg]);
}
