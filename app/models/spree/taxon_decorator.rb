module Spree::TaxonDecorator
  def self.prepended(base)
    base.searchkick(
      callbacks: :async,
      word_start: [:name],
      settings: { number_of_replicas: 0 },
      merge_mappings: true,
      mappings: {
        properties: {
          properties: {
            type: 'nested'
          }
        }
      }
    ) unless base.respond_to?(:searchkick_index)

    def base.autocomplete_fields
      [:name]
    end

    def base.search_fields
      [:name]
    end

    def base.autocomplete(keywords)
      if keywords
        Spree::Taxon.search(
          keywords,
          fields: autocomplete_fields,
          match: :word_start,
          limit: 10,
          load: false,
          misspellings: { below: 3 },
        ).map(&:name).map(&:strip).uniq
      else
        Spree::Taxon.search(
          "*",
          fields: autocomplete_fields,
          load: false,
          misspellings: { below: 3 },
        ).map(&:name).map(&:strip)
      end
    end


    # Searchkick can't be reinitialized, this method allow to change options without it
    # ex add_searchkick_option { settings: { "index.mapping.total_fields.limit": 2000 } }
    def base.add_searchkick_option(option)
      base.class_variable_set(:@@searchkick_options, base.searchkick_options.deep_merge(option))
    end
  end


  def index_data
    {}
  end
end

Spree::Taxon.prepend(Spree::TaxonDecorator)
