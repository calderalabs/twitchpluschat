class User
  attr_accessor :name, :emoticon_set_ids, :color

  def initialize(name)
    @name = name
    @emoticon_set_ids = []
  end

  class << self
    def find_or_create(name)
      store[name] ||= new(name)
    end

    def clear
      store.clear
    end

    private

    def store
      @store ||= {}
    end
  end
end
