import 'package:flutter/material.dart';
import 'package:projects/data/datasource/protocols/entities/photo_entity.dart';

class ViewPhotoInfo extends StatelessWidget {
  final PhotoEntity photoEntity;

  const ViewPhotoInfo({super.key, required this.photoEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: DataTable(
        columnSpacing: 8.0,
        headingTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
            color: Colors.black
        ),
        dataTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
        columns: const [
          DataColumn(label: Text('Campo')),
          DataColumn(label: Text('Valor')),
        ],
        rows: [
          DataRow(cells: [
            const DataCell(Text('ID')),
            DataCell(Text(photoEntity.id)),
          ]),
          DataRow(cells: [
            const DataCell(Text('Descrição')),
            DataCell(Text(photoEntity.description)),
          ]),
          DataRow(cells: [
            const DataCell(Text('Nome original')),
            DataCell(Text(photoEntity.originalName)),
          ]),
          DataRow(cells: [
            const DataCell(Text('Nome do arquivo')),
            DataCell(Text(photoEntity.fileName)),
          ]),
          DataRow(cells: [
            const DataCell(Text('Data de upload')),
            DataCell(Text(photoEntity.uploadAt.toIso8601String())),
          ]),
          DataRow(cells: [
            const DataCell(Text('Tamanho')),
            DataCell(Text("${photoEntity.size.toString()} Mb")),
          ]),
          DataRow(cells: [
            const DataCell(Text('User ID')),
            DataCell(Text(photoEntity.userId)),
          ]),
        ],
      ),
    );
  }
}
