# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(username:"admin",email:"admin@qq.com",password:"11111111",approved: 1) unless User.where(username: "admin").present?
History.delete_all

Api::V1::Client::Category.all
Api::V1::Client::Category.create(name: "老客户")
Api::V1::Client::Category.create(name: "新客户")
Api::V1::Client::Category.create(name: "其他客户")

Api::V1::Client.delete_all
25.times do |index|
  Api::V1::Client.create!(name:"客户#{index}",email:"netfarmer#{index}@netfarmer.com.cn",phone:[*(0..9)].shuffle[0..9].join,address:"地址#{index}",remark:"备注#{index}",category_id:Api::V1::Client::Category.all.pluck(:id).sample, creator_id: 1)
end
puts "clients create over"

Api::V1::Opportunity.delete_all
32.times do |index|
  Api::V1::Opportunity.create!(code:[*(0..9)].shuffle[0..6].join,name:"商机#{index}",client_id:(1..20).to_a.sample,status_id:(1..5).to_a.sample,remark:"备注#{index}", creator_id: 1,amount: Random.rand(10000.00...1000000.00).round(2))
end
puts "opportunities creator over"

dd = DoubleBall.new
dd.insert_data
