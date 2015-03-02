# tairb

tairb is tiny tool to read file like as `tail -f`.

## Getting started

You can install by following command.

    $ gem install tairb

And can use as following command.

    $ tairb log/development.log

## Custom output

You can intercept output for each lines.

    $ tairb log/development.log --eval 'puts $_.strip.downcase'

## Filtering

tairb includes filtering feature as follwoing.

    $ tairb log/development.log --filter '$_ =~ /DEBUG/'

## TSV support

tairb supports TSV (Tab-separated values) file.

    $ tairb log/development.log --tsv -f '$_[:severity] == "DEBUG"'

## Contributing

1. Fork it ( https://github.com/hiroara/tairb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
