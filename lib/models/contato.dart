
class Contato {
  final int id;
  final String name;
  final int account;

  Contato(this.id, this.name, this.account);

  @override
  String toString() {
    return 'Contato{id: $id, name: $name, account: $account}';
  }
}