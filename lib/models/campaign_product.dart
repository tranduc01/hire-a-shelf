import 'dart:convert';

import '../constraints/constraints.dart';
import 'product.dart';
import 'campaign.dart';
import 'package:http/http.dart' as http;

class CampaignProduct {
  final Campaign campaign;
  final Product product;
  CampaignProduct({required this.campaign, required this.product});
  factory CampaignProduct.fromJson(Map<String, dynamic> json) {
    return CampaignProduct(
      campaign: Campaign.fromJson(json['campaignResponse']),
      product: Product.fromJson(json['productResponse']),
    );
  }
}

Future<List<CampaignProduct>> fetchProductByCampaignId(int id) async {
  var response = await http.get(Uri.parse("$BASE_URL/campaign_product/$id"));
  if (response.statusCode == 200) {
    return (json.decode(utf8.decode(response.bodyBytes)) as List)
        .map((e) => CampaignProduct.fromJson(e))
        .toList();
  } else {
    throw Exception("Fail to fetch");
  }
}
