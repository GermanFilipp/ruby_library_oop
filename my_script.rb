require_relative('Library')
require_relative('Book')
require_relative('Order')
require_relative('Reader')
require_relative('Author')
library = Library.new
library.get_data_from_file
library.the_most_popular_reader
library.the_most_popular_book
library.num_of_popular_book
library.save_data

p library