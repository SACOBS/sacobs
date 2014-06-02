require 'spec_helper'

describe Contact, :type => :model do
  subject(:contact) { Contact.new(name: 'ben', message: 'Test message') }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:message) }

  it { is_expected.to allow_value(valid_email_address).for(:email) }
  it { is_expected.not_to allow_value(invalid_email_address).for(:email) }

  it { is_expected.to ensure_length_of(:message).is_at_most(300)}

  it { is_expected.to validate_absence_of(:nickname) }

end