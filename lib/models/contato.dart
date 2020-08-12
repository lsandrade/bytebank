
class Contato {
  final int id;
  final String name;
  final int account;

  Contato(this.id, this.name, this.account);

  @override
  String toString() {
    return 'Contato{id: $id, name: $name, account: $account}';
  }

  Contato.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      name = json['name'],
      account = json['accountNumber'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'accountNumber': account
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contato &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          account == other.account;

  @override
  int get hashCode => name.hashCode ^ account.hashCode;
}