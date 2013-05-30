module ApplicationHelper
  #include ActionView::Helpers::NumberHelpe

  def decimal_register(amount)
    number_to_currency(amount, :separator => ".", :delimiter => " ", :precision => 3, :unit => "")
  end

  def int_register(amount)
    number_to_currency(amount, :separator => ".", :delimiter => " ", :precision => 0, :unit => "")
  end

end
