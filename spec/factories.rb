Factory.define :user do |u|
  u.email         "user@othercompany.com"
  u.full_name     "John Doe"
  u.admin         false
end


Factory.define :admin, :class => "User" do |u|
  u.email         "admin@company.com"
  u.full_name     "Admin Administrator"
  u.admin         true
end

Factory.define :post do |p|
  p.title         "A title"
  p.intro         "An intro"
  p.body          "A body"
  p.published_on  Date.today
  p.reviewed      true
  p.association   :user, :factory => :admin
end