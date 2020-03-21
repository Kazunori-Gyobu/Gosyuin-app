require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:another_user) { FactoryBot.create(:user) }
  let!(:active) { user.active_relationships.create(followed_id: another_user.id) }

  it "ログインしていなければフォローできないこと" do
    expect { 
      post relationships_path
    }.not_to change{ Relationship.count }
  end

  it "ログインしていなければフォロー解除できないこと" do
    expect { 
      delete relationship_path(active.id)
    }.not_to change{ Relationship.count }
  end
end