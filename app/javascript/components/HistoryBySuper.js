import React from "react"
import PropTypes from "prop-types"
import SupersList from "./SupersList";
import ChartContainer from "./ChartContainer";

class HistoryBySuper extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            version: 0
        };
    }


    render() {
        return (
            <React.Fragment>
                <SupersList board_members={this.props.board_members}></SupersList>
                <ChartContainer></ChartContainer>
            </React.Fragment>
        );
    }
}

export default HistoryBySuper
