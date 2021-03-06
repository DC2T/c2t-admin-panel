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
                    width: 50,
                    height: 30,
                    leading: Center(child: Icon(Icons.arrow_back_ios, size: 14,)),
                    onTap: _preNav),
                SizedBox(
                  width: defaultPadding,
                ),
                buttonDefault(
                    width: 50,
                    height: 30,
                    trailing: Center(child: Icon(Icons.arrow_forward_ios, size: 14,)),
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
                      child: netWorkProgressiveImage(
                          context, row[column].toString()),
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
            titlePadding: const EdgeInsets.all(8.0),
            contentPadding: const EdgeInsets.all(8.0),
            title: Text('ID: ${data['_id'].toString()}'),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // image
                      data['photo'] != null
                          ? Container(
                              width: (MediaQuery.of(context).size.width *
                                      0.3) *
                                  0.3,
                              height: (MediaQuery.of(context).size.height *
                                      0.5) *
                                  0.4,
                              child: netWorkProgressiveImage(
                                  context, data['photo']),
                            )
                          : Container(child: null),
                      SizedBox(
                        width: data['photo'] != null ? defaultPadding : 0.0,
                      ),
                      // name, title
                      Expanded(
                        child: Column(
                          children: [
                            textEditFormFill(
                              context,
                              color: Colors.white,
                              labelText:
                                  widget.table == 'Worker' ? 'IP' : 'Name',
                              backgroundColor: bgColor,
                              initValue:
                                  '${data['name'] ?? data['title'] ?? data['ip']}',
                              readOnly: true,
                            ),
                            (data['views'] != null ||
                                    data['pointVoted'] != null)
                                ? Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Expanded(
                                            child: textEditFormFill(
                                              context,
                                              color: Colors.white,
                                              labelText: 'Views',
                                              backgroundColor: bgColor,
                                              initValue:
                                                  '${data['views'].toString()}',
                                              readOnly: true,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: defaultPadding),
                                        Container(
                                          child: Expanded(
                                            child: textEditFormFill(
                                              context,
                                              color: Colors.white,
                                              labelText: 'Votes',
                                              backgroundColor: bgColor,
                                              initValue:
                                                  '${data['pointVotes'].toString()}',
                                              readOnly: true,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(child: null),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  textEditFormFill(
                    context,
                    color: Colors.white,
                    backgroundColor: bgColor,
                    labelText:
                        widget.table == 'Worker' ? 'User Name' : 'Runtime',
                    initValue: '${data['runtime'] ?? data['username']}',
                    readOnly: true,
                  ),
                ],
              ),
            ),
            actions: [
              buttonDefault(
                  width: 50,
                  height: 50,
                  leading: Icon(Icons.edit, size: 14,),
                  onTap: () {
                    Navigator.pop(context);
                    context.read<ScreenController>().controlScreen(
                        screenName: 'Modifier',
                        modifier: widget.table,
                        data: data);
                  }),
              buttonDefault(
                width: 50,
                height: 50,
                leading: Icon(Icons.delete, size: 14,),
                onTap: () {
                  switch (widget.table) {
                    case "Worker":
                      _showDialog("worker", data["_id"]);
                      break;
                    case "Movie":
                      _showDialog("movie", data["_id"]);
                      break;
                  }
                }
              ),
            ],
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

  _showDialog(String type, String id) {
    print(id);
    showDialog(
      context: context, 
      builder: (_) {
        return AlertDialog(
          content: Text('Are you sure delete this item'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                  context: context, 
                  builder: (_) {
                    return AlertDialog(
                      content: FutureBuilder(
                        future: _delete(type, id),
                        builder: (context, snapshot) {
                          if(snapshot.hasData) {
                            return Text('Success');
                          }
                          return CircularProgressIndicator();
                        }),
                    );
                  }
                );
              }, 
              child: Text('Yes')
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: Text('No')
            ),
          ],
        );
      });
  }

  _delete(String type, String id) {   
    print(id); 
    var result;
    switch (type) {
      case "worker":
        result = Worker.delete(id);
        break;
      case "movie":
        result = Movie.delete(id);
        break;
      default:
    }
    return result;
  }
}
