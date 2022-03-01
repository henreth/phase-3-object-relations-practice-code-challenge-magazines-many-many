class Reader < ActiveRecord::Base
  has_many :subscriptions
  has_many :magazines, through: :subscriptions

  def subscribe (magazine, price) 
    sub = Subscription.create(price: price)
    self.subscriptions << sub;
    magazine.subscriptions << sub;
  end

  def total_subscription_price
    self.subscriptions.map{|sub| sub.price}.sum
  end

  def cancel_subscription magazine
    subs = Subscription.all.find_all {|sub| sub.reader_id==self.id }.find_all{|sub| sub.magazine_id==magazine.id}
    subs.each{|sub| Subscription.delete(sub)}
  end


end