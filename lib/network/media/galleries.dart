import 'dart:io';

import 'package:jinya_cms_app/network/base/jinyaRequest.dart';
import 'package:jinya_cms_app/network/media/files.dart' as media;

enum Orientation { horizontal, vertical }

enum Type { sequence, masonry }

class Gallery {
  int id;
  String name;
  String slug;
  String description;
  Orientation orientation;
  Type type;

  Gallery(this.id, this.name, this.slug, this.description, this.orientation,
      this.type);

  factory Gallery.fromMap(Map<String, dynamic> map) => Gallery(
        map['id'],
        map['name'],
        map['slug'],
        map['description'],
        map['orientation'] == 'horizontal'
            ? Orientation.horizontal
            : Orientation.vertical,
        map['type'] == 'masonry' ? Type.masonry : Type.sequence,
      );
}

class GalleryFilePosition {
  int id;
  int position;
  media.File file;

  GalleryFilePosition(this.id, this.position, this.file);

  factory GalleryFilePosition.fromMap(Map<String, dynamic> map) =>
      GalleryFilePosition(
        map['id'],
        map['position'],
        media.File.fromMap(map['file']),
      );
}

Future<List<Gallery>> getGalleries() async {
  final response = await get('api/media/gallery');
  if (response.statusCode != HttpStatus.ok) {
    throw Exception('This should not happen');
  } else {
    final data = response.data;
    return List.generate(
      data['count'],
      (i) => Gallery.fromMap(data['items'][i]),
    );
  }
}

Future<void> deleteGallery(String slug) async {
  final response = await delete('api/media/gallery/$slug');
  if (response.statusCode != HttpStatus.noContent) {
    throw Exception('This should not happen');
  }
}

Future<Gallery> createGallery(
  String name, {
  String description = '',
  Type type = Type.sequence,
  Orientation orientation = Orientation.vertical,
}) async {
  final response = await post('api/media/gallery', data: {
    'name': name,
    'description': description,
    'type': type == Type.sequence ? 'sequence' : 'masonry',
    'orientation':
        orientation == Orientation.vertical ? 'vertical' : 'horizontal',
  });
  if (response.statusCode != HttpStatus.created) {
    throw Exception('This should not happen');
  }

  return Gallery.fromMap(response.data);
}

Future<void> updateGallery(
  String slug, {
  required String name,
  String description = '',
  Type type = Type.sequence,
  Orientation orientation = Orientation.vertical,
}) async {
  final response = await put('api/media/gallery/$slug', data: {
    'name': name,
    'description': description,
    'type': type == Type.sequence ? 'sequence' : 'masonry',
    'orientation':
        orientation == Orientation.vertical ? 'vertical' : 'horizontal',
  });
  if (response.statusCode != HttpStatus.noContent) {
    throw Exception('This should not happen');
  }
}

Future<Gallery> getGallery(String slug) async {
  final response = await get('api/media/gallery/$slug');
  if (response.statusCode != HttpStatus.ok) {
    throw Exception('This should not happen');
  }

  return Gallery.fromMap(response.data);
}

Future<List<GalleryFilePosition>> getPositions(int id) async {
  final response = await get('api/media/gallery/file/$id/file');
  if (response.statusCode != HttpStatus.ok) {
    throw Exception('This should not happen');
  }

  return List.generate(
    response.data.length,
    (index) => GalleryFilePosition.fromMap(response.data[index]),
  );
}

Future<void> updatePosition(
  int galleryFileId,
  int galleryId,
  int oldPosition,
  int newPosition,
) async {
  final response = await put(
    'api/media/gallery/file/$galleryId/file/$galleryFileId/$oldPosition',
    data: {'position': newPosition},
  );
  if (response.statusCode != HttpStatus.noContent) {
    throw Exception('This should not happen');
  }
}

Future<void> removePosition(int galleryId, int galleryFileId) async {
  final response = await delete(
    'api/media/gallery/file/$galleryId/file/$galleryFileId',
  );
  if (response.statusCode != HttpStatus.noContent) {
    throw Exception('This should not happen');
  }
}

Future<GalleryFilePosition> addPosition(
  int galleryId,
  int fileId,
  int position,
) async {
  final response = await post('api/media/gallery/file/$galleryId/file', data: {
    'position': position,
    'file': fileId,
  });
  if (response.statusCode != HttpStatus.created) {
    throw Exception('This should not happen');
  }

  return GalleryFilePosition.fromMap(response.data);
}
