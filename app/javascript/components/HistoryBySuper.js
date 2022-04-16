import React from "react"
import PropTypes from "prop-types"
import SupersList from "./SupersList";
import ChartContainer from "./ChartContainer";
import {Container,Row,Col} from "react-bootstrap";

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
                <Container fluid>
                    <Row>
                        <Col>
                            <SupersList board_members={this.props.board_members}></SupersList>
                        </Col>
                        <Col>
                            <ChartContainer></ChartContainer>
                        </Col>
                    </Row>
                </Container>
            </React.Fragment>
        );
    }
}

export default HistoryBySuper
