require File.dirname(__FILE__) + '/spec_helper'

module CheckoutSpecHelper
  # define a PRODUCT class
  class Product
    def initialize ( id, name, price )
        @id = id
        @name = name
        @price = price
    end
    attr_accessor :id, :name, :price
  end
  # define a CATALOGUE class
  def catalogue
    @catalogue ||= [
      Product.new( "001", "Lavender heart", 9.25 ),
      Product.new( "002", "Personalised cufflinks", 45.00 ),
      Product.new( "003", "Kids T-shirt", 19.95 )
    ]
  end
  # define a discount rule for over £60 spend, 10% off your purchase
  # define a discount rule for buying 2 or more lavender hearts (001), price drops to £8.50
end

describe Checkout, '.total' do
  include CheckoutSpecHelper
  before :all do
    @item1,@item2,@item3 = catalogue
  end
  context "without discount rules" do
    let(:checkout) { Checkout.new(catalogue) }
    it "returns 0 for no items" do
      expect(checkout.total).to eq(0)
    end
    it "returns the correct price for one item" do
      checkout.scan(@item1)
      expect(checkout.total).to eq(9.25)
    end
    it "returns the correct price for two of the same line item" do
      checkout.scan(@item1)
      checkout.scan(@item1)
      expect(checkout.total).to eq(18.5)
    end
    it "returns the correct price for two different line items" do
      checkout.scan(@item1)
      checkout.scan(@item2)
      expect(checkout.total).to eq(54.25)
    end
  end
end
