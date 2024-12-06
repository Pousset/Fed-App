import 'package:fedhubs_pro/models/account_handling/redirection_account_to_enterprise.dart';
import 'package:fedhubs_pro/services/enterprise_info/api_read_enterprise_info.dart';
import 'package:fedhubs_pro/services/local/company_provider.dart';
import 'package:fedhubs_pro/widgets/buttons/circle_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectAccountDialog extends StatefulWidget {
  const SelectAccountDialog(
      {Key? key, this.force = false, required this.dialogContext})
      : super(key: key);

  final bool force;
  final BuildContext dialogContext;

  @override
  State<SelectAccountDialog> createState() => _SelectAccountDialogState();
}

class _SelectAccountDialogState extends State<SelectAccountDialog> {
  late CompanyProvider companyProvider;
  late ApiReadEnterprise apiRead;
  late String? idAccount;

  @override
  void initState() {
    apiRead = Provider.of<ApiReadEnterprise>(context, listen: false);
    companyProvider = Provider.of<CompanyProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !widget.force,
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (!widget.force)
              CircleActionButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icons.close_rounded,
                color: Theme.of(context).secondaryHeaderColor,
                top: -17,
                right: -9,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Comptes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder(
                    future: apiRead.redirectionEnterprise(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data =
                            snapshot.data as RedirectionAccountToEnterprise;
                        final companies = data.enterpriseBody ?? [];
                        idAccount = data.idAccount;

                        final selectedCompany = companies.where(
                            (e) => '${e.id}' == companyProvider.idClient);
                        return Container(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height - 320),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                if (companyProvider.idClient != null &&
                                    selectedCompany.isNotEmpty) ...[
                                  _buildCompanyInfo(selectedCompany.first),
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: const Color(0x31000000),
                                  ),
                                ],
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: companies.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return companyProvider.idClient !=
                                            '${companies[index].id}'
                                        ? _buildCompanyInfo(companies[index])
                                        : const SizedBox();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  // Row(
                  //   children: [
                  //     const SizedBox(height: 1, width: 13),
                  //     SvgPicture.asset('assets/user_add.svg', height: 32),
                  //     const SizedBox(width: 34),
                  //     const Text(
                  //       'Ajouter un établissement',
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.w600, fontSize: 14),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 32),
                  // Row(
                  //   children: [
                  //     const SizedBox(height: 1, width: 13),
                  //     SvgPicture.asset('assets/user_outlined.svg', height: 32),
                  //     const SizedBox(width: 34),
                  //     SizedBox(
                  //       width: MediaQuery.of(context).size.width - 64 - 85,
                  //       child: const Text(
                  //         'Se connecter a un étalissement déja existant',
                  //         overflow: TextOverflow.clip,
                  //         maxLines: 2,
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w600, fontSize: 14),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyInfo(Enterprise data) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        await companyProvider.setCompany('${data.id}', idAccount ?? '-1');
        if (!mounted) return;
        Navigator.pop(widget.dialogContext);
      },
      onLongPress: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: Image.network(
                data.logo,
                height: 64,
                width: 64,
                errorBuilder: (_, __, ___) => Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    border: Border.all(color: const Color(0x31000000)),
                    color: const Color(0xFFDADADA),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 23),
            SizedBox(
              width: MediaQuery.of(context).size.width - 151,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.companyName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 11),
                  Text(
                    data.address,
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                  const SizedBox(height: 9),
                  _buildInfo(data),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(Enterprise entreprise) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          entreprise.typeActivity,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const Text(
          " • ",
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
          ),
        ),
        if (entreprise.rating != null) ...[
          Text(
            ((entreprise.rating! * 10).round() / 10).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 8.0,
              height: 14 / 9,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8,
            child: Icon(
              Icons.star,
              color: Theme.of(context).secondaryHeaderColor,
              size: 10,
            ),
          ),
        ],
        Text(
          "(${entreprise.commentsNumbers} avis)",
          overflow: TextOverflow.visible,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 8.0,
          ),
        ),
        const Text(
          " • ",
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
          ),
        ),
        Text(
          '€' * (entreprise.price + 1),
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
