# org.Hs.eg.db

[![build](https://github.com/ruby-on-bioc/org.Hs.eg.db/actions/workflows/ci.yml/badge.svg)](https://github.com/ruby-on-bioc/org.Hs.eg.db/actions/workflows/ci.yml)
[![version](https://img.shields.io/badge/release%20version-3.15.0-green.svg)](https://bioconductor.org/packages/org.Hs.eg.db/)

:notes: [org.Hs.eg.db](https://bioconductor.org/packages/org.Hs.eg.db/) - for Ruby

## Installation

```
git clone https://github.com/ruby-on-bioc/org.Hs.eg.db
cd org.Hs.eg.db
rake extdata:download
rake install
```

## Usage

```ruby
require 'org_hs_eg_db'

OrgHsEgDb.class # Sequel::SQLite::Database
OrgHsEgDb.tables
```

See [Sequel](https://github.com/jeremyevans/sequel) for more details.

## Development

With all due respect to the R language and Bioconductor maintainers...

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ruby-on-bioc/org.Hs.eg.db.
