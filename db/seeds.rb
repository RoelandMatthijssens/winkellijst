# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


@banana = Item.create({name: "banana"})
@chocolat = Item.create({name: "chocolat"})
@milk = Item.create({name: "milk"})

@enermis = User.create({email: 'enermis@fulgens.com', password: 'somepass'})
@fulgens = User.create({email: 'fulgens@fulgens.com', password: 'somepass'})
@ailurus = User.create({email: 'ailurus@fulgens.com', password: 'somepass'})

@sint_truiden = Household.create!(name: "sint-truiden", creator: @enermis)

@shopping_list1 = @enermis.create_shopping_list(@sint_truiden)
@shopping_list2 = @enermis.create_shopping_list(@sint_truiden)

@enermis.add_item_to_list(@banana, @shopping_list1, amount=3)
@enermis.add_item_to_list(@chocolat, @shopping_list1, amount=2)
@enermis.add_item_to_list(@milk, @shopping_list2, amount=2)
