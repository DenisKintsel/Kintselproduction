// модель текущего пользователя для будущего запроса профиля
class User {
  String username;
  String email;
  String id;

  User(
      {this.username,
        this.email,
        this.id,
      });

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
      username: data['username'],
      email: data['email'],
      id: data['id']
  );

  Map<String, dynamic> toDatabaseJson() => {
    "username": this.username,
    "email": this.email,
    "id": this.id,
  };
}
