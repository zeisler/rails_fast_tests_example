class ParseOrderStub < ParseOrderCsv

  def call
    [
      { "purchaser name" => "Snake Plissken", "item description" => "$10 off $20 of food", "item price" => "10.0", "purchase count" => "2", "merchant address" => "987 Fake St", "merchant name" => "Bob's Pizza" },
      { "purchaser name" => "Amy Pond", "item description" => "$30 of awesome for $10", "item price" => "10.0", "purchase count" => "5", "merchant address" => "456 Unreal Rd", "merchant name" => "Tom's Awesome Shop" },
      { "purchaser name" => "Marty McFly", "item description" => "$20 Sneakers for $5", "item price" => "5.0", "purchase count" => "1", "merchant address" => "123 Fake St", "merchant name" => "Sneaker Store Emporium" },
      { "purchaser name" => "Snake Plissken", "item description" => "$20 Sneakers for $5", "item price" => "5.0", "purchase count" => "4", "merchant address" => "123 Fake St", "merchant name" => "Sneaker Store Emporium" }
    ]
  end

end