import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/brand_colors.dart';
import '../../../../constants/fonts.dart';
import '../../../../constants/routes.dart';
import '../../../../cubits/customized_consultation/customized_consultation_cubit.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../utilities/extensions.dart';
import '../../../widgets/border_painter.dart';

class CustomizedChoosePriceScreen extends StatefulWidget {
  const CustomizedChoosePriceScreen({super.key});

  @override
  State<CustomizedChoosePriceScreen> createState() =>
      _CustomizedChoosePriceScreenState();
}

class _CustomizedChoosePriceScreenState
    extends State<CustomizedChoosePriceScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final _canGoNext = ValueNotifier(false);
  final _isPriceCeiling = ValueNotifier(true);
  final _priceController = TextEditingController();
  final _hoursController = TextEditingController();

  bool _isAgree = false;
  bool _isPriceValid = false;
  bool _isHourValid = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _canGoNext.dispose();
    _isPriceCeiling.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight * 1.5,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              appLocalizations.customizedConsultation,
            ),
            Text(
              '6 - ${appLocalizations.consultationPrice}',
              style: const TextStyle(color: BrandColors.gray),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 27.width),
            child: CustomPaint(
              painter: BorderPainter(
                stroke: 3.0,
                padding: 8.width,
                progress: 6 / 6,
              ),
              child: Transform.translate(
                offset: const Offset(0, 2),
                child: const Center(
                  child: Text.rich(
                    style: TextStyle(color: BrandColors.gray),
                    TextSpan(children: [
                      TextSpan(
                        text: '6',
                        style: TextStyle(color: BrandColors.orange),
                      ),
                      TextSpan(text: '/6'),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 18.height,
          horizontal: 34.width,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.chooseMethod,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: BrandColors.darkGreen,
              ),
            ),
            11.emptyHeight,
            DecoratedBox(
              decoration: BoxDecoration(
                color: BrandColors.snowWhite,
                borderRadius: BorderRadius.circular(26.0),
              ),
              child: TabBar(
                controller: _tabController,
                labelStyle: const TextStyle(
                  fontSize: 13.0,
                  fontFamily: Fonts.main,
                ),
                onTap: (value) {
                  _isPriceCeiling.value = value == 0;
                  if (_isPriceCeiling.value) {
                    _canGoNext.value = _isPriceValid && _isHourValid;
                  } else {
                    _canGoNext.value = _isHourValid;
                  }
                },
                tabs: [
                  Tab(text: appLocalizations.setPriceCeiling),
                  Tab(text: appLocalizations.consultantSetPrice),
                ],
              ),
            ),
            16.emptyHeight,
            ValueListenableBuilder(
              valueListenable: _isPriceCeiling,
              builder: (context, value, child) => AnimatedCrossFade(
                firstChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(text: appLocalizations.price),
                        TextSpan(
                          text: ' (${appLocalizations.minimumTwoDollars})',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                      ]),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: BrandColors.darkGreen,
                      ),
                    ),
                    8.emptyHeight,
                    TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        hintText: '0.00',
                        suffixIcon: Center(
                          widthFactor: 1.0,
                          child: Text(
                            appLocalizations.sar,
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: BrandColors.green,
                            ),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        final number = num.tryParse(value) ?? 0;
                        if (number < 2) {
                          _isPriceValid = false;
                          _canGoNext.value = false;
                          return;
                        }
                        _isPriceValid = true;
                        _canGoNext.value = _isHourValid;
                      },
                    ),
                  ],
                ),
                secondChild: Container(width: double.infinity),
                crossFadeState: value
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: kTabScrollDuration,
                alignment: Alignment.topCenter,
              ),
            ),
            20.emptyHeight,
            Text(
              appLocalizations.maximumReceiveTime,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: BrandColors.darkGreen,
              ),
            ),
            8.emptyHeight,
            TextField(
              controller: _hoursController,
              keyboardType: TextInputType.number,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                hintText: '0.00',
                suffixIcon: Center(
                  widthFactor: 1.0,
                  child: Text(
                    appLocalizations.hour,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: BrandColors.darkGreen,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              onChanged: (value) {
                final number = num.tryParse(value) ?? 0;
                if (number < 5) {
                  _isHourValid = false;
                  _canGoNext.value = false;
                  return;
                }
                _isHourValid = true;
                _canGoNext.value = _isPriceCeiling.value ? _isPriceValid : true;
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(indent: 27.width, endIndent: 24.width),
          StatefulBuilder(
            builder: (context, setState) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.width),
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text.rich(
                  TextSpan(children: [
                    TextSpan(text: '${appLocalizations.agreeOn} '),
                    TextSpan(
                        text: appLocalizations.consultationsTerms,
                        style: const TextStyle(
                          color: BrandColors.orange,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        )),
                    TextSpan(text: ' ${appLocalizations.and} '),
                    TextSpan(
                        text: appLocalizations.royakeTerms,
                        style: const TextStyle(
                          color: BrandColors.orange,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        )),
                    TextSpan(text: ' ${appLocalizations.toSendConsultations}'),
                  ]),
                  style: const TextStyle(fontSize: 15.0),
                ),
                value: _isAgree,
                onChanged: (value) => setState(() => _isAgree = value!),
              ),
            ),
          ),
          Divider(indent: 27.width, endIndent: 24.width),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 27.width),
            child: Text(
              appLocalizations.saveAsDraft,
              style: const TextStyle(
                fontSize: 16.0,
                color: BrandColors.orange,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          BottomAppBar(
            child: Padding(
              padding: EdgeInsets.only(
                left: 27.width,
                top: 24.height,
                right: 27.width,
                bottom: Platform.isAndroid ? 17.height : 0.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey.shade700,
                        side: const BorderSide(color: Colors.grey),
                      ),
                      child: Text(
                        appLocalizations.consultationSchedule,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  10.emptyWidth,
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: ValueListenableBuilder(
                        valueListenable: _canGoNext,
                        builder: (context, value, child) => BlocConsumer<
                            CustomizedConsultationCubit,
                            CustomizedConsultationState>(
                          listener: (context, state) {
                            if (state is CustomizedConsultationSent) {
                              Navigator.pushNamed(
                                context,
                                Routes.consultationSent,
                                arguments: state.id,
                              );
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton.icon(
                              onPressed: value
                                  ? () {
                                      context
                                          .read<CustomizedConsultationCubit>()
                                          .setPrice(
                                            maximumHoursToReceiveOffers:
                                                num.parse(
                                                    _hoursController.text),
                                          );
                                      context
                                          .read<CustomizedConsultationCubit>()
                                          .send(context);
                                    }
                                  : null,
                              icon: const Directionality(
                                textDirection: TextDirection.rtl,
                                child: Icon(Icons.send),
                              ),
                              label: state is CustomizedConsultationSending
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      appLocalizations.send,
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
