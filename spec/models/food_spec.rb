require 'rails_helper'

RSpec.describe Food, type: :model do
  subject { Food.create(name: 'foodstuff', measurement_unit: 'gr', price: 20, quantity: 1) }

  before { subject.save }
  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'quantity should not be smaller than 1' do
    subject.quantity = 0
    expect(subject).to_not be_valid
  end
end