import React from "react"
import {VegaLite} from "react-vega";
import axios from "axios";



class ChartContainer extends React.Component {

  constructor (props) {
    super(props);

    const spec = {
      width: 600,
      height: 500,
      mark: 'bar',
      encoding: {
        x: { field: 'year_decided', type: 'ordinal', axis: {format:'c',title:'Year Decided'} },
        y: { field: 'vote_count', type: 'quantitative', axis: {format: 'c', title: 'Termination Votes'} },
        color: { field: 'last_name', type:'nominal', axis: {format: 'c', title: 'Superintendent'}}
      },
      data: { name: 'boardVotes' },
      transform: [
      ]
    };

    this.state = {
      version: 0,
      chartData: {},
      spec: spec,
      startYear: '1900',
      endYear: '2100'
    };

    this.filterMember = this.filterMember.bind(this);

    addEventListener('filterMember', this.filterMember);

  }

  async filterMember (event) {
    const memberId = event.detail.id;
    console.log('FILTER ON MEMBER: '+memberId);

    let boardVotes = await axios.get('/history/member?board_member_id='+memberId);


    const startYear = boardVotes.data[0].year_decided;
    const endYear = boardVotes.data[boardVotes.data.length-1].year_decided;

    console.log('FilteredVotes: '+JSON.stringify(boardVotes));
    boardVotes.data.push(...this.state.terminationsByYear);
    let vegaData = {
      boardVotes: boardVotes.data
    }


    //Update year filter
    this.setState({
      chartData: vegaData,
      startYear: startYear,
      endYear: endYear
    });

    this.setState({
      spec: spec
    });
  }

  async componentDidMount() {

    let terminationsByYear = await axios.get('/history/terminationsByYear');
    let boardVotes = await axios.get("/history/all");
    console.log('TERMINATIONS: '+JSON.stringify(terminationsByYear.data));
    boardVotes.data.push(...terminationsByYear.data);

    const startYear = boardVotes.data[0].year_decided;
    const endYear = boardVotes.data[boardVotes.data.length-1].year_decided;

    let vegaData = {
      boardVotes: boardVotes.data
    }
    console.log('BOARD VOTES: '+JSON.stringify(boardVotes.data));
    this.setState({
      chartData: vegaData,
      terminationsByYear: terminationsByYear.data,
      startYear: startYear,
      endYear: endYear
    });
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
