# ActiveModel::VersionSerializer

fairly short name. This is a little spin on active model serializers

# what is that?

The purpose of `ActiveModel::Serializers` is to provide an object to
encapsulate serialization of `ActiveModel` objects, including `ActiveRecord`
objects.

Serializers know about both a model and the `current_user`, so you can
customize serialization based upon whether a user is authorized to see the
content.

In short, **serializers replaces hash-driven development with object-oriented
development.**

More Information Go See [ActiveModel::Serializer](https://github.com/josevalim/active_model_serializers)
# Versioning

## Why?

Good Question!

When building an api; one would go through various changes in terms of 
versioning. you could seperate this out into modules and that is my 
perfered way. But hey why not have a place where you can easily see
changes in an expressive way.

## Show Me 

Has the same api as active_model_serializers however we can define
a named version block. it also has some extra source for using
previously defined version attributes.

Notice we inherit from `ActiveModel::VersionSerializer`

```ruby
class UserSerializer < ActiveModel::VersionSerializer

  version :v1 do
    attributes :name, :remote_image, :likes_beans, :id
  end

  version :v2 do
    version_attributes :v1, without: [:likes_beans, :remote_image]
  end

  version :v3 do
    version_attributes :v1, with: :date_of_birth
    embed :ids, :include => true
    has_many :turns
  end
end
```
## Explict Version

```ruby
UserSerializer.new(user, version: v3)
```

## Controller

`ActiveModel::Serializers` gives you some controller goodness in terms
of defining scope for your serializers but you now also specify a
version.

```ruby
    # Any logic that you have to determine the version wanted for that request
    # can go here!
    def default_serializer_options
      {version: some_method_determining_version}
    end
```

## I want to specify a default VERSION

ok

```ruby
ActiveModel::VersionSerializer.default :v3
```


## Installation

Add this line to your application's Gemfile:

    gem 'active_model_version_serializers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_model_version_serializers

## Usage


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
