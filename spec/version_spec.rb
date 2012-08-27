# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Active Model Serializing With Versioning" do
  context "VersionSerializer" do
    subject{ActiveModel::VersionSerializer}
    its(:_default){should eq(:v1)}
    it{should respond_to :version}
  end

  context "defining an new default" do
    describe "#default" do
      before do
        ActiveModel::VersionSerializer.default :v2
      end
      subject{ActiveModel::VersionSerializer} 
      its(:_default){should eq(:v2)}
    end

    context "subclasses" do
      subject{UserSerializer}
      its(:_default){should eq(:v2)}
      context "chaning again" do
        before do
          ActiveModel::VersionSerializer.default :v3
        end
        its(:_default){should eq(:v3)}
      end
    end
  end
end
