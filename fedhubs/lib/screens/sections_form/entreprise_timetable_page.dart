import 'package:fedhubs_pro/models/section/entreprise_timetable_model.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_read_enterprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_update_enterprise_info.dart';
import 'package:fedhubs_pro/services/local/company_provider.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_back_button.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:fedhubs_pro/widgets/forms/custom_date_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EntrepriseTimetablePage extends StatefulWidget {
  const EntrepriseTimetablePage({super.key});

  @override
  State<EntrepriseTimetablePage> createState() =>
      _EntrepriseTimetablePageState();
}

class _EntrepriseTimetablePageState extends State<EntrepriseTimetablePage> {
  bool isChanged = false;

  late final CompanyProvider companyProvider;
  late final Future<EntrepriseTimetableModel> _futureEntrepriseTimetable;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  EntrepriseTimetableModel _modelEntrepriseTimetable =
      EntrepriseTimetableModel.empty();
  late final ApiUpdateEnterprise apiUpdate;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      final state = await apiUpdate.putEntrepriseTimetable(
          _modelEntrepriseTimetable, companyProvider.idClient!);
      // setState(() => isChanged = !state);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: SizedBox(
          height: 40,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  state ? "Changement enregisté" : "Une erreur est survenue")),
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ));
    }
  }

  @override
  void initState() {
    apiUpdate = Provider.of<ApiUpdateEnterprise>(context, listen: false);
    final apiRead = Provider.of<ApiReadEnterprise>(context, listen: false);
    companyProvider = Provider.of<CompanyProvider>(context, listen: false);
    _futureEntrepriseTimetable =
        apiRead.fetchEntrepriseTimetable(companyProvider.idClient!);
    _futureEntrepriseTimetable.then((value) {
      _modelEntrepriseTimetable = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
        Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _buildContent(screenSize),
      floatingActionButton: isChanged
          ? Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: CustomFlatButton(
                color: Theme.of(context).secondaryHeaderColor,
                width: screenSize.width - 48,
                text: 'Appliquer',
                onPressed: _submit,
              ),
            )
          : null,
    );
  }

  Widget _buildContent(Size screenSize) {
    return FutureBuilder<EntrepriseTimetableModel>(
      future: _futureEntrepriseTimetable,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Form(
                  key: _formKey,
                  onChanged: (() => setState(() => isChanged = true)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Horaires d'ouverture",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      _buildDayRow(
                        title: 'Lundi',
                        model: _modelEntrepriseTimetable.mondayHours,
                        screenWidth: screenSize.width,
                      ),
                      const SizedBox(height: 8),
                      _buildDayRow(
                        title: 'Mardi',
                        model: _modelEntrepriseTimetable.tuesdayHours,
                        screenWidth: screenSize.width,
                      ),
                      const SizedBox(height: 8),
                      _buildDayRow(
                        title: 'Mercredi',
                        model: _modelEntrepriseTimetable.wednesdayHours,
                        screenWidth: screenSize.width,
                      ),
                      const SizedBox(height: 8),
                      _buildDayRow(
                        title: 'Jeudi',
                        model: _modelEntrepriseTimetable.thursdayHours,
                        screenWidth: screenSize.width,
                      ),
                      const SizedBox(height: 8),
                      _buildDayRow(
                        title: 'Vendredi',
                        model: _modelEntrepriseTimetable.fridayHours,
                        screenWidth: screenSize.width,
                      ),
                      const SizedBox(height: 8),
                      _buildDayRow(
                        title: 'Samedi',
                        model: _modelEntrepriseTimetable.saturdayHours,
                        screenWidth: screenSize.width,
                      ),
                      const SizedBox(height: 8),
                      _buildDayRow(
                        title: 'Dimanche',
                        model: _modelEntrepriseTimetable.sundayHours,
                        screenWidth: screenSize.width,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _buildDayRow({
    required String title,
    required OpenHours model,
    required double screenWidth,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Switch(
              value: !model.isClosed,
              onChanged: (value) {
                setState(() {
                  model.isClosed = !value;
                  isChanged = true;
                });
              },
              activeTrackColor:
                  Theme.of(context).secondaryHeaderColor.withOpacity(0.4),
              activeColor: Theme.of(context).secondaryHeaderColor,
              inactiveThumbColor: const Color(0xFFA1A1A1),
              inactiveTrackColor: const Color(0x66A1A1A1),
            ),
          ],
        ),
        if (!model.isClosed)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDateFieldStart(model, screenWidth),
              _buildDateFieldEnd(model, screenWidth),
            ],
          )
        else
          SizedBox(
            height: 61,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text('Fermé',
                      style: Theme.of(context).textTheme.displaySmall),
                )),
          ),
      ],
    );
  }

  Widget _buildDateFieldStart(OpenHours model, double screenWidth) {
    return CustomDateFormField(
        initialValue: DateTime.parse('19700101 ${model.start}'),
        label: "Ouverture",
        width: screenWidth / 2 - 29,
        onChanged: (DateTime? value) =>
            model.start = DateFormat.Hms().format(value!));
  }

  Widget _buildDateFieldEnd(OpenHours model, double screenWidth) {
    return CustomDateFormField(
        initialValue: DateTime.parse('19700101 ${model.end}'),
        label: "Fermeture",
        width: screenWidth / 2 - 29,
        onChanged: (DateTime? value) =>
            model.end = DateFormat.Hms().format(value!));
  }
}
