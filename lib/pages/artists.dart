import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jinya_cms_api/jinya_cms.dart' as jinya;
import 'package:jinya_cms_material_app/l10n/localizations.dart';
import 'package:jinya_cms_material_app/shared/current_user.dart';
import 'package:jinya_cms_material_app/shared/nav_drawer.dart';
import 'package:jinya_cms_material_app/shared/navigator_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:validators/validators.dart';

class _AddArtistDialog extends StatefulWidget {
  const _AddArtistDialog({Key? key}) : super(key: key);

  @override
  State<_AddArtistDialog> createState() => _AddArtistDialogState();
}

class _AddArtistDialogState extends State<_AddArtistDialog> {
  final _formKey = GlobalKey<FormState>();
  final _artistNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  var _isReader = true;
  var _isWriter = true;
  var _isAdmin = false;

  @override
  void dispose() {
    _artistNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    return AlertDialog(
      scrollable: true,
      title: Text(l10n.addArtist),
      content: Scrollbar(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _artistNameController,
                  maxLines: 1,
                  decoration: InputDecoration(labelText: l10n.artistName),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.artistNameCannotBeEmpty;
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _emailController,
                  maxLines: 1,
                  decoration: InputDecoration(labelText: l10n.email),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.emailCannotBeEmpty;
                    }

                    if (!isEmail(value)) {
                      return l10n.emailWrongFormat;
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _passwordController,
                  maxLines: 1,
                  decoration: InputDecoration(labelText: l10n.password),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.passwordCannotBeEmpty;
                    }

                    return null;
                  },
                ),
              ),
              Row(
                children: [
                  Switch(
                    value: _isReader,
                    onChanged: (value) {
                      setState(() {
                        _isReader = value;
                      });
                    },
                  ),
                  Text(l10n.roleReader),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: _isWriter,
                    onChanged: (value) {
                      setState(() {
                        _isWriter = value;
                      });
                    },
                  ),
                  Text(l10n.roleWriter),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: _isAdmin,
                    onChanged: (value) {
                      setState(() {
                        _isAdmin = value;
                      });
                    },
                  ),
                  Text(l10n.roleAdmin),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.discard)),
        TextButton(
            onPressed: () async {
              try {
                await apiClient.createArtist(
                  _artistNameController.text,
                  _emailController.text,
                  _passwordController.text,
                  enabled: true,
                  isAdmin: _isAdmin,
                  isReader: _isReader,
                  isWriter: _isWriter,
                );
                navigator.pop();
              } on jinya.ConflictException {
                messenger.showSnackBar(SnackBar(
                  content: Text(l10n.artistAddConflict),
                  behavior: SnackBarBehavior.floating,
                ));
              } catch (ex) {
                messenger.showSnackBar(SnackBar(
                  content: Text(l10n.artistAddGeneric),
                  behavior: SnackBarBehavior.floating,
                ));
              }
            },
            child: Text(l10n.addArtist)),
      ],
    );
  }
}

class _EditArtistDialog extends StatefulWidget {
  const _EditArtistDialog(this.artist, {Key? key}) : super(key: key);

  final jinya.Artist artist;

  @override
  State<_EditArtistDialog> createState() => _EditArtistDialogState(artist);
}

class _EditArtistDialogState extends State<_EditArtistDialog> {
  final _formKey = GlobalKey<FormState>();
  final _artistNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  final jinya.Artist artist;

  var _isReader = true;
  var _isWriter = true;
  var _isAdmin = false;

  _EditArtistDialogState(this.artist) {
    _isReader = artist.roles!.contains('ROLE_READER');
    _isWriter = artist.roles!.contains('ROLE_WRITER');
    _isAdmin = artist.roles!.contains('ROLE_ADMIN');

    _artistNameController.text = artist.artistName!;
    _emailController.text = artist.email!;
  }

  @override
  void dispose() {
    _artistNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    return AlertDialog(
      scrollable: true,
      title: Text(l10n.editArtist),
      content: Scrollbar(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _artistNameController,
                  maxLines: 1,
                  decoration: InputDecoration(labelText: l10n.artistName),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.artistNameCannotBeEmpty;
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _emailController,
                  maxLines: 1,
                  decoration: InputDecoration(labelText: l10n.email),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.emailCannotBeEmpty;
                    }

                    if (!isEmail(value)) {
                      return l10n.emailWrongFormat;
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _passwordController,
                  maxLines: 1,
                  decoration: InputDecoration(labelText: l10n.password),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.passwordCannotBeEmpty;
                    }

                    return null;
                  },
                ),
              ),
              Row(
                children: [
                  Switch(
                    value: _isReader,
                    onChanged: (value) {
                      setState(() {
                        _isReader = value;
                      });
                    },
                  ),
                  Text(l10n.roleReader),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: _isWriter,
                    onChanged: (value) {
                      setState(() {
                        _isWriter = value;
                      });
                    },
                  ),
                  Text(l10n.roleWriter),
                ],
              ),
              Row(
                children: [
                  Switch(
                    value: _isAdmin,
                    onChanged: (value) {
                      setState(() {
                        _isAdmin = value;
                      });
                    },
                  ),
                  Text(l10n.roleAdmin),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.discard)),
        TextButton(
            onPressed: () async {
              try {
                final roles = <String>[];
                if (_isWriter) {
                  roles.add('ROLE_WRITER');
                }
                if (_isReader) {
                  roles.add('ROLE_READER');
                }
                if (_isAdmin) {
                  roles.add('ROLE_ADMIN');
                }

                await apiClient.updateArtist(
                  jinya.Artist(
                    id: artist.id!,
                    artistName: _artistNameController.text,
                    email: _emailController.text,
                    enabled: true,
                    roles: roles,
                  ),
                );
                if (_passwordController.text.isNotEmpty) {
                  await apiClient.changePasswordAdmin(artist.id!, _passwordController.text);
                }
                navigator.pop();
              } on jinya.ConflictException {
                messenger.showSnackBar(SnackBar(
                  content: Text(l10n.artistEditConflict),
                  behavior: SnackBarBehavior.floating,
                ));
              } catch (ex) {
                messenger.showSnackBar(SnackBar(
                  content: Text(l10n.artistEditGeneric),
                  behavior: SnackBarBehavior.floating,
                ));
              }
            },
            child: Text(l10n.editArtist)),
      ],
    );
  }
}

