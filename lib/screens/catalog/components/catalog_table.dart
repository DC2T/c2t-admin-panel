import 'package:admin/constants.dart';
import 'package:admin/models/Movies.dart';
import 'package:admin/models/Worker.dart';
import 'package:admin/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';

class CatalogTable extends StatefulWidget {
  String Model;

  CatalogTable(this.Model);

  @override
  _CatalogTableState createState() => _CatalogTableState();
}

class _CatalogTableState extends State<CatalogTable> {
  bool loading = true;
  var page;
  var perPage;
  var totalRows;

  var table_columns = Movie.table_columns();
  var columns = Movie.columns();

  List rows;
  var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future _fetchData() async {
    switch (widget.Model) {
      case 'Movie':
        table_columns = Movie.table_columns();
        columns = Movie.columns();
        data = (await Movie.find())['data'];
        break;
      case 'Worker':
        table_columns = Worker.table_columns();
        columns = Worker.columns();
        data = (await Worker.find())['data'];
        break;
      default:
        break;
    }
    page = data['page'];
    totalRows = data['totalRows'];
    rows = data['data'];
    print(rows.length);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: !loading
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: _dataColumn(),
                rows: _dataRow(),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  _dataColumn() {
    return table_columns.map((column) {
      if (columns[column]['name'] == column) {
        return DataColumn(
          label: Text(columns[column]['label']),
        );
      }
    }).toList();
  }

  _dataRow() {
    return rows
        .map((row) => DataRow(
              cells: table_columns.map((column) {
                if (columns[column]['name'] == 'photo') {
                  return DataCell(
                    Container(
                      width: 40,
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: ProgressiveImage(
                        placeholder:
                            AssetImage('assets/images/placeholder.jpg'),
                        // size: 1.87KB
                        thumbnail: row[column].toString() != null
                            ? NetworkImage(row[column].toString(), scale: 0.3)
                            : Image.asset('assets/images/no_image.png'),
                        // size: 1.29MB
                        image: row[column].toString() != null
                            ? NetworkImage(row[column].toString())
                            : Image.asset('assets/images/no_image.png'),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        fadeDuration: const Duration(milliseconds: 500),
                        fit: BoxFit.cover,
                      ),
                      // child: Image.network(row[column].toString()),
                    ),
                  );
                } else if (columns[column]['name'] == 'form') {
                  return DataCell(
                    Text(row[column] ? 'Series' : 'Odds'),
                  );
                } else if (['createAt', 'updateAt']
                    .toList()
                    .contains(columns[column]['name'])) {
                  DateTime date = new DateTime.fromMillisecondsSinceEpoch(
                      int.parse(row[column].toString()));
                  return DataCell(
                    Text(formatDateTime(date)),
                  );
                } else {
                  return DataCell(
                    Text(row[column].toString() ?? ''),
                  );
                }
              }).toList(),
            ))
        .toList();
  }
}
