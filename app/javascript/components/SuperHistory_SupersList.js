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
                    <tr key={index}><td data-member-id={thisSuper.id} onClick={this.filterSuper}>{thisSuper.first_name} {thisSuper.last_name}</td></tr>
                )
              })
            }
            </tbody>
          </table>
        </React.Fragment>
    );
  }

  async filterMember (event) {
    const superId = event.currentTarget.dataset.superId;
    const filterEvent = new CustomEvent('filterSuper',{detail: { id: superId}});
    dispatchEvent(filterEvent);
  }
}

export default SuperHistory_SupersList
