require 'csv'
require 'roo'

namespace :import do
  board_members = Roo::Excelx.new("#{Rails.root.to_s}/lib/assets/board-members.xlsx").sheet(0)
  board_terms   = Roo::Excelx.new("#{Rails.root.to_s}/lib/assets/board-member-terms.xlsx").sheet(0)
  raw_data      = Roo::Excelx.new("#{Rails.root.to_s}/lib/assets/raw-data.xlsx").sheet(0)
  rules         = Roo::Excelx.new("#{Rails.root.to_s}/lib/assets/rules.xlsx").sheet(0)
    
  desc "Reimport db"
  task :reimport_db do  	
  	Rake::Task['db:drop'].invoke
  	Rake::Task['db:create'].invoke
  	Rake::Task['db:migrate'].invoke
  	Rake::Task['import:all'].invoke
  end
    
  desc "Import all tables"
  task :all do
    Rake::Task['import:authorities'].invoke
  	Rake::Task['import:vote_types'].invoke  
  	Rake::Task['import:outcomes'].invoke
  	Rake::Task['import:board'].invoke
  	Rake::Task['import:board_terms'].invoke
  	Rake::Task['import:rules'].invoke
  	Rake::Task['import:defendants'].invoke
  	Rake::Task['import:cases'].invoke
  end
  
  desc "Import authorities"
  task :authorities => :environment do	
		Authority.create(:name=>"Bureau of Internal Affairs")
		Authority.create(:name=>"Independent Police Review Authority")
  end
  
  desc "Import vote types"
  task :vote_types => :environment do	
		Vote.create(:name=>"Abstain")
		Vote.create(:name=>"Agree")
		Vote.create(:name=>"Dissent")
  end
  
  desc "Import outcomes"
  task :outcomes => :environment do	
		Outcome.create(:name=>"Termination")
		Outcome.create(:name=>"Suspension")
		Outcome.create(:name=>"Return to duty")
		Outcome.create(:name=>"Resignation")
		Outcome.create(:name=>"Death")
		Outcome.create(:name=>"Settlement agreement")
		Outcome.create(:name=>"Other")
  end
  
  desc "Import board"
  task :board => :environment do
    i = -1
    board_members.each(
      fname: 'First name', 
      lname: 'Last name', 
      position: 'Board position', 
      title: 'Job title', 
      org: 'Organization'
    ) do |bm|
      i += 1
      next if i == 0
      BoardMember.create(
        :first_name=>bm[:fname], 
        :last_name=>bm[:lname], 
        :board_position=>bm[:position], 
        :job_title=>bm[:title], 
        :organization=>bm[:org]
      )
    end
  end
  
  desc "Import board terms"
  task :board_terms => :environment do 
    i = -1
    board_terms.each(last_name: 'Last name', start: 'start', end: 'end') do |bt|
      i += 1
      next if i == 0
      bm = BoardMember.find_by_last_name(bt[:last_name])
      Term.create(:start=>bt[:start], :end=>bt[:end], :board_member_id=>bm.id)
    end
  end
  
  desc "Import rules"
  task :rules => :environment do 
    i = -1
    rules.each(code: 'Code', description: 'Description', comment: 'Comment') do |rule|
      i += 1
      next if i == 0
      Rule.create(:code=>rule[:code], :description=>rule[:description], :comment=>rule[:comment])
    end
  end
  
  desc "Import defendants"
  task :defendants => :environment do 
    i = -1
    raw_data.each(
      fname: 'Officer_First_Name', 
      lname: 'Officer_Last_Name', 
      rank: 'Rank_Title',
      badge_num: 'Badge_Number',
      employee_num: 'Employee_Number'
    ) do |df|
      i += 1
      next if i == 0
      
      rank = Rank.find_by_name(df[:rank])
      if rank.nil?
        civ = df[:badge_num].nil? ? true : false        
        r = Rank.create(:name=>df[:rank], :is_civilian=>civ)
        rank_id = r.id
      else
        rank_id = rank.id
      end 
      
      num = df[:badge_num].nil? ? df[:employee_num] : df[:badge_num]
            
      puts "Defendant: #{num.to_i} #{df[:fname]} #{df[:lname]} #{rank_id}"
              
      Defendant.create(:first_name=>df[:fname], :last_name=>df[:lname], :number=>num.to_i, :rank_id=>rank_id)
    end
  end  
  
  desc "Import cases"
  task :cases => :environment do
    i = -1
    raw_data.each(
      number: 'Case Number', 
      fname: 'Officer_First_Name', 
      lname: 'Officer_Last_Name', 
      initiated: 'Date_Initiated',
      decided: 'Date_of_Judgement',
      rec_outcome: 'Discipline_Recommended',
      dec_outcome: 'FD Basic'
    ) do |c|
    
      i += 1
      next if i == 0
            
      if !c[:fname].nil? && !c[:lname].nil?
        df = Defendant.where(first_name: c[:fname], last_name: c[:lname])
        df_id = df.count > 0 ? df.first.id : nil
      end 
      
      if !c[:rec_outcome].nil?
        rec = Outcome.find_by_name(c[:rec_outcome])
        rec_id = rec.nil? ? nil : rec.id 
      end
      
      if !c[:dec_outcome].nil?
        dec = Outcome.find_by_name(c[:dec_outcome])
        dec_id = dec.nil? ? nil : dec.id
      end
      
      puts "Case #{c[:number]} #{df_id} #{c[:initiated]} #{c[:decided]} #{rec_id} #{dec_id}"
      
      Case.create(
        :number=>c[:number], 
        :defendant_id=>df_id, 
        :date_initiated=>c[:initiated], 
        :date_decided=>c[:decided],
        :recommended_outcome_id=>rec_id, 
        :decided_outcome_id=>dec_id
      )
    end
	end
end