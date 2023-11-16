import 'package:flutter/material.dart';
import 'package:romanticapp/data/datasource/protocols/entities/photo_entity.dart';

class ViewPhotoInfo extends StatelessWidget {
  final PhotoEntity photoEntity;

  const ViewPhotoInfo({super.key, required this.photoEntity});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ViewPhotoPropertyRow(fieldName: "ID", value: photoEntity.id),
                ViewPhotoPropertyRow(
                    fieldName: "Descrição", value: photoEntity.description),
                ViewPhotoPropertyRow(
                    fieldName: "Nome original",
                    value: photoEntity.originalName),
                ViewPhotoPropertyRow(
                    fieldName: "Nome do arquivo", value: photoEntity.fileName),
                ViewPhotoPropertyRow(
                    fieldName: "Data de upload",
                    value: photoEntity.uploadAt.toIso8601String()),
                ViewPhotoPropertyRow(
                    fieldName: "Tamanho do arquivo(Mb)",
                    value: photoEntity.size.toString()),
                ViewPhotoPropertyRow(
                    fieldName: "Autor", value: photoEntity.user.name),
              ],
            )),
      ),
    ]);
  }
}

class ViewPhotoPropertyRow extends StatelessWidget {
  final String fieldName;
  final String value;

  const ViewPhotoPropertyRow(
      {super.key, required this.fieldName, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                fieldName,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    value,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                  )))
        ]);
  }
}
