import 'package:codeal/core/service_locator.dart';
import 'package:codeal/modules/company/cubit/company_cubit.dart';
import 'package:codeal/shared/widgets/app_header.dart';
import 'package:codeal/shared/widgets/app_layout.dart';
import 'package:codeal/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyListingPage extends AppLayout {
  const CompanyListingPage({super.key});

  @override
  Widget header() => const AppHeader(title: "Company Listing");

  @override
  Widget content(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyCubit()..getAllCompanies(),
      child: BlocConsumer<CompanyCubit, CompanyState>(
        listener: (context, state) {
          if (state is CompanyError) sl<AppToast>().error(state.errorMsg);
        },
        builder: (context, state) {
          if (state is CompanyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompanyListLoaded) {
            var companies = state.companies;
            if (companies.isEmpty) return const Center(child: Text('No companies Found'));

            return ListView(
              children: companies.map((company) {
                return ListTile(
                  title: Text("${company['name']}"),
                  subtitle: Text("${company['panNumber']}"),
                );
              }).toList(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
