class Checkout
  def initialize(catalogue,promotional_rules=[])
    @catalogue = catalogue
    @promotional_rules = promotional_rules
  end
  def scan (item)
    items << item
  end
  def total
    ## apply discounts
    total_discount = 0
    @promotional_rules.each do |rule|
      total_discount += rule.get_discount(items)
    end
    # calculate the total price less total discount
    total = items.inject(0){|sum,item| sum + item.price} - total_discount
    # round to pennies
    (total*100).round / 100.0
  end
  private
    def items
      @items ||= []
    end
end