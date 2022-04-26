import React from "react"
import moment from "moment";
class SuperHistory_SupersList extends React.Component {
  constructor (props) {
    super(props);

    this.state = {
      version: 0
    };
  }

  render () {
    return (
        <React.Fragment>
          <table>
            <tbody>
            <tr><th><h4>Superintendents</h4></th></tr>
            {
              this.props.supers.map((thisSuper, index) => {
                let startLabel = new moment(thisSuper.start_of_term).year();
                let endLabel;
                if (thisSuper.end_of_term) {
                  endLabel = new moment(thisSuper.end_of_term).year();
                }
                else {
                  endLabel = 'Present';
                }


                return (
                    <tr key={index}><td data-start-term={thisSuper.start_of_term}
                                        data-end-term={thisSuper.end_of_term}
                        onClick={this.filterSuper}>{thisSuper.first_name} {thisSuper.last_name} [{startLabel}-{endLabel}]</td></tr>
                )
              })
            }
            </tbody>
          </table>
        </React.Fragment>
    );
  }

  async filterSuper (event) {
    const startTerm = event.currentTarget.dataset.startTerm;
    const endTerm = event.currentTarget.dataset.endTerm;
    const filterEvent = new CustomEvent('filterSuper',{detail: { startTerm: startTerm, endTerm: endTerm}});
    dispatchEvent(filterEvent);
  }
}

export default SuperHistory_SupersList
