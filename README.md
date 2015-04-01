# Predefined

Predefined is a library for writing parameterized SQL queries, executing them and mapping the result to on to objects.

## Installation

To use in a [Rails][rails] app, add this line to your application's Gemfile:

```ruby
gem 'predefined', require: 'predefined/rails'
```

To use in a Ruby app with [Sequel][sequel], app this line your application's Gemfile:

```ruby
gem 'predefined', require: 'predefined/sequel'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install predefined

## Usage

The basic concept of Predefined is that you will write SQL queries and save them into a file. For example, if you have a Rails app with a users table, you would create a file `app/queries/users/get.sql` that would look like this:

```sql
SELECT
  *
FROM
  users
WHERE
  id = :id
```

Then to execute the query and return the results, you would write code like this:

```ruby
Predefined::ActiveRecordQuery.new('users/get').select_one(id: id)
```

This will replace `:id` in your SQL statement with the actual value you pass in, then run the query and return the results as a Hash.

To make the syntax a bit cleaner, include the module `Predefined::ActiveRecordHelpers` in your base classes like `ApplicationController`, then you can simply run this code:

```ruby
select_one 'users/get', id: id
```

There are several methods you can use to execute a query:

### `select_one(template_file, params)`

This method take the name of the query and the parameters for the query and returns a Hash with the keys as Symbols and the values are type casted, meaning if the database column is an Integer, you will get a Integer instead of a String.

### `select_all(template_file, params)`

This method takes the name of the query and the parameters for the query and returns an Array of Hashes, one Hash for each row in the result of the query. The keys of the Hashes are Symbols and the values are type casted.

### `select_rows(template_file, params)`

This method will return an Array of Arrays of type casted values, one Array for each row in the result of the query.

### `select_values(template_file, params)`

This method will return an Array of type casted values, using the first column from the result of the query.

### `select_values(template_file, params)`

This method will return a type casted value, the first column in the first row of the result

### `select_object(template_file, klass, params)`

This method is like `select_one`, but it will also pass the Hash an an argument to the class's new method and return the object instance. This:

```ruby
select_object 'thing', Thing, id: 1
```

is equivalent to

```ruby
Thing.new(select_one('thing', id: 1))
```

### `select_objects(template_file, klass, params)`

This is like `select_object` except that it creates an object for every row in the result of the query and returns the Array of objects

## Contributing

1. Fork it ( https://github.com/[my-github-username]/predefined/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[rails]: http://rubyonrails.org/
[sequel]: http://sequel.jeremyevans.net/
