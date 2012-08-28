require "active_model_serializers"
require "active_support/concern"
require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/hash/slice'

module ActiveModel
  class VersionSerializer

    # make sure we move serialization to the version 
    [:as_json, :to_json, :serializable_hash].each do |method|
      undef_method method if instance_methods.include?(method)
    end

    class_attribute :_versions, :_default, :_root, :_name
    self._versions, self._default = {}, :v1
    attr_reader :object, :options, :version, :vklass

    def initialize(object, options = {})
      @object, @options = object, options
      @version = @options[:version] || _default
      @vklass = self._versions[@version]
      @vinstance = @vklass.new(@object, @options)
    end

    def self.default(version)
      self._default = version
    end

    # Defines the root used on serialization. If false, disables the root.
    def self.root(name)
      self._root = name
    end

    # Replication of inherited from active_model_serializer but we 
    # get the name so we can define the correct name on each version
    #
    # of defined active model serializers
    def self.inherited(klass) #:nodoc:
      return if klass.anonymous?
      name = klass.name.demodulize.underscore.sub(/_serializer$/, '')
      self._name = name
      klass.class_eval do
        alias_method name.to_sym, :object
        root name.to_sym unless self._root == false
      end
    end

    # creates a anoymous subclass of ActiveModel::Serializer
    # setting the root from base alias of the serialbe object
    # with the name
    #
    # version_attributes so less typing if the versions are similar
    # options :with and :without.
    #
    # @example
    #   version :v1 do
    #     attributes :beans, :eggs
    #   end
    #
    #   version :v2 do
    #     version_attributes :v1, with: :toast
    #   end
    #
    # @param [Symbol] version
    # @param [Proc] block
    def self.version(version, &block)
      base_class = self
      vklass = Class.new(ActiveModel::Serializer) do
        self.root(base_class._root)
        alias_method base_class._name.to_sym, :object

        singleton_class.class_eval do
          define_method(:to_s) do
            "(#{base_class.name} VERSION: #{version})"
          end
          alias inspect to_s
        end

        define_singleton_method(:version_attributes) do |v, options = {}|
          version_attributes = base_class._versions[v]._attributes.keys
          version_options = options.extract!(:without, :with)
          if with_attributes = version_options[:with]
            version_attributes = (version_attributes + [*with_attributes])
          end
          if without_attributes = version_options[:without]
            version_attributes = (version_attributes - [*without_attributes])
          end
          attributes(*version_attributes)
        end
        self.class_eval(&block)
      end

      # mutables with class attribute use setters!
      self._versions = self._versions.merge({version => vklass})
    end

    def method_missing(method, *args)
      if @vinstance.respond_to?(method)
        @vinstance.send(method, *args)
      else
        super
      end
    end

    # lets be nice to method
    def respond_to_missing?(method_name, include_private = false)
      @vinstance.respond_to?(method_name, include_private)
    end

  end
end

