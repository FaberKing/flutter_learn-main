import 'package:course_bank_sha/blocs/data_plan/data_plane_bloc.dart';
import 'package:course_bank_sha/model/data_plane_form_model.dart';
import 'package:course_bank_sha/model/data_plane_model.dart';
import 'package:course_bank_sha/model/operator_card_model.dart';
import 'package:course_bank_sha/shared/theme.dart';
import 'package:course_bank_sha/ui/widget/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../shared/shared_method.dart';
import '../widget/forms.dart';
import '../widget/package_item.dart';

class DataPackagePage extends StatefulWidget {
  final OperatorCardModel operatorCard;
  const DataPackagePage({
    super.key,
    required this.operatorCard,
  });

  @override
  State<DataPackagePage> createState() => _DataPackagePageState();
}

class _DataPackagePageState extends State<DataPackagePage> {
  final phoneController = TextEditingController();
  DataPlanModel? selectedDataPlan;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataPlaneBloc(),
      child: BlocConsumer<DataPlaneBloc, DataPlaneState>(
        listener: (context, state) {
          if (state is DataPlaneFailed) {
            showCustomSnackbar(context, state.e);
          }
          if (state is DataPlaneSuccess) {
            context.read<AuthBloc>().add(
                  AuthUpdateBalance(
                    selectedDataPlan!.price! * -1,
                  ),
                );

            Navigator.pushNamedAndRemoveUntil(
              context,
              '/data-success',
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is DataPlaneLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Paket Data',
              ),
            ),
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Phone Nunber',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomFormField(
                    title: '+628',
                    isShowTitle: false,
                    controller: phoneController,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Select Package',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Center(
                    child: Wrap(
                      spacing: 17,
                      runSpacing: 17,
                      children: widget.operatorCard.dataPlans!.map(
                        (e) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDataPlan = e;
                              });
                            },
                            child: PackageItem(
                              dataPlan: e,
                              isSelected: selectedDataPlan?.id == e.id,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton:
                (selectedDataPlan != null && phoneController.text.isNotEmpty)
                    ? Container(
                        margin: const EdgeInsets.all(24),
                        child: CustomFilledButton(
                          title: 'Continue',
                          onPressed: () async {
                            if (await Navigator.pushNamed(context, '/pin') ==
                                true) {
                              final authState = context.read<AuthBloc>().state;

                              String pin = "";
                              if (authState is AuthSuccess) {
                                pin = authState.user.pin!;
                              }

                              context.read<DataPlaneBloc>().add(
                                    DataPlanPost(
                                      DataPlanFormModel(
                                        dataPlanId: selectedDataPlan!.id,
                                        phoneNumber: phoneController.text,
                                        pin: pin,
                                      ),
                                    ),
                                  );
                            }
                          },
                        ),
                      )
                    : Container(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }
}