class Artists extends StatefulWidget {
  const Artists({super.key});

  @override
  State<Artists> createState() => _ArtistsState();
}

class _ArtistsState extends State<Artists> {
  Iterable<jinya.Artist> artists = [];
  final apiClient = SettingsDatabase.getClientForCurrentAccount();

  Future<void> loadArtists() async {
    final artists = await apiClient.getArtists();
    setState(() {
      this.artists = artists;
    });
  }

  @override
  void initState() {
    super.initState();
    loadArtists();
  }

  Widget itemBuilder(BuildContext context, int index) {
    final l10n = AppLocalizations.of(context)!;
    final item = artists.elementAt(index);
    final children = <Widget>[
      ListTile(
        title: Text(item.artistName!),
      ),
    ];
    if (item.profilePicture!.isNotEmpty) {
      children.add(
        CachedNetworkImage(
          imageUrl: SettingsDatabase.selectedAccount!.url + (item.profilePicture ?? ''),
          fit: BoxFit.cover,
          height: 240,
          width: double.infinity,
          progressIndicatorBuilder: (context, url, progress) => Container(
            height: 48,
            width: 48,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')) {
      final buttons = [
        TextButton(
          onPressed: () async {
            final dialog = _EditArtistDialog(item);
            await showDialog(context: context, builder: (context) => dialog);
            await loadArtists();
          },
          child: const Icon(Icons.edit),
        ),
      ];

      if (item.id != SettingsDatabase.selectedAccount!.jinyaId) {
        if (item.enabled == true) {
          buttons.add(
            TextButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(l10n.disableArtistTitle),
                    content: Text(l10n.disableArtistContent(item.artistName!)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          NavigationService.instance.goBack();
                        },
                        child: Text(l10n.disableArtistCancel),
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            await apiClient.deactivateArtist(item.id!);
                            NavigationService.instance.goBack();
                            await loadArtists();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(l10n.disableArtistFailure),
                              behavior: SnackBarBehavior.floating,
                            ));
                          }
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).errorColor,
                        ),
                        child: Text(l10n.disableArtistConfirm),
                      ),
                    ],
                  ),
                );
              },
              child: const Icon(MdiIcons.accountCancel),
            ),
          );
        } else {
          buttons.add(
            TextButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(l10n.enableArtistTitle),
                    content: Text(l10n.enableArtistContent(item.artistName!)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          NavigationService.instance.goBack();
                        },
                        child: Text(l10n.enableArtistCancel),
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            await apiClient.activateArtist(item.id!);
                            NavigationService.instance.goBack();
                            await loadArtists();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(l10n.enableArtistFailure),
                              behavior: SnackBarBehavior.floating,
                            ));
                          }
                        },
                        child: Text(l10n.enableArtistConfirm),
                      ),
                    ],
                  ),
                );
              },
              child: const Icon(MdiIcons.accountCheck),
            ),
          );
        }
      }

      buttons.add(
        TextButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(l10n.deleteArtistTitle),
                content: Text(l10n.deleteArtistMessage(item.artistName!)),
                actions: [
                  TextButton(
                    onPressed: () {
                      NavigationService.instance.goBack();
                    },
                    child: Text(l10n.keep),
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        await apiClient.deleteArtist(item.id!);
                        NavigationService.instance.goBack();
                        await loadArtists();
                      } on jinya.ConflictException {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(l10n.failedToDeleteArtistConflict(item.artistName!)),
                          behavior: SnackBarBehavior.floating,
                        ));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(l10n.failedToDeleteArtistGeneric(item.artistName!)),
                          behavior: SnackBarBehavior.floating,
                        ));
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).errorColor,
                    ),
                    child: Text(l10n.delete),
                  ),
                ],
              ),
            );
          },
          child: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
        ),
      );
      children.add(
        ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: buttons,
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.menuArtists),
      ),
      drawer: const JinyaNavigationDrawer(),
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () async {
            await loadArtists();
          },
          child: query.size.width >= 720
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: query.size.width >= 1080 ? 4 : 2,
                    childAspectRatio: query.size.width >= 1080 ? 9 / 11 : 9 / 9,
                  ),
                  itemCount: artists.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                )
              : ListView.builder(
                  itemCount: artists.length,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemBuilder: itemBuilder,
                ),
        ),
      ),
      floatingActionButton: SettingsDatabase.selectedAccount!.roles!.contains('ROLE_WRITER')
          ? FloatingActionButton(
              child: const Icon(MdiIcons.accountPlus),
              onPressed: () async {
                const dialog = _AddArtistDialog();
                await showDialog(context: context, builder: (context) => dialog);
                await loadArtists();
              },
            )
          : null,
    );
  }
}
