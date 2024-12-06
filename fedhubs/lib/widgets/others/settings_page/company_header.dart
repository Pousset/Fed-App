import 'package:fedhubs_pro/models/section/sect1_visit_card.dart';
import 'package:flutter/material.dart';

class CompanyHeader extends StatelessWidget {
  const CompanyHeader({super.key, required this.data});

  final VisitCardSect1 data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 36.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildCompanyInfo(context, data),
          ),
          _buildProfilImage(data),
        ],
      ),
    );
  }

  Widget _buildProfilImage(VisitCardSect1 data) {
    return Container(
      width: 64.0,
      height: 64.0,
      decoration: BoxDecoration(
        color: data.logo?.isNotEmpty ?? false
            ? null
            : Colors.black.withOpacity(0.08),
        image: data.logo?.isNotEmpty ?? false
            ? DecorationImage(
                image: NetworkImage(data.logo!),
                fit: BoxFit.fill,
                onError: (_, __) => () {})
            : null,
        borderRadius: BorderRadius.circular(64.0),
        border: Border.all(
          color: Colors.white,
          width: 4.0,
        ),
      ),
    );
  }

  List<Widget> _buildCompanyInfo(BuildContext context, VisitCardSect1 data) {
    return [
      Text(
        data.companyName!,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
      ),
      const SizedBox(height: 8),
      Text(
        data.address!,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
      ),
      const SizedBox(height: 8),
      _buildInfo(context, data),
      const SizedBox(height: 8),
    ];
  }

  Widget _buildInfo(BuildContext context, VisitCardSect1 data) {
    return Row(
      children: [
        Text(
          data.typeActivity!,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const Text(
          " • ",
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 11.0,
          ),
        ),
        if (data.rating != null) ...[
          Text(
            ((data.rating! * 10).round() / 10).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11.0,
              height: 11 / 9,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 11,
            child: Icon(
              Icons.star,
              color: Theme.of(context).secondaryHeaderColor,
              size: 12,
            ),
          ),
        ],
        Text(
          "(${data.commentsNumbers} avis)",
          overflow: TextOverflow.visible,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 11.0,
          ),
        ),
        const Text(
          " • ",
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 11.0,
          ),
        ),
        Text(
          '€' * (data.price! + 1),
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
