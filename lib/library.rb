require "library/version"
require "library/Book"
require "library/Author"
require "library/Order"
require "library/Reader"

module Library
 class Library
  attr_accessor :books, :orders, :readers, :authors

  def initialize ()
  @books = []
  @orders = []
  @readers = []
  @authors = []
  end




  def add something

    case "#{something.class}"
      when "Book"
        @books.push something
      when "Order"
        @orders.push something
      when "Reader"
        @readers.push something
      when "Author"
        @authors.push something
    end

  end

  def the_most_popular_reader
   array = []
   @orders.each{|order| array.push order.reader}
   frequencies = Hash.new(0)
   array.each{|arr| frequencies[arr]+=1}

   a = frequencies.select{|k,v| v == frequencies.values.max}
   a.each{|k,v| puts "#{k} often takes the book"}
  end


  def the_most_popular_book
    array = []
    @orders.each{|order| array.push order.book}
    frequencies = Hash.new(0)
    array.each{|arr| frequencies[arr]+=1}

    a = frequencies.select{|k,v| v == frequencies.values.max}
    a.each { |k,v|  puts "#{k} the most popular book"}

  end

  def num_of_popular_book
    array = []
    @orders.each{|order| array.push [order.book,order.reader]}
    array.uniq!
    arr = Array.new
    arr= array.each{|order| arr.push order}
    frequencies = Hash.new(0)
    arr.each{|arr| frequencies[arr[0]]+=1}
    frequencies =  frequencies.sort_by{|a,b| b}.reverse!

    count=0
    frequencies.each do |word,frequency|
      count+=frequency
    end
    puts "#{count} people ordered one of the three most popular books"
  end

  def create_if_not_found
    file_name = ["library_book.txt","library_order.txt","library_reader.txt","library_author.txt"]
    file_name.each{|name|file?(name) unless File.new(name) }
  end

  def get_data_from_file
    create_if_not_found

    add_book
    add_order
    add_author
    add_reader
  end

  def save_data
    create_if_not_found

    f = File.open("library_book.txt","w")
    @books.each{|book|  f.puts "#{book.title}% #{book.author} " }
    f.close
    e = File.open("library_order.txt","w")
    @orders.each{|order| e.puts "#{order.book}% #{order.reader} "}
    e.close
    c = File.open("library_reader.txt","w")
    @readers.each{|reader| c.puts "#{reader.name}% #{reader.email}% #{reader.city}% #{reader.street}% #{reader.house}"}
    c.close
    h = File.open("library_author.txt","w")
    @authors.each{|author| f.puts "#{author.name}% #{author.biography} "}
    h.close

  end


  def add_book

    file = File.readlines("library_book.txt")
    file.map! { |f| f.chomp.split('%') }
    file.each{|val| add Book.new(title:val[0],author:val[1])}

  end

  def add_reader

    file = File.readlines("library_reader.txt")
    file.map! { |f| f.chomp.split('%') }
    file.each{|val| add Reader.new(name:val[0],email:val[1],city:val[2],street:val[3],house:val[4])}

  end


  def add_order

    file = File.readlines("library_order.txt")
    file.map! { |f| f.chomp.split('%') }
    file.each{|val| add Order.new(book:val[0],reader:val[1])}
  end

  def add_author

    file = File.readlines("library_author.txt")
    file.map! { |f| f.chomp.split('%') }
    file.each{|val| add Author.new(name:val[0],biography:val[1])}
  end


end
end
