import React from "react"
import PropTypes from "prop-types"
import BoardHistory_BoardMemberList from "./BoardHistory_BoardMemberList";
import BoardHistory_VegaChart from "./BoardHistory_VegaChart";
import {Container,Row,Col} from "react-bootstrap";

class BoardHistory_Container extends React.Component {
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
                            <BoardHistory_BoardMemberList board_members={this.props.board_members}></BoardHistory_BoardMemberList>
                        </Col>
                        <Col>
                            <BoardHistory_VegaChart></BoardHistory_VegaChart>
                        </Col>
                    </Row>
                </Container>
            </React.Fragment>
        );
    }
}

export default BoardHistory_Container
