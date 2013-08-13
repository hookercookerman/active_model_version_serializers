# encoding: utf-8
require File.expand_path("../../spec_helper", __FILE__)

describe "InheritedSerialization" do
  context "v1" do
    context "serialization of a car object" do
      let(:car_attributes) do
        FactoryGirl.attributes_for(:v1_car)
      end

      let(:car) do
        FactoryGirl.build(:v1_car, car_attributes)
      end

      let(:car_serializer) do
        CarSerializer.new(car)
      end

      subject {car_serializer.as_json}
      it {should eq({car: car_attributes})}
    end
  end

  context "v2" do
    let(:car_attributes) do
      FactoryGirl.attributes_for(:v2_car)
    end

    let(:car) do
      FactoryGirl.build(:v2_car, car_attributes)
    end

    let(:car_serializer) do
      CarSerializer.new(car, version: :v2)
    end

    subject {car_serializer.as_json}
    it {should eq({car: car_attributes})}
  end
end
