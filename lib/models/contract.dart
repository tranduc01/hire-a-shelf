class Contract {
  final int campaignId;
  final int storeId;
  Contract({required this.campaignId, required this.storeId});
  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(campaignId: json['campaignId'], storeId: json['storeId']);
  }
}
