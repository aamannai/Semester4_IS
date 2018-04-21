module Contexts
  module UserContexts
    # create your contexts here...
    def create_users
      @mark_user = FactoryBot.create(:user)
      @alex_user = FactoryBot.create(:user, username: "tank", phone: "412-369-4314")
      @rachel_user = FactoryBot.create(:user, username: "rachel", role: "instructor")
    end

    def delete_users
      @mark_user.delete
      @alex_user.delete
      @rachel_user.delete
    end

    def create_family_users
      @gruberman_user = FactoryBot.create(:user, username: "gruberman", role: "parent")
      @skirpan_user   = FactoryBot.create(:user, username: "skripan", role: "parent")
      @regan_user     = FactoryBot.create(:user, username: "regan", role: "parent")
      @ellis_user     = FactoryBot.create(:user, username: "ellis", role: "parent")
    end

    def delete_family_users
      @gruberman_user.delete
      @skirpan_user.delete
      @regan_user.delete
      @ellis_user.delete
    end    
  end
end