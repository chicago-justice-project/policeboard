import React from "react"
import axios from "axios";
import moment from "moment";
import {VegaLite} from "react-vega";
class SuperHistory_VegaChart extends React.Component {

  spec = {
    height: 500,
    mark: 'bar',
    encoding: {
      x: { field: 'year_decided', type: 'ordinal', axis: {format:'c',title:'Year Decided'} },
      y: { field: 'vote_count', type: 'quantitative', stack: null, axis: {format: 'c', title: 'Terminations'} },
      color: { field: 'record_type', type:'nominal', axis: {format: 'c', title: 'Record Type'}}
    },
    data: { name: 'boardVotes' },
  };

  constructor (props) {
    super(props);

    this.state = {
      version: 0,
      chartData: {}
    };

    this.filterSuper = this.filterSuper.bind(this);

    addEventListener('filterSuper', this.filterSuper);

  }

  async filterSuper (event) {

    let startTerm = event.detail.startTerm;
    let endTerm=event.detail.endTerm;
    let skipYearConversion=false;

    if (startTerm===undefined) {
      startTerm='1990-01-01';
      endTerm = '2099-01-01';
      skipYearConversion=true;
    }

    let terminationsByYear = await axios.get('/super_history/terminationsByYear?start_term='+startTerm+'&end_term='+endTerm);
    let recommendedTermsByYear = await axios.get('/super_history/recommendedTermsByYear?start_term='+startTerm+'&end_term='+endTerm);

    let boardVotes = [];
    boardVotes.push(...terminationsByYear.data);
    boardVotes.push(...recommendedTermsByYear.data);

    if (!skipYearConversion) {
      this.convertYears(boardVotes, startTerm);
    }

    let vegaData = {
      boardVotes: boardVotes
    }

    //Update year filter
    this.setState({
      chartData: vegaData
    });
  }

  convertYears (boardVotes, startYear) {
    let year = new moment(startYear).year();
    for (let vote of boardVotes) {
      let yearDiff = (parseInt(vote.year_decided)-year)+1
      vote.year_decided=`Year ${yearDiff}`
    }
  }

  async componentDidMount() {
    await this.loadFirstChart();
  }

  async loadFirstChart () {
    let terminationsByYear = await axios.get('/super_history/terminationsByYear?start_term=1990-01-01&end_term=2099-01-01');
    let recommendedTermsByYear = await axios.get('/super_history/recommendedTermsByYear?start_term=1990-01-01&end_term=2099-01-01');

    let boardVotes = [];
    boardVotes.push(...terminationsByYear.data);
    boardVotes.push(...recommendedTermsByYear.data);

    let vegaData = {
      boardVotes: boardVotes
    }

    this.setState({
      chartData: vegaData
    });
  }

  render () {
    return (
      <React.Fragment>
        <VegaLite spec={this.spec} data={this.state.chartData} width={600}/>
      </React.Fragment>
    );
  }
}

export default SuperHistory_VegaChart
