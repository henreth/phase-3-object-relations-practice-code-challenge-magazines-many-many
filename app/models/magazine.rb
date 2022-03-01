class Magazine < ActiveRecord::Base
    has_many :subscriptions
    has_many :readers, through: :subscriptions

    def email_list
        emails = ''
        self.readers.each{|reader| emails+=reader.email+';'} 
        emails.delete_suffix!(';')
        emails
    end

    def self.most_popular
        Magazine.all.max{|magazine|magazine.readers.count}
    end
end