class Account {
  final int id;
  final String username;
  final bool status;
  Account({required this.id, required this.username, required this.status});
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      username: json['username'],
      status: json['status'],
    );
  }
}
