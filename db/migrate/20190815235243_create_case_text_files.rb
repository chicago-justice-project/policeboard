class CreateCaseTextFiles < ActiveRecord::Migration
  def up
    create_table :case_text_files do |t|
      t.references :case
      t.string :name
      t.text :search_text

      t.timestamps null: false
    end

    # store_pdf_to_case_text_file

    execute <<-SQL
      CREATE INDEX case_text_files_search_idx
      ON case_text_files
      USING gin(to_tsvector('english', search_text));
    SQL
  end

  def down
    execute <<-SQL
      DROP INDEX
      IF EXISTS case_text_files_search_idx;
    SQL

    drop_table(:case_text_files, if_exists: true)
  end

  private

  def store_pdf_to_case_text_file
    Case.where('files is not null').each do |xcase|
      xcase.files.each do |pdf|
        pdf.cache_stored_file!
        pdf.retrieve_from_cache!(pdf.cache_name)
        CaseTextFile
          .create!(case_id: xcase.id,
                   name: pdf.filename,
                   search_text:  pdf_to_text(pdf.file.file))
      end
    end
  end

  def pdf_to_text(file)
    reader = PDF::Reader.new(file)
    pdf_text = StringIO.new
    reader.pages.each do |page|
      pdf_text << page.text
      pdf_text << '\n' unless page.text.empty?
    end
    pdf_text.string
  end
end
