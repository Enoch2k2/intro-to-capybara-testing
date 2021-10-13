require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a first name, last name, email, and password" do
    user = User.new
    user.first_name = "Bob"
    user.last_name = "Test"
    user.email = "bob@test.com"
    user.password = "testtest"
    expect(user.first_name).to eq("Bob")
    expect(user.last_name).to eq("Test")
    expect(user.email).to eq("bob@test.com")
    expect(user.password).to eq("testtest")
  end

  it "first name is required" do
    user = User.create(last_name: "Test", email: "test@test.com", password: "testtest")
    
    expect(user).to_not be_valid
  end
  
  it "last name is required" do
    user = User.create(first_name: "Bob", email: "test@test.com", password: "testtest")
    
    expect(user).to_not be_valid
  end
  
  it "email is required" do
    user = User.create(first_name: "Bob", last_name: "Test", password: "testtest")
    
    expect(user).to_not be_valid
  end
  it "email should be unique" do
    user = User.create(first_name: "Bob", last_name: "Test", email: "bob@test.com", password: "testtest")
    user_2 = User.create(first_name: "Bob", last_name: "Test", email: "bob@test.com", password: "testtest")
    
    expect(user).to be_valid
    expect(user_2).to_not be_valid
  end
  
  it "has a password digest when given a password" do
    user = User.create(first_name: "Bob", last_name: "Test", email: "bob@test.com", password: "testtest")
    expect(user.password_digest).to_not eq(nil)
  end
  
  it "has an authenticate method attached" do
    user = User.create(first_name: "Bob", last_name: "Test", email: "bob@test.com", password: "testtest")
    expect(user.authenticate("testtest")).to eq(user)
  end
end
