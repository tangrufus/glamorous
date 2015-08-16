module HTML
  class Pipeline
    # HTML filter that wraps @username mentions with <strong>. Mentions within <pre>,
    # <code>, and <a> elements are ignored. Mentions that reference users that do
    # not exist are ignored.
    #
    # Context options:
    #   :username_pattern - Used to provide a custom regular expression to
    #                       identify usernames
    #
    class UsernameFilter < MentionFilter
      def link_to_mentioned_user(login)
        result[:false_usernames] ||= []
        result[:mentioned_usernames] ||= []
        result[:mentioned_user] ||= []

        return unless login_exists?(login)

        "<strong>@#{login}</strong>"
      end

      def login_exists?(login)
        return false if result[:false_usernames].include?(login)
        return true if result[:mentioned_usernames].include?(login)

        mentioned_user = User.where(username: login).take

        if mentioned_user
          result[:mentioned_usernames] |= [login]
          result[:mentioned_user] |= [mentioned_user]
        else
          result[:false_usernames] |= [login]
          false
        end
      end
    end
  end
end
