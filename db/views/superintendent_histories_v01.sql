select count(*) as vote_count, board_members.first_name as first_name, board_members.last_name as last_name,
       votes.name as vote_name, to_char(cases.date_decided,'YYYY') as year_decided, outcomes.name as outcome_name, 'Termination' as recommended_outcome
from board_member_votes, board_members, votes, cases, outcomes
where cases.recommended_outcome_id = 1 and
        board_member_votes.board_member_id=board_members.id
  and board_member_votes.vote_id=votes.id and board_member_votes.case_id=cases.id and cases.decided_outcome_id=outcomes.id
group by last_name, first_name, year_decided, outcome_name, vote_name
order by last_name, first_name, year_decided, outcome_name
