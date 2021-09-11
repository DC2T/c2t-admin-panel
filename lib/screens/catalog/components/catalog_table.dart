import 'package:admin/constants.dart';
import 'package:admin/models/Movies.dart';
import 'package:admin/models/Worker.dart';
import 'package:admin/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';

class CatalogTable extends StatefulWidget {
  Map<String, dynamic> data;
  Map<String, dynamic> columns;
  List table_columns;

  CatalogTable({this.table_columns, this.columns, this.data});

  @override
  _CatalogTableState createState() => _CatalogTableState();
}

class _CatalogTableState extends State<CatalogTable> {
  var page;
  var perPage;
  var totalRows;
  bool loading = true;

  List rows;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.data!=null){
      // print(widget.data.toString());
      totalRows = widget.data['totalRows'];
      rows = widget.data['data'];
      page = widget.data['page'];
      print(rows.length);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
            : Center(child: CircularProgressIndicator()));
  }

  _dataColumn() {
    return widget.table_columns.map((column) {
      if (widget.columns[column]['name'] == column) {
        return DataColumn(
          label: Text(widget.columns[column]['label']),
        );
      }
    }).toList();
  }

  _dataRow() {
    return rows
        .map((row) => DataRow(
              cells: widget.table_columns.map((column) {
                if (widget.columns[column]['name'] == 'photo') {
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
                } else if (widget.columns[column]['name'] == 'form') {
                  return DataCell(
                    Text(row[column] ? 'Series' : 'Odds'),
                  );
                } else if (['createAt', 'updateAt']
                    .toList()
                    .contains(widget.columns[column]['name'])) {
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
