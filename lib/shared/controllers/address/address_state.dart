part of 'address_cubit.dart';

sealed class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

final class AddressInitial extends AddressState {}

final class ProvinceLoading extends AddressState {}

final class ProvinceListLoaded extends AddressState {}

final class ProvinceChanged extends AddressState {
  final dynamic province;
  const ProvinceChanged({required this.province});

  @override
  List<Object> get props => super.props..addAll([province]);
}

final class DistrictLoading extends AddressState {}

final class DistrictListLoaded extends AddressState {}

final class DistrictChanged extends AddressState {
  final dynamic district;
  const DistrictChanged({required this.district});

  @override
  List<Object> get props => super.props..addAll([district]);
}

final class PalikaLoading extends AddressState {}

final class PalikaListLoaded extends AddressState {}

final class PalikaChanged extends AddressState {
  final dynamic palika;
  const PalikaChanged({required this.palika});

  @override
  List<Object> get props => super.props..addAll([palika]);
}

final class AddressError extends AddressState {
  final String errorMsg;
  const AddressError({required this.errorMsg});

  @override
  List<Object> get props => super.props..addAll([errorMsg]);
}
