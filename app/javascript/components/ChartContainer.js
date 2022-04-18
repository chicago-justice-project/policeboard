import React from "react"
import {VegaLite} from "react-vega";
import axios from "axios";
import moment from "moment";



class ChartContainer extends React.Component {

  constructor (props) {
    super(props);


    this.state = {
      version: 0,
      chartData: {},
      spec: {}
    };

    this.filterMember = this.filterMember.bind(this);

    addEventListener('filterMember', this.filterMember);

  }

  async filterMember (event) {


    const memberId = event.detail.id;
    console.log('FILTER ON MEMBER: '+memberId);

    let memberVotes = await axios.get('/history/memberVotes?board_member_id='+memberId);
    let memberTerms = await axios.get('/history/memberTerms?board_member_id='+memberId);
    let boardVotes = [];
    boardVotes.push(...this.state.terminationsByYear);
    boardVotes.push(...this.state.recommendedTermsByYear);
    boardVotes.push(...memberVotes.data);

    let vegaData = {
      boardVotes: boardVotes
    }

    let startYear;
    let endYear;
    for (let memberTerm of memberTerms.data) {
      if (startYear === undefined || new moment(memberTerm.start)>startYear) {
        startYear = new moment(memberTerm.start);
      }
      if (endYear === undefined || new moment(memberTerm.end)>endYear) {
        endYear = new moment(memberTerm.end);
      }
      if (memberTerm.end === undefined) {
        endYear = new moment(); //No end date so set to current date
      }
    }

    let startYearString = startYear.format('YYYY');
    let endYearString = endYear.format('YYYY');

    const spec = {
      width: 600,
      height: 500,
      mark: 'bar',
      encoding: {
        x: { field: 'year_decided', type: 'ordinal', axis: {format:'c',title:'Year Decided'} },
        y: { field: 'vote_count', type: 'quantitative', stack: null, axis: {format: 'c', title: 'Terminations'} },
        color: { field: 'last_name', type:'nominal', axis: {format: 'c', title: 'Superintendent'}}
      },
      transform: [
        {filter: `datum.year_decided >= '${startYearString}'`},
        {filter: `datum.year_decided <= '${endYearString}'`}
      ],
      data: { name: 'boardVotes' }
    };



    //Update year filter
    this.setState({
      chartData: vegaData,
      spec: spec
    });
  }

  async loadFirstChart () {
    const firstSpec = {
      width: 600,
      height: 500,
      mark: 'bar',
      encoding: {
        x: { field: 'year_decided', type: 'ordinal', axis: {format:'c',title:'Year Decided'} },
        y: { field: 'vote_count', type: 'quantitative', stack: null, axis: {format: 'c', title: 'Terminations'} },
        color: { field: 'outcome_label', type:'nominal', axis: {format: 'c', title: 'Outcomes'}}
      },
      data: { name: 'boardVotes' },
    };

    let recommendedTermsByYear = await axios.get('/history/recommendedTermsByYear');
    let boardVotes = [];
    boardVotes.push(...this.state.terminationsByYear);
    boardVotes.push(...recommendedTermsByYear.data);

    let vegaData = {
      boardVotes: boardVotes
    }

    this.setState({
      chartData: vegaData,
      spec: firstSpec,
      recommendedTermsByYear: recommendedTermsByYear.data
    });
  }

  async componentDidMount() {

    let terminationsByYear = await axios.get('/history/terminationsByYear');
    this.setState({
      terminationsByYear: terminationsByYear.data,
    });

    await this.loadFirstChart();
  }

  render () {
    return (
      <React.Fragment>
        <VegaLite spec={this.state.spec} data={this.state.chartData}/>
      </React.Fragment>
    );
  }
}

export default ChartContainer
