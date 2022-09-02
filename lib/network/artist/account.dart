import 'package:jinya_cms_app/network/artist/artist.dart';
import 'package:jinya_cms_app/network/base/jinyaRequest.dart';

Future<Artist> getAccount() async {
  final response = await get('api/me');

  return Artist.fromMap(response.data);
}
