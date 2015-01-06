class Checkout
  def initialize(catalogue,promotional_rules=[])
    @catalogue = catalogue
    @promotional_rules = promotional_rules
  end
  def scan (item)
    items << item
  end
  def total
    total = items.inject(0){|sum,item| sum + item.price}
  end
  private
    def items
      @items ||= []
    end
end