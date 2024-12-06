import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:fedhubs_pro/models/section/sect8_payment_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_read_enterprise_info.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_update_enterprise_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormEditPaymentInfoPage extends StatefulWidget {
  final String idClient;
  const FormEditPaymentInfoPage(this.idClient, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormEditPaymentInfoState();
  }
}

class FormEditPaymentInfoState extends State<FormEditPaymentInfoPage> {
  late Future<PaymentInfoSect8> _paymentInfoModel;
  late final ApiUpdateEnterprise apiUpdate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PaymentInfoSect8 _modelInfoPayment = PaymentInfoSect8();

  @override
  void initState() {
    apiUpdate = Provider.of<ApiUpdateEnterprise>(context, listen: false);
    final apiRead = Provider.of<ApiReadEnterprise>(context, listen: false);
    _paymentInfoModel = apiRead.fetchPaymentInfoSect8(widget.idClient);
    _modelInfoPayment.idClient = widget.idClient.toString();
    super.initState();
  }

  Widget _buildCashAvailability(PaymentInfoSect8 data) {
    return CheckboxListTileFormField(
      initialValue: data.cashEnable!,
      secondary: SizedBox(
        height: 40,
        width: 40,
        child: Image.asset(
          'assets/other_images/espese.png',
        ),
      ),
      title: const Text('Espèces'),
      onSaved: (bool? value) {
        _modelInfoPayment.cashEnable = value;
      },
    );
  }

  Widget _buildCardAvailability(PaymentInfoSect8 data) {
    return CheckboxListTileFormField(
      initialValue: data.cardEnable!,
      secondary: SizedBox(
        height: 40,
        width: 40,
        child: Image.asset(
          'assets/other_images/payment.png',
        ),
      ),
      title: const Text('Carte & PIN'),
      onSaved: (bool? value) {
        _modelInfoPayment.cardEnable = value;
      },
    );
  }

  Widget _buildPaymentNoContactAvailability(PaymentInfoSect8 data) {
    return CheckboxListTileFormField(
      initialValue: data.noContactEnable!,
      secondary: SizedBox(
        height: 40,
        width: 40,
        child: Image.asset(
          'assets/other_images/contactless.png',
        ),
      ),
      title: const Text('Paiement sans contact'),
      onSaved: (bool? value) {
        _modelInfoPayment.noContactEnable = value;
      },
    );
  }

  Widget _buildQrCodeAvailability(PaymentInfoSect8 data) {
    return CheckboxListTileFormField(
      initialValue: data.qrCodeEnable!,
      secondary: SizedBox(
        height: 40,
        width: 40,
        child: Image.asset(
          'assets/other_images/qrcodescan.png',
        ),
      ),
      title: const Text('Scan & Pay'),
      onSaved: (bool? value) {
        _modelInfoPayment.qrCodeEnable = value;
      },
    );
  }

  Widget _buildBankTransferAvailability(PaymentInfoSect8 data) {
    return CheckboxListTileFormField(
      initialValue: data.bankTransferEnable!,
      secondary: SizedBox(
        height: 40,
        width: 40,
        child: Image.asset(
          'assets/other_images/virement.png',
        ),
      ),
      title: const Text('Virement Bancaire'),
      onSaved: (bool? value) {
        _modelInfoPayment.bankTransferEnable = value;
      },
    );
  }

  Widget _buildBankChequeAvailability(PaymentInfoSect8 data) {
    return CheckboxListTileFormField(
      initialValue: data.chequeEnable!,
      secondary: SizedBox(
        height: 40,
        width: 40,
        child: Image.asset(
          'assets/other_images/cheque.png',
        ),
      ),
      title: const Text('Chèque'),
      onSaved: (bool? value) {
        _modelInfoPayment.chequeEnable = value;
      },
    );
  }

  Widget _buildRestaurantTicketAvailability(PaymentInfoSect8 data) {
    return CheckboxListTileFormField(
      initialValue: data.restaurantTicketEnable!,
      secondary: SizedBox(
        height: 40,
        width: 40,
        child: Image.asset(
          'assets/other_images/ticket_resto.png',
        ),
      ),
      title: const Text('Ticket Restaurant'),
      onSaved: (bool? value) {
        _modelInfoPayment.restaurantTicketEnable = value;
      },
    );
  }

/*  Widget _buildChequeHolidayAvailability(PaymentInfoSect8 data) {
    return CheckboxListTileFormField(

      secondary: SizedBox(
        child: SvgPicture.network(
          'https://image.flaticon.com/icons/svg/2270/2270340.svg',
        ),
        height: 40,
        width: 40,
      ),
      title: Text('Chèque vacance'),
      onSaved: (bool value) {
        _modelInfoPayment.chequeHoliday=value;
      },

    );
  }*/

  Widget _buildCouponAvailability(PaymentInfoSect8 data) {
    return CheckboxListTileFormField(
      initialValue: data.couponEnable!,
      secondary: SizedBox(
        height: 40,
        width: 40,
        child: Image.asset(
          'assets/other_images/coupon.png',
        ),
      ),
      title: const Text('Coupon'),
      onSaved: (bool? value) {
        _modelInfoPayment.couponEnable = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Accès Paiement"),
        backgroundColor: Colors.black,
        actions: <Widget>[
          TextButton(
              child: const Text('Enregistrer', style: TextStyle(fontSize: 15)),
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                final isValid = _formKey.currentState!.validate();
                if (isValid) {
                  _formKey.currentState!.save();
                  apiUpdate.putPaymentInfoSect8(_modelInfoPayment);
                  Navigator.pop(context);
                }
              }),
        ],
      ),
      body: FutureBuilder<PaymentInfoSect8>(
        future: _paymentInfoModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return Container(
              margin: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    _buildCashAvailability(data!),
                    _buildCardAvailability(data),
                    _buildPaymentNoContactAvailability(data),
                    _buildQrCodeAvailability(data),
                    _buildBankTransferAvailability(data),
                    _buildBankChequeAvailability(data),
                    _buildRestaurantTicketAvailability(data),
                    _buildCouponAvailability(data),
                  ],
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
      ),
    );
  }
}
