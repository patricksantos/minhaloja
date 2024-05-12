import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minhaloja/infra/infra.dart';
import 'package:minhaloja/presentation_layer/components/default_file_image.dart';
import 'package:minhaloja/presentation_layer/modules/dashboard/components/components.dart';

class ImagesStore extends StatefulWidget {
  const ImagesStore({super.key});

  @override
  State<ImagesStore> createState() => _ImagesStoreState();
}

class _ImagesStoreState extends State<ImagesStore> {
  XFile? logoUrl;
  XFile? backgroundUrl;

  Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Images',
          style: design.h2(color: Colors.white),
        ),
        SizedBox(height: 10.height),
        DefaultFileImage(
          context: context,
          label: 'Selecione a sua Logo',
          onPressed: (value) {
            setState(() {
              logoUrl = value;
            });
          },
        ),
        SizedBox(height: 8.height),
        DefaultFileImage(
          context: context,
          label: 'Selecione uma imagem de fundo',
          onPressed: (value) {
            setState(() {
              backgroundUrl = value;
            });
          },
        ),
        SizedBox(height: 8.height)
      ],
    );
  }
}
