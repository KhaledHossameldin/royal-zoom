import 'package:flutter/material.dart';

import '../../../../../constants/routes.dart';
import '../../../../../localization/app_localizations.dart';
import '../../../../../utilities/extensions.dart';

class ConsultantReportScreen extends StatefulWidget {
  const ConsultantReportScreen({super.key});

  @override
  State<ConsultantReportScreen> createState() => _ConsultantReportScreenState();
}

class _ConsultantReportScreenState extends State<ConsultantReportScreen> {
  bool _isAbuse = false;

  bool _isViolation = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appLocalizations.reportThisAccount()),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.height,
          horizontal: 34.width,
        ),
        child: Column(
          children: [
            StatefulBuilder(
              builder: (context, setState) => CheckboxListTile(
                value: _isAbuse,
                title: Text(
                  appLocalizations.reportViolation(),
                  style: textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onChanged: (value) => setState(() => _isAbuse = value!),
              ),
            ),
            10.emptyHeight,
            StatefulBuilder(
              builder: (context, setState) => CheckboxListTile(
                value: _isViolation,
                title: Text(
                  appLocalizations.reportAbuse(),
                  style: textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onChanged: (value) => setState(() => _isViolation = value!),
              ),
            ),
            20.emptyHeight,
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                Routes.consultantReportSuccess,
              ),
              child: Text(appLocalizations.confirm),
            ),
          ],
        ),
      ),
    );
  }
}
