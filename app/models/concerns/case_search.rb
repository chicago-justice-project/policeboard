module CaseSearch
  include FullText

  SEARCH_CATEGORIES = [
    ["Case #", 0],
    ["Defendant Last Name", 1],
    ["Badge/Employee #", 2],
    ["Keyword",3],
  ].freeze


  def search(keywords, category, options = {})
    category_id = category.to_i
    searcher = CaseSearcher.for(keywords, category_id, options )
    @cases = searcher.build_case_list
  end

  class CaseSearcher
    def self.for(keywords, category, options = {})
      case SEARCH_CATEGORIES[category].first
      when 'Keyword'
        FullTextSearcher.new(keywords, options)
      else
        FieldSearcher.new(keywords, category, options)
      end
    end
  end

  class FieldSearcher
    def initialize(keyword, category, options = {})
      @keyword = keyword.downcase
      @category = category
      @page = options['page'] || 1
    end

    def build_case_list
      filtering_clause = filter_clause
      Case.all
          .joins(:defendant)
          .where(is_active:true)
          .where.not(defendant_id: nil)
          .where(filtering_clause,
            { keyword: '%' + @keyword + '%' })
          .order('date_initiated IS NULL, date_initiated DESC')
          .paginate(:page => @page)
    end

    private

    def filter_clause
      case SEARCH_CATEGORIES[@category].first
      when "Case #"
        "LOWER(cases.number) LIKE :keyword "
      when "Defendant Last Name"
        "LOWER(defendants.first_name) LIKE :keyword " +
          "OR LOWER(defendants.last_name) LIKE :keyword " +
          "OR LOWER(defendants.first_name||' '||defendants.last_name) LIKE :keyword "
      when "Badge/Employee #"
        "LOWER(defendants.number) LIKE :keyword"
      end
    end
  end
end