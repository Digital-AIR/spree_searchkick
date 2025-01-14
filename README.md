Spree + Searchkick
===============

[![Build Status](https://travis-ci.org/spree-contrib/spree_searchkick.svg?branch=master)](https://travis-ci.org/spree-contrib/spree_searchkick)

Add [Elasticsearch](http://elastic.co) goodies to Spree, powered by [searchkick](http://searchkick.org)

Features
--------

* Full search (keyword, in_taxon)
* Taxons Aggregations (aggs)
* Search Autocomplete endpoint (`/autocomplete/products?keywords=example`)
* Added `/best` route, where best selling products are boosted in first page

Installation
------------

Add searchkick and spree_searchkick to your Gemfile:

```ruby
gem 'spree_searchkick', github: 'spree-contrib/spree_searchkick'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_searchkick:install
bundle exec rails searchkick:reindex CLASS=Spree::Product
bundle exec rails searchkick:reindex CLASS=Spree::Taxon
```

### Important

[Install elasticsearch](https://www.elastic.co/downloads/elasticsearch)

Documentation
-------------

By default, only the `Spree::Product` class is indexed and to control what data is indexed, override `Spree::Product#search_data` method. Call `Spree::Product.reindex` after changing this method.

To enable or disable taxons filters, go to taxonomy form and change `filterable` boolean.

Testing
-------

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_searchkick/factories'
```

Copyright (c) 2015-2020 Gonzalo Moreno & [other contributors](https://github.com/spree-contrib/spree_searchkick/graphs/contributors), released under the New BSD License
