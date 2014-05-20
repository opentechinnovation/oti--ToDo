require 'spec_helper'

describe User do
  let(:valid_attributes) {
      {
        first_name: "David",
        last_name: "Burns",
        email: "dbmoonchild51@gmail.com",
        password: "opentech1234",
        password_confirmation: "opentech1234"
      }
    }
  context "validations" do
    let(:user) { User.new(valid_attributes) }
    
    before do
      User.create(valid_attributes)
      
    end
    
    it "requires an email" do
      expect(user).to validate_presence_of(:email)
    end
    
    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end
    
    it "requires a unique email (case insensitive)" do
      user.email = "DBMOONCHILD51@GMAIL.COM"
      expect(user).to validate_uniqueness_of(:email)
    end
    
    it "requires the email address to look like an email" do
      user.email = "david"
      expect(user).to_not be_valid
    end
    
  end
  
  describe "#downcase_email" do
    it "makes the email attribute lower case" do
      user = User.new(valid_attributes.merge(email: "DBMOONCHILD51@GMAIL.COM"))
      expect{ user.downcase_email }.to change{ user.email }.
        from("DBMOONCHILD51@GMAIL.COM").
        to("dbmoonchild51@gmail.com")
    end

    it "downcases an email before saving" do
      user = User.new(valid_attributes)
      user.email = "DBMOONCHILD51@GMAIL.COM"
      expect(user.save).to be_true
      expect(user.email).to eq("dbmoonchild51@gmail.com")
    end
  end
end
