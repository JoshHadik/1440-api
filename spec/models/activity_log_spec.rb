require 'rails_helper'

RSpec.describe ActivityLog, type: :model do
  subject do
    FactoryBot.build(:activity_log)
  end

  context "Validations" do
    it "is invalid with no label" do
      subject.label = nil
      expect(subject.valid?).to be(false)
    end

    it "is invalid with no user" do
      subject.user = nil
      expect(subject.valid?).to be(false)
    end

    it "is invalid with no started at attribute" do
      subject.started_at = nil
      expect(subject.valid?).to be(false)
    end

    it "is invalid with no ended at attribute" do
      subject.ended_at = nil
      expect(subject.valid?).to be(false)
    end

    it "is invalid if started at is greater than ended at" do
      subject = FactoryBot.build(:activity_log, :started_at_greater_than_ended_at)
      expect(subject.valid?).to be(false)
    end
  end
end
