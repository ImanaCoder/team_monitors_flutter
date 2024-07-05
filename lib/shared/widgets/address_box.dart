import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/shared/controllers/address/address_cubit.dart';
import 'package:team_monitor/shared/models/address.dart';
import 'package:team_monitor/shared/widgets/value_selector.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_form_fields.dart';

class AddressBox extends StatelessWidget {
  final Address address;
  const AddressBox({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit()..getProvinces(),
      child: Column(
        children: [
          _ProvinceSelector(address: address),
          _DistrictSelector(address: address),
          _PalikaSelector(address: address),
          AppFormField(
            label: "City",
            initialValue: address.city,
            textInputAction: TextInputAction.next,
            onSaved: (value) => address.city = value,
          ),
          AppFormField(
            label: "Street Address",
            initialValue: address.streetAddress,
            textInputAction: TextInputAction.next,
            onSaved: (value) => address.streetAddress = value,
          ),
        ],
      ),
    );
  }
}

class _ProvinceSelector extends StatelessWidget {
  final Address address;
  const _ProvinceSelector({required this.address});

  @override
  Widget build(BuildContext context) {
    return ValueSelectorBox(
      label: "Province",
      child: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state is AddressError) sl<AppToast>().error(state.errorMsg);
          if (state is ProvinceChanged) address.provinceCode = state.province['code'];
        },
        builder: (context, state) {
          if (state is ProvinceLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          var provinces = context.read<AddressCubit>().provinces;
          var selected = context.read<AddressCubit>().selectedProvince;
          if (address.provinceCode != 0 && provinces.isNotEmpty) {
            selected = provinces.firstWhere((element) => element['code'] == address.provinceCode);
            if (context.read<AddressCubit>().districts.isEmpty) {
              context.read<AddressCubit>().getDistricts(selected['code']);
            }
          }

          return _FederalDropdown(
            items: provinces,
            currentValue: selected,
            onChanged: (value) {
              if (value != null) {
                context.read<AddressCubit>().changeProvince(value);
                context.read<AddressCubit>().getDistricts(value['code']);
              }
            },
          );
        },
      ),
    );
  }
}

class _DistrictSelector extends StatelessWidget {
  final Address address;
  const _DistrictSelector({required this.address});

  @override
  Widget build(BuildContext context) {
    return ValueSelectorBox(
      label: "District",
      child: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state is AddressError) sl<AppToast>().error(state.errorMsg);
          if (state is DistrictChanged) address.districtCode = state.district['code'];
        },
        builder: (context, state) {
          if (state is DistrictLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          var districts = context.read<AddressCubit>().districts;
          dynamic selected = context.read<AddressCubit>().selectedDistrict;
          if (address.districtCode != 0 && districts.isNotEmpty) {
            selected = districts.firstWhere(
              (element) => element['code'] == address.districtCode,
              orElse: () => districts[0],
            );
            if (context.read<AddressCubit>().palikas.isEmpty) {
              context.read<AddressCubit>().getPalikas(selected['code']);
            }
          } else if (address.districtCode == 0) {
            address.districtCode = selected != null ? selected['code'] : 0;
          }
          return _FederalDropdown(
            items: districts,
            currentValue: selected,
            onChanged: (value) {
              if (value != null) {
                context.read<AddressCubit>().changeDistrict(value);
                context.read<AddressCubit>().getPalikas(value['code']);
              }
            },
          );
        },
      ),
    );
  }
}

class _PalikaSelector extends StatelessWidget {
  final Address address;
  const _PalikaSelector({required this.address});

  @override
  Widget build(BuildContext context) {
    return ValueSelectorBox(
      label: "Palika",
      child: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state is AddressError) sl<AppToast>().error(state.errorMsg);
          if (state is PalikaChanged) address.palikaCode = state.palika['code'];
        },
        builder: (context, state) {
          if (state is PalikaLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          var palikas = context.read<AddressCubit>().palikas;
          var selected = context.read<AddressCubit>().selectedPalika;
          if (address.palikaCode != 0 && palikas.isNotEmpty) {
            selected = palikas.firstWhere(
              (element) => element['code'] == address.palikaCode,
              orElse: () => palikas[0],
            );
          } else if (address.palikaCode == 0) {
            address.palikaCode = selected != null ? selected['code'] : 0;
          }
          return _FederalDropdown(
            items: palikas,
            currentValue: selected,
            onChanged: (value) {
              if (value != null) {
                context.read<AddressCubit>().changePalika(value);
              }
            },
          );
        },
      ),
    );
  }
}

class _FederalDropdown extends StatelessWidget {
  final List<dynamic> items;
  final dynamic currentValue;
  final void Function(dynamic)? onChanged;
  const _FederalDropdown({required this.items, required this.currentValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<dynamic>(
        isExpanded: true,
        underline: Container(),
        items: items
            .map((p) => DropdownMenuItem<dynamic>(
                  value: p,
                  // enabled: p.enabled,
                  child: Text(p['englishName'], style: const TextStyle(fontSize: 14)),
                ))
            .toList(),
        value: currentValue,
        onChanged: onChanged,
      ),
    );
  }
}
