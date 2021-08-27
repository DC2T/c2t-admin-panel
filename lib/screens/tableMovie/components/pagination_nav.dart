import 'package:flutter/material.dart';
import 'package:admin/models/Movies.dart';
import '../../../constants.dart';

class Pagination extends StatefulWidget {
  final int page;
  final int totalRow;
  final int perPage;
  final Function setPage;
  const Pagination(
      {Key key, this.page, this.totalRow, this.perPage, this.setPage})
      : super(key: key);

  @override
  _PaginationState createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  @override
  Widget build(BuildContext context) {
    final int numOfPage = (widget.totalRow / widget.perPage).ceil();
    List<Widget> pages = [];
    int pageRecent = widget.page;

    int endPage = ((pageRecent + 1) * 10 > widget.totalRow) ? pageRecent : pageRecent + 4;

    for (int i = (endPage == pageRecent) ? pageRecent - 4 : pageRecent; i <= endPage; i++) {
      pages.add(TextButton(
          onPressed: () {
            fetchMovie(i, widget.perPage);
            widget.setPage(i);
            setState(() {
              pageRecent = i;
            });
          },
          child: Text(
            i.toString(),
            style: TextStyle(
              color: (i != pageRecent) ? Colors.white : Colors.yellowAccent,
            ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(10),
            backgroundColor: (i == pageRecent) ? bgColor : secondaryColor,
          )));
    }

    return Center(
      child: Container(
          margin: EdgeInsets.only(top: defaultPadding),
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: secondaryColor,
          ),
          width: 1230,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Text(
                      '${(widget.page * 10 >= widget.totalRow) ? widget.totalRow : widget.page * 10} from ${widget.totalRow}')),
              Container(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          if (pageRecent > 1) {
                            setState(() {
                              pageRecent--;
                            });
                            widget.setPage(pageRecent);
                          }
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    (pageRecent > 1)
                        ? Text(
                            '...',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        : SizedBox(),
                    Row(
                      children: pages,
                    ),
                    Text(
                      '...',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (pageRecent < numOfPage) {
                            setState(() {
                              pageRecent++;
                            });
                            widget.setPage(pageRecent);
                          }
                        },
                        icon: Icon(Icons.arrow_forward_ios)),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
