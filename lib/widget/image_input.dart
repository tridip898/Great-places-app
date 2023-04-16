import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? storedImage;
  Future<void> _takePicture() async{
    final imagePicker= ImagePicker();
    final XFile? photo = await imagePicker.pickImage(source: ImageSource.camera,maxWidth: 600);
    if(photo == null){
      return;
    }
    setState(() {
      storedImage=File(photo!.path);
    });
    final appDir=await sysPath.getApplicationDocumentsDirectory();
    final fileName=path.basename(photo!.path);
    final savedImage=await File(photo.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 150,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
          alignment: Alignment.center,
          child: storedImage != null
              ? Image.file(
                  storedImage!,
                  fit: BoxFit.cover,
                )
              : const Text("No image taken",textAlign: TextAlign.center,),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: ElevatedButton.icon(
              onPressed: _takePicture,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0
              ),
              icon: Icon(Icons.camera_alt,color: Colors.grey.shade600,),
              label: Text("Take picture",style: TextStyle(color: Colors.grey.shade600),)),
        )
      ],
    );
  }
}
