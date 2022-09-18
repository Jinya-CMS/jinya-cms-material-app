import 'package:jinya_cms_material_app/network/base/jinyaRequest.dart';

class Artist {
  int id;
  String artistName;
  String email;
  String profilePicture;
  List<String> roles;

  Artist({
    required this.id,
    required this.artistName,
    required this.email,
    required this.profilePicture,
    required this.roles,
  });

  factory Artist.fromMap(Map<String, dynamic> data) {
    final roles = <String>[];
    final rolesFromMap = data['roles'];
    for (final role in rolesFromMap) {
      roles.add(role.toString());
    }

    return Artist(
      id: data['id'],
      email: data['email'],
      artistName: data['artistName'],
      profilePicture: data['profilePicture'],
      roles: roles,
    );
  }
}
