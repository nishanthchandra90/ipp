import 'package:flutter/material.dart';
import 'package:internal_portal_projects/bloc/employee_bloc.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/employee_details.dart';
import 'package:internal_portal_projects/screens/admin_screens/show_employee_detail.dart';

class EmployeesTabScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmployeesTabScreenState();
}

class _EmployeesTabScreenState extends State<EmployeesTabScreen> {
  final bloc = EmployeeBloc();
  TextEditingController controller = new TextEditingController();
  List<EmployeeDetails> _searchResult = [];
  List<EmployeeDetails> _employeeDetails = [];
  double column1Width;
  double column2Width;
  double column3Width;

  @override
  Widget build(BuildContext context) {
    column1Width = MediaQuery.of(context).size.width * 0.25;
    column2Width = MediaQuery.of(context).size.width * 0.4;
    column3Width = MediaQuery.of(context).size.width * 0.25;
    return Scaffold(
      body: _buildScreen(),
    );
  }

  _buildScreen() {
    return Container(
      child: StreamBuilder(
        stream: bloc.employees,
        builder: (BuildContext context,
            AsyncSnapshot<List<EmployeeDetails>> snapshot) {
          if (snapshot.hasData) {
            _employeeDetails = snapshot.data;
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                      color: Theme.of(context).primaryColor,
                      child: _buildSearchBox()),
                  _createTableHeader(),
                  new Expanded(
                      child: _searchResult.length != 0 ||
                              controller.text.isNotEmpty
                          ? _buildSearchResults()
                          : _createEmployeeList(snapshot.data)),
                ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  _createTableHeader() {
    return ListTile(
      leading: Container(
          width: column1Width,
          child: IPPText.simpleText("Name",
              fontSize: 18, fontWeight: FontWeight.bold)),
      title: Container(
          width: column2Width,
          child: IPPText.simpleText("Emp Id",
              fontSize: 17, fontWeight: FontWeight.bold)),
      trailing: Container(
          width: column3Width,
          child: IPPText.simpleText("Location",
              fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  _createEmployeeList(List<EmployeeDetails> employees) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: new ListView.separated(
          itemCount: employees.length,
          itemBuilder: (BuildContext _context, int index) {
            EmployeeDetails employee = employees[index];
            return InkWell(
              onTap: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ShowEmployeeScreen(employee))),
              child: _displayEmployeeItem(employee),
            );
          },
          separatorBuilder: (BuildContext _context, int index) => const Divider(
            thickness: 1,
          ),
        ));
  }

  Widget _displayEmployeeItem(EmployeeDetails employeeDetails) {
    if (employeeDetails.isAdmin) {
      return SizedBox();
    }
    return ListTile(
      leading: Container(
          width: column1Width,
          child: IPPText.simpleText(employeeDetails.empName.toUpperCase(),
              color: Colors.blue)),
      title: Container(
          width: column2Width,
          child: IPPText.simpleText(employeeDetails.employeeId,
              fontSize: 15, overflow: TextOverflow.fade)),
      trailing: Container(
          width: column3Width,
          child:
              IPPText.simpleText(employeeDetails.currLocation, fontSize: 15)),
    );
  }

  Widget _buildSearchResults() {
    return new ListView.builder(
      itemCount: _searchResult.length,
      itemBuilder: (context, i) {
        return _displayEmployeeItem(_searchResult[i]);
      },
    );
  }

  Widget _buildSearchBox() {
    return new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new Card(
        child: new ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: controller,
            decoration: new InputDecoration(
                hintText: 'Search', border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
            onPressed: () {
              controller.clear();
              onSearchTextChanged('');
            },
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _employeeDetails.forEach((employeeDetail) {
      String loc = employeeDetail.currLocation.toLowerCase();
      String searchText = text.toLowerCase();
      if (loc.contains(searchText) || employeeDetail.employeeId.contains(text))
        _searchResult.add(employeeDetail);
      setState(() {});
    });
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
