select count(*) as vote_count, board_members.first_name as first_name, board_members.last_name as last_name, board_members.id as board_member_id,
       votes.name as vote_name, to_char(cases.date_decided,'YYYY') as year_decided, outcomes.name as outcome_name, 'Termination' as recommended_outcome
from board_member_votes, board_members, votes, cases, outcomes
where cases.decided_outcome_id = 1 and cases.recommended_outcome_id=1 and cases.date_decided is not null and
        board_member_votes.board_member_id=board_members.id and votes.name='Agree'
  and board_member_votes.vote_id=votes.id and board_member_votes.case_id=cases.id and cases.decided_outcome_id=outcomes.id
group by board_members.id, last_name, first_name, year_decided, outcome_name, vote_name
order by last_name, first_name, year_decided, outcome_name
