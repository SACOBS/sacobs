require 'spec_helper'

describe Contact do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:message) }

  it { should allow_value(valid_email_address).for(:email) }
  it { should_not allow_value(invalid_email_address).for(:email) }

  it { should ensure_length_of(:message).is_at_most(300)}

  it { should validate_absence_of(:nickname) }

end