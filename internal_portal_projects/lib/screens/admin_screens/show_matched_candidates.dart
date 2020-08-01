import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:internal_portal_projects/bloc/project_bloc.dart';
import 'package:internal_portal_projects/common_components/ipp_text.dart';
import 'package:internal_portal_projects/model/potential_candidates.dart';

class MatchedCandidates extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MatchedCandidateState();
}

class _MatchedCandidateState extends State<MatchedCandidates> {
  final bloc = ProjectsBloc();

  @override
  Widget build(BuildContext context) {
    bloc.getApplicationsAndMatches();

    return Scaffold(body: _displayMatchesAndApplications());
  }

  _displayMatchesAndApplications() {
    return Container(
      child: StreamBuilder(
        stream: bloc.potentialCandidates,
        builder: (BuildContext context,
            AsyncSnapshot<List<PotentialCandidates>> snapshot) {
          if (snapshot.hasData) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Expanded(child: _createProjectList(snapshot.data)),
                ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  _createProjectList(List<PotentialCandidates> potentialCandidates) {
    return new ListView.separated(
      padding: const EdgeInsets.all(2),
      itemCount: potentialCandidates.length,
      itemBuilder: (BuildContext _context, int index) {
        PotentialCandidates potentialCandidate = potentialCandidates[index];
        return Container(
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            child: _createListItem(potentialCandidate),
          ),
        );
      },
      separatorBuilder: (BuildContext _context, int index) => const Divider(
        thickness: 1,
      ),
    );
  }

  Widget _createListItem(PotentialCandidates potentialCandidate) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
      child: new SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            _createRow(potentialCandidate.projectName.toUpperCase(),
                potentialCandidate.projectId.toUpperCase()),
            SizedBox(
              height: 30,
            ),
            _createCustomRow("Matched", potentialCandidate.matchedCandidates),
            SizedBox(
              height: 10,
            ),
            _createCustomRow("Applied", potentialCandidate.appliedCandidates)
          ])),
    );
  }

  _createRow(String fieldName, String fieldVal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IPPText.simpleText(fieldName,
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),
        SizedBox(
          width: 50,
        ),
        Expanded(
            child: IPPText.simpleText(
          fieldVal,
          fontSize: 18,
        )),
      ],
    );
  }

  _createCustomRow(String fieldName, List<dynamic> fieldVal) {
    return fieldVal.isNotEmpty
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: StringUtils.equalsIgnoreCase("matched", fieldName)
                    ? Colors.green
                    : Colors.yellow,
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: IPPText.simpleText(fieldName,
                        fontWeight: FontWeight.bold, fontSize: 13)),
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                  child: IPPText.simpleText(
                fieldVal.toString().replaceAll("[", "").replaceAll("]", ""),
                fontSize: 15,
              )),
            ],
          )
        : Container();
  }
}
