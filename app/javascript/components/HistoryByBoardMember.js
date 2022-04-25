import React from "react"
import PropTypes from "prop-types"
import BoardMembersList from "./BoardMembersList";
import MemberVoteChartContainer from "./MemberVoteChartContainer";
import {Container,Row,Col} from "react-bootstrap";

class HistoryByBoardMember extends React.Component {
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
                            <BoardMembersList board_members={this.props.board_members}></BoardMembersList>
                        </Col>
                        <Col>
                            <MemberVoteChartContainer></MemberVoteChartContainer>
                        </Col>
                    </Row>
                </Container>
            </React.Fragment>
        );
    }
}

export default HistoryByBoardMember
