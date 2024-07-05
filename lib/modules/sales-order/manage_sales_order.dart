import 'package:team_monitor/core/service_locator.dart';
import 'package:team_monitor/modules/company/cubit/company_cubit.dart';
import 'package:team_monitor/modules/customer/cubit/customer_cubit.dart';
import 'package:team_monitor/modules/customer/manage_customer.dart';
import 'package:team_monitor/modules/sales-order/cubit/sales_order_cubit.dart';
import 'package:team_monitor/modules/sales-order/widgets.dart';
import 'package:team_monitor/shared/widgets/app_buttons.dart';
import 'package:team_monitor/shared/widgets/app_form_fields.dart';
import 'package:team_monitor/shared/widgets/app_header.dart';
import 'package:team_monitor/shared/widgets/app_layout.dart';
import 'package:team_monitor/utils/display_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models.dart';

class ManageSalesOrder extends AppLayout {
  ManageSalesOrder({super.key});

  final order = Order();

  @override
  Widget header() => const AppHeader(title: "Create New Sales");

  @override
  Widget content(BuildContext context) {
    return ListView(
      children: [
        _CustomerSearchArea(order: order),
        const SizedBox(height: 8),
        // _AddProductArea(order: order),
        _Content(order: order),
        const SizedBox(height: 5),
        BlocProvider(
          create: (context) => SalesOrderCubit(),
          child: BlocConsumer<SalesOrderCubit, SalesOrderState>(
            listener: (context, state) {
              if (state is SalesOrderError) {
                sl<AppToast>().error(state.errorMsg);
              } else if (state is SalesOrderSuccess) {
                sl<AppToast>().success(state.successMsg);
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is SalesOrderLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return AppButton(
                name: "Create",
                onPressed: () {
                  if (order.customerId != null) {
                    context.read<SalesOrderCubit>().addNewSalesOrder(order.toJson());
                  } else {
                    sl<AppToast>().error("Please select customer");
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Content extends StatefulWidget {
  final Order order;
  const _Content({super.key, required this.order});

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // company select, order-type select
        Row(
          children: [
            Expanded(child: _CompanySearchArea(order: widget.order)),
            Expanded(
              child: AppSearchableDropdown(
                labelText: 'Choose Type',
                keyString: 'name',
                items: const [
                  {'name': 'Product'},
                  {'name': 'Offer'}
                ],
                onChanged: (val) {
                  setState(() {
                    widget.order.changeOrderType(val['name']);
                  });
                  // context.read<SalesOrderCubit>().refreshSalesOrderInfo();
                },
              ),
            )
          ],
        ),
        if (widget.order.type != null && widget.order.type == "Product") AddProductArea(order: widget.order),
        if (widget.order.type != null && widget.order.type == "Offer") AddOfferToOrder(order: widget.order),
      ],
    );
  }
}

class _CustomerSearchArea extends StatelessWidget {
  final Order order;
  const _CustomerSearchArea({required this.order});

  @override
  Widget build(BuildContext context) {
    return BoxLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: BlocProvider(
                  create: (context) => CustomerCubit()..getAllCustomersByCoSeller(),
                  child: BlocConsumer<CustomerCubit, CustomerState>(
                    listener: (context, state) {
                      if (state is CustomerError) sl<AppToast>().error(state.errorMsg);
                    },
                    builder: (context, state) {
                      if (state is CustomerLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CustomerListLoaded) {
                        return AppSearchableDropdown(
                          labelText: 'Find Customer',
                          keyString: 'name',
                          items: state.customers,
                          onChanged: (customer) {
                            order.customerId = customer['id'];
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // add new customer button
              InkWell(
                onTap: () {
                  showAppDialogBox(context: context, title: "New Customer", content: ManageCustomer());
                },
                child: const Row(
                  children: [
                    Icon(Icons.add_circle, color: Color(0xFF171717), size: 18),
                    SizedBox(width: 10),
                    Text('Add New', style: TextStyle(color: Color(0xFF2D3B8A))),
                  ],
                ),
              ),
            ],
          ),
          // const _CustomerBox(),
        ],
      ),
    );
  }
}

class _CompanySearchArea extends StatelessWidget {
  final Order order;
  const _CompanySearchArea({required this.order});

  @override
  Widget build(BuildContext context) {
    return BoxLayout(
      child: BlocProvider(
        create: (context) => CompanyCubit()..getCompaniesForCoseller(),
        child: BlocConsumer<CompanyCubit, CompanyState>(
          listener: (context, state) {
            if (state is CompanyError) sl<AppToast>().error(state.errorMsg);
          },
          builder: (context, state) {
            if (state is CompanyLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CompanyListLoaded) {
              return AppSearchableDropdown(
                labelText: 'Find Company',
                keyString: 'name',
                items: state.companies,
                onChanged: (company) {
                  order.companyId = company['id'];
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

// class _CustomerBox extends StatelessWidget {
//   const _CustomerBox();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.green,
//       ),
//       child: const Text(
//         'Hari Bahadur Nepali  9852054672',
//         style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w300),
//       ),
//     );
//   }
// }
