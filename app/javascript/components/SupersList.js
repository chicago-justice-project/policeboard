import React from "react"
import PropTypes from "prop-types"
class SupersList extends React.Component {

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
          this.props.board_members.map((member, index) => {
            return (
                <tr key={index}><td data-member-id={member.id} onClick={this.filterMember}>{member.first_name} {member.last_name}</td></tr>
            )
          })
        }
          </tbody>
        </table>
      </React.Fragment>
    );
  }

  async filterMember (event) {
    const memberId = event.currentTarget.dataset.memberId;
    const filterEvent = new CustomEvent('filterMember',{detail: { id: memberId}});
    dispatchEvent(filterEvent);
  }
}

export default SupersList
