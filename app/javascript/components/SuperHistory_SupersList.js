import React from "react"
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
            {
              this.props.supers.map((thisSuper, index) => {
                return (
                    <tr key={index}><td data-start-term={thisSuper.start_of_term}
                                        data-end-term={thisSuper.end_of_term}
                        onClick={this.filterSuper}>{thisSuper.first_name} {thisSuper.last_name}</td></tr>
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
