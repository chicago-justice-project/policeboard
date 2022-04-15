import React from "react"
import {VegaLite} from "react-vega";
import axios from "axios";

const spec = {
  width: 600,
  height: 500,
  mark: 'line',
  encoding: {
    x: { field: 'year_decided', type: 'ordinal' },
    y: { field: 'sum_vote_count', type: 'quantitative' },
    color: { field: 'last_name', type:'ordinal'}
  },
  data: { name: 'data' }, // note: vega-lite data attribute is a plain object instead of an array
}

class ChartContainer extends React.Component {

  constructor (props) {
    super(props);

    this.state = {
      version: 0,
      chartData: []
    };
  }

  async componentDidMount() {
    let chartData = await axios.get("/history/all");
    let vegaData = {
      data: chartData.data
    }
    console.log('CHART DATA: '+JSON.stringify(vegaData));
    this.setState({
      chartData: vegaData
    });
  }

  render () {
    return (
      <React.Fragment>
        <VegaLite spec={spec} data={this.state.chartData}/>
      </React.Fragment>
    );
  }
}

export default ChartContainer
