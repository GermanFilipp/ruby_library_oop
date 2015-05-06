module Library
  class Order < Library
    attr_accessor :book, :reader

    def initialize (book:, reader:)
      @book   = book
      @reader = reader
    end
  end
end
