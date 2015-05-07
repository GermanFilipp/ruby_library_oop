require "library/version"
require "library/Book"
require "library/Author"
require "library/Order"
require "library/Reader"

module Library
 class Library
  attr_accessor :books, :orders, :readers, :authors

  def initialize ()
  @books   = []
  @orders  = []
  @readers = []
  @authors = []
  end

  def add obj
    case "#{obj.class}"
      when "Book"
        @books.push   obj
      when "Order"
        @orders.push  obj
      when "Reader"
        @readers.push obj
      when "Author"
        @authors.push obj
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
     ["library_book.txt","library_order.txt","library_reader.txt","library_author.txt"].each do |name|
      if puts File.exist?(name) == false
        File.new(name,"w") #Why don't work?
       end
     end
  end

  def get_data_from_file
    create_if_not_found
    ["library_book.txt","library_order.txt","library_reader.txt","library_author.txt"].each do |file_name|
      file = File.readlines("library_book.txt")
      file.map! { |f| f.chomp.split('%') }
      case file_name
        when "library_book.txt"
          file.each{|val| add Book.new(title:val[0],author:val[1])}
        when "library_order.txt"
          file.each{|val| add Order.new(book:val[0],reader:val[1])}
        when "library_reader.txt"
          file.each{|val| add Reader.new(name:val[0],email:val[1],city:val[2],street:val[3],house:val[4])}
        when "library_author.txt"
          file.each{|val| add Author.new(name:val[0],biography:val[1])}
      end

    end

  end

  def save_data
    create_if_not_found
    ["library_book.txt","library_order.txt","library_reader.txt","library_author.txt"].each do |file_name|
      f = File.open(file_name,"w")
      case file_name
        when "library_book.txt"
          @books.each{|book|  f.puts "#{book.title}% #{book.author} " }
        when "library_order.txt"
          @orders.each{|order| f.puts "#{order.book}% #{order.reader} "}
        when "library_reader.txt"
          @readers.each{|reader| f.puts "#{reader.name}% #{reader.email}% #{reader.city}% #{reader.street}% #{reader.house}"}
        when "library_author.txt"
          @authors.each{|author| f.puts "#{author.name}% #{author.biography} "}
      end
      f.close
    end
  end





 end
end
