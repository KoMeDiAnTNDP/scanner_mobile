import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scanner_mobile/src/home/bloc/home_bloc.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import 'package:scanner_mobile/src/home/widgets/widgets.dart';
import 'package:scanner_mobile/src/shared/models/models.dart' as models;

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  Future<List<models.File>> _getImages(BuildContext context, {bool camera = false}) async {
    List<AssetEntity> assets = [];

    if (camera) {
      assets = await _getImageFromCamera(context);
    } else {
      assets = await _getImagesFromGallery(context);
    }

    List<models.File> files = await _getFiles(assets);

    return files;
  }

  Future<List<AssetEntity>> _getImagesFromGallery(BuildContext context) async {
    AssetPickerTextDelegate textDelegate = const EnglishAssetPickerTextDelegate();
    AssetPickerConfig config = AssetPickerConfig(
      textDelegate: textDelegate,
      pathNameBuilder: (AssetPathEntity path) {
        return path.name;
      }
    );
    List<AssetEntity>? assets = await AssetPicker.pickAssets(context, pickerConfig: config);

    if (assets == null) return [];

    return assets;
  }

  Future<List<AssetEntity>> _getImageFromCamera(BuildContext context) async {
    CameraPickerTextDelegate textDelegate = EnglishCameraPickerTextDelegate();
    CameraPickerConfig config = CameraPickerConfig(
      textDelegate: textDelegate
    );
    AssetEntity? asset =  await CameraPicker.pickFromCamera(context, pickerConfig: config);

    if (asset == null) return [];

    return [asset];
  }

  Future<List<models.File>> _getFiles(List<AssetEntity> assets) async {
    List<models.File> files = [];

    for (MapEntry<int, AssetEntity> mappedAsset in assets.asMap().entries) {
      var fileio = await mappedAsset.value.originFile;

      if (fileio == null) continue;

      models.File file = models.File(
        path: fileio.path,
        name: mappedAsset.value.title ?? 'image-${mappedAsset.key}',
      );

      files.add(file);
    }

    return files;
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isDialOpen = ValueNotifier(false);
    HomeBloc homeBloc = context.read<HomeBloc>();

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HomeAppBar(),
      ),
      body: GestureDetector(
        onTap: () => isDialOpen.value = false,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Categories(),
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        renderOverlay: false,
        spacing: 3,
        spaceBetweenChildren: 4.0,
        closeManually: true,
        childPadding: const EdgeInsets.all(5),
        openCloseDial: isDialOpen,
        closeDialOnPop: true,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.document_scanner),
            onTap: () => _getImages(context)
                .then((files) => homeBloc.add(UploadFiles(files))),
          ),
          SpeedDialChild(
            child: const Icon(Icons.camera_alt),
            onTap: () => _getImages(context, camera: true)
                .then((files) => homeBloc.add(UploadFiles(files))),
          )
        ],
      ),
    );
  }
}