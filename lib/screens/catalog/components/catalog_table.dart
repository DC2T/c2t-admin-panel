import 'package:admin/constants.dart';
import 'package:admin/controllers/ScreenController.dart';
import 'package:admin/models/Movies.dart';
import 'package:admin/models/Worker.dart';
import 'package:admin/screens/reuseable/widgets.dart';
import 'package:admin/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';

class CatalogTable extends StatefulWidget {
  String table;

  CatalogTable({this.table});

  @override
  _CatalogTableState createState() => _CatalogTableState();
}

class _CatalogTableState extends State<CatalogTable> {
  int page = 1;
  int perPage = 20;
  int pages = 1;
  var totalRows;
  bool loading = true;

  var table_columns;
  var columns;

  var data;

  List rows;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  _fetchData() async {
    switch (widget.table) {
      case 'Movie':
        table_columns = Movie.table_columns();
        columns = Movie.columns();
        Movie.filter_params['page'] = page;
        data = (await Movie.find())['data'];
        break;
      case 'Worker':
        table_columns = Worker.table_columns();
        columns = Worker.columns();
        Worker.filter_params['page'] = page;
        data = (await Worker.find())['data'];
        break;
      default:
        break;
    }
    totalRows = data['totalRows'];
    pages = (totalRows / perPage).ceil();
    rows = data['data'];

    // print(rows.length);
    // setState(() {
    //   loading = false;
    // });
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(defaultBorderRadius)),
                color: secondaryColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buttonDefault(
                    label: 'Pre',
                    leading: Icon(Icons.arrow_back_ios),
                    onTap: _preNav),
                SizedBox(
                  width: defaultPadding,
                ),
                buttonDefault(
                    label: 'Next',
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: _nextNav),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: defaultPadding + 50,
          top: defaultPadding,
          left: 0.0,
          right: 0.0,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
                future: _fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          showCheckboxColumn: false,
                          columns: _dataColumn(),
                          rows: _dataRow(snapshot.data),
                        ),
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
      ],
    );
  }

  _dataColumn() {
    return table_columns.map<DataColumn>((column) {
      if (columns[column]['name'] == column) {
        return DataColumn(
          label: Text(columns[column]['label']),
        );
      }
    }).toList();
  }

  _dataRow(rows) {
    return rows
        .map<DataRow>((row) => DataRow(
              onSelectChanged: (value) {
                _miniShowDetail(row);
              },
              cells: table_columns.map<DataCell>((column) {
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

  _miniShowDetail(data) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('ID: ${data['_id'].toString()}'),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // image
                      data['photo'] != null
                          ? Container(
                              width: (MediaQuery.of(context).size.width * 0.3) *
                                  0.3,
                              height:
                                  (MediaQuery.of(context).size.height * 0.5) *
                                      0.4,
                              child: ProgressiveImage(
                                placeholder:
                                    AssetImage('assets/images/placeholder.jpg'),
                                // size: 1.87KB
                                thumbnail: NetworkImage(
                                    data['photo'].toString(),
                                    scale: 0.3),
                                // size: 1.29MB
                                image: NetworkImage(data['photo'].toString()),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                fadeDuration: const Duration(milliseconds: 500),
                                fit: BoxFit.cover,
                              ))
                          : Container(child: null),
                      SizedBox(
                        width: data['photo'] != null? defaultPadding: 0.0,
                      ),
                      // name, title
                      Expanded(
                        child: Column(
                          children: [
                            textEditFormFill(
                              context,
                              color: Colors.white,
                              labelText: 'Name',
                              backgroundColor: bgColor,
                              initValue: '${data['name'] ?? data['title'] ?? data['ip']}',
                              expands: true,
                              readOnly: true,
                            ),
                            (data['views'] !=null || data['pointVoted'] !=null)?Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Expanded(
                                      child: textEditFormFill(
                                        context,
                                        color: Colors.white,
                                        labelText: 'Views',
                                        backgroundColor: bgColor,
                                        initValue: '${data['views'].toString()}',
                                        expands: true,
                                        readOnly: true,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: defaultPadding
                                  ),
                                  Container(
                                    child: Expanded(
                                      child: textEditFormFill(
                                        context,
                                        color: Colors.white,
                                        labelText: 'Votes',
                                        backgroundColor: bgColor,
                                        initValue: '${data['pointVotes'].toString()}',
                                        expands: true,
                                        readOnly: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ): Container(child: null),
                          ],
                        ),
                      ),//     'Name: ${data['name'] ?? data['title'] ?? data['ip']}'))
                    ],
                  ),
                  Positioned(
                    right: 0.0,
                    bottom: defaultPadding,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        buttonDefault(leading: Icon(Icons.edit), onTap: () {
                          Navigator.pop(context);
                          context.read<ScreenController>().controlScreen(screenName: 'Modifier', modifier: widget.table);
                        }),
                        SizedBox(
                            width: defaultPadding
                        ),
                        buttonDefault(leading: Icon(Icons.delete)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _preNav() {
    if (page >= 1) {
      page -= 1;
      setState(() {});
    }
  }

  _nextNav() {
    if (page < pages) {
      page += 1;
      setState(() {});
    }
  }
}
