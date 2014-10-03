require 'rails_helper'
require 'stepford/factory_girl/rspec_helpers'

describe 'validate factories build', type: :model do
  FactoryGirl.factories.each do |factory|
    context "with factory for :#{factory.name}" do
      subject { deep_create(factory.name) }

      it 'is valid' do
        expect(subject.valid?).to be, subject.errors.full_messages.join(',')
      end
    end
  end
end
