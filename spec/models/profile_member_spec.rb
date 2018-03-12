require 'rails_helper'

RSpec.describe ProfileMember, type: :model do
  before(:all) do
    @non_blank_profile = create(:non_blank_profile)
    @blank_profile = create(:profile_member)
  end

  it 'blank profile' do
    expect(@blank_profile.first_name).to be_nil
  end

  it 'non blank profile' do
    expect(@non_blank_profile.first_name.nil?).to be_falsy
  end

  it '#full_name' do
    expect(@non_blank_profile.full_name).to eq("#{@non_blank_profile.first_name} #{@non_blank_profile.second_name}")
  end
end
