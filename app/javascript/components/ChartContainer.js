import React from "react"
import {VegaLite} from "react-vega";
import axios from "axios";



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

    let memberVotes = await axios.get('/history/member?board_member_id='+memberId);
    let boardVotes = [];
    boardVotes.push(...this.state.terminationsByYear);
    boardVotes.push(...memberVotes.data);

    let vegaData = {
      boardVotes: boardVotes
    }


    const startYear = memberVotes.data[0].year_decided;
    const endYear = memberVotes.data[memberVotes.data.length-1].year_decided;

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
        {filter: `datum.year_decided >= '${startYear}'`},
        {filter: `datum.year_decided <= '${endYear}'`}
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
      spec: firstSpec
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
