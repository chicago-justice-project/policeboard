import React from "react"
import {Col, Container, Row} from "react-bootstrap";
import SuperHistory_SupersList from "./SuperHistory_SupersList";
import SuperHistory_VegaChart from "./SuperHistory_VegaChart";
class SuperHistory_Container extends React.Component {
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
                <SuperHistory_SupersList supers={this.props.supers}></SuperHistory_SupersList>
              </Col>
              <Col>
                <SuperHistory_VegaChart></SuperHistory_VegaChart>
              </Col>
            </Row>
          </Container>
        </React.Fragment>
    );
  }
}

export default SuperHistory_Container
