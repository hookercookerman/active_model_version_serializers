# encoding: utf-8
require File.expand_path("../../spec_helper", __FILE__)

describe "UserSerialization" do
  context "v1" do
    context "serialization of a user object" do
      let(:user_attributes) do
        FactoryGirl.attributes_for(:v1_user)
      end

      let(:user) do
        FactoryGirl.build(:v1_user, user_attributes)
      end

      let(:user_serializer) do
        UserSerializer.new(user)
      end

      subject{user_serializer.as_json}
      it{should eq({user: user_attributes})}
    end
  end

  context "v2" do
    let(:user_attributes) do
      FactoryGirl.attributes_for(:v2_user)
    end

    let(:user) do
      FactoryGirl.build(:v2_user, user_attributes)
    end

    let(:user_serializer) do
      UserSerializer.new(user, version: :v2)
    end

    subject{user_serializer.as_json}
    it{should eq({user: user_attributes})}
  end

  context "v3" do
    let(:user_attributes) do
      FactoryGirl.attributes_for(:v3_user)
    end

    let(:turn_attributes_1) do
      FactoryGirl.attributes_for :v3_turn
    end

    let(:turn_attributes_2) do
      FactoryGirl.attributes_for :v3_turn
    end

    let(:turn_attributes_3) do
      FactoryGirl.attributes_for :v3_turn
    end

    let(:turn_1) do
      FactoryGirl.build(:v3_turn, turn_attributes_1)
    end

    let(:turn_2) do
      FactoryGirl.build(:v3_turn, turn_attributes_2)
    end

    let(:turn_3) do
      FactoryGirl.build(:v3_turn, turn_attributes_3)
    end

    let(:turns) do
      [turn_1, turn_2, turn_3]
    end

    let(:turn_attributes) do
      [turn_attributes_1, turn_attributes_2, turn_attributes_3]
    end

    let(:user) do
      FactoryGirl.build(:v3_user, user_attributes.merge(turns: turns))
    end

    let(:user_serializer) do
      UserSerializer.new(user, version: :v3)
    end

    subject{user_serializer.as_json}
    it{should eq({user: user_attributes.merge(turns: [1,2,3]), turns: turn_attributes})}
  end
end
