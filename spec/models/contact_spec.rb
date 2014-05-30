require 'spec_helper'

describe Contact do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:message) }


  it { should allow_value('niceandsimple@example.com', 'very.common@example.com','a.little.lengthy.but.fine@dept.example.com').for(:email) }
  it { should allow_value(ValidationsHelper.valid_emails)}

  it { should_not allow_value('paul.example.com').for(:email) }
  it { should_not allow_value('A@b@c@example.com').for(:email) }




end