require 'date'
require 'pry'
#ruby -v 3.0.1

class Shop
    attr_accessor :id, :name
    @@all = []
    def initialize(shop_id, shop_name)
      @id, @name = shop_id, shop_name
      @@all << self
    end

    def orders
      Order.shop(self.id)
    end

    def new_order(dollar_amount, order_date, fulfilled)
      Order.new(self.id, dollar_amount, order_date, fulfilled)
    end

    def self.all
      @@all
    end

    def self.names
      puts @@all.map(&:name)
    end

    def self.fulfilled
      puts @@all.map{|shop| [shop.name, shop.orders.filter_map{|order| order.amount if order.fulfilled}.sum]}
    end

    def self.biggest_unfulfilled
      biggest_loser = Order.unfulfilled.max{|a, b| a.amount <=> b.amount}
      puts Shop.all.detect{|shop| shop.id == biggest_loser.shop_id}.name
    end
    
    # if there is a tie for the lowest amount of sales
    # it will pick the store with the 'lowest' id value.
    def self.least_sales_by_month_year(month, year)
      orders = Order.order_by_month_year(month, year)
      shop_id = orders.filter_map{|order| order.shop_id}.tally.min[1]
      puts @@all.find{|shop| shop.id == shop_id}.name
    end 

end

class Order
    attr_accessor :shop_id, :amount, :order_date, :fulfilled
    @@all = []
    def initialize(shop_id, dollar_amount, order_date, fulfilled)
      @shop_id, @amount, @order_date, @fulfilled  = shop_id, dollar_amount, order_date, fulfilled
      @@all << self
    end
    
    def self.all
      @@all
    end

    def self.order_by_month_year(month, year)
      @@all.select{|order| order.order_date.month == month && order.order_date.year == year}
    end 

    def self.shop(id) 
    @@all.select{|order| order.shop_id == id}
    end 

    def self.unfulfilled
      @@all.reject{|order| order.fulfilled}
    end 

end 

    Shop.new(1, "Atlantis")
    Shop.new(2, "Rustic Range")
    Shop.new(3, "Golden Apple")
    Shop.new(4, "Cascade Corner")

    Order.new(1, 230, Date.new(2021, 5, 13), true)
    Order.new(1, 145, Date.new(2021, 5, 17), true)
    Order.new(1, 600, Date.new(2021, 6, 12), false)
    
    Order.new(2, 55, Date.new(2021, 5, 10), true)
    Order.new(2, 39, Date.new(2021, 6, 7), false)

    Order.new(3, 180, Date.new(2021, 5, 5), true)
    Order.new(3, 490, Date.new(2021, 5, 7), true)
    Order.new(3, 1250, Date.new(2021, 5, 12), true)
    Order.new(3, 480, Date.new(2021, 6, 2), true)
    Order.new(3, 535, Date.new(2021, 6, 8), false)
    Order.new(3, 499, Date.new(2021, 6, 18), false)

    Order.new(4, 300, Date.new(2021, 5, 4), true)
    Order.new(4, 275, Date.new(2021, 5, 28), true)
    Order.new(4, 35, Date.new(2021, 6, 4), false)
    Order.new(4, 79, Date.new(2021, 6, 21), false)


# Your employer has multiple shops with associated orders.
# In order to get better insights into their sales operations
# you have been tasked with getting some reporting statistics
# from their sales data.

# See class definitions above for data structure.

# 1a. Display the names of the shops
Shop.names
# 1b. Display the sum of the shop's fulfilled orders after the name
Shop.fulfilled
# 2. Display the name of the shop that has the largest unfulfilled order
Shop.biggest_unfulfilled
# 3. Display the name of the shop that had the least orders in May of 2021
Shop.least_sales_by_month_year(5, 2021)
# Put your code here

binding.pry