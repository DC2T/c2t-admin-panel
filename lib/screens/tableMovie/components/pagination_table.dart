import 'package:admin/models/Movies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pagination_nav.dart';

import '../../../constants.dart';
import 'actions.dart';

class PaginationTable extends StatefulWidget {
  const PaginationTable({Key key}) : super(key: key);

  @override
  _PaginationTableState createState() => _PaginationTableState();
}

class _PaginationTableState extends State<PaginationTable> {
  int perpageM = 10;
  int pageM = 1;
  int totalRowM = 0;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final double _idWidth = 60;
    final double _imageWidth = 180;
    final double _nameWidth = 330;
    final double _genresWidth = 125;
    final double _ratingWidth = 105;
    final double _viewsWidth = 105;
    final double _runtimeWidth = 175;
    final double _actionsWidth = 150;
    final double _headerTableHeight = 40;

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        padding: EdgeInsets.all(defaultPadding / 2),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      width: _idWidth,
                      height: _headerTableHeight,
                      child: TextHeaderTable(
                        text: 'ID',
                      )),
                  Container(
                      width: _imageWidth,
                      height: _headerTableHeight,
                      child: TextHeaderTable(
                        text: 'IMAGE',
                      )),
                  Container(
                      width: _nameWidth,
                      height: _headerTableHeight,
                      child: TextHeaderTable(
                        text: 'NAME',
                      )),
                  Container(
                      width: _genresWidth,
                      height: _headerTableHeight,
                      child: TextHeaderTable(
                        text: 'GENRES',
                      )),
                  Container(
                      width: _ratingWidth,
                      height: _headerTableHeight,
                      child: TextHeaderTable(
                        text: 'RATING',
                      )),
                  Container(
                      width: _viewsWidth,
                      height: _headerTableHeight,
                      child: TextHeaderTable(
                        text: 'VIEWS',
                      )),
                  Container(
                      width: _runtimeWidth,
                      height: _headerTableHeight,
                      child: TextHeaderTable(
                        text: 'RUN TIME',
                      )),
                  Container(
                      width: _actionsWidth,
                      height: _headerTableHeight,
                      child: TextHeaderTable(
                        text: 'ACTIONS',
                      )),
                ],
              ),
              Container(
                  width: 1230,
                  child: FutureBuilder<FinalResponse>(
                    future: fetchMovie(pageM, perpageM),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return _buildRowData(
                                  id: ((pageM - 1) * 10) + index + 1,
                                  mov: snapshot.data.movies[index],
                                  setPage: (int pg) {
                                    setState(() {
                                      pageM = pg;
                                    });
                                  },
                                  pageRecent: pageM,
                                );
                              },
                              itemCount: snapshot.data.movies.length,
                            ),
                            Pagination(
                              page: pageM,
                              totalRow: snapshot.data.totalRow,
                              perPage: perpageM,
                              setPage: (int pg) {
                                setState(() {
                                  pageM = pg;
                                });
                              },
                            ),
                          ],
                        );
                      }
                      return Center(
                        child: Container(
                          width: 100,
                          height: _size.height,
                          child: Center(
                            child: Container(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator()
                            )
                          )
                        )
                      );
                    },
                  )),
            ],
          ),
        ));
  }
}

class TextHeaderTable extends StatelessWidget {
  final String text;
  const TextHeaderTable({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}

class CellData extends StatelessWidget {
  final Widget content;
  final double width;
  final double height;
  const CellData({Key key, this.content, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(defaultPadding),
      child: Center(
        child: content,
      ),
    ));
  }
}

class _buildRowData extends StatelessWidget {
  final Movie mov;
  final int id;
  final Function setPage;
  final int pageRecent;
  const _buildRowData({
    Key key,
    this.mov,
    this.id,
    this.setPage,
    this.pageRecent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _idWidth = 60;
    final double _imageWidth = 180;
    final double _nameWidth = 330;
    final double _genresWidth = 125;
    final double _ratingWidth = 105;
    final double _viewsWidth = 105;
    final double _runtimeWidth = 175;
    final double _actionsWidth = 150;
    final double _heightDataCell = 200;

    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: secondaryColor,
      ),
      child: InkWell(
        onTap: () {
          print("You've just tapped this row");
        },
        child: Row(
          children: [
            CellData(
                content: Text(id.toString()),
                width: _idWidth,
                height: _heightDataCell),
            CellData(
                content: Image(
                  image: NetworkImage(mov.photo),
                ),
                width: _imageWidth,
                height: _heightDataCell),
            CellData(
                content: Text(mov.title),
                width: _nameWidth,
                height: _heightDataCell),
            CellData(
                content: Text((mov.form) ? 'Odd' : 'Series'),
                width: _genresWidth,
                height: _heightDataCell),
            CellData(
                content: Center(
                    child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellowAccent,
                    ),
                    SizedBox(width: 10),
                    Text((mov.pointVoted.toString())),
                  ],
                )),
                width: _ratingWidth,
                height: _heightDataCell),
            CellData(
                content: Text(mov.views.toString()),
                width: _viewsWidth,
                height: _heightDataCell),
            CellData(
                content: Text(mov.runtime),
                width: _runtimeWidth,
                height: _heightDataCell),
            CellData(
                content: ActionButtons(
                  mov: mov,
                  reload: setPage,
                  pageRecent: pageRecent,
                ),
                width: _actionsWidth,
                height: _heightDataCell),
          ],
        ),
      ),
    );
  }
}
