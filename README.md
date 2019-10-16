# hiera-dynamodb

![Gitlab Workflow](https://github.com/andytechdad/hiera-dynamodb/workflows/Ruby%20Gem/badge.svg "Build Pipeline")

A hiera backend for an AWS DynamoDB table

To use this backend, add the following to your hiera.yaml

    ---
    :hierarchy:
      - common
    :backends:
      - yaml
      - dynamodb
    :yaml:
      :datadir: '/puppet/hiera/'
    :dynamodb:
      :access_key_id: xxxxxxxxxxxxxxxx
      :secret_access_key: XXXXXXXXXXXXXXXXX
      :region: 'eu-west-1'
      :table: 'your-table-name-here'

In your dynamoDB table, you will need to define the table with the primary key of "hiera_key" as a string. the values will be "hiera_value".

Future updates will support custom column names.

## TODO

 - [ ] read credentials from a hidden file
 - [ ] support custom column names for key/value
 - [ ] re-write for hiera5
 - [ ] Tests!
 - [ ] make a gem to install via ruby gems

 Enjoy!
