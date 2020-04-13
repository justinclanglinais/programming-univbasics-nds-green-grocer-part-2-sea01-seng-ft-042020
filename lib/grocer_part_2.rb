require_relative './part_1_solution.rb'
require 'pry'

describe "Grocer" do
let(:items) do
    [
      {:item => "AVOCADO", :price => 3.00, :clearance => true},
      {:item => "KALE", :price => 3.00, :clearance => false},
      {:item => "BLACK_BEANS", :price => 2.50, :clearance => false},
      {:item => "ALMONDS", :price => 9.00, :clearance => false},
      {:item => "TEMPEH", :price => 3.00, :clearance => true},
      {:item => "CHEESE", :price => 6.50, :clearance => false},
      {:item => "BEER", :price => 13.00, :clearance => false},
      {:item => "PEANUTBUTTER", :price => 3.00, :clearance => true},
      {:item => "BEETS", :price => 2.50, :clearance => false},
      {:item => "SOY MILK", :price => 4.50, :clearance => true}
    ]
  end

  let(:coupons) do
    [
      {:item => "AVOCADO", :num => 2, :cost => 5.00},
      {:item => "BEER", :num => 2, :cost => 20.00},
      {:item => "CHEESE", :num => 3, :cost => 15.00}
    ]
  end
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do | items |
    coupons.each do | coupon_items |
      if coupon_items[:item] == items[:item]
        items[:count] = items[:count] - coupon_items[:num]
        cart << {
          :item => "#{items[:item]} W/COUPON",
          :price => coupon_items[:cost] / coupon_items[:num].to_f,
          :clearance => items[:clearance],
          :count => coupon_items[:num]
        }
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do | items |
    if items[:clearance] == true 
      items[:price] = (items[:price].to_f * 0.80).round(2)
    end
  end
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  beer = find_item_by_name_in_collection('BEER', items)
  beets = find_item_by_name_in_collection('BEETS', items)
  cart = [beets, beer, beer, beer]
  coupon_collection = [coupons[1]]
  
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearanced_cart = apply_clearance(couponed_cart)
  price = []
  # binding.pry 
  clearanced_cart.each do | items |
    price << (items[:price] * items[:count])
  end
  sum = 0 
  price.each do | i |
    sum += i
  end
  return sum
  # binding.pry
end
