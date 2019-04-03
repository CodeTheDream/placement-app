module AdminsHelper
    def resource_name
        :user
    end

    def resource_class 
        User 
    end

    def resource
        @user ||= User.new
        @resource ||= @user
    end
end
