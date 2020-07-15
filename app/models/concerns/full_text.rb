module FullText
  class FullTextSearcher
    def initialize(keywords, options = {})
      @keywords = keywords
      @current_page = options['page'] || 1
      @per_page = options['per_page'] || 10
    end

    def build_case_list
      @cases = []
      search_results = text_search

      search_results.each do |record|
        id = record['id'].to_i

        begin
          case_item = Case
                  .joins(:defendant)
                  .where.not(defendant_id: nil)
                  .order('date_initiated IS NULL, date_initiated DESC')
                  .find id

          rescue ActiveRecord::RecordNotFound
        end
        next unless case_item

        case_item.search_text = record['search_text']
        @cases << case_item
      end
      paginate
    end

    private

    def text_search
      query = build_query
      result = ActiveRecord::Base.connection.execute(query)
      result
    end

    private

    def build_query
      @ts_queries = keywords_to_tsquery(@keywords.split(' '))

      query =
      "#{select_fields} "\
      "#{where_clause} "\
      "GROUP BY cases.id)ts "
      query
    end

    def select_fields
      'SELECT id, '\
        "ts_headline('english', search_text, "\
        "#{keywords_to_query}"\
        ", 'StartSel = <strong> , StopSel = </strong>, MinWords=1, MaxWords=45, MaxFragments=1,ShortWord=2') as search_text "\
        "FROM "\
        "(SELECT cases.id, string_agg(ctf.search_text::text, ' ') as search_text "\
          "FROM cases INNER JOIN case_text_files ctf ON cases.id = ctf.case_id "\
    end

    def keywords_to_tsquery(keywords_array)
      ts_query = []
      keywords_array.each do |term|
        ts_query << "to_tsquery('english', ''' ' || '#{term}' || ' ''' || ':*') "
      end
      ts_query
    end

    def where_clause
      to_query = StringIO.new
      to_query << "WHERE ( "
      @ts_queries.each do |term|
        to_query << "#{field_to_vector} @@ #{term}"
        to_query << "AND " if term != @ts_queries.last
      end
      to_query << ") "
      to_query.string
    end

    def keywords_to_query
      to_query = StringIO.new
      to_query << "("
      @ts_queries.each do |term|
        to_query << "#{term}"
        to_query << "|| " if term != @ts_queries.last
      end
      to_query << ") "
      to_query.string
    end

    def field_to_vector
      "(to_tsvector('english', coalesce(search_text,'')) )"
    end

    def paginate
      @cases = WillPaginate::Collection.create(@current_page, 10, @cases.length) do |pager|
        start = (@current_page -1)* @per_page
        pager.replace(@cases[start, @per_page])
      end
    end
  end
end